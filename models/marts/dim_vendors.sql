with
    stg_product_vendors as (
        select *
        from {{ ref('stg_sap__product_vendors') }}
    )

    , stg_vendors as (
        select *
        from {{ ref('stg_sap__vendors') }}
    )

    , dim_vendors as (
        select 
            v.vendor_id
            , pv.product_id
            , v.vendor_name
            , v.is_preferred
            , pv.standard_price
        from stg_vendors v
        left join stg_product_vendors pv on
            v.vendor_id = pv.vendor_id
    )
select
    {{ dbt_utils.generate_surrogate_key(['vendor_id', 'product_id']) }} as vendor_sk
    , *
from dim_vendors