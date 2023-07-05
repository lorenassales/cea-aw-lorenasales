with
    stg_sales_order as (
        select *
        from {{ ref('stg_sap__sales_order') }}
    )

    , stg_sales_order_details as (
        select *
        from {{ ref('stg_sap__sales_order_details') }}
    )

    , int_sales_order_details as (
        select
            sd.sales_order_detail_id
            , so.sales_order_id
            , sd.product_id
            , sd.special_offer_id
            , so.customer_id
            , so.sales_person_id
            , so.territory_id
            , so.credit_card_id
            , so.bill_address_id
            , so.ship_address_id
            , so.order_date
            , so.max_delivery_date
            , so.ship_date
            , sd.order_qty
            , sd.unit_price
            , sd.discount_pct            
            , so.order_status
            , so.sold_by
             /* Columns below were removed, because before i made join's, their math are not correct anymore
            , so.subtotal
            , so.tax_amt
            , so.freight
            , so.total_due */
            , (unit_price * order_qty) * (1-discount_pct) as subtotal
            , tax_amt/subtotal as tax_amt_pct
            , freight/subtotal as freight_pct
        from stg_sales_order_details sd
        left join stg_sales_order so on
            sd.sales_order_id = so.sales_order_id
    )
select *
from int_sales_order_details