{% set event_types = ["page_view", "add_to_cart", "checkout", "package_shipped"] %}

with events as ( 

    select * from {{ ref('stg_events') }}
), 

orders as (
    
    select * from {{ ref('stg_orders') }}
),

session_events as (

    select
        e.session_id,
        e.user_id,
        max(e.order_id) as order_id,
        {% for event_type in event_types %}
            max(case when e.event_type = '{{event_type}}' then true else false end) as has_{{event_type}},
        {% endfor %}
        {% for event_type in event_types %}
            count(distinct case when e.event_type = '{{event_type}}' then e.event_id end) as num_{{event_type}},
        {% endfor %}
        count(distinct e.event_id) as num_events,
        count(distinct e.product_id) as num_products,
        count(distinct e.order_id) as num_orders,
        sum(o.order_cost) as session_order_cost,
        sum(o.shipping_cost) as session_shipping_cost,
        sum(o.order_total) as session_total_cost

    from
        events e
        left join orders o
            on e.order_id = o.order_id

    group by 1, 2
)

select * from session_events
