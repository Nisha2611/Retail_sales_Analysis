-- 05_insights_summary.sql
-- Strategic Business Insights and Profitability

-- Highest revenue-generating category
WITH revenue_per_category AS (
    SELECT category, SUM(total_sale) AS revenue
    FROM Retail_sales
    GROUP BY category
),
ranked_revenue AS (
    SELECT category, revenue, DENSE_RANK() OVER (ORDER BY revenue DESC) AS rank
    FROM revenue_per_category
)
SELECT category, revenue AS Highest_Revenue
FROM ranked_revenue
WHERE rank = 1;

-- Category with highest profit margin
WITH profit_margin_per_category AS (
    SELECT category,
        SUM(total_sale) AS total_sale,
        SUM(total_sale - cogs) AS total_profit,
        (SUM(total_sale - cogs) * 100.0) / NULLIF(SUM(total_sale), 0) AS total_profit_margin
    FROM Retail_sales
    GROUP BY category
),
ranked_category AS (
    SELECT category, total_profit_margin, DENSE_RANK() OVER (ORDER BY total_profit_margin DESC) AS rank
    FROM profit_margin_per_category
)
SELECT category, total_profit_margin
FROM ranked_category
WHERE rank = 1;

-- Monthly trend of sales, cogs, and profit
SELECT FORMAT(sales_date, 'yyyy-MM') AS Month,
       SUM(total_sale) AS Monthly_Sales,
       SUM(cogs) AS Monthly_COGS,
       SUM(total_sale - cogs) AS Monthly_Profit
FROM Retail_sales
GROUP BY FORMAT(sales_date, 'yyyy-MM')
ORDER BY Month;

-- Busiest hour by sales
SELECT DATEPART(hour, sales_time) AS Hour,
       SUM(total_sale) AS Total_Sales
FROM Retail_sales
GROUP BY DATEPART(hour, sales_time)
ORDER BY Total_Sales DESC;

-- Day of week with highest profit margin
SELECT TOP 1 DATENAME(weekday, sales_date) AS Day,
       (SUM(total_sale - cogs) * 100.0) / NULLIF(SUM(total_sale), 0) AS Profit_Margin
FROM Retail_sales
GROUP BY DATENAME(weekday, sales_date)
ORDER BY Profit_Margin DESC;

-- Top customer segments by profit
SELECT TOP 1 age, gender,
       SUM(total_sale) AS Total_Sale,
       SUM(total_sale - cogs) AS Profit,
       (SUM(total_sale - cogs) * 100.0) / NULLIF(SUM(total_sale), 0) AS Profit_Margin
FROM Retail_sales
GROUP BY age, gender
ORDER BY Profit_Margin DESC;
