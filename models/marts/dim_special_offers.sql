with
    dim_special_offers as (
        select *
        from {{ ref('stg_sap__special_offers') }}
    )
select 
    {{ dbt_utils.generate_surrogate_key(['special_offer_id']) }} as special_offer_sk
    , *
from dim_special_offers