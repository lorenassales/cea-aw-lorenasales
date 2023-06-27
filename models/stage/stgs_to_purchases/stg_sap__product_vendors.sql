with
    product_vendors as (
        select *
        from {{ source('sap_adw', 'productvendor') }}
    )

    , changes as (
        select
            cast(productid as int) as product_id                   
            , cast(standardprice as numeric) as standard_price
        from product_vendores
    )
select 
    product_id
    , avg(standard_price) as avg_standard_price
from changes
group by product_id