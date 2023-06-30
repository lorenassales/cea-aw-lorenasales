with
    special_offers as (
        select *
        from {{ source('sap_adw', 'specialoffer') }}
    )

    , changes as (
        select
            cast(specialofferid as int) as special_offer_id
            , cast(description as string) as description
            , cast(discountpct as numeric) as discount_pct
            , cast(type as string) as for_whom
        from special_offers
    )
select *
from changes