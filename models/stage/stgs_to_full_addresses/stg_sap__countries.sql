with
    countries as (
        select *
        from {{ source('sap_adw', 'countryregion') }}
    )

    , changes as (
        select
            cast(countryregioncode as string) as country_id
            , cast(name as string) as country_name
        from countries
    )
select *
from changes