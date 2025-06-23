{% macro audit_log(run_activity) %}

{% set audit_schema = 'debezium' %}
{% set audit_table = 'dbt_audits' %}


{%  set audit_query %}

{% if this.name %}

insert into {{ target.database }}.{{ audit_schema }}.{{ audit_table }}
values (
    '{{ invocation_id }}', 
    '{{ this.name }}',
    '{{ run_activity }}',
    current_timestamp()
);

{% else %}

insert into {{ target.database }}.{{ audit_schema }}.{{ audit_table }}
values (
    '{{ invocation_id }}', 
    'N/A',
    '{{ run_activity }}',
    current_timestamp()
);

{% endif %}
{% endset %}
{% do run_query(audit_query) %}

{% endmacro %}




{% macro audit_prep() %}

  {% set audit_schema = 'debezium' %}
  {% set audit_table = 'dbt_audits' %}

  {% set audit_prep_query %}
    CREATE TABLE IF NOT EXISTS {{ target.database }}.{{ audit_schema }}.{{ audit_table }} (
      run_id STRING,
      run_object STRING,
      run_activity STRING,
      created_at TIMESTAMP
    )
  {% endset %}

  {% do run_query(audit_prep_query) %}

{% endmacro %}  