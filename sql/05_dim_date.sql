CREATE TABLE analytics.dim_date AS
SELECT
    d::date AS date,
    EXTRACT(year FROM d)  AS year,
    EXTRACT(month FROM d) AS month,
    EXTRACT(day FROM d)   AS day,
    TO_CHAR(d, 'YYYY-MM') AS year_month,
    EXTRACT(dow FROM d)   AS day_of_week
FROM generate_series(
    DATE '2024-01-01',
    DATE '2024-12-31',
    INTERVAL '1 day'
) AS d;

