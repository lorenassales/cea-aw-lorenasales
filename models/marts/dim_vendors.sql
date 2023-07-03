with
    dim_vendors as (
        select *
        from {{ ref('stg_sap__vendors') }}
    )    
select *
from dim_vendors
      