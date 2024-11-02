WITH stats AS (
  SELECT
    AVG(duration_sec) AS mean_duration,
    STDDEV(duration_sec) AS stddev_duration
  FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
)

SELECT
    trip_id,
    start_station_name,
    end_station_name,
    duration_sec
FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`,
    stats
WHERE
    duration_sec > (stats.mean_duration + 2 * stats.stddev_duration)
ORDER BY
    duration_sec DESC;
