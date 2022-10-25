
with stg_orders as ( 

    select * from {{ ref('stg_orders') }}
), 

dim_product as (
    
    select * from {{ ref('dim_products') }}
),

product_aggr as (

    select * from {{ ref('int_product_aggregates') }}
),

int_session_product as (

    select * from {{ ref('int_session_product_aggregates') }}
),

product_conversion_rate as (

    select
        isp.product_id,
        count(distinct case when isp.order_id is not null then isp.session_id end) / count(distinct isp.session_id) as product_conversion_rate
    from 
        int_session_product isp
    group by 1
),

fact_product as (

    select
        dp.product_key,
        pa.num_orders,
        pa.total_quantity,
        (pa.total_quantity * dp.price) as total_cost,
        (pa.total_quantity / pa.num_orders) as avg_quantity_per_order,
        (pa.total_quantity * dp.price) / pa.num_orders as avg_cost_per_order,
        pcr.product_conversion_rate as conversion_rate

    from 
        dim_product dp
        inner join product_aggr pa
            on pa.product_id = dp.product_id
        inner join product_conversion_rate pcr
            on pcr.product_id = dp.product_id
        
)

select * from fact_product
