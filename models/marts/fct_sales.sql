with
    dim_addresses as (
        select *
        from {{ ref('dim_addresses') }}
    )

    , dim_credit_cards as (
        select *
        from {{ ref('dim_credit_cards') }}
    )

    , dim_customers as (
        select *
        from {{ ref('dim_customers') }}
    )
    
    , dim_products as (
        select *
        from {{ ref('dim_products') }}
    )

    , dim_sales_person as (
        select *
        from {{ ref('dim_sales_person') }}
    )

    , dim_sales_reasons as (
        select *
        from {{ ref('dim_sales_reasons') }}
    )

    , dim_special_offers as (
        select *
        from {{ ref('dim_special_offers') }}
    )

    , int_sales_order_details as (
        select *
        from {{ ref('int_sales_order_details') }}
    )

    , fct_sales as (
        select 
            sd.sales_order_detail_id
            , sd.sales_order_id
            , p.product_sk as product_fk
            , so.special_offer_sk as special_offer_fk
            , c.customer_sk as customer_fk 
            , sp.sales_person_sk as sales_person_fk
            , a.address_sk as address_fk 
            , cc.credit_card_sk as credit_card_fk
            , sd.ship_address_id
            , sd.order_date
            , sd.max_delivery_date
            , sd.ship_date
            , c.customer_name
            , a.continent
            , case 
                when sp.name is null then "Sold Online"
            else sp.name
            end as sales_person
            , p.product_name
            , case
                when ss.reason is null then "No Informed"
            else ss.reason
            end as sales_reason        
            , sd.order_qty
            , sd.unit_price
            , sd.discount_pct
            , p.standard_cost
            , p.list_price
            , sd.order_status
            , sd.sold_by            
            , sd.subtotal -- calculated on int_sales_order_details
            , subtotal * tax_amt_pct as tax_amt
            , subtotal * freight_pct as freight
        from int_sales_order_details sd
        left join dim_addresses a on 
            sd.bill_address_id = a.address_id
        left join dim_credit_cards cc on
            sd.credit_card_id = cc.credit_card_id
         left join dim_customers c on 
            sd.customer_id = c.customer_id
        left join dim_products p on
            sd.product_id = p.product_id
        left join dim_sales_person sp on
            sd.sales_person_id = sp.sales_person_id
        left join dim_sales_reasons ss on 
            sd.sales_order_id = ss.sales_order_id
        left join dim_special_offers so on 
            sd.special_offer_id = so.special_offer_id
    )
select
    {{ dbt_utils.generate_surrogate_key(['sales_order_detail_id', 'sales_order_id']) }} as sales_sk
    , *
    , subtotal + tax_amt + freight as total_due
from fct_sales