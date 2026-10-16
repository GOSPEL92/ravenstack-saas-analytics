--Data Profiling in SSMS
--first analyst task — exploring the raw tables to understand their quality.
-- step 1 . List of Raw Tables
        --raw.ravensstack_accounts

       --raw.ravenstack_subscriptions

       --raw.ravenstack_feature_usage

       --raw_.ravenstack_support_tickets

       --raw.ravenstack_churn_events

--Step 2: Profiling Checklist for Each Table
--1. raw.ravenstack_accounts
-- Count total rows to understand dataset size
SELECT COUNT(*) AS total_rows FROM raw.ravenstack_accounts;

-- Check for missing account IDs (critical for joins and fact tables)
SELECT COUNT(*) AS null_account_ids 
FROM raw.ravenstack_accounts 
WHERE account_id IS NULL;

-- Identify duplicate account IDs (could indicate data quality issues)
SELECT account_id, COUNT(*) AS duplicate_count
FROM raw.ravenstack_accounts
GROUP BY account_id
HAVING COUNT(*) > 1;

-- Check signup date ranges to ensure values are realistic
SELECT MIN(signup_date) AS earliest_signup,
       MAX(signup_date) AS latest_signup
FROM raw.ravenstack_accounts;

--2 . raw.ravenstack_subscriptions
--Row Count
-- Count total subscriptions
SELECT COUNT(*) AS total_rows 
FROM raw.ravenstack_subscriptions;

--Nulls in Key Columns
-- Check for missing subscription IDs
SELECT COUNT(*) AS null_subscription_ids
FROM raw.ravenstack_subscriptions
WHERE subscription_id IS NULL;

-- Check for missing account IDs (important for joins)
SELECT COUNT(*) AS null_account_ids
FROM raw.ravenstack_subscriptions
WHERE account_id IS NULL;

--Duplicate IDs
-- Identify duplicate subscription IDs
SELECT subscription_id, COUNT(*) AS duplicate_count
FROM raw.ravenstack_subscriptions
GROUP BY subscription_id
HAVING COUNT(*) > 1;

--Date Validity
-- Check for invalid date ranges (end before start)
SELECT COUNT(*) AS invalid_dates
FROM raw.ravenstack_subscriptions
WHERE end_date < start_date;

-- Find earliest and latest subscription dates
SELECT MIN(start_date) AS earliest_start,
       MAX(end_date) AS latest_end
FROM raw.ravenstack_subscriptions;

--Numeric Values
-- Spot negative or unrealistic MRR/ARR values
SELECT *
FROM raw.ravenstack_subscriptions
WHERE mrr_amount < 0 OR arr_amount < 0;

--Flags & Status
-- Check distribution of churn_flag
SELECT churn_flag, COUNT(*) AS count
FROM raw.ravenstack_subscriptions
GROUP BY churn_flag;


--3. raw.ravenstack_feature_usage
--1. Row Count
-- Count total feature usage records
SELECT COUNT(*) AS total_rows 
FROM  raw.ravenstack_feature_usage;

--Nulls in Key Columns
-- Check for missing usage IDs
SELECT COUNT(*) AS null_usage_ids
FROM raw.ravenstack_feature_usage
WHERE usage_id IS NULL;

-- Check for missing subscription IDs (critical for joins)
SELECT COUNT(*) AS null_subscription_ids
FROM raw.ravenstack_feature_usage
WHERE subscription_id IS NULL;

--Duplicate IDs
-- Identify duplicate usage IDs
SELECT usage_id, COUNT(*) AS duplicate_count
FROM raw.ravenstack_feature_usage
GROUP BY usage_id
HAVING COUNT(*) > 1;


--Date Validity
-- Find earliest and latest usage dates
SELECT MIN(usage_date) AS earliest_usage,
       MAX(usage_date) AS latest_usage
FROM raw.ravenstack_feature_usage;

--Numeric Values
-- Spot negative or unrealistic usage counts/durations
SELECT *
FROM  raw.ravenstack_feature_usage
WHERE usage_count < 0 
   OR usage_duration_secs < 0 
   OR error_count < 0;

--Feature Distribution
-- Check how many distinct features are being used
SELECT feature_name, COUNT(*) AS usage_events
FROM raw.ravenstack_feature_usage
GROUP BY feature_name
ORDER BY usage_events DESC;


--4. raw.ravenstack_support_tickets
--Row Count
-- Count total support tickets
SELECT COUNT(*) AS total_rows 
FROM  raw.ravenstack_support_tickets;

--Nulls in Key Columns
-- Check for missing ticket IDs
SELECT COUNT(*) AS null_ticket_ids
FROM raw.ravenstack_support_tickets
WHERE ticket_id IS NULL;


--Duplicate IDs
-- Identify duplicate ticket IDs
SELECT ticket_id, COUNT(*) AS duplicate_count
FROM raw.ravenstack_support_tickets
GROUP BY ticket_id
HAVING COUNT(*) > 1;

--Date Validity
-- Find earliest and latest ticket dates
-- Find earliest and latest submitted/closed dates
SELECT MIN(submitted_at) AS earliest_submitted,
       MAX(closed_at) AS latest_closed
FROM raw.ravenstack_support_tickets;

--Numeric Values
-- Spot negative or unrealistic resolution times or satisfaction scores
-- Use TRY_CAST to avoid conversion errors
SELECT *
FROM raw.ravenstack_support_tickets
WHERE TRY_CAST(resolution_time_hours AS DECIMAL(10,2)) < 0
   OR TRY_CAST(satisfaction_score AS DECIMAL(3,1)) < 0
   OR TRY_CAST(satisfaction_score AS DECIMAL(3,1)) > 10;

  
 --Escalation Flag Distribution
 -- Check distribution of escalation_flag
SELECT escalation_flag, COUNT(*) AS count
FROM  raw.ravenstack_support_tickets
GROUP BY escalation_flag;

SELECT TOP 10 * FROM raw.ravenstack_support_tickets;


--5.raw.ravenstack_churn_events
--Row Count
-- Count total churn events
SELECT COUNT(*) AS total_rows 
FROM raw.ravenstack_churn_events;

--Nulls in Key Columns
-- Check for missing churn IDs
SELECT COUNT(*) AS null_churn_ids
FROM raw.ravenstack_churn_events
WHERE churn_event_id IS NULL;

-- Check for missing account IDs
SELECT COUNT(*) AS null_account_ids
FROM raw.ravenstack_churn_events
WHERE account_id IS NULL;

--Duplicate IDs
-- Identify duplicate churn IDs
SELECT churn_event_id, COUNT(*) AS duplicate_count
FROM raw.ravenstack_churn_events
GROUP BY churn_event_id
HAVING COUNT(*) > 1;

--Date Validity
-- Find earliest and latest churn event dates
SELECT MIN(churn_date) AS earliest_churn,
       MAX(churn_date) AS latest_churn
FROM raw.ravenstack_churn_events;

--Numeric Values
-- Spot negative or unrealistic churn-related metrics (if any exist, e.g., refund_amount)
SELECT *
FROM raw.ravenstack_churn_events
WHERE TRY_CAST(refund_amount_usd AS DECIMAL(10,2)) < 0;

--Reason Distribution
-- Check distribution of churn reasons
SELECT reason_code, COUNT(*) AS count
FROM raw.ravenstack_churn_events
GROUP BY reason_code
ORDER BY count DESC;
