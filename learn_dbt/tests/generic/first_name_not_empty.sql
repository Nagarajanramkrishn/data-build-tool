{% test first_name_not_empty(model, column_name) %}

{% do log("Running first_name_not_empty on model: " ~ model ~ ", column: " ~ column_name, info=True) %}

select {{ column_name }} 
from {{ model }}
where {{ column_name }} is null

{% endtest %}
