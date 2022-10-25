
with dim_products as ( 
    select * from {{ ref('stg_products') }}
)

select 
  {{ dbt_utils.surrogate_key(["product_id"]) }} as  product_key,
  product_id,
  name,
  price,
  inventory
from dim_products