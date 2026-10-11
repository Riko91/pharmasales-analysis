CREATE TABLE dw.fact_sales (
    sales_id  SERIAL  PRIMARY KEY,
    full_date DATE    NOT NULL REFERENCES dw.dim_date(full_date),
    hour      INTEGER NOT NULL,
    atc_key    INTEGER NOT NULL REFERENCES dw.dim_atc(atc_key),
    quantity  NUMERIC NOT NULL
);

INSERT INTO dw.fact_sales (full_date, hour, atc_key, quantity)
SELECT
    p.full_date,
    p.hour,
    a.atc_key,
    p.quantity
FROM (
    SELECT TO_DATE(SPLIT_PART(datum, ' ', 1), 'MM/DD/YYYY') AS full_date,
           SPLIT_PART(SPLIT_PART(datum, ' ', 2), ':', 1)::INTEGER AS hour,
           'M01AB' AS atc_code, m01ab::NUMERIC AS quantity
    FROM staging.sales_hourly
    UNION ALL
    SELECT TO_DATE(SPLIT_PART(datum, ' ', 1), 'MM/DD/YYYY'),
           SPLIT_PART(SPLIT_PART(datum, ' ', 2), ':', 1)::INTEGER,
           'M01AE', m01ae::NUMERIC
    FROM staging.sales_hourly
    UNION ALL
    SELECT TO_DATE(SPLIT_PART(datum, ' ', 1), 'MM/DD/YYYY'),
           SPLIT_PART(SPLIT_PART(datum, ' ', 2), ':', 1)::INTEGER,
           'N02BA', n02ba::NUMERIC
    FROM staging.sales_hourly
    UNION ALL
    SELECT TO_DATE(SPLIT_PART(datum, ' ', 1), 'MM/DD/YYYY'),
           SPLIT_PART(SPLIT_PART(datum, ' ', 2), ':', 1)::INTEGER,
           'N02BE', n02be::NUMERIC
    FROM staging.sales_hourly
    UNION ALL
    SELECT TO_DATE(SPLIT_PART(datum, ' ', 1), 'MM/DD/YYYY'),
           SPLIT_PART(SPLIT_PART(datum, ' ', 2), ':', 1)::INTEGER,
           'N05B', n05b::NUMERIC
    FROM staging.sales_hourly
    UNION ALL
    SELECT TO_DATE(SPLIT_PART(datum, ' ', 1), 'MM/DD/YYYY'),
           SPLIT_PART(SPLIT_PART(datum, ' ', 2), ':', 1)::INTEGER,
           'N05C', n05c::NUMERIC
    FROM staging.sales_hourly
    UNION ALL
    SELECT TO_DATE(SPLIT_PART(datum, ' ', 1), 'MM/DD/YYYY'),
           SPLIT_PART(SPLIT_PART(datum, ' ', 2), ':', 1)::INTEGER,
           'R03', r03::NUMERIC
    FROM staging.sales_hourly
    UNION ALL
    SELECT TO_DATE(SPLIT_PART(datum, ' ', 1), 'MM/DD/YYYY'),
           SPLIT_PART(SPLIT_PART(datum, ' ', 2), ':', 1)::INTEGER,
           'R06', r06::NUMERIC
    FROM staging.sales_hourly
) AS p
JOIN dw.dim_atc AS a ON a.atc_code = p.atc_code;

SELECT COUNT(*) FROM dw.fact_sales;
