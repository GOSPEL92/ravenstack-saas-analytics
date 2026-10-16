{{ config(materialized='view') }}

WITH subscriptions AS (
    SELECT
        account_id,
        subscription_id,
        plan_tier,
        start_date,
        end_date,
        seats,
        mrr_amount,
        arr_amount,
        churn_flag
    FROM {{ ref('stg_ravenstack_subscriptions') }}
)

SELECT
    s.account_id,
    COUNT(s.subscription_id) AS subscription_count,
    SUM(s.seats) AS total_seats,
    SUM(s.mrr_amount) AS total_mrr,
    SUM(s.arr_amount) AS total_arr,
    SUM(CASE WHEN s.churn_flag = 1 THEN 1 ELSE 0 END) AS churned_subscriptions,
    AVG(DATEDIFF(day, s.start_date, COALESCE(s.end_date, GETDATE()))) AS avg_subscription_duration_days
FROM subscriptions s
GROUP BY s.account_id;
