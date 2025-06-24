{% macro generate_schema_name(custom_schema_name, node) %}
    {{ custom_schema_name }}
{% endmacro %}

--para evitar que me anteponga el prefijo spasinato_ al schema de cada modelo cuando lo crea en silver