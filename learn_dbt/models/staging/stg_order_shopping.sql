with 
order_shopping as (

    select * from {{ ref('order_shipping_snapshot') }}

),

final as (
    select 
        shipping_id,
        order_id,
        status,
        updated_at,
        shipping_method,
        shipping_cost,
        dbt_scd_id,
        dbt_updated_at,
        dbt_valid_from,
        dbt_valid_to

    from order_shopping
    where
        dbt_valid_to is null
)

select * from final
