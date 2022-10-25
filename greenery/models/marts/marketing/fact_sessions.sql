
with dim_sessions as ( 

    select * from {{ ref('dim_sessions') }}
),

dim_users as ( 

    select * from {{ ref('dim_users') }}
),

dim_orders as ( 

    select * from {{ ref('dim_orders') }}
),

int_sessions as (

    select * from {{ ref('int_session_aggregates') }}
),

fact_sessions as (

    select
        ds.session_key,
        du.user_key,
        do.order_key,
        datediff(hour, ds.started_at, ds.ended_at) as session_duration,
        iss.num_events,
        iss.num_products,
        iss.session_order_cost,
        iss.session_shipping_cost,
        iss.session_total_cost,
        iss.has_checkout as has_purchase_event

    from
        dim_sessions ds
        inner join int_sessions iss
            on ds.session_id = iss.session_id
        inner join dim_users du 
            on iss.user_id = du.user_id
        left join dim_orders do 
            on iss.order_id = do.order_id

)

select * from fact_sessions
