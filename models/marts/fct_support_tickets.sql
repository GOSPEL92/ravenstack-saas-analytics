{{ config(materialized='view') }}

WITH tickets AS (
    SELECT
        ticket_id,
        account_id,
        submitted_at,
        closed_at,
        resolution_time_hours,
        priority,
        first_response_time_minutes,
        satisfaction_score,
        escalation_flag
    FROM {{ ref('stg_ravenstack_support_tickets') }}
)

SELECT
    account_id,
    COUNT(ticket_id) AS ticket_count,
    AVG(resolution_time_hours) AS avg_resolution_time_hours,
    AVG(first_response_time_minutes) AS avg_first_response_time_minutes,
    AVG(satisfaction_score) AS avg_satisfaction_score,
    SUM(CASE WHEN escalation_flag = 1 THEN 1 ELSE 0 END) AS escalated_ticket_count
FROM tickets
GROUP BY account_id;
