{{ config(materialized='view') }}

SELECT
    ticket_id,
    account_id,
    priority,
    submitted_at,
    closed_at,
    escalation_flag
FROM {{ ref('stg_ravenstack_support_tickets') }}
