{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_000_airbyte_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('property_history_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'created',
        'propertykeynew',
        'propertykeyold',
        'propertyvaluenew',
        'propertyvalueold',
    ]) }} as _airbyte_property_history_hashid,
    tmp.*
from {{ ref('property_history_ab2') }} tmp
-- property_history
where 1 = 1

