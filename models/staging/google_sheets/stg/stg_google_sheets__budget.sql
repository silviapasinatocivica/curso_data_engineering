with budget_raw as (
    select * from {{ ref("base_google_sheets__budget") }}
)

select   
    _row,
    md5(_row||month||product_id) as prod_per_month,
    {{ dbt_utils.generate_surrogate_key(['_row', 'month','product_id']) }} as prod_per_month2,
    quantity,
    month,
    product_id,
    _fivetran_synced
from budget_raw