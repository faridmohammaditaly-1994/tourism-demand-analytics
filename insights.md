# Tourism Demand Analytics — Key Insights

## Task 1: Data Audit
- **Dataset:** 50,000 bookings spanning 2019-01-01 to 2023-12-31
- **Data quality:** No nulls, no outliers — all satisfaction scores within 1–5 range
- **Geographic coverage:** 15 distinct source countries
- **Completeness:** 100% — all bookings have valid spend, nights stayed, and traveler counts

## Task 2: Destination Performance Overview
- **Top revenue destinations:** Paris ($12.7M), Bangkok ($12.6M), New York ($12.5M)
- **Distribution:** Revenue is evenly distributed across 15 destinations — no single destination dominates
- **Satisfaction:** Average satisfaction scores range from 3.80 to 3.85 — consistent across all destinations
- **Regional balance:** Europe has 6 destinations in top 15, but Asia and Americas compete strongly

## Task 3: Seasonal Demand by Region
- **Africa peak:** December (11.45% of annual revenue) vs February low (4.73%) — 2.4x seasonal swing
- **Americas:** More balanced distribution — June leads at 11.10%, but no month drops below 7%
- **Window function insight:** Nested SUM required to calculate monthly percentage of regional total without collapsing result set

## Task 4: Traveler Segment Revenue Analysis
- **Group Tour dominates revenue** ($86M, rank #1) purely due to party size (16.44 avg travelers)
- **Business travelers** have highest satisfaction (4.25) and highest daily spend per person ($311)
- **All segments have equal booking volume** (~10,000 each) — revenue differences driven by party size and spend, not demand
- **Recommendation:** Improve Group Tour satisfaction to protect the highest-revenue segment; upsell Business travelers on longer stays

## Task 5: Year-over-Year Revenue Growth by Region
- **2020 decline:** All regions dropped in 2020 — consistent with COVID-19 impact on global tourism
- **Asia hardest hit:** -8.48% in 2020 and continued declining through 2023 (-5.30%) — never fully recovered
- **Middle East most volatile:** Swung from +12.99% in 2021 to -8.40% in 2023
- **Europe most stable:** Largest revenue region but growth has been flat since 2020 recovery
- **No region returned to strong growth by 2023** — suggests full tourism recovery was still incomplete