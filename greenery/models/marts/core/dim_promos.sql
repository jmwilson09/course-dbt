
with dim_promos as ( 
    select * from {{ ref('stg_promos') }}
)

select 
  {{ dbt_utils.surrogate_key(["promo_id"]) }} as  promo_key,
  promo_id,
  discount,
  status
from dim_promos