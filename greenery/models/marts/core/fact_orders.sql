
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
)


select 
  do.order_key,
--   dp.product_key,
  da.address_key,
  dpr.promo_key,
  created_at,
  estimated_delivery_at,
  delivered_at,
  order_cost,
  shipping_cost,
  order_total
from 
    dim_orders do
  inner join stg_orders so
    on do.order_id = so.order_id
--   inner join dim_products dp
--     on dp.product_id = so.product_id
  inner join dim_addr da
    on da.address_id = so.address_id
  left join dim_promos dpr
    on dpr.promo_id = so.promo_id