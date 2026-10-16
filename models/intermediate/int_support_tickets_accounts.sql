WITH base AS (
    SELECT
        t.ticket_id,
        t.account_id,
        a.account_name,
        a.plan_tier,
        a.churn_flag,             -- instead of status
        t.submitted_at,
        t.closed_at,
        t.priority,
        t.resolution_time_hours,
        t.first_response_time_minutes,
        t.satisfaction_score,
        t.escalation_flag
    FROM {{ ref('stg_ravenstack_support_tickets') }} t
    LEFT JOIN {{ ref('stg_ravenstack_accounts') }} a
      ON t.account_id = a.account_id
)

SELECT * FROM base;
