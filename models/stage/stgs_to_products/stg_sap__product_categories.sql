with
    product_categories as (
        select *
        from {{ source('sap_adw', 'productcategory') }}
    )

    , changes as (
        select
            cast(productcategoryid as int) as product_category_id
            , cast(name as string) as category_name
        from product_categories
    )
select *
from changes