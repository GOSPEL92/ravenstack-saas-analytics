{{ config(materialized='view') }}

WITH subs AS (
    SELECT
        account_id,
        COALESCE(subscription_count,0) AS subscription_count,
        COALESCE(total_mrr,0) AS total_mrr,
        COALESCE(churned_subscriptions,0) AS churned_subscriptions,
        COALESCE(avg_subscription_duration_days,0) AS avg_subscription_duration_days
    FROM {{ ref('fct_subscriptions') }}
),
tickets AS (
    SELECT
        account_id,
        COUNT(ticket_id) AS ticket_count,
        AVG(resolution_time_hours) AS avg_resolution_time_hours,
        AVG(first_response_time_minutes) AS avg_first_response_time_minutes,
        AVG(satisfaction_score) AS avg_satisfaction_score,
        SUM(CASE WHEN escalation_flag = 1 THEN 1 ELSE 0 END) AS escalated_ticket_count
    FROM {{ ref('stg_ravenstack_support_tickets') }}
    GROUP BY account_id
),
accounts AS (
    SELECT
        account_id,
        industry,
        country,
        plan_tier
    FROM {{ ref('dim_accounts') }}
)

SELECT
    a.account_id,
    a.industry,
    a.country,
    a.plan_tier,
    COALESCE(s.subscription_count,0) AS subscription_count,
    COALESCE(s.total_mrr,0) AS total_mrr,
    COALESCE(s.churned_subscriptions,0) AS churned_subscriptions,
    COALESCE(s.avg_subscription_duration_days,0) AS avg_subscription_duration_days,
    COALESCE(t.ticket_count,0) AS ticket_count,
    t.avg_resolution_time_hours,              -- keep NULL if no tickets
    t.avg_first_response_time_minutes,        -- keep NULL if no tickets
    t.avg_satisfaction_score,                 -- keep NULL if no tickets
    COALESCE(t.escalated_ticket_count,0) AS escalated_ticket_count,

    -- Composite health score formula
    (
        (COALESCE(s.total_mrr,0) / NULLIF(COALESCE(s.subscription_count,0),0)) * 0.4
        + (10 - COALESCE(t.avg_resolution_time_hours,0)) * 0.2
        + COALESCE(t.avg_satisfaction_score,0) * 0.3
        - (COALESCE(s.churned_subscriptions,0) * 0.1)
    ) AS customer_health_score
FROM accounts a
LEFT JOIN subs s ON a.account_id = s.account_id
LEFT JOIN tickets t ON a.account_id = t.account_id;
