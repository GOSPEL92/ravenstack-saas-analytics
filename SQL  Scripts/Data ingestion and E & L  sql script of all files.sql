CREATE DATABASE ravenstack_saas;
GO

USE ravenstack_saas;
GO

CREATE SCHEMA raw;
GO


--1. create table for ravenstack_accounts 
CREATE TABLE raw.ravenstack_accounts (
    account_id NVARCHAR(50),
    account_name NVARCHAR(255),
    industry NVARCHAR(100),
    country NVARCHAR(100),
    signup_date NVARCHAR(50),
    referral_source NVARCHAR(100),
    plan_tier NVARCHAR(50),
    seats NVARCHAR(50),
    is_trial NVARCHAR(10),
    churn_flag NVARCHAR(10)
);

--and ingest csv file ravenstack_account to created table
BULK INSERT raw.ravenstack_accounts
FROM 'C:\Data Saas\ravenstack_accounts.csv'
WITH (
    FIRSTROW = 2,              -- skip header row
    FIELDTERMINATOR = ',',     -- CSV delimiter
    ROWTERMINATOR = '\n',      -- line break
    TABLOCK
);


--verify the table
SELECT TOP 10 * FROM raw.ravenstack_accounts;


--2. create table for ravenstack_churn_events


CREATE TABLE raw.ravenstack_churn_events (
    churn_event_id NVARCHAR(50),
    account_id NVARCHAR(50),
    churn_date NVARCHAR(50),
    reason_code NVARCHAR(50),
    refund_amount_usd NVARCHAR(50),
    preceding_upgrade_flag NVARCHAR(10),
    preceding_downgrade_flag NVARCHAR(10),
    is_reactivation NVARCHAR(10),
    feedback_text NVARCHAR(MAX)
);

--and ingest csv file ravenstack_churn_events to created table
BULK INSERT raw.ravenstack_churn_events
FROM 'C:\Data Saas\ravenstack_churn_events.csv'
WITH (
    FIRSTROW = 2,              -- skip header row
    FIELDTERMINATOR = ',',     -- CSV delimiter
    ROWTERMINATOR = '\n',      -- line break
    TABLOCK
);


--verify churn-events table
SELECT TOP 10 * FROM raw.ravenstack_churn_events;


--3. create table for ravenstack_feature_usage
CREATE TABLE raw.ravenstack_feature_usage (
    usage_id NVARCHAR(50),
    subscription_id NVARCHAR(50),
    usage_date NVARCHAR(50),
    feature_name NVARCHAR(100),
    usage_count NVARCHAR(50),
    usage_duration_secs NVARCHAR(50),
    error_count NVARCHAR(50),
    is_beta_feature NVARCHAR(10)
);

--and ingest csv file ravenstack_feature_usage to created table
BULK INSERT raw.ravenstack_feature_usage
FROM 'C:\Data Saas\ravenstack_feature_usage.csv'
WITH (
    FIRSTROW = 2,              -- skip header row
    FIELDTERMINATOR = ',',     -- CSV delimiter
    ROWTERMINATOR = '\n',      -- line break
    TABLOCK
);


--verify ravenstack_feature_usage
SELECT TOP 10 * FROM raw.ravenstack_feature_usage;


--4. create table for ravenstack_subscriptions;

CREATE TABLE raw.ravenstack_subscriptions (
    subscription_id NVARCHAR(50),
    account_id NVARCHAR(50),
    start_date NVARCHAR(50),
    end_date NVARCHAR(50),
    plan_tier NVARCHAR(50),
    seats NVARCHAR(50),
    mrr_amount NVARCHAR(50),
    arr_amount NVARCHAR(50),
    is_trial NVARCHAR(10),
    upgrade_flag NVARCHAR(10),
    downgrade_flag NVARCHAR(10),
    churn_flag NVARCHAR(10),
    billing_frequency NVARCHAR(50),
    auto_renew_flag NVARCHAR(10)
);


--and ingest csv file ravenstack_subscription to created table
BULK INSERT raw.ravenstack_subscriptions
FROM 'C:\Data Saas\ravenstack_subscriptions.csv'
WITH (
    FIRSTROW = 2,              -- skip header row
    FIELDTERMINATOR = ',',     -- CSV delimiter
    ROWTERMINATOR = '\n',      -- line break
    TABLOCK
);


--verify ravenstack_subscription
SELECT TOP 10 * FROM raw.ravenstack_subscriptions;


--4. create table for ravenstack_support_tickets;

CREATE TABLE raw.ravenstack_support_tickets (
    ticket_id NVARCHAR(50),
    account_id NVARCHAR(50),
    submitted_at NVARCHAR(50),
    closed_at NVARCHAR(50),
    resolution_time_hours NVARCHAR(50),
    priority NVARCHAR(50),
    first_response_time_minutes NVARCHAR(50),
    satisfaction_score NVARCHAR(50),
    escalation_flag NVARCHAR(10)
);


--and ingest csv file ravenstack_support_tickets to created table
BULK INSERT raw.ravenstack_support_tickets
FROM 'C:\Data Saas\ravenstack_support tickets.csv'
WITH (
    FIRSTROW = 2,              -- skip header row
    FIELDTERMINATOR = ',',     -- CSV delimiter
    ROWTERMINATOR = '\n',      -- line break
    TABLOCK
);


--verify ravenstack_support tickets table
 SELECT TOP 10 * FROM raw.ravenstack_support_tickets;
