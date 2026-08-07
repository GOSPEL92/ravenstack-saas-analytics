--Profiling Queries
--1. Count Rows in Each Table(this tells you the size of each dataset:)
SELECT COUNT(*) AS accounts_count FROM saas.accounts;
SELECT COUNT(*) AS features_count FROM saas.features;
SELECT COUNT(*) AS subscriptions_count FROM saas.subscriptions;
SELECT COUNT(*) AS tickets_count FROM saas.support_tickets;
SELECT COUNT(*) AS churn_count FROM saas.churn_events;

--2. Preview Sample Data(Quick look at the first few rows:)
SELECT TOP 10 * FROM saas.accounts;
SELECT TOP 10 * FROM saas.subscriptions;
SELECT TOP 10 * FROM saas.support_tickets;

-- 3. Uniqueness Checks
-- Accounts
SELECT account_id, COUNT(*) AS duplicates
FROM saas.accounts
GROUP BY account_id
HAVING COUNT(*) > 1;

-- Features
SELECT usage_id, COUNT(*) AS duplicates
FROM saas.features
GROUP BY usage_id
HAVING COUNT(*) > 1;

-- Subscriptions
SELECT subscription_id, COUNT(*) AS duplicates
FROM saas.subscriptions
GROUP BY subscription_id
HAVING COUNT(*) > 1;

-- Support Tickets
SELECT ticket_id, COUNT(*) AS duplicates
FROM saas.support_tickets
GROUP BY ticket_id
HAVING COUNT(*) > 1;

-- Churn Events
SELECT churn_event_id, COUNT(*) AS duplicates
FROM saas.churn_events
GROUP BY churn_event_id
HAVING COUNT(*) > 1;

--4 completeness checks 
SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'accounts'
-- Accounts: check for missing values in all columns
SELECT 
  SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS missing_account_id,
  SUM(CASE WHEN account_name IS NULL THEN 1 ELSE 0 END) AS missing_account_name,
  SUM(CASE WHEN industry IS NULL THEN 1 ELSE 0 END) AS missing_industry,
  SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS missing_country,
  SUM(CASE WHEN signup_date IS NULL THEN 1 ELSE 0 END) AS missing_signup_date,
  SUM(CASE WHEN referral_source IS NULL THEN 1 ELSE 0 END) AS missing_referral_source,
  SUM(CASE WHEN plan_tier IS NULL THEN 1 ELSE 0 END) AS missing_plan_tier,
  SUM(CASE WHEN seats IS NULL THEN 1 ELSE 0 END) AS missing_seats,
  SUM(CASE WHEN is_trial IS NULL THEN 1 ELSE 0 END) AS missing_is_trial,
  SUM(CASE WHEN churn_flag IS NULL THEN 1 ELSE 0 END) AS missing_churn_flag
FROM saas.accounts;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'subscriptions';
-- Subscriptions: check for missing values in all columns
SELECT 
  SUM(CASE WHEN subscription_id IS NULL THEN 1 ELSE 0 END) AS missing_subscription_id,
  SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS missing_account_id,
  SUM(CASE WHEN start_date IS NULL THEN 1 ELSE 0 END) AS missing_start_date,
  SUM(CASE WHEN end_date IS NULL THEN 1 ELSE 0 END) AS missing_end_date,
  SUM(CASE WHEN plan_tier IS NULL THEN 1 ELSE 0 END) AS missing_plan_tier,
  SUM(CASE WHEN seats IS NULL THEN 1 ELSE 0 END) AS missing_seats,
  SUM(CASE WHEN mrr_amount IS NULL THEN 1 ELSE 0 END) AS missing_mrr_amount,
  SUM(CASE WHEN arr_amount IS NULL THEN 1 ELSE 0 END) AS missing_arr_amount,
  SUM(CASE WHEN is_trial IS NULL THEN 1 ELSE 0 END) AS missing_is_trial,
  SUM(CASE WHEN upgrade_flag IS NULL THEN 1 ELSE 0 END) AS missing_upgrade_flag,
  SUM(CASE WHEN downgrade_flag IS NULL THEN 1 ELSE 0 END) AS missing_downgrade_flag,
  SUM(CASE WHEN churn_flag IS NULL THEN 1 ELSE 0 END) AS missing_churn_flag,
  SUM(CASE WHEN billing_frequency IS NULL THEN 1 ELSE 0 END) AS missing_billing_frequency,
  SUM(CASE WHEN auto_renew_flag IS NULL THEN 1 ELSE 0 END) AS missing_auto_renew_flag
FROM saas.subscriptions;


SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'support_tickets';
-- Support Tickets: check for missing ticket details
SELECT 
  SUM(CASE WHEN ticket_id IS NULL THEN 1 ELSE 0 END) AS missing_ticket_id,
  SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS missing_account_id,
  SUM(CASE WHEN submitted_at IS NULL THEN 1 ELSE 0 END) AS missing_submitted_at,
  SUM(CASE WHEN closed_at IS NULL THEN 1 ELSE 0 END) AS missing_closed_at,
  SUM(CASE WHEN resolution_time_hours IS NULL THEN 1 ELSE 0 END) AS missing_resolution_time,
  SUM(CASE WHEN priority IS NULL THEN 1 ELSE 0 END) AS missing_priority,
  SUM(CASE WHEN first_response_time_minutes IS NULL THEN 1 ELSE 0 END) AS missing_first_response,
  SUM(CASE WHEN satisfaction_score IS NULL THEN 1 ELSE 0 END) AS missing_satisfaction_score,
  SUM(CASE WHEN escalation_flag IS NULL THEN 1 ELSE 0 END) AS missing_escalation_flag
