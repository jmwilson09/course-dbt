
with dim_orders as ( 
    select * from {{ ref('stg_orders') }}
)

select 
  row_number() over ( order by order_id) as order_key,
  order_id,
  shipping_service,
  tracking_id,
  status
from dim_orders