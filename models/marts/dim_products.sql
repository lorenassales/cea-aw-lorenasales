with
    stg_product_models as (
        select *
        from {{ ref('stg_sap__product_models') }}
    )
    
    , stg_product_subcategories as (
        select *
        from {{ ref('stg_sap__product_subcategories') }}
    )

    , stg_categories as (
        select *
        from {{ ref('stg_sap__product_categories') }}
    )

    , stg_products as (
        select *
        from {{ ref('stg_sap__products') }}
    )

    , dim_products as (
        select
            p.product_id
            , p.product_name
            , case
                when pc.category_name is null then "No Category"
            else pc.category_name
            end as category_name 
            , case
                when ps.subcategory_name is null then "No Subcategory"
            else ps.subcategory_name
            end as subcategory_name
            , pm.model_name
            , p.purchased_or_made
            , p.is_salable
            , p.product_color
            , p.standard_cost
            , p.list_price
            , p.class
            , p.style
        from stg_products p
        left join stg_product_models pm on
            p.product_model_id = pm.product_model_id
        left join stg_product_subcategories ps on 
            p.product_subcategory_id = ps.product_subcategory_id
        left join stg_categories pc on 
            ps.product_category_id = pc.product_category_id
    )
select
    {{ dbt_utils.generate_surrogate_key(['product_id']) }} as product_sk
    , *
from dim_products