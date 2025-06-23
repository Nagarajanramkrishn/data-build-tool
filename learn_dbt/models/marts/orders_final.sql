{{
    config(
        materialized= 'table'
    )
}}

with cutomer_orders as(
    select * from {{ ref('int_customer_and_orders_joined') }}
)

select * from cutomer_orders

