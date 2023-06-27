with
    customers as (
        select *
        from {{ source('sap_adw', 'customer') }}
    )

    , changes as (
        select
            cast(customerid as int) as customer_id
            , cast(storeid as int) as store_id
        from customers
    )
select *
from changes