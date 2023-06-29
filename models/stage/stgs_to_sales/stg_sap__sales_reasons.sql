with
    sales_reasons as (
        select * 
        from {{ source('sap_adw', 'salesreason') }}
    )

    , changes as (
        select
            cast(salesreasonid as int) as sales_reason_id
            , cast(name as string) as reason
        from sales_reasons
    )
select *
from changes