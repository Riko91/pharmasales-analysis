SELECT
    f.hour,
    ROUND(SUM(f.quantity)) AS ukupno_prodano
FROM dw.fact_sales AS f
GROUP BY f.hour
ORDER BY f.hour;