with
    credit_cards as(
        select *
        from {{ source('sap_adw', 'creditcard') }}
    )
    
    , changes as (
        select 
            cast(creditcardid as int) as creditcard_id
            , cast(cardtype as string) as card_type
        from credit_cards
    )
select *
from changes