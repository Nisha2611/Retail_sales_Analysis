-- 04_data_exploration.sql
-- Exploratory Data Analysis Queries

----- General Sales Overview -----

-- Total sales (transactions) 
SELECT COUNT(total_sale) AS Total_sales_transaction FROM Retail_sales;

-- Total revenue generated
SELECT SUM(total_sale) AS Total_revenue FROM Retail_sales;

-- Total cost incurred
SELECT SUM(cogs) AS Total_cogs FROM Retail_sales;

-- Total profit earned
SELECT SUM(total_sale - cogs) AS Total_profit FROM Retail_sales;

-- Average sales amount per transaction 
SELECT AVG(total_sale) AS Average_sale_per_transaction FROM Retail_sales;

-- Average quantity sold per transaction
SELECT AVG(quantity) AS Average_quantity_per_transaction FROM Retail_sales;

----- Customer Analysis -----

-- Unique customers who made the purchase
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM Retail_sales;

-- Gender distribution of customers
SELECT gender, COUNT(*) AS count_of_gender FROM Retail_sales GROUP BY gender;

-- Which gender spends more per transaction?
SELECT gender, AVG(total_sale) AS Average_sale_per_transaction FROM Retail_sales GROUP BY gender;

-- Age distribution of customers 
SELECT age, COUNT(*) AS total_no_of_customer FROM Retail_sales GROUP BY age;

-- Which age group contributes most to sales?
SELECT age, SUM(total_sale) AS Total_sales_by_age FROM Retail_sales GROUP BY age ORDER BY Total_sales_by_age DESC;

-- Who are the top 5 customers by spending?
SELECT TOP 5 customer_id, SUM(total_sale) AS total_spending FROM Retail_sales GROUP BY customer_id ORDER BY total_spending DESC;

----- Product & Category Analysis -----

-- How many unique product categories exist?
SELECT COUNT(DISTINCT category) AS count_of_unique_products FROM Retail_sales;

-- Which category sells the most by quantity?
SELECT TOP 1 category, SUM(quantity) AS total_quantity_sold FROM Retail_sales GROUP BY category ORDER BY total_quantity_sold DESC;

-- Which category generates the highest revenue?
WITH revenue_per_category AS (
    SELECT category, SUM(total_sale) AS revenue FROM Retail_sales GROUP BY category
),
ranked_revenue AS (
    SELECT category, revenue, DENSE_RANK() OVER (ORDER BY revenue DESC) AS rank FROM revenue_per_category
)
SELECT category, revenue AS highest_revenue FROM ranked_revenue WHERE rank = 1;

-- What is the average price per unit for each category?
SELECT category, AVG(price_per_unit) AS average_price_per_unit FROM Retail_sales GROUP BY category;

-- Which category has the highest profit margin?
WITH profit_margin_per_category AS (
    SELECT category,
           SUM(total_sale) AS total_sale,
           SUM(total_sale - cogs) AS total_profit,
           (SUM(total_sale - cogs) * 100.0) / NULLIF(SUM(total_sale), 0) AS total_profit_margin
    FROM Retail_sales
    GROUP BY category
),
ranked_category AS (
    SELECT category,
           total_sale,
           total_profit,
           total_profit_margin,
           DENSE_RANK() OVER (ORDER BY total_profit_margin DESC) AS rank
    FROM profit_margin_per_category
)
SELECT category, total_profit_margin FROM ranked_category WHERE rank = 1;

----- Time-Based Trends -----

-- What is the monthly trend of total sales and revenue?
SELECT FORMAT(sales_date, 'yyyy-MM') AS month,
       SUM(total_sale) AS total_monthly_sale,
       SUM(cogs) AS total_monthly_cogs,
       SUM(total_sale - cogs) AS total_monthly_profit
FROM Retail_sales
GROUP BY FORMAT(sales_date, 'yyyy-MM')
ORDER BY month;

-- Which day of the week has the highest sales volume?
SELECT TOP 1 FORMAT(sales_date, 'dddd') AS day_of_week,
       SUM(total_sale) AS highest_sales_volume
FROM Retail_sales
GROUP BY FORMAT(sales_date, 'dddd')
ORDER BY highest_sales_volume DESC;

-- What are the busiest hours of the day for sales?
SELECT DATEPART(hour, sales_time) AS busiest_hour,
       SUM(total_sale) AS total_sale
FROM Retail_sales
GROUP BY DATEPART(hour, sales_time)
ORDER BY total_sale DESC;
