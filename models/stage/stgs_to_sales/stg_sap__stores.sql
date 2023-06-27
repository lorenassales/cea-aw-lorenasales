with
    stores as (
        select *
        from {{ source('sap_adw', 'store') }}
    )

    , changes as (
        select
            cast(businessentityid as int) as store_id
            , cast(salespersonid as int) as sales_person_id
            , cast(name as string) as store_name           
        from stores
    )
select *
from changes