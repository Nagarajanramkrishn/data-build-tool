{% snapshot order_shipping_snapshot %}

{{
    config(
        target_schema='snapshots',
    
        unique_key='order_id',
        strategy='timestamp',
        updated_at='updated_at'
    )
}}
select * from {{ source('shipping_platform', 'order_shipping') }}

{% endsnapshot %}

