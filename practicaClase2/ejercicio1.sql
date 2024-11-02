WITH start_station AS (
  SELECT 
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS row_number,
    start_station_name,
    COUNT(*) AS freq_inicio
  FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
  GROUP BY
    start_station_name
  ORDER BY
    freq_inicio DESC
), end_station AS (
  SELECT
    ROW_NUMBER() OVER (ORDER BY COUNT(*) DESC) AS row_number,
    end_station_name,
    COUNT(*) AS freq_final,
  FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
  GROUP BY
    end_station_name
  ORDER BY
    freq_final DESC
)

SELECT 
  start_station_name,
  freq_inicio,
  end_station_name,
  freq_final
FROM 
  start_station INNER JOIN
  end_station
  ON start_station.row_number = end_station.row_number
LIMIT 5;
