
with dim_products as ( 

    select * from {{ ref('dim_products') }}
),

dim_sessions as (

    select * from {{ ref('dim_sessions') }}
),

int_product_sessions as (

    select * from {{ ref('int_session_product_aggregates') }}
),

fact_product_funnel as (

    select
        dp.product_key,
        to_date(ds.started_at) as session_start_date,
        count(distinct ips.session_id) as num_sessions,
        count(distinct ips.user_id) as num_users,
        avg(datediff(hour, ds.started_at, ds.ended_at)) as avg_session_duration_hours,
        count(distinct case when ips.has_page_view = true 
                            then ips.session_id
                        end) as num_page_views,
        count(distinct case when ips.has_add_to_cart = true 
                            then ips.session_id
                        end) as num_add_to_cart,
        count(distinct case when ips.has_checkout = true 
                            then ips.session_id
                        end) as num_checkouts
        
    from
        dim_products dp
        left join int_product_sessions ips
            on dp.product_id = ips.product_id
        left join dim_sessions ds
            on dp.product_id = ips.product_id
                and ips.session_id = ds.session_id

    group by 1, 2
)

select * from fact_product_funnel
