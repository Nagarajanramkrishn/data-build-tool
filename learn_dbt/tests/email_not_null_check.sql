
select  email
from {{ ref('stg_debezium_customers') }}
where email is null