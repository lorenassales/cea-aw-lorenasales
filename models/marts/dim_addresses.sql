with
    stg_states as (
        select *
        from {{ ref('stg_sap__states') }}
    )

    , stg_countries as (
        select *
        from {{ ref('stg_sap__countries') }}
    )    

    , stg_sales_territories as (
        select *            
        from {{ ref('stg_sap__sales_territories') }}
    )

    , stg_addresses as (
        select *
        from {{ ref('stg_sap__addresses') }}
    )

    , dim_addresses as (
        select
            a.address_id
            , s.state_id
            , c.country_id
            , s.territory_id            
            , a.city_name
            , s.state_name
            , c.country_name
            , st.continent
        from stg_addresses a       
        left join stg_states s on
            a.state_id = s.state_id
        left join stg_countries c on
            s.country_id = c.country_id
        left join stg_sales_territories st on
            s.territory_id = st.territory_id
    )
select
    {{ dbt_utils.generate_surrogate_key(['address_id']) }} as address_sk
    , *
from dim_addresses