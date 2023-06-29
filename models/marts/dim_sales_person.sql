with
    stg_people as (
        select *
        from {{ ref('stg_sap__people') }}
    )

    , stg_employees as (
        select *
        from {{ ref('stg_sap__employees') }}
    )

    , stg_sales_person as (
        select *
        from {{ ref('stg_sap__sales_person') }}
    )

    , dim_sales_person as (
        select
            sp.sales_person_id           
            , p.person_name as name
            , e.job_title
            , e.marital_status
            , e.salaried_flag
            , sp.goal
            , sp.commission_pct
        from stg_sales_person sp
        left join stg_employees e on
            sp.sales_person_id = e.employee_id
        left join stg_people p on 
            sp.sales_person_id = person_id
    )
select
    {{ dbt_utils.generate_surrogate_key(['sales_person_id']) }} as sales_person_sk
    , *
from dim_sales_person