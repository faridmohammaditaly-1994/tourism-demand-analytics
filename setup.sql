CREATE SCHEMA tourism;

CREATE TABLE tourism.bookings (
    booking_id              INT,
    destination             VARCHAR(100),
    destination_country     VARCHAR(100),
    region                  VARCHAR(50),
    source_country          VARCHAR(100),
    travel_date             DATE,
    travel_year             INT,
    travel_month            VARCHAR(20),
    nights_stayed           INT,
    num_travelers           INT,
    traveler_type           VARCHAR(50),
    accommodation_type      VARCHAR(50),
    booking_channel         VARCHAR(50),
    trip_purpose            VARCHAR(50),
    daily_spend_per_person  NUMERIC(10,2),
    total_spend             NUMERIC(10,2),
    satisfaction_score      INT,
    is_repeat_visitor       INT
);