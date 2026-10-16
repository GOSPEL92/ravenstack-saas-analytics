{{ config(materialized='view') }}

WITH source AS (
    SELECT
        subscription_id,
        account_id,
        start_date,
        end_date,
        plan_tier,
        seats,
        mrr_amount,
        arr_amount,
        is_trial,
        upgrade_flag,
        downgrade_flag,
        churn_flag,
        billing_frequency,
        auto_renew_flag
    FROM raw.ravenstack_subscriptions
)

SELECT
    TRIM(subscription_id) AS subscription_id,
    TRIM(account_id) AS account_id,
    CAST(start_date AS DATE) AS start_date,
    CAST(end_date AS DATE) AS end_date,
    LOWER(TRIM(plan_tier)) AS plan_tier,
    CAST(seats AS INT) AS seats,
    CAST(mrr_amount AS DECIMAL(18,2)) AS mrr_amount,
    CAST(arr_amount AS DECIMAL(18,2)) AS arr_amount,
    CAST(is_trial AS BIT) AS is_trial,
    CAST(upgrade_flag AS BIT) AS upgrade_flag,
    CAST(downgrade_flag AS BIT) AS downgrade_flag,
    CAST(churn_flag AS BIT) AS churn_flag,
    LOWER(TRIM(billing_frequency)) AS billing_frequency,
    CAST(auto_renew_flag AS BIT) AS auto_renew_flag
FROM source;
