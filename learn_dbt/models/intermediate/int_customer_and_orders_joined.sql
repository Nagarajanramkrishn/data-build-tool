with customers as(
    select * from {{ ref('stg_debezium_customers') }}

),

orders as (
    select * from {{ ref('stg_orders') }}

),

final as (

    select c.customer_id,
            CONCAT(c.first_name, ' ', c.last_name) AS full_name,
            c.country_code,
            o.order_id,
            o.order_date,
            o.total_amount

    from customers c
    left join orders o on c.customer_id = o.customer_id
)

select * from final
 