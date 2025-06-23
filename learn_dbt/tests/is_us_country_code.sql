select  email
from {{ ref('stg_debezium_customers') }}
where country_code = 'US'
  and email is null