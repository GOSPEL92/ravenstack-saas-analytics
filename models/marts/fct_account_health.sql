{{ config(materialized='table') }}

WITH subscriptions AS (
    SELECT
        account_id,
        COUNT(*) AS subscription_count,
        MAX(plan_tier) AS current_plan
    FROM {{ ref('int_feature_usage_subscriptions_agg') }}
    GROUP BY account_id
),

tickets AS (
    SELECT
        account_id,
        COUNT(*) AS support_ticket_count,
        AVG(resolution_time_hours) AS avg_resolution_time,
        AVG(satisfaction_score) AS avg_satisfaction_score
    FROM {{ ref('int_support_tickets_accounts') }}
    GROUP BY account_id
),

accounts AS (
    SELECT
        account_id,
        account_name,
        industry,
        country,
        signup_date,
        referral_source,
        plan_tier,
        seats,
        is_trial,
        churn_flag
    FROM {{ ref('stg_ravenstack_accounts') }}
)

SELECT
    a.account_id,
    a.account_name,
    a.industry,
    a.country,
    a.signup_date,
    a.referral_source,
    a.plan_tier,
    a.seats,
    a.is_trial,
    a.churn_flag,
    COALESCE(s.subscription_count, 0) AS subscription_count,
    s.current_plan,
    COALESCE(t.support_ticket_count, 0) AS support_ticket_count,
    COALESCE(t.avg_resolution_time, 0) AS avg_resolution_time,
    t.avg_satisfaction_score   -- keep NULL if no tickets
FROM accounts a
LEFT JOIN subscriptions s ON a.account_id = s.account_id
LEFT JOIN tickets t ON a.account_id = t.account_id;
