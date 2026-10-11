SELECT
    d.year,
    ROUND(SUM(f.quantity)) AS ukupno_prodano
FROM dw.fact_sales AS f
JOIN dw.dim_date AS d ON d.full_date = f.full_date
GROUP BY d.year
ORDER BY d.year;