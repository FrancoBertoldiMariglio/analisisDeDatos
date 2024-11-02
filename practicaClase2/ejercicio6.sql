WITH total_trips AS (
  SELECT
    COUNT(*) AS total_trips
  FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
  WHERE
    subscriber_type IS NOT NULL
)

SELECT
    subscriber_type,
    COUNT(trip_id) / total_trips.total_trips AS average_total_trips
FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`,
    total_trips
WHERE
    subscriber_type != 'nan'
GROUP BY
    subscriber_type, total_trips.total_trips;
