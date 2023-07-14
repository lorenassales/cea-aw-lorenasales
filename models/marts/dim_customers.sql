with
    stg_people as (
        select *
        from {{ ref('stg_sap__people') }}
    )

    , stg_customers as (
        select *
        from {{ ref('stg_sap__customers') }}
    )

    , stg_stores as (
        select *
        from {{ ref('stg_sap__stores') }}
    )

    , dim_customers as (
        select
            c.customer_id
            , s.store_id
            , p.person_name as customer_name
            , s.store_name                                     
        from stg_customers c
        left join stg_people p on
            c.customer_id = p.person_id
        left join stg_stores s on
            c.store_id = s.store_id
    )
select 
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk
    , *
from dim_customers