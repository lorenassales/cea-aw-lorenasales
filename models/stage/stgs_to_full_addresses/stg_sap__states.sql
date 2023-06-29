with
    states as (
        select *
        from {{ source('sap_adw', 'stateprovince') }}
    )

    , changes as (
        select
            cast(stateprovinceid as int) as state_id
            , cast(countryregioncode as string) as country_id   
            , cast(name as string) as state_name
        from states
    )
select *
from changes