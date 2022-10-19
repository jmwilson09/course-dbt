
with stg_orders as ( 

    select * from {{ ref('stg_orders') }}
),

dim_orders as (

    select * from  {{ ref('dim_orders') }}
),

dim_product as (

    select * from  {{ ref('dim_products') }}
),

dim_addr as (

    select * from  {{ ref('dim_addresses') }}
),

dim_promos as (

    select * from  {{ ref('dim_promos') }}
),

int_order_aggr as (

    select * from  {{ ref('int_order_aggregates') }}
)


select 
  do.order_key,
  da.address_key,
  dpr.promo_key,
  du.user_key,
  so.created_at,
  so.estimated_delivery_at,
  so.delivered_at,
  so.order_cost,
  so.shipping_cost,
  so.order_total,
  (so.order_cost * (1 - (dpr.discount / 100))) as discount_total,
  ioa.num_unique_products,
  ioa.num_total_products,
  ioa.total_quantity,
  (so.order_cost / ioa.num_unique_products) as avg_spent_per_product,
  (so.order_cost / ioa.total_quantity) as avg_spent_per_item,
  datediff(day, so.created_at, so.delivered_at) as days_created_to_delivered,
  datediff(day, so.estimated_delivery_at, so.delivered_at) as days_off_on_delivery_estimate
from 
    dim_orders do
  inner join stg_orders so
    on do.order_id = so.order_id
  inner join int_order_aggr ioa
    on so.order_id = ioa.order_id
  inner join dim_addr da
    on da.address_id = so.address_id
  inner join dim_users du
    on so.user_id = du.user_id
  left join dim_promos dpr
    on dpr.promo_id = so.promo_id
