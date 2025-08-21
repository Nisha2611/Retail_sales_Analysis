-- 05_insights_summary.sql
-- Profitability & Strategy Insights

-- Which customer segments (by age and gender) have the highest profit margin (profit/revenue)?
SELECT TOP 1 age, gender,
       SUM(total_sale) AS total_sales,
       SUM(cogs) AS total_cogs,
       SUM(total_sale - cogs) AS total_profit,
       (SUM(total_sale - cogs) * 100.0) / NULLIF(SUM(total_sale), 0) AS total_profit_margin
FROM Retail_sales
GROUP BY age, gender
ORDER BY total_profit_margin DESC;

-- Are there product categories with high sales volume but below-average profit margins?
WITH category_profit_margin AS (
    SELECT category,
           SUM(total_sale) AS total_sale,
           SUM(cogs) AS total_cog,
           SUM(total_sale - cogs) AS total_profit,
           (SUM(total_sale - cogs) * 100.0) / NULLIF(SUM(total_sale), 0) AS total_profit_margin
    FROM Retail_sales
    GROUP BY category
),
average_profit_margin AS (
    SELECT AVG(total_profit_margin) AS category_average_profit_margin FROM category_profit_margin
),
average_sales_margin AS (
    SELECT AVG(total_sale) AS category_average_sale FROM category_profit_margin
)
SELECT cpm.category,
       cpm.total_sale,
       cpm.total_profit_margin
FROM category_profit_margin cpm
CROSS JOIN average_profit_margin apm
CROSS JOIN average_sales_margin asm
WHERE cpm.total_profit_margin < apm.category_average_profit_margin
  AND cpm.total_sale > asm.category_average_sale
ORDER BY cpm.total_sale DESC;

-- Which hour of the day generates the highest profit (not just sales)?
SELECT TOP 1 DATEPART(hour, sales_time) AS sale_hour,
       SUM(total_sale - cogs) AS total_profit
FROM Retail_sales
GROUP BY DATEPART(hour, sales_time)
ORDER BY total_profit DESC;

-- Which day of the week has the highest profit margin?
SELECT TOP 1 DATENAME(weekday, sales_date) AS sales_day,
       (SUM(total_sale - cogs) * 100) / NULLIF(SUM(total_sale), 0) AS total_profit_margin
FROM Retail_sales
GROUP BY DATENAME(weekday, sales_date)
ORDER BY total_profit_margin DESC;

-- Which customers have high revenue but low profit margins?
WITH customerwise_margin AS (
    SELECT customer_id,
           SUM(total_sale) AS customer_total_sale,
           SUM(total_sale - cogs) AS customer_total_profit,
           (SUM(total_sale - cogs) * 100.0) / NULLIF(SUM(total_sale), 0) AS customer_profit_margin
    FROM Retail_sales
    GROUP BY customer_id
),
average_profit_margin AS (
    SELECT AVG(customer_profit_margin) AS customer_average_profit_margin FROM customerwise_margin
),
average_sales AS (
    SELECT AVG(customer_total_sale) AS customer_average_sale FROM customerwise_margin
)
SELECT cm.customer_id,
       cm.customer_total_sale,
       cm.customer_profit_margin
FROM customerwise_margin cm
CROSS JOIN average_profit_margin apm
CROSS JOIN average_sales avg_sale
WHERE cm.customer_total_sale > avg_sale.customer_average_sale
  AND cm.customer_profit_margin < apm.customer_average_profit_margin
ORDER BY cm.customer_total_sale DESC;

-- What category + customer segment combinations drive the most profit?
SELECT category,
       customer_id,
       SUM(total_sale - cogs) AS total_profit
FROM Retail_sales
GROUP BY category, customer_id
ORDER BY total_profit DESC;

-- Based on the analysis, which customer segments (age or gender) and product categories should be prioritized for marketing and growth strategies?
WITH segment_profit AS (
    SELECT age, gender,
           SUM(total_sale) AS total_sale,
           SUM(total_sale - cogs) AS total_profit,
           SUM(total_sale - cogs) * 100.0 / NULLIF(SUM(total_sale), 0) AS total_profit_margin
    FROM Retail_sales
    GROUP BY age, gender
),
category_profit AS (
    SELECT category,
           SUM(total_sale) AS category_total_sale,
           SUM(total_sale - cogs) AS category_total_profit,
           SUM(total_sale - cogs) * 100.0 / NULLIF(SUM(total_sale), 0) AS category_profit_margin
    FROM Retail_sales
    GROUP BY category
)
SELECT sp.gender,
       sp.age,
       sp.total_sale,
       sp.total_profit,
       sp.total_profit_margin,
       cp.category,
       cp.category_total_sale,
       cp.category_total_profit,
       cp.category_profit_margin
FROM segment_profit sp
CROSS JOIN category_profit cp
WHERE sp.total_profit > (SELECT AVG(total_profit) FROM segment_profit)
  AND cp.category_total_profit > (SELECT AVG(category_total_profit) FROM category_profit)
ORDER BY sp.total_profit DESC, cp.category_total_profit DESC;

-- End of Project
