{% macro obtener_valores(table, column) %}
    --preparamos la query
    {% set query_sql %}
        select distinct {{column}} from {{table}}
    {% endset %}
    --ejecutamos la query
    {% set results = run_query(query_sql) %}
    --en caso de que se ejecute
    {% if execute %}
        --devolvemos los valores de la primera columna
        {% set results_list = results.columns[0].values() %}
    {% else %}
        {% set results_list = [] %}
    {% endif %}

{{return(results_list)}}
{% endmacro %}