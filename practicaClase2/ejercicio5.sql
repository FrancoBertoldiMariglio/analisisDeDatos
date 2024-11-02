WITH top_trip_time AS (
  SELECT
    FLOOR(MAX(duration_sec) / 60) AS max_time
  FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
),
trip_data AS (
  SELECT
    FLOOR(duration_sec / 60) AS duration_minutes,
    COUNT(*) AS trip_count
  FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
  GROUP BY duration_minutes
),
time_intervals AS (
  SELECT
    seq * 5 AS interval_start,
    (seq + 1) * 5 AS interval_end
  FROM
    UNNEST(GENERATE_ARRAY(0, (SELECT max_time FROM top_trip_time) / 5)) AS seq
)
SELECT
  t.interval_start,
  t.interval_end,
  COALESCE(SUM(td.trip_count), 0) AS trip_count
FROM
  time_intervals t
LEFT JOIN
  trip_data td
ON
  td.duration_minutes >= t.interval_start
  AND td.duration_minutes < t.interval_end
GROUP BY
  t.interval_start, t.interval_end
ORDER BY
  t.interval_start;
