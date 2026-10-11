SELECT
    a.atc_code,
    a.atc_name,
    ROUND(SUM(f.quantity)) AS ukupno_prodano
FROM dw.fact_sales AS f
JOIN dw.dim_atc AS a ON a.atc_key = f.atc_key
GROUP BY a.atc_code, a.atc_name
ORDER BY ukupno_prodano DESC;