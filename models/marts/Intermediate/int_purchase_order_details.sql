with
    stg_purchase_header as (
        select * 
        from {{ ref('stg_sap__purchase_order_headers') }}
    )

    , stg_purchase_details as (
        select * 
        from {{ ref('stg_sap__purchase_order_details') }}
    )

    , int_purchase_details as (
        select
            pd.purchase_order_detail_id
            , pd.purchase_order_id
            , pd.product_id
            , ph.employee_id
            , ph.vendor_id
            , pd.order_qty
            , pd.unit_price
            , pd.received_qty
            , pd.rejected_qty            
            , ph.order_date
            , ph.ship_date
            , ph.revision_qty
            , ph.order_status
            , ph.subtotal
            , ph.tax_amt
            , ph.freight
        from stg_purchase_details pd
        left join stg_purchase_header ph on
            pd.purchase_order_id = ph.purchase_order_id
    )
select *
from int_purchase_details