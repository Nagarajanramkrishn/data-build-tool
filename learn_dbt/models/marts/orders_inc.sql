
{{ config(
    materialized='incremental',
    unique_key='order_id',
    on_schema_change ='append_new_columns'
) }}

select
    order_id,
    customer_id,
    order_date,
    updated_at,
    total_amount,
    order_info
from {{ ref('stg_orders') }}

{% if is_incremental() %}
  where updated_at > (select max(updated_at) from {{ this }})
{% endif %}
