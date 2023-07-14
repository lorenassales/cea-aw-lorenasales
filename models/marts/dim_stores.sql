with
    stg_stores as (
        select *
        from {{ ref('stg_sap__stores') }}
    )
select 
    {{ dbt_utils.generate_surrogate_key(['store_id']) }} as store_sk
    , *
from stg_stores

