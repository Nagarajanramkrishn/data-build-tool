with customers as (
    select * from {{ ref('stg_debezium_customers') }}
),
country_lookup as (
    select * from {{ ref('country_codes') }}
)

select
    c.*,
    cc.country_name,
    cc.continent
from customers c
left join country_lookup cc
    on c.country_code = cc.country_code