with
    product_models as (
        select *
        from {{ source('sap_adw', 'productmodel') }}
    )

    , changes as (
        select
            cast(productmodelid as int) as product_model_id
            , cast(name as string) as model_name
        from product_models
    )
select *
from changes