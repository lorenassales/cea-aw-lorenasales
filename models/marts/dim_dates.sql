with date_series as (
    {{ dbt_utils.date_spine( 
        datepart="day",
        start_date="cast('2011-01-01' as date)",
        end_date="cast('2014-12-31' as date)"
    )}}
)

, date_columns as (
    select distinct
        cast(date_day as date) as date
        , extract(day from date_day) as day_month
        , extract(month from date_day) as nb_month
        , extract(year from date_day) as year
        , extract(quarter from date_day) as quarter
        , extract(dayofyear from date_day) as day_year        
        , case
            when
                extract(day from date_day) != 1 and extract(dayofweek from date_day) = 1
                then extract(week from date_day)-1
            else extract(week from date_day)
        end as week
        , case
            when extract(dayofweek from date_day) = 1 then 'Sunday'
            when extract(dayofweek from date_day) = 2 then 'Monday'
            when extract(dayofweek from date_day) = 3 then 'Tuesday'
            when extract(dayofweek from date_day) = 4 then 'Wednesday'
            when extract(dayofweek from date_day) = 5 then 'Thursday'
            when extract(dayofweek from date_day) = 6 then 'Friday'
            when extract(dayofweek from date_day) = 7 then 'Saturday'
        end as day_week
        , case
            when extract(month from date_day) = 1 then 'Jan'
            when extract(month from date_day) = 2 then 'Feb'
            when extract(month from date_day) = 3 then 'Mar'
            when extract(month from date_day) = 4 then 'Apr'
            when extract(month from date_day) = 5 then 'May'
            when extract(month from date_day) = 6 then 'June'
            when extract(month from date_day) = 7 then 'July'
            when extract(month from date_day) = 8 then 'Aug'
            when extract(month from date_day) = 9 then 'Sept'
            when extract(month from date_day) = 10 then 'Oct'
            when extract(month from date_day) = 11 then 'Nov'
            when extract(month from date_day) = 12 then 'Dec'
        end as month
    from date_series
)

, transformed as (
    select
        *
        , concat(month, '-', cast(year as string)) as month_year
        , concat('T', cast(quarter as string), '-', cast(year as string)) as quarter_year        
    from date_columns
)

select *
from transformed