{{ config(materialized='view') }}

WITH subscriptions AS (
    SELECT *
    FROM {{ ref('stg_ravenstack_subscriptions') }}
),
accounts AS (
    SELECT *
    FROM {{ ref('stg_ravenstack_accounts') }}
)

SELECT
    s.subscription_id,
    s.account_id,
    a.account_name,
    a.industry,
    a.country,
    s.start_date,
    s.end_date,
    s.plan_tier,
    s.seats,
    s.mrr_amount,
    s.arr_amount,
    s.is_trial,
    s.upgrade_flag,
    s.downgrade_flag,
    s.churn_flag,
    s.billing_frequency,
    s.auto_renew_flag
FROM subscriptions s
LEFT JOIN accounts a
    ON s.account_id = a.account_id;
