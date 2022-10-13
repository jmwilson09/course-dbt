
with fact_orders as ( 
    select * from {{ ref('stg_orders') }}
)

select 
*
from fact_orders