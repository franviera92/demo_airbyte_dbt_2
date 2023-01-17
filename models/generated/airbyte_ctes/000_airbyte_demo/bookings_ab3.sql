{{ config(
    cluster_by = "_airbyte_emitted_at",
    partition_by = {"field": "_airbyte_emitted_at", "data_type": "timestamp", "granularity": "day"},
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_000_airbyte_demo",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('bookings_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        'id',
        'user_id',
        'booked_at',
        'confirmed',
        'starts_at',
        'booked_for',
        'apartment_id',
    ]) }} as _airbyte_bookings_hashid,
    tmp.*
from {{ ref('bookings_ab2') }} tmp
-- bookings
where 1 = 1

