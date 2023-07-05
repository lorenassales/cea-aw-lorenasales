with
    people as (
        select *
        from {{ source('sap_adw', 'person') }}
    )

    , changes as (
        select
            cast(businessentityid as int) as person_id
            , case cast(trim(persontype) as string)
                when "SC" then "Store Contact"
                when "IN" then "Retail Customer"
                when "SP" then "Sales Person"
                when "EM" then "Employee"
                when "VC" then "Vendor Contact"
                when "GC" then "General Contact"
            else "other"
            end as person_type
            , cast((firstname || " " || lastname) as string) as person_name           
        from people
    )
select *
from changes