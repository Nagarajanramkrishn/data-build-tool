
with source_customers as (
    -- This CTE selects the relevant columns from the source table
    select *
    from {{ source('debezium', 'customers') }} 
)

select * from source_customers 