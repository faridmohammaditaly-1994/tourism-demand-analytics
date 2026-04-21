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