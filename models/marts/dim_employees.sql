with
    stg_people as (
        select *
        from {{ ref('stg_sap__people') }}
    )

    , stg_employees as (
        select *
        from {{ ref('stg_sap__employees') }}
    )

    , dim_employees as (
        select
            e.employee_id
            , p.person_name as name
            , p.person_type as type
            , e.job_title
            , e.birth_date
            , e.hire_date
            , e.marital_status
            , e.gender
            , e.salaried_flag
            , e.employee_status            
        from stg_employees e
        left join stg_people p on
            e.employee_id = p.person_id
    )
select 
   {{ dbt_utils.generate_surrogate_key(['employee_id']) }} as employee_sk
    , *
from dim_employees


