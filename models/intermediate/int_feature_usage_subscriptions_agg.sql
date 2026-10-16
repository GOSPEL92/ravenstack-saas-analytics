WITH base AS (
    SELECT
        f.subscription_id,
        s.account_id,
        s.plan_tier,
        s.is_trial,
        s.seats,
        f.usage_date,
        f.feature_name,
        SUM(f.usage_count) AS total_usage_count,
        SUM(f.usage_duration_secs) AS total_usage_duration_secs,
        SUM(f.error_count) AS total_error_count,
        MAX(CAST(f.is_beta_feature AS INT)) AS is_beta_feature
    FROM {{ ref('stg_ravenstack_feature_usage') }} f
    LEFT JOIN {{ ref('stg_ravenstack_subscriptions') }} s
      ON f.subscription_id = s.subscription_id
    GROUP BY
        f.subscription_id,
        s.account_id,
        s.plan_tier,
        s.is_trial,
        s.seats,
        f.usage_date,
        f.feature_name
)

SELECT * FROM base;
