with orders as (
    select order_id,
            customer_id,
            order_date,
            total_amount,
            updated_at,
            order_info
    from {{ source('debezium', 'orders') }}
)
select * from orders
