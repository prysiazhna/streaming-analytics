CREATE TABLE analytics.mart_retention_summary AS
WITH cohort_sizes AS (
    SELECT
        cohort_date,
        COUNT(DISTINCT user_id) AS cohort_size
    FROM analytics.user_cohorts
    GROUP BY cohort_date
),
retention_points AS (
    SELECT
        cohort_date,
        days_from_cohort,
        active_users
    FROM analytics.mart_retention_daily
    WHERE days_from_cohort IN (0, 1, 7, 30)
)
SELECT
    c.cohort_date,
    c.cohort_size,

    rp0.active_users AS d0_users,
    rp0.active_users::decimal / c.cohort_size AS d0_retention,

    rp1.active_users AS d1_users,
    rp1.active_users::decimal / c.cohort_size AS d1_retention,

    rp7.active_users AS d7_users,
    rp7.active_users::decimal / c.cohort_size AS d7_retention,

    rp30.active_users AS d30_users,
    rp30.active_users::decimal / c.cohort_size AS d30_retention

FROM cohort_sizes c
LEFT JOIN retention_points rp0
    ON c.cohort_date = rp0.cohort_date AND rp0.days_from_cohort = 0
LEFT JOIN retention_points rp1
    ON c.cohort_date = rp1.cohort_date AND rp1.days_from_cohort = 1
LEFT JOIN retention_points rp7
    ON c.cohort_date = rp7.cohort_date AND rp7.days_from_cohort = 7
LEFT JOIN retention_points rp30
    ON c.cohort_date = rp30.cohort_date AND rp30.days_from_cohort = 30
ORDER BY c.cohort_date;
