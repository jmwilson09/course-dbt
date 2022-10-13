
with dim_users as ( 
    select * from {{ ref('stg_users') }}
)

select 
  row_number() over(order by user_id) as user_key,
  first_name,
  last_name,
  concat(first_name, ' ', last_name) as full_name,
  email,
  phone_number,
  created_at,
  updated_at
from dim_users