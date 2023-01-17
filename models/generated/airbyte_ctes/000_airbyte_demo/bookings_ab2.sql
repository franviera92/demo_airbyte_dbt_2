{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_000_airbyte_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('bookings_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(user_id as {{ dbt_utils.type_bigint() }}) as user_id,
    cast(booked_at as {{ dbt_utils.type_string() }}) as booked_at,
    cast(confirmed as {{ dbt_utils.type_bigint() }}) as confirmed,
    cast(starts_at as {{ dbt_utils.type_string() }}) as starts_at,
    cast(booked_for as {{ dbt_utils.type_bigint() }}) as booked_for,
    cast(apartment_id as {{ dbt_utils.type_bigint() }}) as apartment_id,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('bookings_ab1') }}
-- bookings
where 1 = 1

