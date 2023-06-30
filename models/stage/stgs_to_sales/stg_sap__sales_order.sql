with
    sales_order as (
        select *
        from {{ source('sap_adw', 'salesorderheader') }}
    )

    , changes as (
        select          
            cast(salesorderid as int) as sales_order_id            
            , cast(customerid as int) as customer_id
            , cast(salespersonid as int) as sales_person_id            
            , cast(territoryid as int) as territory_id
            , cast(creditcardid as int) as credit_card_id
            , cast(shiptoaddressid as int) as ship_address_id         
            , cast(orderdate as datetime) as order_date          
            , cast(duedate as datetime) as max_delivery_date
            , cast(shipdate as datetime) as ship_date
            , case cast(status as numeric)
                when 1 then "In process"
                when 2 then "Approved"
                when 3 then "Backordered"
                when 4 then "Rejected"
                when 5 then "shipped"
                when 6 then "Cancelled"
            else "unknown"
            end as order_status
            , case cast(onlineorderflag as boolean)
                when false then "Sales Person"
                when true then "Online"
            else "unknown"
            end as sold_by
            , cast(subtotal as numeric) as subtotal
            , cast(taxamt as numeric) as tax_amt
            , cast(freight as numeric) as freight
            , cast(totaldue as numeric) as total_due
        from sales_order
    )
select *
from changes