{{ config(materialized='view') }}

WITH source AS (
    SELECT
        usage_id,
        subscription_id,
        usage_date,
        feature_name,
        usage_count,
        usage_duration_secs,
        error_count,
        is_beta_feature
    FROM raw.ravenstack_feature_usage
)

SELECT
    TRIM(usage_id) AS usage_id,
    TRIM(subscription_id) AS subscription_id,
    CAST(usage_date AS DATE) AS usage_date,
    LOWER(TRIM(feature_name)) AS feature_name,
    CAST(usage_count AS INT) AS usage_count,
    CAST(usage_duration_secs AS INT) AS usage_duration_secs,
    CAST(error_count AS INT) AS error_count,
    CAST(is_beta_feature AS BIT) AS is_beta_feature
FROM source;
