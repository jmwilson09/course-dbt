
with dim_product as (

    select * from {{ ref('dim_products') }}
),

stg_events as (

    select * from {{ ref('stg_events') }} where event_type = 'page_view'
),

fact_page_views as (

    select
      dp.product_key,
      count(distinct event_id) as num_page_views,
      count(distinct user_id) as num_users_viewed,
      count(distinct event_id) / count(distinct user_id) as avg_page_views_per_user

    from 
        dim_product dp
        inner join stg_events se
            on dp.product_id = se.product_id
    group by 1
)

select * from fact_page_views
