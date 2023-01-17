{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_000_airbyte_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('property_history_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast({{ empty_string_to_null('created') }} as {{ type_timestamp_without_timezone() }}) as created,
    cast(propertykeynew as {{ dbt_utils.type_string() }}) as propertykeynew,
    cast(propertykeyold as {{ dbt_utils.type_string() }}) as propertykeyold,
    cast(propertyvaluenew as {{ dbt_utils.type_string() }}) as propertyvaluenew,
    cast(propertyvalueold as {{ dbt_utils.type_string() }}) as propertyvalueold,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('property_history_ab1') }}
-- property_history
where 1 = 1

