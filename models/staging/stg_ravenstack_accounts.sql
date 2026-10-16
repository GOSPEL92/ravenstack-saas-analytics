{{ config(materialized='view') }}

WITH source AS (
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
    FROM raw.ravenstack_accounts
)

SELECT
    TRIM(account_id) AS account_id,
    TRIM(account_name) AS account_name,
    LOWER(TRIM(industry)) AS industry,
    LOWER(TRIM(country)) AS country,
    CAST(signup_date AS DATE) AS signup_date,
    LOWER(TRIM(referral_source)) AS referral_source,
    LOWER(TRIM(plan_tier)) AS plan_tier,
    CAST(seats AS INT) AS seats,
    CAST(is_trial AS BIT) AS is_trial,
    CAST(churn_flag AS BIT) AS churn_flag
FROM source;
