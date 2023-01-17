{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_000_airbyte_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('config_item_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'propertykey',
        'propertyvalue',
    ]) }} as _airbyte_config_item_hashid,
    tmp.*
from {{ ref('config_item_ab2') }} tmp
-- config_item
where 1 = 1

