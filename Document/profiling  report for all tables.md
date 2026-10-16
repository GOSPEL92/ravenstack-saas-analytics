Data Profiling Summary Report
1. raw.ravenstack_accounts
. Row Count: 500

. Nulls/Duplicates: None (account_id clean and unique)

. Date Range: 2023‑10‑02 → 2024‑12‑31

. Findings: Clean IDs, valid signup dates, dataset covers ~15 months.

Recommended Actions:

. Cast IDs → INT, dates → DATE.

. Standardize categorical fields (industry, country, plan_tier).

. Use account_id as primary key in dim_accounts.

2. raw.ravenstack_subscriptions
. Row Count: 5,000

. Nulls/Duplicates: None (subscription_id and account_id clean)

. Date Range: 2023‑01‑09 → 2024‑12‑31

. Churn Flag: True = 486, False = 4,514 → Churn rate ≈ 9.7%

. Findings: Strong keys, valid dates, no negative values.

Recommended Actions:

. Cast amounts → DECIMAL.

. Standardize churn_flag → BIT/BOOLEAN.

. Build fact_subscriptions for revenue and churn analysis.

3. raw.ravenstack_feature_usage
Row Count: 5,000

. Nulls: None

. Duplicates: Yes → 10 duplicate usage_id records (each appears twice).

. Date Range: 2023‑01‑01 → 2024‑12‑31

. Feature Distribution (Top 10): Balanced usage (~1,300 events each).

. Findings: Clean data except duplicates, valid ranges, balanced feature adoption.

Recommended Actions:

. Deduplicate usage_id records (decide whether to keep first/latest or aggregate).

. Cast counts/durations → INT/DECIMAL.

. Standardize feature_name values.

. Build fact_feature_usage linked to dim_features.

4. raw.ravenstack_support_tickets
. Row Count: 2,000

. Nulls/Duplicates: None (ticket_id clean and unique)

. Date Range: 2023‑01‑01 → 2024‑12‑31 19:00:00

. Negative Values: None (resolution times and satisfaction scores valid)

. Escalation Flag: True = 95, False = 1,905 → Escalation rate ≈ 4.75%

. Findings: Clean IDs, valid dates, numeric fields stored as NVARCHAR but convertible.

Recommended Actions:

. Cast resolution_time_hours → DECIMAL(10,2).

. Cast satisfaction_score → DECIMAL(3,1).

. Standardize escalation_flag → BIT/BOOLEAN.

. Build fact_support_tickets for SLA and satisfaction analysis.

5. raw.ravenstack_churn_events
. Row Count: 600

. Nulls/Duplicates: None (churn_id clean and unique)

. Date Range: 2023‑01‑25 → 2024‑12‑31

. Reason Distribution:

Features = 114

Budget = 104

Support = 104

Unknown = 95

Competitor = 92

Pricing = 91

. Findings: Clean IDs, valid dates, churn reasons dominated by features, budget, and support.

Recommended Actions:

. Cast IDs → INT, dates → DATE.

. Standardize churn_reason values (handle “unknown”).

. Build fact_churn_events for churn analysis by reason, industry, plan tier.

🔹 Overall Insights
All five raw tables are clean and consistent, with minor issues (duplicates in feature usage, NVARCHAR numeric fields in support tickets, “unknown” churn reasons).

Data spans ~2 years (2023–2024), enabling growth, churn, and feature adoption analysis.

Key KPIs already visible:

Churn rate ≈ 9.7%

Escalation rate ≈ 4.75%

Top churn drivers: Features, Budget, Support (~54% combined)