FROM saas.support_tickets;


SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'churn_events'

ALTER TABLE saas.churn_events
DROP COLUMN usage_id;

-- Churn Events: check for missing churn dates
-- Churn Events: check for missing values in all columns
SELECT 
  SUM(CASE WHEN churn_event_id IS NULL THEN 1 ELSE 0 END) AS missing_churn_event_id,
  SUM(CASE WHEN account_id IS NULL THEN 1 ELSE 0 END) AS missing_account_id,
  SUM(CASE WHEN churn_date IS NULL THEN 1 ELSE 0 END) AS missing_churn_date,
  SUM(CASE WHEN reason_code IS NULL THEN 1 ELSE 0 END) AS missing_reason_code,
  SUM(CASE WHEN refund_amount_usd IS NULL THEN 1 ELSE 0 END) AS missing_refund_amount_usd,
  SUM(CASE WHEN preceding_upgrade_flag IS NULL THEN 1 ELSE 0 END) AS missing_preceding_upgrade_flag,
  SUM(CASE WHEN preceding_downgrade_flag IS NULL THEN 1 ELSE 0 END) AS missing_preceding_downgrade_flag,
  SUM(CASE WHEN is_reactivation IS NULL THEN 1 ELSE 0 END) AS missing_is_reactivation,
  SUM(CASE WHEN feedback_text IS NULL THEN 1 ELSE 0 END) AS missing_feedback_text
FROM saas.churn_events;

SELECT COLUMN_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'features'
-- Features: check for missing values in all columns
SELECT 
  SUM(CASE WHEN usage_id IS NULL THEN 1 ELSE 0 END) AS missing_usage_id,
  SUM(CASE WHEN subscription_id IS NULL THEN 1 ELSE 0 END) AS missing_subscription_id,
  SUM(CASE WHEN usage_date IS NULL THEN 1 ELSE 0 END) AS missing_usage_date,
  SUM(CASE WHEN feature_name IS NULL THEN 1 ELSE 0 END) AS missing_feature_name,
  SUM(CASE WHEN usage_count IS NULL THEN 1 ELSE 0 END) AS missing_usage_count,
  SUM(CASE WHEN usage_duration_secs IS NULL THEN 1 ELSE 0 END) AS missing_usage_duration_secs,
  SUM(CASE WHEN error_count IS NULL THEN 1 ELSE 0 END) AS missing_error_count,
  SUM(CASE WHEN is_beta_feature IS NULL THEN 1 ELSE 0 END) AS missing_is_beta_feature,
  SUM(CASE WHEN feature_id IS NULL THEN 1 ELSE 0 END) AS missing_feature_id
FROM saas.features;


--Handling Missing Values
--1 Identify and Flag(Keep track of which rows have missing values by adding a flag column in queries or views.)
SELECT 
    ticket_id,
    satisfaction_score,
    CASE WHEN satisfaction_score IS NULL THEN 1 ELSE 0 END AS missing_flag
FROM saas.support_tickets;

--Impute Where Logical
--Support Tickets → satisfaction_score

-- Replace NULLs with a default (e.g., 0 or “No Response”).
--This avoids skewing averages.
UPDATE saas.support_tickets
SET satisfaction_score = 0
WHERE satisfaction_score IS NULL;

--Relationship Integrity Checks
--1. Accounts ↔ Subscriptions(Every account_id in Subscriptions should exist in Accounts.)
SELECT s.account_id
FROM saas.subscriptions s
LEFT JOIN saas.accounts a ON s.account_id = a.account_id
WHERE a.account_id IS NULL;

--2. Subscriptions ↔ Features(Every subscription_id in Features should exist in Subscriptions.)
SELECT f.subscription_id
FROM saas.features f
LEFT JOIN saas.subscriptions s ON f.subscription_id = s.subscription_id
WHERE s.subscription_id IS NULL;


--3. Accounts ↔ Churn Events(Every account_id in Churn Events should exist in Accounts.)
SELECT c.account_id
FROM saas.churn_events c
LEFT JOIN saas.accounts a ON c.account_id = a.account_id
WHERE a.account_id IS NULL;

--4. Accounts ↔ Support Tickets(Every account_id in Support Tickets should exist in Accounts.)
SELECT t.account_id
FROM saas.support_tickets t
LEFT JOIN saas.accounts a ON t.account_id = a.account_id
WHERE a.account_id IS NULL;


--Check Distributions in SQL
----Check Distributions in saas
--1. Accounts
-- Distribution of industries
SELECT industry, COUNT(*) AS count
FROM saas.accounts
GROUP BY industry
ORDER BY count DESC;

-- Distribution of plan tiers
SELECT plan_tier, COUNT(*) AS count
FROM saas.accounts
GROUP BY plan_tier
ORDER BY count DESC;

-- Trial vs non-trial
SELECT is_trial, COUNT(*) AS count
FROM saas.accounts
GROUP BY is_trial;


--2. Subscriptions
-- Billing frequency distribution
SELECT billing_frequency, COUNT(*) AS count
FROM saas.subscriptions
GROUP BY billing_frequency;

-- Churn flag distribution
SELECT churn_flag, COUNT(*) AS count
FROM saas.subscriptions
GROUP BY churn_flag;

--3. Features
-- Feature usage distribution
SELECT feature_name, COUNT(*) AS usage_count
FROM saas.features
GROUP BY feature_name
ORDER BY usage_count DESC;

-- Beta vs non-beta features
SELECT is_beta_feature, COUNT(*) AS count
FROM saas.features
GROUP BY is_beta_feature;
