{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_000_airbyte_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('000_airbyte_demo', '_airbyte_raw_bookings') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['user_id'], ['user_id']) }} as user_id,
    {{ json_extract_scalar('_airbyte_data', ['booked_at'], ['booked_at']) }} as booked_at,
    {{ json_extract_scalar('_airbyte_data', ['confirmed'], ['confirmed']) }} as confirmed,
    {{ json_extract_scalar('_airbyte_data', ['starts_at'], ['starts_at']) }} as starts_at,
    {{ json_extract_scalar('_airbyte_data', ['booked_for'], ['booked_for']) }} as booked_for,
    {{ json_extract_scalar('_airbyte_data', ['apartment_id'], ['apartment_id']) }} as apartment_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('000_airbyte_demo', '_airbyte_raw_bookings') }} as table_alias
-- bookings
where 1 = 1

