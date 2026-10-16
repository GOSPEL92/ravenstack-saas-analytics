SELECT
    subscription_id,
    feature_name,
    usage_date,
    COUNT(*) AS row_count
FROM {{ ref('int_feature_usage_subscriptions_agg') }}
GROUP BY subscription_id, feature_name, usage_date
HAVING COUNT(*) > 1
