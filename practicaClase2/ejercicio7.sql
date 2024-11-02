SELECT
    start_station_name,
    end_station_name,
    COUNT(*) AS trip_count
FROM
    `bigquery-public-data.san_francisco_bikeshare.bikeshare_trips`
WHERE
    subscriber_type = 'Subscriber'
GROUP BY
    start_station_name,
    end_station_name
ORDER BY
    trip_count DESC
LIMIT 5;
