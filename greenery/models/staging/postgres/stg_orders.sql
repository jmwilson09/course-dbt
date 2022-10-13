with orders as (
    select * from {{ source('postgres', 'orders')}}
)

select 
  order_id,
  user_id,
  promo_id,
  address_id,
  created_at,
  order_cost,
  shipping_cost,
  order_total,
  tracking_id,
  shipping_Service,
  estimated_delivery_at,
  delivered_at,
  status
from orders