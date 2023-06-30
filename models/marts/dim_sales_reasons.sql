with
    stg_sales_reasons as (
        select * 
        from {{ ref('stg_sap__sales_reasons') }}
    )

    , stg_header_sales_reasons as (
        select *
        from {{ ref('sta_sap__header_sales_reasons') }}
    )

    , dim_sales_reasons as (
        select
            hr.sales_order_id
            , string_agg(r.reason, ', ') as reason
        from stg_header_sales_reasons hr
        left join stg_sales_reasons r on 
            hr.sales_reason_id = r.sales_reason_id
        group by sales_order_id       
    )
select
    {{ dbt_utils.generate_surrogate_key(['sales_order_id']) }} as sales_order_sk
    , sales_order_id
    , reason
from dim_sales_reasons