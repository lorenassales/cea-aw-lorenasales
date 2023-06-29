with
    credit_catds as(
        select *
        from {{ source('sap_adw', 'creditcard') }}
    )
    
    , changes as (
        select 
            cast(creditcardid as int) as creditcard_id
            , cast(cardtype as string) as card_type
        from credit_catds
    )
select *
from changes