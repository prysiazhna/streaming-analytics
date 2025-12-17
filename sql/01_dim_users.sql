CREATE TABLE analytics.dim_users AS
SELECT
    DISTINCT
    CAST(user_id AS BIGINT) AS user_id,

    CASE
        WHEN signup_date ~ '^\d{4}-\d{2}-\d{2}$' THEN signup_date::date
        WHEN signup_date ~ '^\d{4}/\d{2}/\d{2}$' THEN to_date(signup_date, 'YYYY/MM/DD')
        WHEN signup_date ~ '^\d{2}-\d{2}-\d{4}$' THEN to_date(signup_date, 'DD-MM-YYYY')
        ELSE NULL
    END AS signup_date,

    CASE
	    WHEN LOWER(country) IN ('us','usa') THEN 'US'
	    WHEN LOWER(country) IN ('ca') THEN 'CA'
	    WHEN LOWER(country) IN ('ua') then 'UA'
	    WHEN LOWER(country) IN ('ro') THEN 'RO'
	    WHEN LOWER(country) IN ('pl') THEN 'PL'
	    WHEN LOWER(country) IN ('md') THEN 'MD'
	    WHEN LOWER(country) IN ('it') THEN 'IT'
	    WHEN LOWER(country) IN ('nl') THEN 'NL'
	    WHEN LOWER(country) IN ('fr') THEN 'FR'
	    WHEN LOWER(country) IN ('de') THEN 'DE'
	    WHEN LOWER(country) IN ('es') THEN 'ES'
	    WHEN LOWER(country) IN ('uk', 'u k') THEN 'UK'
	    ELSE 'OTHER'
	END AS country,

    CASE
        WHEN LOWER(acquisition_channel) LIKE 'ad%' THEN 'ads'
        WHEN LOWER(acquisition_channel) = 'organic' THEN 'organic'
        WHEN LOWER(acquisition_channel) LIKE 'refer%' THEN 'referral'
        ELSE 'unknown'
    END AS acquisition_channel,

    CASE
        WHEN plan_type IS NULL OR plan_type = '' THEN 'free'
        ELSE LOWER(plan_type)
    END AS plan_type,

    email
FROM raw.users_raw;
