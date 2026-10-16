{{ config(materialized='view') }}

WITH source AS (
    SELECT
        churn_event_id,
        account_id,
        churn_date,
        reason_code,
        refund_amount_usd,
        preceding_upgrade_flag,
        preceding_downgrade_flag,
        is_reactivation,
        feedback_text
    FROM raw.ravenstack_churn_events
)

SELECT
    TRIM(churn_event_id) AS churn_event_id,
    TRIM(account_id) AS account_id,
    CAST(churn_date AS DATE) AS churn_date,
    CASE 
        WHEN LOWER(TRIM(reason_code)) IN ('pricing','service_issue','competition','feature_gap','other')
        THEN LOWER(TRIM(reason_code))
        ELSE 'other'
    END AS reason_code,
    CAST(refund_amount_usd AS DECIMAL(18,2)) AS refund_amount_usd,
    CAST(preceding_upgrade_flag AS BIT) AS preceding_upgrade_flag,
    CAST(preceding_downgrade_flag AS BIT) AS preceding_downgrade_flag,
    CAST(is_reactivation AS BIT) AS is_reactivation,
    TRIM(feedback_text) AS feedback_text
FROM source;
