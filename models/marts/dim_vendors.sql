with
    dim_vendors as (
        select *
        from {{ ref('stg_sap__vendors') }}
    )    
select 
    {{ dbt_utils.generate_surrogate_key(['vendor_id']) }} as vendor_sk
    , *
from dim_vendors
      