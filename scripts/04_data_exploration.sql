-- 04_data_exploration.sql
-- Exploratory Data Analysis Queries

-- General Overview
SELECT COUNT(total_sale) AS Total_Transactions FROM Retail_sales;
SELECT SUM(total_sale) AS Total_Revenue FROM Retail_sales;
SELECT SUM(cogs) AS Total_COGS FROM Retail_sales;
SELECT SUM(total_sale - cogs) AS Total_Profit FROM Retail_sales;
SELECT AVG(total_sale) AS Avg_Sale_Per_Transaction FROM Retail_sales;
SELECT AVG(quantity) AS Avg_Quantity_Per_Transaction FROM Retail_sales;

-- Customer Analysis
SELECT COUNT(DISTINCT customer_id) AS Unique_Customers FROM Retail_sales;
SELECT gender, COUNT(*) AS Count_By_Gender FROM Retail_sales GROUP BY gender;
SELECT gender, AVG(total_sale) AS Avg_Sale_By_Gender FROM Retail_sales GROUP BY gender;
SELECT age, COUNT(*) AS Customers_By_Age FROM Retail_sales GROUP BY age;
SELECT TOP 1 age, SUM(total_sale) AS Sales_By_Age FROM Retail_sales GROUP BY age ORDER BY Sales_By_Age DESC;
SELECT TOP 5 customer_id, SUM(total_sale) AS Total_Spending FROM Retail_sales GROUP BY customer_id ORDER BY Total_Spending DESC;

-- Product Category Analysis
SELECT COUNT(DISTINCT category) AS Unique_Categories FROM Retail_sales;
SELECT TOP 1 category, SUM(quantity) AS Quantity_Sold FROM Retail_sales GROUP BY category ORDER BY Quantity_Sold DESC;
SELECT category, AVG(price_per_unit) AS Avg_Unit_Price FROM Retail_sales GROUP BY category;
