with
    sales_territories as (
        select *            
        from {{ source('sap_adw', 'salesterritory') }}
    )

    , changes as (
        select
            cast(territoryid as int) as territoryid
            , cast(name as string) as country_name            
            , cast(continent as string) as continent
        from sales_territories
    )
select *
from changes