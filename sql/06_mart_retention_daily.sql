CREATE TABLE analytics.mart_retention_daily AS
WITH cohort_sizes AS (
    SELECT cohort_date, COUNT(DISTINCT user_id) AS cohort_size
    FROM analytics.user_cohorts
    GROUP BY cohort_date
),
activity AS (
    SELECT
        s.user_id,
        c.cohort_date,
        s.session_date,
        s.session_date - c.cohort_date AS days_from_cohort
    FROM analytics.fact_sessions s
    JOIN analytics.user_cohorts c USING (user_id)
    WHERE s.session_date >= c.cohort_date
),
daily AS (
    SELECT
        cohort_date,
        session_date AS activity_date,
        days_from_cohort,
        COUNT(DISTINCT user_id) AS active_users
    FROM activity
    GROUP BY cohort_date, activity_date, days_from_cohort
)
SELECT
    d.cohort_date,
    d.activity_date,
    d.days_from_cohort,
    d.active_users,
    c.cohort_size,
    d.active_users::decimal / c.cohort_size AS retention_rate
FROM daily d
JOIN cohort_sizes c USING (cohort_date);
