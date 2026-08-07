SaaS Data Profiling Report
1. Record Counts

| Table          | Result | Interpretation                    |
| ---            | ---    | ---                               |
| Accounts       | 500    | Reasonable size for customer base |
| Features       | 250,000| High volume, expected due to event granularity |
| Subscriptions  | 5,000  | ~10 per account, consistent with SaaS model |
| Support Tickets| 2,000  | Manageable support load |
| Churn Events   | 9,600  | High relative to accounts, tracked at subscription level |

2. Uniqueness Checks
Accounts: account_id unique → ✅ safe PK.

Features: usage_id duplicates → requires composite PK (usage_id + subscription_id + usage_date + feature_id).

Subscriptions: subscription_id unique → ✅ safe PK.

Support Tickets: ticket_id unique → ✅ safe PK.

Churn Events: churn_id duplicates → requires composite PK (churn_id + subscription_id + churn_date).

3. Completeness Checks
| Table          | Missing Values | Notes             |
| ---            | ---            | ---               |
| Accounts       | 0              | ✅ Fully complete |
| Subscriptions  | 0              | ✅ Fully complete |
| Features       | 0              | ✅ Fully complete |
| Support Tickets| 825 (satisfaction_score) | ⚠️ Missing feedback data |

Handling: Support ticket satisfaction scores imputed with 0 (“No Response”) and flagged.

4. Relationship Integrity
| Relationship               | Result               | Interpretation                           |
| ---                        | ---                  | ---                                      |
| Accounts ↔ Subscriptions   | ✅ No orphan records | All subscriptions tied to valid accounts |
| Subscriptions ↔ Features   | ✅ No orphan records | All feature usage tied to valid subscriptions |
| Accounts ↔ Churn Events    | ✅ No orphan records | All churn events tied to valid accounts |
| Accounts ↔ Support Tickets | ✅ No orphan records | All tickets tied to valid accounts |

5. Distribution Checks
Accounts: Balanced spread across industries and plan tiers; trial vs non‑trial clearly distinguishable.

Subscriptions: Billing frequencies consistent; churn flags distributed.

Features: Usage well‑distributed; beta vs non‑beta tracked cleanly.

Support Tickets: Ticket statuses balanced; 825 “No Response” cases imputed.

Churn Events: Reason codes distributed; no missing values after backfill.

6. Consistency Profiling
Churn Flag vs Churn Events: 134 subscriptions flagged as churned but missing churn_event → backfilled.

Trial Accounts vs Plan Tier: 97 accounts mislabeled as trial → corrected.

Feature Usage vs Churned Subscriptions: 23,730 records inconsistent; 2,900 flagged as invalid after soft cleaning.

7. Handling Inconsistencies
Churn Events Backfill: Added missing churn_event records with generated IDs, aligned churn_date, reason_code = ‘Backfill’.

Trial Flag Alignment: Bulk update reset is_trial = 0 where plan_tier ≠ Trial.

Feature Usage vs Churn: Added is_invalid_usage column, flagged 2,900 invalid records, enforced trigger to block future violations.

📈 Outcome
Stage 1: Churn events backfilled → dataset complete.

Stage 2: Trial flag mismatch resolved → segmentation accurate.

Stage 3: Feature usage vs churn validated → 2,900 invalid records flagged, trigger active for future enforcement.