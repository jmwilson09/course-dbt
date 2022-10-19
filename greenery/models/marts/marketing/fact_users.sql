
with dim_users as ( 

    select * from {{ ref('dim_users') }}
),

user_order_aggr as (

    select * from {{ ref('int_user_order_aggregates') }}
),

fact_user_order as (

    select 
      du.user_key,
      uoa.num_orders,
      uoa.order_cost,
      (uoa.order_cost / uoa.num_orders) as avg_cost_per_order

    from 
        dim_users du 
        inner join user_order_aggr uoa 
            on uoa.user_id = du.user_id
)

select * from fact_user_order
