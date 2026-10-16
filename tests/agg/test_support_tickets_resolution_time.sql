SELECT *
FROM {{ ref('int_support_tickets_accounts') }}
WHERE resolution_time_hours < 0
