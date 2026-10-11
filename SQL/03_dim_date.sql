CREATE TABLE dw.dim_date (
    full_date   DATE PRIMARY KEY,
    year        INTEGER,
    quarter     INTEGER,
    month       INTEGER,
    day_of_week INTEGER,   
    is_weekend  BOOLEAN,
    season      TEXT
);

INSERT INTO dw.dim_date (full_date, year, quarter, month, day_of_week, is_weekend, season)
SELECT
    d                                AS full_date,
    EXTRACT(YEAR FROM d)             AS year,
    EXTRACT(QUARTER FROM d)          AS quarter,
    EXTRACT(MONTH FROM d)            AS month,
    EXTRACT(ISODOW FROM d)           AS day_of_week,
    EXTRACT(ISODOW FROM d) IN (6, 7) AS is_weekend,
    CASE
        WHEN EXTRACT(MONTH FROM d) IN (12, 1, 2) THEN 'zima'
        WHEN EXTRACT(MONTH FROM d) IN (3, 4, 5) THEN 'pomlad'
        WHEN EXTRACT(MONTH FROM d) IN (6, 7, 8) THEN 'poletje'
        ELSE 'jesen'
    END AS season
FROM (
    SELECT DISTINCT TO_DATE(SPLIT_PART(datum, ' ', 1), 'MM/DD/YYYY') AS d
    FROM staging.sales_hourly
) AS dani;

SELECT COUNT(*) FROM dw.dim_date;
