WITH viajes_mes AS (
  SELECT
    FORMAT_DATETIME('%Y-%m', start_date) AS fecha,
    COUNT(*) AS freq
  FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
  GROUP BY FORMAT_DATETIME('%Y-%m', start_date)
)

SELECT
  fecha,
  freq,
  CAST(ROUND((freq - LAG(freq) OVER (ORDER BY fecha)) / LAG(freq) OVER (ORDER BY fecha) * 100, 2) AS STRING) || '%' AS tasa_crecimiento_mensual
FROM
  viajes_mes
ORDER BY
  fecha ASC;