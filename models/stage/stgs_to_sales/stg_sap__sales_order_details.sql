with
    sales_order_details as (
        select *
        from {{ source('sap_adw', 'salesorderdetail') }}
    )

    , changes as (
        select
            cast(salesorderdetailid as int) as sales_order_detail_id
            , cast(salesorderid as int) as sales_order_id            
            , cast(productid as int) as product_id
            , cast(specialofferid as int) as special_offer_id
            , cast(orderqty as int) as order_qty
            , cast(unitprice as numeric) as unit_price
            , cast(unitpricediscount as numeric) as discount_pct
        from sales_order_details
    )
select *
from changes