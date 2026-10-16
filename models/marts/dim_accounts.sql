{{ config(materialized='view') }}

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
