/*
==========================================================
 RetailCo Sales Decline Analysis

 Business Problem:
 RetailCo increased marketing spend by 18% in 2024,
 however overall revenue declined.

 Objective:
 Identify the root cause using SQL analysis before
 building Tableau dashboards.
==========================================================
*/

USE prac;

-- ======================================================
-- 1. Revenue Overview
-- ======================================================

-- Total orders by year
SELECT
    YEAR(o_date) AS year,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_transc
GROUP BY YEAR(o_date);

-- Insight:
-- Order count remained relatively stable.


-- Total revenue by year
SELECT
    YEAR(o_date) AS year,
    ROUND(SUM(revenue),2) AS total_revenue
FROM sales_transc
GROUP BY YEAR(o_date);

-- Insight:
-- Revenue declined by approximately 28% in 2024.


-- ======================================================
-- 2. Regional Performance
-- ======================================================

-- Order count by region
SELECT
    YEAR(o_date) AS year,
    region,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_transc
GROUP BY YEAR(o_date), region
ORDER BY region;

-- Insight:
-- No major decline in order volume across regions.


-- Revenue by region
SELECT
    YEAR(o_date) AS year,
    region,
    ROUND(SUM(revenue),2) AS total_revenue
FROM sales_transc
GROUP BY YEAR(o_date), region
ORDER BY region;

-- Insight:
-- East and North experienced the largest revenue decline.


-- ======================================================
-- 3. Discount Analysis
-- ======================================================

-- Average discount by region
SELECT
    YEAR(o_date) AS year,
    region,
    ROUND(AVG(discount),2) AS avg_discount_pct
FROM sales_transc
GROUP BY YEAR(o_date), region
ORDER BY region;

-- Insight:
-- East and North nearly doubled their discount percentage.


-- Average Order Value (AOV)
SELECT
    YEAR(o_date) AS year,
    ROUND(SUM(revenue)/COUNT(DISTINCT order_id),2) AS avg_order_value
FROM sales_transc
GROUP BY YEAR(o_date);

-- Insight:
-- Average Order Value declined in 2024 despite higher discounts.


-- ======================================================
-- 4. Marketing Performance
-- ======================================================

-- CTR by marketing channel
SELECT
    YEAR(month) AS year,
    channel,
    ROUND((SUM(clicks)/SUM(impressions))*100,2) AS ctr_pct
FROM marketing_spend
GROUP BY YEAR(month), channel;

-- Insight:
-- Digital and TV performed better than Email and Outdoor.


-- Conversion Rate
SELECT
    YEAR(month) AS year,
    channel,
    ROUND((SUM(conversions)/SUM(clicks))*100,2) AS conversion_rate
FROM marketing_spend
GROUP BY YEAR(month), channel;

-- Insight:
-- Conversion efficiency varied significantly across channels.


-- Cost Per Conversion (CPC)
SELECT
    YEAR(month) AS year,
    region,
    ROUND(SUM(spend)/SUM(conversions),2) AS cost_per_conversion
FROM marketing_spend
GROUP BY YEAR(month), region;

-- Insight:
-- CPC increased sharply in East and North.


-- ======================================================
-- 5. Customer Health
-- ======================================================

-- Customer status distribution
SELECT
    region,
    c_status,
    COUNT(*) AS customer_count
FROM cust_master
GROUP BY region, c_status;

-- Insight:
-- North has the highest number of occasional customers.


-- Customer Lifetime Value
SELECT
    region,
    ROUND(AVG(lifetime_value),2) AS avg_ltv
FROM cust_master
GROUP BY region
ORDER BY avg_ltv DESC;

-- Insight:
-- South has the highest average customer lifetime value.


-- ======================================================
-- 6. Target Achievement
-- ======================================================

SELECT
    year,
    region,
    target,
    actual,
    achievement_pct
FROM regional_targets
ORDER BY year, region;

-- Insight:
-- West achieved target while East and North missed theirs.


-- ======================================================
-- Final Business Conclusions
-- ======================================================

/*
1. Revenue declined despite similar order volume.

2. East and North experienced the largest revenue loss.

3. Higher discounts reduced Average Order Value.

4. Marketing became less efficient as CPC increased.

5. North has the weakest customer health due to
   high churn and more occasional customers.

6. South and West demonstrate healthier pricing,
   marketing efficiency and customer retention.
*/