with orders as (
    select * from {{ref('stg_sql_server_dbo__orders')}}
),
order_items as(
    select * from {{ref('stg_sql_server_dbo__order_items')}}
),
products as (
    select * from {{ref('stg_sql_server_dbo__products')}}
),
users as (
    select * from {{ref('stg_sql_server_dbo__users')}}
),
budget as (
    select * from {{ref('stg_google_sheets__budget')}}
)

select 
        p.name as product_name
       --,p.price
       --,o.status
       ,o.shipping_service
       ,ROUND(SUM(o.shipping_cost),2) as coste_total_por_shipping_service
       ,SUM(b.quantity) as cantidad_total_por_producto
       --,CONCAT (u.first_name, ' ', u.last_name) as usuario
from 
    orders o
    inner join order_items oi on o.order_id = oi.order_id
    inner join products p on oi.product_id = p.product_id
    inner join budget b on p.product_id = b.product_id
    inner join users u on o.user_id = u.user_id

where o.status = 'delivered'
and MONTHNAME(b.month) = 'Mar'
group by p.name,o.shipping_service
order by o.shipping_service


/*
shipped
delivered
preparing
*/

