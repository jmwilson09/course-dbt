with stg_orders as (

    select * from {{ ref('stg_orders') }}
),

user_order_aggregates as (

    select
        user_id,
        count(distinct order_id) as num_orders,
        sum(order_cost) as order_cost,
        sum(shipping_cost) as shipping_cost,
        sum(order_total) as order_total
    from stg_orders
    group by 1
)

select * from user_order_aggregates
