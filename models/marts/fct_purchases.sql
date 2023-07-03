with
    dim_vendors as (
        select *
        from {{ ref('dim_vendors') }}
    )

    , dim_employees as (
        select *
        from {{ ref('dim_employees') }}
    )

    , int_purchase_order_details as (
        select *
        from {{ ref('int_purchase_order_details') }}
    )

    , fct_purchase as (
        select
            pd.purchase_order_detail_id
            , pd.purchase_order_id
            , pd.product_id
            , e.employee_id
            , v.vendor_id
            , pd.order_date
            , pd.ship_date
            , v.vendor_name           
            , e.name as employee_name
            , pd.order_qty
            , pd.unit_price
            , pd.received_qty
            , pd.rejected_qty            
            , pd.revision_qty
            , pd.order_status
            , pd.subtotal
            , pd.tax_amt
            , pd.freight
        from int_purchase_order_details pd
        left join dim_vendors v on
            pd.vendor_id = v.vendor_id
        left join dim_employees e on 
            pd.employee_id = e.employee_id
    )
select 
    {{ dbt_utils.generate_surrogate_key(['purchase_order_detail_id', 'purchase_order_id']) }} as purchase_sk
    , *
    , subtotal + tax_amt + freight as total_due
from fct_purchase