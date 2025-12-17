CREATE TABLE analytics.user_funnel AS
WITH signup AS (
    SELECT
        user_id,
        MIN(event_time)::date AS signup_date
    FROM analytics.fact_events
    WHERE LOWER(event_type) = 'signup'
    GROUP BY user_id
),
first_session AS (
    SELECT
        user_id,
        MIN(session_date) AS first_session_date
    FROM analytics.fact_sessions
    WHERE session_date IS NOT NULL
    GROUP BY user_id
),
trial AS (
    SELECT
        user_id,
        MIN(event_time)::date AS trial_date
    FROM analytics.fact_events
    WHERE LOWER(event_type) = 'start_trial'
    GROUP BY user_id
),
purchase AS (
    SELECT
        user_id,
        MIN(event_time)::date AS purchase_date
    FROM analytics.fact_events
    WHERE LOWER(event_type) = 'purchase'
    GROUP BY user_id
)
SELECT
    u.user_id,
    u.country,
    u.acquisition_channel,
    u.plan_type,

    s.signup_date,
    fs.first_session_date,
    t.trial_date,
    p.purchase_date,

    CASE WHEN s.signup_date IS NOT NULL        THEN 1 ELSE 0 END AS signed_up,
    CASE WHEN fs.first_session_date IS NOT NULL THEN 1 ELSE 0 END AS had_session,
    CASE WHEN t.trial_date IS NOT NULL        THEN 1 ELSE 0 END AS started_trial,
    CASE WHEN p.purchase_date IS NOT NULL     THEN 1 ELSE 0 END AS purchased
FROM analytics.dim_users u
LEFT JOIN signup       s  ON s.user_id  = u.user_id
LEFT JOIN first_session fs ON fs.user_id = u.user_id
LEFT JOIN trial        t  ON t.user_id  = u.user_id
LEFT JOIN purchase     p  ON p.user_id  = u.user_id;
