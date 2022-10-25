
with dim_users as ( 
    select * from {{ ref('stg_users') }}
)

select 
  {{ dbt_utils.surrogate_key(["user_id"]) }} as  user_key,
  user_id,
  first_name,
  last_name,
  concat(first_name, ' ', last_name) as full_name,
  email,
  phone_number,
  created_at,
  updated_at
from dim_users