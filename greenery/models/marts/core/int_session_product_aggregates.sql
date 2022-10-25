{% set event_types = ["page_view", "add_to_cart", "checkout", "package_shipped"] %}

with events as ( 

    select * from {{ ref('stg_events') }}
), 

products as ( 

    select * from {{ ref('stg_products') }}
), 

order_items as (
    
    select * from {{ ref('stg_order_items') }}
),

session_events as (
     /*note that product_id is null for checkout; go through order to check conversion*/

    select
        e.session_id,
        e.user_id,
        e.product_id,
        {% for event_type in event_types %}
            max(case when e.event_type = '{{event_type}}' then true else false end) as has_{{event_type}},
        {% endfor %}
        {% for event_type in event_types %}
            count(distinct case when e.event_type = '{{event_type}}' then e.event_id end) as num_{{event_type}},
        {% endfor %}
        count(distinct e.event_id) as num_events
        
    from
        events e

    group by 1, 2, 3
),

bridge_session_orders as (

    select
        o.order_id
        , o.product_id
        , e.session_id,
        sum(o.quantity * p.price) as session_product_cost,
        sum(o.quantity) as session_product_quantity
    from 
        order_items o
        inner join events e
            on o.order_id = e.order_id
        inner join products p
            on o.product_id = p.product_id
    group by 1, 2, 3
),

session_product_orders as (

    select
        s.session_id,
        s.user_id,
        s.product_id,
        b.order_id,
        s.has_page_view,
        s.has_add_to_cart,
        case when b.order_id is not null 
                then true
            else s.has_checkout
            end as has_checkout,
        case when s_ship.session_id is not null 
                    and b.order_id is not null
                then true
            else s.has_package_shipped
            end as has_package_shipped,
        s.num_page_view,
        s.num_add_to_cart,
        case when b.order_id is not null 
                then 1
            else 0
            end as num_checkout,
        case when s_ship.session_id is not null 
                    and b.order_id is not null
                then 1
            else 0
            end as num_package_shipped,
        b.session_product_cost,
        b.session_product_quantity
    from 
        session_events s
        left join session_events s_ship
            on s.session_id = s_ship.session_id
              and s_ship.has_package_shipped = true
        left join bridge_session_orders b
            on b.session_id = s.session_id
                and b.product_id = s.product_id
    where s.product_id is not null
)

select * from session_product_orders
