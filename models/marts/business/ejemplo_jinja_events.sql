
{%- set event_types = dbt_utils.get_column_values(table=ref('stg_sql_server_dbo__events'), column='event_type') -%}

/*aqui he usado la marco de dbt_utils porque ya existía, pero también podría haber usado la macro obtener_valores
que creé precisamente para este ejercicio*/

with stg_events as (
    select * 
    from {{ ref('stg_sql_server_dbo__events') }}
    ),
renamed_casted as (
    select
        user_id,
        {%- for event_type in event_types %}
            sum(
                case when event_type = '{{event_type}}' then 1 end
            ) as {{ event_type }}_amount
            {%- if not loop.last %},{% endif -%}
        {% endfor %}
    from stg_events
    group by 1
)

select *
from
    renamed_casted

    /*
checkout
package_shipped
add_to_cart
page_view


--{%- set event_types = obtener_valores(ref('stg_sql_server_dbo__events'), 'event_type') -%}
*/
    
