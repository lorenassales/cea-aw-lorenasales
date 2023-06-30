with
    dim_credit_cards as (
        select *
        from {{ ref('stg_sap__credit_cards') }}
    )
select 
    {{ dbt_utils.generate_surrogate_key(['credit_card_id']) }} as credit_cards_sk
    , *
from dim_credit_cards