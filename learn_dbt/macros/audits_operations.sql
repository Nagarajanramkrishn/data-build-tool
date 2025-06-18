{% macro insert_audits(action_name) -%}

insert into debezium.audit_log (audit_type)
values('{{ action_name }}');

{%- endmacro %}