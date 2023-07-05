with
    employees as (
        select *
        from {{ source('sap_adw', 'employee') }}
    )

    , changes as (
        select
            cast(businessentityid as int) as employee_id
            , cast(jobtitle as string) as job_title
            , cast(birthdate as date) as birth_date
            , cast(hiredate as date) as hire_date
            , cast(maritalstatus as string) as marital_status
            , cast(gender as string) as gender            
            , case cast(salariedflag as boolean)
                when false then "Hourly"
                when true then "Salaried"
            else "unknown"
            end as salaried_flag
            , case cast(currentflag as boolean)
                when false then "Inactive"
                when true then "Active"
            else "unknown"
            end as employee_status
        from employees
    )
select *
from changes