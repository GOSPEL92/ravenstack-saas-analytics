RavenStack SaaS Analytics Platform
Overview
RavenStack SaaS Analytics Platform is an end-to-end analytics solution designed to provide executive visibility into revenue performance, customer health, churn risk, and customer success operations.

The project demonstrates the complete analytics lifecycle, from data warehousing and transformation to business intelligence reporting and executive decision-making.
-------------------------------------------------------------
Business Problem
Modern SaaS organizations require visibility into:

1. Revenue growth and recurring revenue performance
2. Customer acquisition and retention
3. Churn risk and customer health
4. Customer support effectiveness
5. Customer satisfaction and success metrics
This project delivers a centralized analytics platform that enables stakeholders to monitor and optimize SaaS business performance.
-------------------------------------------------------------
Technology Stack
1. SQL Server
2. dbt
3. Power BI
4. DAX
5. GitHub
-------------------------------------------------------------

Data Architecture

Raw Data
    ↓
Staging Layer
    ↓
Intermediate Layer
    ↓
Mart Layer
    ↓
Power BI Dashboard
-------------------------------------------------------------
Data Warehouse Components
Raw Layer
. Accounts
. Subscriptions
. Support Tickets
. Feature Usage
. Churn Events

Staging Layer
. Standardized and cleaned source data
. Data quality checks
. Data type normalization

Intermediate Layer
. Business transformations
. Customer aggregations
. Revenue calculations
. Churn preparation

Mart Layer
Fact Tables
. fct_subscriptions
. fct_customer_health
. fct_support_tickets
. fct_account_health

Dimension Tables
. dim_accounts
. dim_subscriptions
. dim_support_tickets
-------------------------------------------------------------
Dashboard Pages
Cover Page

. Provides project introduction and navigation experience.

screenshots\cover-page.png
-------------------------------------------------------------
Executive Overview
Provides a high-level view of business performance through key SaaS KPIs.

KPIs

. Monthly Recurring Revenue (MRR)
. Annual Recurring Revenue (ARR)
. Customer Retention Rate
. Customer Churn Rate
. Customer Satisfaction Score (CSAT)

Trends
. MRR Trend
. Customer Growth Trend
. Customer Churn Trend
screenshots\executive-overview.png
-------------------------------------------------------------
Revenue Analytics

Revenue-focused analysis designed to identify growth drivers.

KPIs

. MRR
. ARR
. ARPU
. Active Accounts

Analysis
. MRR Trend
. ARR Trend
. MRR by Subscription Plan
. Customers by Subscription Plan
. Top Revenue Accounts
screenshots\revenue-analytics.png
-------------------------------------------------------------
Customer Analytics

Customer-focused analysis for segmentation and account health evaluation.

KPIs
. Active Accounts
. Churned Accounts
. Retention Rate
. Average Health Score

Analysis
. Customers by Industry
. Customers by Country
. Customers by Subscription Plan
. Health Score Analysis
screenshots\customer-analytics.png
-------------------------------------------------------------
Churn Intelligence
Identifies customer attrition patterns and retention opportunities.

Analysis
. Churn by Industry
. Churn by Country
. Churn by Subscription Plan
. Health Score Analysis
. Churn Driver Investigation
screenshots\churn-intelligence.png
-------------------------------------------------------------
Customer Success Analytics
Measures support effectiveness and customer satisfaction.

KPIs
. CSAT
. Average Resolution Time
. Average First Response Time
. Escalation Rate
Analysis
. CSAT by Industry
. CSAT by Subscription Plan
. Resolution Time Analysis
. Escalation Analysis
screenshots\customer-success.png
-------------------------------------------------------------
Custom Tooltips
Enhanced report experience through interactive report-page tooltips.

screenshots\tooltips-overview.png
-------------------------------------------------------------
Key KPIs

KPI	Value
MRR	$11.34M
ARR	$136.06M
Customer Retention Rate	78%
Customer Churn Rate	22%
CSAT	3.96 / 5
-------------------------------------------------------------
Key Insights
. Revenue remains strong with $11.34M in Monthly Recurring Revenue.
. Annual Recurring Revenue exceeds $136M.
. Customer retention is healthy at 78%.
. Customer churn remains the primary business risk at 22%.
. Customer satisfaction averages 3.96/5, indicating generally positive customer experiences.
-------------------------------------------------------------
Project Highlights
✅ Data Warehouse Design

✅ dbt Data Transformation Pipeline

✅ Star Schema Modeling

✅ SaaS KPI Framework

✅ Revenue Analytics

✅ Customer Analytics

✅ Churn Intelligence

✅ Customer Success Analytics

✅ Power BI Executive Reporting

Author
Eze Chikaodili

Data Analytics | Business Intelligence | Analytics Engineering