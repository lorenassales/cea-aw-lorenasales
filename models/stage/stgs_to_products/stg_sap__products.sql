with
    products as (
        select *
        from {{ source('sap_adw', 'product') }}
    )

    , changes as (
        select
            cast(productid as int) as product_id
            , cast(productsubcategoryid as int) as product_subcategory_id
            , cast(productmodelid as int) as product_model_id
            , cast(name as string) as product_name
            , case cast(makeflag as boolean)
                when false then "Purchased"
                when true then "Made"
                else "unknown"
                end as purchased_or_made  
            , case cast(finishedgoodsflag as boolean)
                when false then "Not salable"
                when true then "Salable"
                else "unknown"
                end as is_salable  
            , cast(color as string) as product_color            
            , cast(standardcost as numeric) as standard_cost
            , cast(listprice as numeric) as list_price            
            , case cast(trim(class) as string)
                when "L" then "Low"
                when "M" then "Medium"
                when "H" then "High"
            else "non"
            end as class
            , case cast(trim(style) as string)
                when "W" then "Womens"
                when "H" then "Mens"
                when "U" then "Universal"
            else "Universal"
            end as style 
        from products
    )
select *
from changes