{{ config(materialized='view') }}

WITH churn AS (
    SELECT *
    FROM {{ ref('stg_ravenstack_churn_events') }}
),
accounts AS (
    SELECT *
    FROM {{ ref('stg_ravenstack_accounts') }}
)

SELECT
    c.churn_event_id,
    c.account_id,
    a.account_name,
    a.industry,
    a.country,
    c.churn_date,
    c.reason_code,
    c.refund_amount_usd,
    c.preceding_upgrade_flag,
    c.preceding_downgrade_flag,
    c.is_reactivation,
    c.feedback_text
FROM churn c
LEFT JOIN accounts a
    ON c.account_id = a.account_id;
