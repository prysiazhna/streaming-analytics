CREATE TABLE analytics.mart_conversion_funnel AS
WITH base AS (
    SELECT
        country,
        acquisition_channel,
        plan_type,

        COUNT(*) FILTER (WHERE signed_up = 1) AS signed_up_users,
        COUNT(*) FILTER (WHERE had_session = 1) AS session_users,
        COUNT(*) FILTER (WHERE started_trial = 1) AS trial_users,
        COUNT(*) FILTER (WHERE purchased = 1) AS purchased_users
    FROM analytics.user_funnel
    GROUP BY country, acquisition_channel, plan_type
)
SELECT
    country,
    acquisition_channel,
    plan_type,

    signed_up_users,
    session_users,
    trial_users,
    purchased_users,

    CASE WHEN signed_up_users > 0 THEN session_users::decimal / signed_up_users ELSE NULL END AS signup_to_session_rate,
    CASE WHEN session_users > 0 THEN trial_users::decimal / session_users ELSE NULL END AS session_to_trial_rate,
    CASE WHEN trial_users > 0 THEN purchased_users::decimal / trial_users ELSE NULL END AS trial_to_purchase_rate,
    CASE WHEN signed_up_users > 0 THEN purchased_users::decimal / signed_up_users ELSE NULL END AS signup_to_purchase_rate
FROM base
ORDER BY signed_up_users DESC;
