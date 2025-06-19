-- column name query
-- This query extracts distinct keys from the JSON structure of artist_info in the debezium artist
{{ config(
    materialized='view'
)}}

{% set json_column_query %}
SELECT DISTINCT key AS column_name
FROM (
  SELECT
    REGEXP_EXTRACT_ALL(TO_JSON_STRING(artist_info), r'"([^"]+)":') AS keys
  FROM {{ source('debezium','artist_data') }}
),
UNNEST(keys) AS key
{% endset %}



{% set query_result = run_query(json_column_query) %}

{% if execute %}
{# Return the first column #}
{% set column_names = query_result.columns[0].values() %}{% else %}
{% set column_names = [] %}
{% endif %}

SELECT
  artist_info,
  {% for column_name in column_names %}
    JSON_VALUE(artist_info, '$.{{ column_name }}') AS {{ column_name }}{% if not loop.last %},{% endif %}
  {% endfor %}

FROM {{ source('debezium', 'artist_data') }}