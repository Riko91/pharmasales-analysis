SELECT
    d.season,
    ROUND(SUM(f.quantity)) AS ukupno_prodano
FROM dw.fact_sales AS f
JOIN dw.dim_date AS d ON d.full_date = f.full_date
JOIN dw.dim_atc AS a ON a.atc_key = f.atc_key
WHERE a.atc_code = 'R06'
GROUP BY d.season
ORDER BY ukupno_prodano DESC;