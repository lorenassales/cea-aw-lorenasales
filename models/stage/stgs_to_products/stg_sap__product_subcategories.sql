with
    product_subcategories as (
        select *
        from {{ source('sap_adw', 'productsubcategory') }}
    )

    , changes as (
        select
            cast(productsubcategoryid as int) as product_subcategory_id
            , cast(productcategoryid as int) as product_category_id
            , cast(name as string) as subcategory_name
        from product_subcategories
    )
select *
from changes