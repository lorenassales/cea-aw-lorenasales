with
    addresses as (
        select *
        from {{ source('sap_adw', 'address') }}
    )

    , changes as (
        select
            cast(addressid as int) as address_id
            , cast(stateprovinceid as int) as state_id
            , cast(addressline1 as string) as address
            , cast(city as string) as city_name
        from addresses
    )
select *
from changes