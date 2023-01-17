{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_000_airbyte_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to cast each column to its adequate SQL type converted from the JSON schema type
-- depends_on: {{ ref('users_ab1') }}
select
    cast(id as {{ dbt_utils.type_bigint() }}) as id,
    cast(city as {{ dbt_utils.type_string() }}) as city,
    cast(email as {{ dbt_utils.type_string() }}) as email,
    cast(image as {{ dbt_utils.type_string() }}) as image,
    cast(phone as {{ dbt_utils.type_string() }}) as phone,
    cast(country as {{ dbt_utils.type_string() }}) as country,
    cast(job_type as {{ dbt_utils.type_string() }}) as job_type,
    cast(full_name as {{ dbt_utils.type_string() }}) as full_name,
    cast(job_title as {{ dbt_utils.type_string() }}) as job_title,
    cast(last_name as {{ dbt_utils.type_string() }}) as last_name,
    cast(first_name as {{ dbt_utils.type_string() }}) as first_name_2,
    cast(onboarding_completion as {{ dbt_utils.type_bigint() }}) as onboarding_completion,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at
from {{ ref('users_ab1') }}
-- users
where 1 = 1

