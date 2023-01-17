{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_000_airbyte_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('appartments_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(name as {{ dbt_utils.type_string() }}) as name,
    cast(image as {{ dbt_utils.type_string() }}) as image,
    cast(booked as {{ dbt_utils.type_bigint() }}) as booked,
    cast(address as {{ dbt_utils.type_string() }}) as address,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(address2 as {{ dbt_utils.type_string() }}) as address2,
    cast(latitude as {{ dbt_utils.type_float() }}) as latitude,
    cast(zip_code as {{ dbt_utils.type_string() }}) as zip_code,
    cast(direction as {{ dbt_utils.type_string() }}) as direction,
    cast(longitude as {{ dbt_utils.type_float() }}) as longitude,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('appartments_ab1') }}
-- appartments
where 1 = 1

