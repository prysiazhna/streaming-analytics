CREATE TABLE analytics.fact_sessions AS
SELECT
    CAST(user_id AS BIGINT) AS user_id,

    CASE
        WHEN session_date ~ '^\d{4}-\d{2}-\d{2}$' THEN session_date::date
        WHEN session_date ~ '^\d{4}/\d{2}/\d{2}$' THEN to_date(session_date,'YYYY/MM/DD')
        WHEN session_date ~ '^\d{2}-\d{2}-\d{4}$' THEN to_date(session_date,'DD-MM-YYYY')
        ELSE NULL
    END AS session_date,

    CASE
        WHEN session_length ~ '^\d+(\.\d+)?$' THEN session_length::numeric
        ELSE NULL
    END AS session_length,

    LOWER(device_type) AS device_type
FROM raw.sessions_raw
WHERE user_id IS NOT NULL;
