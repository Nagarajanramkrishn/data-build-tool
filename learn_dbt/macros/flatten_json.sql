{% macro flatten_json(model_name, json_column) %}

{% set json_column_query %}
SELECT DISTINCT key AS column_name
FROM (
  SELECT
    REGEXP_EXTRACT_ALL(TO_JSON_STRING({{ json_column }}), r'"([^"]+)":') AS keys
  FROM {{ model_name }}
),
UNNEST(keys) AS key
{% endset %}

{% set query_result = run_query(json_column_query) %}

{% if execute %}
  {% set column_names = query_result.columns[0].values() %}
{% else %}
  {% set column_names = [] %}
{% endif %}

SELECT
  {{ json_column }},
  {% if column_names | length == 0 %}
    NULL AS no_columns_found
  {% endif %}
  {% for column_name in column_names %}
    JSON_VALUE({{ json_column }}, '$.{{ column_name }}') AS {{ column_name }}{% if not loop.last %},{% endif %}
  {% endfor %}
FROM {{ model_name }}

{% endmacro %}