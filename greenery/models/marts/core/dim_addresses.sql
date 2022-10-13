
with dim_addresses as ( 
    select * from {{ ref('stg_addresses') }}
)

select 
  row_number() over( order by address_id) as address_key,
  address_id,
  address,
  zipcode,
  state, 
  country
from dim_addresses