WITH firstHalf AS (
    SELECT 
        driver_id,
        AVG(distance_km / fuel_consumed) AS raw_first_avg 
    FROM trips
    WHERE MONTH(trip_date) BETWEEN 1 AND 6
    GROUP BY driver_id 
),
secondHalf AS (
    SELECT 
        driver_id,
        AVG(distance_km / fuel_consumed) AS raw_second_avg 
    FROM trips
    WHERE MONTH(trip_date) BETWEEN 7 AND 12
    GROUP BY driver_id 
)
SELECT 
    d.driver_id, 
    d.driver_name, 
    ROUND(fh.raw_first_avg, 2) AS first_half_avg,
    ROUND(sf.raw_second_avg, 2) AS second_half_avg,
    ROUND(sf.raw_second_avg - fh.raw_first_avg, 2) AS efficiency_improvement
FROM firstHalf AS fh
JOIN secondHalf AS sf ON fh.driver_id = sf.driver_id
JOIN drivers AS d ON sf.driver_id = d.driver_id
WHERE sf.raw_second_avg > fh.raw_first_avg
ORDER BY efficiency_improvement DESC, d.driver_name ASC;