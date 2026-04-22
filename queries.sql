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




-- ============================================================
-- TASK 3: SEASONAL DEMAND ANALYSIS BY REGION
-- ============================================================
-- Business question: When does each region see peak bookings?
-- Extract month from travel_date to avoid using redundant stored columns.

SELECT
    region,
    TO_CHAR(travel_date, 'Month')                                               AS month_name,
    COUNT(*)                                                                    AS total_bookings,
    SUM(total_spend)                                                            AS month_revenue,
        ROUND(100.0 * SUM(total_spend) / SUM(SUM(total_spend)) OVER (PARTITION BY region), 2) AS pct_of_regional_revenue
FROM tourism.bookings
GROUP BY region, month_name
ORDER BY region, total_bookings DESC;


-- ============================================================
-- TASK 4: TRAVELER SEGMENT REVENUE ANALYSIS
-- ============================================================
-- Business question: Which traveler types generate the most revenue
-- and have the longest stays? Which segments should marketing target?

SELECT
    traveler_type,
    COUNT(*)                                        AS total_bookings,
    SUM(total_spend)                                AS total_revenue,
    ROUND(AVG(nights_stayed), 2)                    AS avg_nights_stayed,
    ROUND(AVG(num_travelers), 2)                    AS avg_num_travelers,
    ROUND(AVG(daily_spend_per_person), 2)           AS avg_daily_spend_per_person,
    ROUND(AVG(satisfaction_score), 2)               AS avg_satisfaction,
    RANK() OVER (ORDER BY SUM(total_spend) DESC)    AS rank_by_revenue
FROM tourism.bookings
GROUP BY traveler_type
ORDER BY rank_by_revenue;


-- ============================================================
-- TASK 5: YEAR-OVER-YEAR REVENUE GROWTH BY REGION
-- ============================================================
-- Business question: Is tourism demand recovering and growing?
-- Leadership wants revenue trends by region and YoY growth rates.

WITH previous_year_revenues AS (
    SELECT
        region,
        EXTRACT(YEAR FROM travel_date)                                          AS travel_year,
        SUM(total_spend)                                                        AS total_revenue,
        LAG(SUM(total_spend)) OVER (
            PARTITION BY region
            ORDER BY EXTRACT(YEAR FROM travel_date)
        )                                                                       AS previous_year_revenue
    FROM tourism.bookings
    GROUP BY region, EXTRACT(YEAR FROM travel_date)
)
SELECT
    region,
    travel_year,
    total_revenue,
    previous_year_revenue,
    ROUND(
        (total_revenue - NULLIF(previous_year_revenue, 0)) * 100.0
        / NULLIF(previous_year_revenue, 0),
    2)                                                                          AS yoy_growth
FROM previous_year_revenues
ORDER BY region, travel_year;

-- ============================================================
-- TASK 6: BOOKING CHANNEL PERFORMANCE ANALYSIS
-- ============================================================
-- Business question: Which booking channels generate the most revenue
-- and which channels attract the highest-spending traveler types?

SELECT
    booking_channel,
    traveler_type,
    COUNT(*)                                AS total_bookings,
    SUM(total_spend)                        AS total_revenue,
    ROUND(AVG(daily_spend_per_person), 2)   AS avg_daily_spend_per_person,
    ROUND(AVG(satisfaction_score), 2)       AS avg_satisfaction_score,
    RANK() OVER (
        PARTITION BY booking_channel
        ORDER BY SUM(total_spend) DESC
    )                                       AS ranking
FROM tourism.bookings
GROUP BY booking_channel, traveler_type
ORDER BY booking_channel, ranking;


-- ============================================================
-- TASK 7: DESTINATION POPULARITY TREND USING DATE_TRUNC
-- ============================================================
-- Business question: Which destinations are growing or declining?
-- Quarterly booking trends per destination to spot momentum.

WITH quarterly_performance AS (
    SELECT
        destination,
        DATE_TRUNC('quarter', travel_date)                          AS quarter_date,
        COUNT(*)                                                    AS total_bookings,
        SUM(total_spend)                                            AS total_revenue,
        ROUND(AVG(daily_spend_per_person), 2)                       AS avg_daily_spend_per_person,
        LAG(COUNT(*)) OVER (
            PARTITION BY destination
            ORDER BY DATE_TRUNC('quarter', travel_date)
        )                                                           AS previous_quarter_bookings
    FROM tourism.bookings
    GROUP BY destination, DATE_TRUNC('quarter', travel_date)
)
SELECT
    destination,
    TO_CHAR(quarter_date, 'YYYY "Q"Q')                             AS quarter_label,
    total_bookings,
    total_revenue,
    previous_quarter_bookings,
    avg_daily_spend_per_person,
    ROUND(
        (total_bookings - previous_quarter_bookings) * 100.0
        / NULLIF(previous_quarter_bookings, 0),
    2)                                                              AS qoq_bookings
FROM quarterly_performance
ORDER BY destination, quarter_date;























