{{
    config(
        severity = 'error'
    )
}}
with
    general_sales as (
        select
            sum(total_due) as total_sales
        from {{ ref('fct_sales') }}        
    )
select total_sales
from general_sales
where total_sales not between 123216786.00 and 123216787.00