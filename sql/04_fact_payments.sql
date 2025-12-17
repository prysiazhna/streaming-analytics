CREATE TABLE analytics.fact_payments AS
SELECT
    CAST(user_id AS BIGINT) AS user_id,

    CASE
        WHEN payment_date ~ '^\d{4}-\d{2}-\d{2}$' THEN payment_date::date
        WHEN payment_date ~ '^\d{4}/\d{2}/\d{2}$' THEN to_date(payment_date, 'YYYY/MM/DD')
        WHEN payment_date ~ '^\d{2}-\d{2}-\d{4}$' THEN to_date(payment_date, 'DD-MM-YYYY')
        ELSE NULL
    END AS payment_date,


    CASE
        WHEN amount ~ '^\d+(\.\d+)?$' THEN amount::numeric
        ELSE NULL
    END AS amount,

    CASE
         WHEN LOWER(subscription_type) IN ('premium','premuim')  THEN 'premium'
         WHEN LOWER(subscription_type) IN ('basic')    THEN 'basic'
       	 ELSE 'unknown'
    END AS subscription_type,
    
   
    COALESCE(is_renewal, FALSE) AS is_renewal

FROM raw.payments_raw;
