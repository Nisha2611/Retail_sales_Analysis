-- 04_data_exploration.sql
-- Exploratory Data Analysis Queries

--Total sales (transactions) 
Select count([total_sale]) as Total_sales_transaction
from Retail_sales

--Total revenue generated
Select format(Round(sum(total_sale),2),'c','en-IN') as Total_revenue 
from retail_sales

--Total cost incurred
Select format(sum(cogs),'c','en-in')as Total_revenue from retail_sales

--Total profit earned
Select format(Round(sum(total_sale - cogs),2),'c','en-IN')as Total_profit from retail_sales

-- Average sales amount per transaction 
select format(Round(avg(total_sale),2),'c','en-In') as Average_sale_per_transaction
from retail_sales

--average quantity sold per transaction
Select Round(avg(quantity),2) as Average_quantity_per_transaction
from retail_sales

-----Customer Analysis-----

--Unique customers who made the purchase
Select count(distinct(customer_id)) as unique_customers
from retail_sales

--Gender distribution of customers
Select gender, count(*) count_of_gender
from retail_sales
group by gender

--Which gender spends more per transaction?
Select gender,format(round(avg(total_sale),2),'c','en-In') as Average_sale_per_transaction
from retail_sales
group by gender

--Age distribution of customers 
select age, count(*) as total_no_of_customer
from retail_sales
group by age 

--Which top 10 age group contributes most to sales?
Select top 10 age, format(sum(total_sale),'c','en-in') as Total_sales_by_age
from retail_sales
group by age 
order by sum(total_sale) desc

--Who are the top 5 customers by spending?
select top 5 customer_id, format(sum(total_sale),'c','en-in') as total_spending
from retail_sales
group by customer_id
order by total_spending desc

-----Product & Category Analysis-----

--How many unique product categories exist?
Select count(distinct category) as count_of_unique_products
from retail_sales

--Which category sells the most by quantity?
Select top 1 category, sum(quantity) as total_quantity_sold
from retail_sales
group by category 
order by total_quantity_sold desc;

--Which category generates the highest revenue?
with revenue_per_category as (
select category, sum(total_sale) as revenue
from retail_sales
group by category),
ranked_revenue as (
select category,revenue,
dense_rank() over ( order by revenue desc) as rank 
from revenue_per_category 
)

select category,format(revenue,'c','en-in') as highest_revenue
from ranked_revenue
where rank = 1

--What is the average price per unit for each category?
Select category, format(avg(price_per_unit),'c','en-in') as average_price_per_unit
from  retail_sales
group by category;

--Which category has the highest profit margin?
WITH profit_margin_per_category AS (
SELECT category,
SUM(total_sale) AS total_sale,
SUM(total_sale - cogs) AS total_profit,
(SUM(total_sale - cogs) * 100.0) / NULLIF(SUM(total_sale), 0) AS total_profit_margin
FROM retail_sales
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

SELECT category, format(total_profit_margin,'n2') + '%' as total_profit_margin
FROM ranked_category
WHERE rank = 1;


-----Time-Based Trends-----

--What is the monthly trend of total sales and revenue?
SELECT
    FORMAT(sales_date, 'MM') AS month,
    
    -- Sales for 2022
    FORMAT(SUM(CASE WHEN FORMAT(sales_date, 'yyyy') = '2022' THEN total_sale ELSE 0 END), 'c', 'en-in') AS total_sale_2022,
    FORMAT(SUM(CASE WHEN FORMAT(sales_date, 'yyyy') = '2022' THEN cogs ELSE 0 END), 'c', 'en-in') AS total_cogs_2022,
    FORMAT(SUM(CASE WHEN FORMAT(sales_date, 'yyyy') = '2022' THEN total_sale - cogs ELSE 0 END), 'c', 'en-in') AS total_profit_2022,
    
    -- Sales for 2023
    FORMAT(SUM(CASE WHEN FORMAT(sales_date, 'yyyy') = '2023' THEN total_sale ELSE 0 END), 'c', 'en-in') AS total_sale_2023,
    FORMAT(SUM(CASE WHEN FORMAT(sales_date, 'yyyy') = '2023' THEN cogs ELSE 0 END), 'c', 'en-in') AS total_cogs_2023,
    FORMAT(SUM(CASE WHEN FORMAT(sales_date, 'yyyy') = '2023' THEN total_sale - cogs ELSE 0 END), 'c', 'en-in') AS total_profit_2023

FROM retail_sales
GROUP BY FORMAT(sales_date, 'MM')
ORDER BY month;


--Which day of the week has the highest sales volume?
select top 1 format(sales_date,'dddd') as day_of_week,
sum(total_sale) as highest_sales_volume
from retail_sales
group by format(sales_date,'dddd')
order by sum(total_sale) desc 

--What is the busiest hours of the day for sales?
select  top 1
datepart(hour,sales_time) as busiest_hour,
format(sum(total_sale),'c','en-in') as total_sale
from retail_sales
group by datepart(hour,sales_time)
order by total_sale desc 
