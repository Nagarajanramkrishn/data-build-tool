{% test is_us_country_code(model, column_name) %}

    select 
        {{ column_name }} as country_code
    from {{ model }}
    where {{ column_name}} = 'US'


{% endtest %}