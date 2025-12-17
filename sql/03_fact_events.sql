CREATE TABLE analytics.fact_events AS
WITH base AS (
    SELECT
        CAST(user_id AS BIGINT) AS user_id,

        CASE
            WHEN event_time ~ '^\d{4}-\d{2}-\d{2}' THEN event_time::timestamp
            WHEN event_time ~ '^\d{4}/\d{2}/\d{2} \d{2}:\d{2}:\d{2}$'
                THEN to_timestamp(event_time, 'YYYY/MM/DD HH24:MI:SS')
            WHEN event_time ~ '^\d{8}$'
                THEN to_timestamp(event_time, 'YYYYMMDD')
            ELSE NULL
        END AS event_time,

        CASE
            WHEN LOWER(event_type) = 'start_trail'              THEN 'start_trial'
            WHEN LOWER(event_type) LIKE 'start%'                THEN 'start_trial'
            WHEN LOWER(event_type) IN ('signup','sign_up')      THEN 'signup'
            WHEN LOWER(event_type) IN ('purchase','purhcase')   THEN 'purchase'
            WHEN LOWER(event_type) IN ('play')                  THEN 'play'
            WHEN LOWER(event_type) IN ('search')                THEN 'search'
            WHEN LOWER(event_type) = 'cancel'                   THEN 'cancel'
            WHEN LOWER(event_type) IN ('paused')                THEN 'paused'
            WHEN event_type IS NULL OR TRIM(event_type) = ''    THEN 'unknown'
            ELSE LOWER(event_type)
        END AS event_type,

        CASE
            WHEN LOWER(channel) IN ('push')                     THEN 'push'
            WHEN LOWER(channel) IN ('email')                    THEN 'email'
            WHEN LOWER(channel) IN ('sms')                      THEN 'sms'
            WHEN LOWER(channel) IN ('app')                      THEN 'app'
            WHEN LOWER(channel) IN ('web')                      THEN 'web'
            WHEN LOWER(channel) = 'branch'                      THEN 'branch'
            ELSE 'other'
        END AS channel
    FROM raw.events_raw
    WHERE user_id IS NOT NULL
)
SELECT
    user_id,
    event_time,
    event_time::date AS event_date,
    event_type,
    channel
FROM base
WHERE event_time IS NOT NULL;
