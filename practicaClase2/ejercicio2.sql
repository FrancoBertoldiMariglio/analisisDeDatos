WITH dias_laborales AS (
  SELECT
    COUNT(*) as total_dias_laborales
  FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
  WHERE
    EXTRACT(DAYOFWEEK FROM start_date) IN (2, 3, 4, 5, 6)
),
fin_semana AS (
  SELECT
    COUNT(*) as total_dias_fin_semana
  FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
  WHERE
    EXTRACT(DAYOFWEEK FROM start_date) IN (1, 7)
)

SELECT
  total_dias_laborales,
  total_dias_fin_semana,
  total_dias_laborales / (total_dias_laborales + total_dias_fin_semana) * 100 AS porcentaje_dias_laborales,
  total_dias_fin_semana / (total_dias_laborales + total_dias_fin_semana) * 100 AS porcentaje_dias_fin_semana
FROM
 dias_laborales,
 fin_semana