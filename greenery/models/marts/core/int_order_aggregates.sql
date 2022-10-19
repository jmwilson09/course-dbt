with stg_order_items as (

    select * from {{ ref('stg_order_items') }}
),

order_aggregates as (

    select
        order_id,
        count(distinct product_id) as num_unique_products,
        count(product_id) as num_total_products,
        sum(quantity) as total_quantity
    from stg_order_items
    group by 1
)

select * from order_aggregates
