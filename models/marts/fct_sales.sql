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

    , int_sales_order_details as (
        select *
        from {{ ref('int_sales_order_details') }}
    )

    , fct_sales as (
        select 
            sd.sales_order_detail_id
            , sd.sales_order_id
            , p.product_sk as product_fk
            , sp.special_offer_sk as special_offer_fk
            , c.customer_sk as customer_fk 
            , sp.sales_person_sk as sales_person_fk
            , a.address_sk as address_fk
            , cc.credit_card_sk as credit_card_fk
            , sd.ship_address_id
            , sd.order_date
            , sd.max_delivery_date
            , sd.ship_date
            , c.customer_name
            , sp.name as sales_person
            , p.product_name
            , p.category_name
            , p.subcategory_name
            , sd.order_qty
            , sd.unit_price
            , sd.discount_pct
            , sd.order_status
            , sd.sold_by            
            , sd.subtotal
            , sd.tax_amt
            , sd.freight
            , sd.total_due
        from int_sales_order_details sd
        left join dim_addresses a on 
            sd.territory_id = a.territory_id
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

    )
select
    {{ dbt_utils.generate_surrogate_key(['sales_order_detail_id', 'sales_order_id']) }} as sales_sk
    , *
from fct_sales