with
    vendors as (
        select *
        from {{ source('sap_adw', 'vendor') }}
    )

    , changes as (
        select
            businessentityid
            , cast(name as string) as vendor_name
            , cast(preferredvendorstatus as boolean) as is_preferred
        from vendors
    )
select *
from changes