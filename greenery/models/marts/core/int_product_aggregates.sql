with stg_order_items as (

    select * from {{ ref('stg_order_items') }}
),

product_aggregates as (

    select
        product_id,
        count(distinct order_id) as num_orders,
        sum(quantity) as total_quantity
    from stg_order_items
    group by 1
)

select * from product_aggregates
