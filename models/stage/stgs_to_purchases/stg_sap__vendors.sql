with
    vendors as (
        select *
        from {{ source('sap_adw', 'vendor') }}
    )

    , changes as (
        select
            cast(businessentityid as int) as vendor_id
            , cast(name as string) as vendor_name
            , cast(preferredvendorstatus as boolean) as is_preferred
        from vendors
    )
select *
from changes