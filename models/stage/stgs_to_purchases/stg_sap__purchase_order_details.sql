with
    purchase_order_details as (
        select *
        from {{ source('sap_adw', 'purchaseorderdetail') }}
    )

    , changes as (
        select
            cast(purchaseorderdetailid as int) as purchase_order_detail_id             
            , cast(purchaseorderid as int) as purchase_order_id
            , cast(productid as int) as product_id
            , cast(orderqty as int) as order_qty
            , cast(unitprice as numeric) as unit_price
            , cast(receivedqty as int) as received_qty
            , cast(rejectedqty as int) as rejected_qty
        from purchase_order_details
    )
select *
from changes