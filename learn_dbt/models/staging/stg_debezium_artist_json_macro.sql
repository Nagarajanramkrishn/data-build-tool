with source_model as (

    {{ flatten_json(
        model_name=source('debezium', 'artist_data'),
        json_column='artist_info'
    )}}

),

final as (

    select
        artist_info,
        country as country_name,
        cast(debut_year as int64) as debut_year,
        genre as genre_type,
        name as artist_name -- selecting a coumn
    from source_model
)

select * from final