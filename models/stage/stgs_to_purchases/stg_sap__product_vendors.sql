with
    product_vendors as (
        select *
        from {{ source('sap_adw', 'productvendor') }}
    )

    , changes as (
        select
            cast(productid as int) as product_id
            , cast(businessentityid as int) as vendor_id                
            , cast(standardprice as numeric) as standard_price
        from product_vendors
    )
select *    
from changes

    