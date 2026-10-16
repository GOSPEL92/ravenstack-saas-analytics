{{ config(materialized='view') }}

WITH source AS (
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
    FROM raw.ravenstack_support_tickets
)

SELECT
    TRIM(ticket_id) AS ticket_id,
    TRIM(account_id) AS account_id,
    CAST(submitted_at AS DATETIME) AS submitted_at,
    CAST(closed_at AS DATETIME) AS closed_at,
    CAST(resolution_time_hours AS FLOAT) AS resolution_time_hours,
    LOWER(TRIM(priority)) AS priority,
    CAST(first_response_time_minutes AS FLOAT) AS first_response_time_minutes,
    CAST(satisfaction_score AS FLOAT) AS satisfaction_score,
    CAST(escalation_flag AS BIT) AS escalation_flag
FROM source;
