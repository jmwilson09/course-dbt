
with dim_orders as ( 
    select * from {{ ref('stg_orders') }}
)

select 
  {{ dbt_utils.surrogate_key(["order_id"]) }} as order_key,
  order_id,
  shipping_service,
  tracking_id,
  status
from dim_orders