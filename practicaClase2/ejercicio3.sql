SELECT
  start_station_name,
  AVG(duration_sec) / 60 AS duracion_promedio_viaje
FROM
  `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
GROUP BY
  start_station_name
ORDER BY
  duracion_promedio_viaje DESC