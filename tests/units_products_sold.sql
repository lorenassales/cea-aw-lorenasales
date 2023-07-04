{{
    config(
        severity = 'error'
    )
}}
with
    products_sold as (
        select
            sum(order_qty) as units_sold
        from {{ ref('fct_sales') }}
        where order_date between '2014-01-01' and '2014-12-31'
    )
select units_sold
from products_sold
where units_sold <> 61659.0