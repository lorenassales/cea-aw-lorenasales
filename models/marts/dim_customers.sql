with
    stg_people as (
        select *
        from {{ ref('stg_sap__people') }}
    )

    , stg_customers as (
        select *
        from {{ ref('stg_sap__customers') }}
    )

    , dim_customers as (
        select
            c.customer_id            
            , p.person_name as customer_name           
        from stg_customers c
        left join stg_people p on
            c.customer_id = p.person_id       
    )
select 
    {{ dbt_utils.generate_surrogate_key(['customer_id']) }} as customer_sk
    , *
from dim_customers
	