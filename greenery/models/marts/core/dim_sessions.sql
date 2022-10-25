with all_sessions as ( 
    select * from {{ ref('stg_events') }}
), 

session_start_and_end_times as (

    select
        session_id,
        min(created_at) AS started_at,
        max(created_at) AS ended_at
    
    from 
        all_sessions

    group by 1
)

select 
  {{ dbt_utils.surrogate_key(["session_id"]) }} as session_key,
  session_id,
  started_at,
  ended_at

from 
    session_start_and_end_times sset
