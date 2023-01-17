{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_000_airbyte_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('000_airbyte_demo', '_airbyte_raw_config_item') }}
select
    {{ json_extract_scalar('_airbyte_data', ['propertykey'], ['propertykey']) }} as propertykey,
    {{ json_extract_scalar('_airbyte_data', ['propertyvalue'], ['propertyvalue']) }} as propertyvalue,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('000_airbyte_demo', '_airbyte_raw_config_item') }} as table_alias
-- config_item
where 1 = 1

