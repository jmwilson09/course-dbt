
with dim_promos as ( 
    select * from {{ ref('stg_promos') }}
)

select 
  row_number() over ( order by promo_id) as promo_key,
  promo_id,
  discount,
  status
from dim_promos