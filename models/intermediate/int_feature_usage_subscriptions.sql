{{ config(materialized='view') }}

WITH feature_usage AS (
    SELECT *
    FROM {{ ref('stg_ravenstack_feature_usage') }}
),
subscriptions AS (
    SELECT *
    FROM {{ ref('stg_ravenstack_subscriptions') }}
)

SELECT
    f.usage_id,
    f.subscription_id,
    s.account_id,
    s.plan_tier,
    s.is_trial,
    s.seats,
    f.usage_date,
    f.feature_name,
    f.usage_count,
    f.usage_duration_secs,
    f.error_count,
    f.is_beta_feature
FROM feature_usage f
LEFT JOIN subscriptions s
    ON f.subscription_id = s.subscription_id;
