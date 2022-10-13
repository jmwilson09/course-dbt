
with dim_products as ( 
    select * from {{ ref('stg_products') }}
)

select 
  row_number() over( order by product_id) as product_key,
  product_id,
  name,
  price,
  inventory
from dim_products