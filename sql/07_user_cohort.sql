CREATE TABLE analytics.user_cohorts AS
WITH first_session AS (
    SELECT
        user_id,
        MIN(session_date) AS first_session_date
    FROM analytics.fact_sessions
    WHERE session_date IS NOT NULL
    GROUP BY user_id
)
SELECT
    u.user_id,
    COALESCE(u.signup_date, fs.first_session_date) AS cohort_date,
    u.country,
    u.acquisition_channel,
    u.plan_type
FROM analytics.dim_users u
LEFT JOIN first_session fs
    ON fs.user_id = u.user_id
WHERE COALESCE(u.signup_date, fs.first_session_date) IS NOT NULL;
