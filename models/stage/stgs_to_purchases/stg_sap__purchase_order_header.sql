with
    purchase_order_header as (
        select *
        from {{ source('sap_adw', 'purchaseorderheader') }}
    )

    , changes as (
        select
            cast(purchaseorderid as int) as purchase_order_id
            , cast(employeeid as int) as employee_id
            , cast(vendorid as int) as vendor_id
            , cast(orderdate as datetime) as order_date
            , cast(shipdate  as datetime) as ship_date
            , cast(revisionnumber as int) as revision_qty
            , case cast(status as numeric)
                when 1 then "Pending"
                when 2 then "Approved"
                when 3 then "Rejected"
                when 4 then "Complete"
            else "unknown"
            end as order_status
            , cast(subtotal as numeric) as subtotal
            , cast(taxamt as numeric) as tax_amt
            , cast(freight as numeric) as freight
        from purchase_order_header
    )
select *
from changes