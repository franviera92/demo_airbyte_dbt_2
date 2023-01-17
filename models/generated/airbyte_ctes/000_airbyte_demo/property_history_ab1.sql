{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_000_airbyte_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to parse JSON blob stored in a single column and extract into separated field columns as described by the JSON Schema
-- depends_on: {{ source('000_airbyte_demo', '_airbyte_raw_property_history') }}
select
    {{ json_extract_scalar('_airbyte_data', ['id'], ['id']) }} as id,
    {{ json_extract_scalar('_airbyte_data', ['created'], ['created']) }} as created,
    {{ json_extract_scalar('_airbyte_data', ['propertykeynew'], ['propertykeynew']) }} as propertykeynew,
    {{ json_extract_scalar('_airbyte_data', ['propertykeyold'], ['propertykeyold']) }} as propertykeyold,
    {{ json_extract_scalar('_airbyte_data', ['propertyvaluenew'], ['propertyvaluenew']) }} as propertyvaluenew,
    {{ json_extract_scalar('_airbyte_data', ['propertyvalueold'], ['propertyvalueold']) }} as propertyvalueold,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ source('000_airbyte_demo', '_airbyte_raw_property_history') }} as table_alias
-- property_history
where 1 = 1

