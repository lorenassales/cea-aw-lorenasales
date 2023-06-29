with
    stg_states as (
        select *
        from {{ ref('stg_sap__states') }}
    )

    , stg_countries as (
        select *
        from {{ ref('stg_sap__countries') }}
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
            , a.city_name
            , s.state_name
            , c.country_name
        from stg_addresses a
        left join stg_states s on
            a.state_id = s.state_id
        left join stg_countries c on
            s.country_id = c.country_id
    )
select
    {{ dbt_utils.generate_surrogate_key(['address_id']) }} as address_sk
    , *
from dim_addresses