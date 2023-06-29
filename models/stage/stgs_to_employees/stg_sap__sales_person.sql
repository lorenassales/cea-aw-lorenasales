with
    sales_person as (
        select *
        from {{ source('sap_adw', 'salesperson') }}
    )

    , changes as (
        select
            cast(businessentityid as int) as sales_person_id
            , cast(salesquota as numeric) as goal
            , cast(commissionpct as numeric) as commission_pct
        from sales_person
    )
select *
from changes