with
    header_sales_reason as (
        select *
        from {{ source('sap_adw', 'salesorderheadersalesreason') }}
    )

    , changes as (
        select
            cast(salesorderid as int) as sales_order_id
            , cast(salesreasonid as int) as sales_reason_id
        from header_sales_reason
    )
select *
from changes