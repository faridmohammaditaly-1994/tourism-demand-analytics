-- ============================================================
-- TASK 1: DATA AUDIT
-- ============================================================
-- Business question: What does this dataset contain?
-- Are there nulls, unexpected values, or data quality issues?

SELECT 
    COUNT(*)                                                                        AS total_bookings,
    MIN(travel_date)                                                                AS earliest_date,
    MAX(travel_date)                                                                AS latest_date,
    COUNT(DISTINCT destination)                                                     AS distinct_destinations,
    COUNT(DISTINCT source_country)                                                  AS distinct_source_countries,
    COUNT(*) FILTER (WHERE total_spend IS NULL OR total_spend = 0)                  AS null_zero_total_spend,
    COUNT(*) FILTER (WHERE satisfaction_score > 5 OR satisfaction_score < 1 
                           OR satisfaction_score IS NULL)                           AS satisfaction_null_or_outlier,
    COUNT(*) FILTER (WHERE nights_stayed <= 0 OR nights_stayed IS NULL)             AS null_zero_nights_stayed,
    COUNT(*) FILTER (WHERE num_travelers <= 0 OR num_travelers IS NULL)             AS null_zero_num_travelers
FROM tourism.bookings;



-- ============================================================
-- TASK 2: DESTINATION PERFORMANCE OVERVIEW
-- ============================================================
-- Business question: Which destinations generate the most revenue?
-- Leadership wants a ranked summary of bookings, revenue, and satisfaction.

SELECT
    destination,
    region,
    COUNT(*)                                AS num_bookings,
    SUM(total_spend)                        AS total_revenue,
    ROUND(AVG(total_spend), 2)              AS avg_revenue,
    ROUND(AVG(satisfaction_score), 2)       AS avg_satisfaction,
    RANK() OVER(ORDER BY SUM(total_spend) DESC) AS rank_by_revenue
FROM tourism.bookings
GROUP BY destination, region
ORDER BY rank_by_revenue;



























