# Tourism Demand Analytics

## Business Problem
As a data analyst at a national tourism board, leadership needs insights into destination performance, seasonal demand patterns, and traveler behavior to inform marketing strategy and resource allocation.

## Dataset
- **Table:** `tourism.bookings`
- **Size:** 50,000 bookings from 2019–2023
- **Scope:** 15 destinations across Europe, Asia, Americas, Africa, Middle East
- **Source countries:** 15 major tourism markets

### Schema
| Column | Type | Description |
|---|---|---|
| `booking_id` | INT | Unique booking identifier |
| `destination` | VARCHAR | City name |
| `destination_country` | VARCHAR | Country |
| `region` | VARCHAR | Geographic region |
| `source_country` | VARCHAR | Tourist origin country |
| `travel_date` | DATE | Arrival date |
| `travel_year` | INT | Year (2019–2023) |
| `travel_month` | VARCHAR | Month name |
| `nights_stayed` | INT | Length of stay |
| `num_travelers` | INT | Party size |
| `traveler_type` | VARCHAR | Solo/Couple/Family/Group/Business |
| `accommodation_type` | VARCHAR | Hotel tier / Airbnb / Hostel |
| `booking_channel` | VARCHAR | Direct / Agency / Corporate |
| `trip_purpose` | VARCHAR | Leisure / Business / Honeymoon / etc. |
| `daily_spend_per_person` | NUMERIC | Per-person daily spend |
| `total_spend` | NUMERIC | Total booking revenue |
| `satisfaction_score` | INT | Rating 1–5 |
| `is_repeat_visitor` | INT | 0 or 1 |

## Key Questions
1. Which destinations drive the most revenue?
2. How does demand vary by season and region?
3. What traveler segments spend the most?
4. How do booking channels differ in performance?
5. What factors correlate with satisfaction?

## Status
- [x] Task 1: Data Audit
- [x] Task 2: Destination Performance Overview
- [x] Task 3: Seasonal Demand by Region
- [x] Task 4: Traveler Segment Revenue Analysis
- [x] Task 5: Year-over-Year Revenue Growth
- [x] Task 6: Booking Channel Performance
- [x] Task 7: Quarterly Destination Trend
- [x] Task 8: Destination Performance Scorecard