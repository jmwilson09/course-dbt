
with dim_addresses as ( 
    select * from {{ ref('stg_addresses') }}
)

select 
  {{ dbt_utils.surrogate_key(["address_id"]) }} as address_key,
  address_id,
  address,
  zipcode,
  state, 
  country
from dim_addresses