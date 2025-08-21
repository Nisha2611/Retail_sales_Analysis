-- Retail Sales Analysis

Create database SQL_Projects_1

-- Drop final table if exists
IF OBJECT_ID('dbo.Retail_sales', 'U') IS NOT NULL
    DROP TABLE dbo.Retail_sales;

-- Create final table
CREATE TABLE dbo.Retail_sales (
    transactions_id   INT NOT NULL,
    sales_date        DATE,
    sales_time        TIME(7),
    customer_id       INT,
    gender            VARCHAR(10),
    age               INT,
    category          VARCHAR(15),
    quantity          INT,
    price_per_unit    FLOAT,
    cogs              FLOAT,
    total_sale        FLOAT
);


//*  Imported data from CSV 
Faced error while importing directly so imported by creating staging table *//

-- Drop staging table if exists
IF OBJECT_ID('dbo.Retail_sales_staging', 'U') IS NOT NULL
    DROP TABLE dbo.Retail_sales_staging;

--Create staging table with all columns as VARCHAR for flexible import
CREATE TABLE dbo.Retail_sales_staging (
    transactions_id   VARCHAR(100) NULL,
    sales_date        VARCHAR(100) NULL,
    sales_time        VARCHAR(100) NULL,
    customer_id       VARCHAR(100) NULL,
    gender            VARCHAR(100) NULL,
    age               VARCHAR(100) NULL,
    category          VARCHAR(100) NULL,
    quantity          VARCHAR(100) NULL,
    price_per_unit    VARCHAR(100) NULL,
    cogs              VARCHAR(100) NULL,
    total_sale        VARCHAR(100) NULL
);

-- Insert into dbo.Retail_sales with proper type conversion and NULL handling
INSERT INTO dbo.Retail_sales (
    transactions_id,
    sales_date,
    sales_time,
    customer_id,
    gender,
    age,
    category,
    quantity,
    price_per_unit,
    cogs,
    total_sale
)
SELECT
    TRY_CAST(NULLIF(transactions_id, '') AS INT),
    TRY_CAST(NULLIF(sales_date, '') AS DATE),
    TRY_CAST(NULLIF(sales_time, '') AS TIME),
    TRY_CAST(NULLIF(customer_id, '') AS INT),
    gender,
    TRY_CAST(NULLIF(age, '') AS INT),
    category,
    TRY_CAST(NULLIF(quantity, '') AS INT),
    TRY_CAST(NULLIF(price_per_unit, '') AS FLOAT),
    TRY_CAST(NULLIF(cogs, '') AS FLOAT),
    TRY_CAST(NULLIF(total_sale, '') AS FLOAT)
FROM dbo.Retail_sales_staging
WHERE NULLIF(transactions_id, '') IS NOT NULL;

-- Truncate the staging table 
TRUNCATE TABLE dbo.Retail_sales_staging;

--Define transactions_id as the primary key
ALTER TABLE dbo.Retail_sales
ADD CONSTRAINT PK_Retail_sales_transactions_id PRIMARY KEY (transactions_id);

--check if all data have been imported count of data in csv file is 2000)
Select count(*)
from [dbo].[Retail_sales]

/* Result shows 2000 hence proving successful import and insert  */

/* DATA CLEANING */

-- Check if any null values
Select * from Retail_sales
where transactions_id is null
or sales_date is null
or sales_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null

--Handling null values 
Delete from Retail_sales
where transactions_id is null
or sales_date is null
or sales_time is null
or customer_id is null
or gender is null
or age is null
or category is null
or quantity is null
or price_per_unit is null
or cogs is null
or total_sale is null


--Indexing for performance 

-- Index for customer analysis
CREATE NONCLUSTERED INDEX IX_RetailSales_CustomerID
ON dbo.Retail_sales (customer_id);

-- Index for date-based queries
CREATE NONCLUSTERED INDEX IX_RetailSales_SalesDate
ON dbo.Retail_sales (sales_date);

-- Index for category-based queries
CREATE NONCLUSTERED INDEX IX_RetailSales_Category
ON dbo.Retail_sales (category);

-- Composite index for gender & age segmentation
CREATE NONCLUSTERED INDEX IX_RetailSales_Gender_Age
ON dbo.Retail_sales (gender, age);


/* DATA EXPLORATION */

-----General Sales Overview-----

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

-----Profitability & Strategy-----

--Which customer segments (by age and gender) have the highest profit margin (profit/revenue)?
select top 1 age,gender,
format(sum(total_sale),'c','en-in') as total_sales,
format(sum(cogs),'c','en-in') as total_cogs,
format(sum(total_sale - cogs),'c','en-in') as total_profit,
format((sum(total_sale - cogs) *100.0)/nullif(sum(total_sale),0),'n2') +'%' as total_profit_margin
from retail_sales
group by age,gender
order by total_profit_margin desc;

--Are there product categories with high sales volume but below-average profit margins?

with category_profit_margin as (
select category,
sum(total_sale) as total_sale,
sum(cogs) as total_cog,
sum(total_sale - cogs) as total_profit,
(sum(total_sale-cogs) * 100.0) / nullif (sum(total_sale),0) as total_profit_margin 
from retail_sales
group by category),
average_profit_margin as (
select  avg(total_profit_margin) as category_average_profit_margin
from category_profit_margin
),
average_sales_margin as (
select avg(total_sale) as category_average_sale
from category_profit_margin
)

select cpm.category,
format(round(cpm.total_sale,2),'c','en-in') as Total_sale, 
format(round(cpm.total_profit_margin,2),'n2')+'%' as total_profit_margin
from category_profit_margin cpm
cross join average_profit_margin apm
cross join average_sales_margin asm 
where cpm.total_profit_margin <  apm.category_average_profit_margin
and cpm.total_sale >asm.category_average_sale
order by cpm.total_sale desc 

 --Which hour of the day generates the highest profit (not just sales)?
 select top 1
 datepart(hour , sales_time) as sale_hour,
 format(sum(total_sale - cogs),'c','en-in') as total_profit
 from retail_sales
 group by datepart(hour , sales_time)
 order by total_profit desc 

 --Which day of the week has the highest profit margin?
 select top 1
 datename(weekday,sales_date) as sales_day,
 format((sum(total_sale - cogs)*100)/nullif(sum(total_sale),0),'n2') + '%' as total_profit_margin
 from retail_sales
 group by datename(weekday,sales_date)
 order by total_profit_margin desc ;

 --Which top 10 customers have high revenue but low profit margins?

 with customerwise_margin as (
 select customer_id,
 sum(total_sale) as customer_total_sale,
 sum(total_sale - cogs) as customer_total_profit,
(sum(total_sale - cogs)*100.0)/nullif(sum(total_sale),0) as customer_profit_margin
 from retail_sales
 group by customer_id),
 average_profit_margin as (
 select avg(customer_profit_margin) as customer_average_profit_margin
from customerwise_margin),
average_sales as (
select avg(customer_total_sale) as customer_average_sale 
from customerwise_margin)

select top 10
cm.customer_id,
Format(Round(cm.customer_total_sale,2),'c','en-in')as customer_total_sale,
format(round(cm.customer_profit_margin,2),'N2') + ' %' as customer_profit_margin
from customerwise_margin cm
cross join average_profit_margin apm
cross join average_sales avg_sale
where cm.customer_total_sale > avg_sale.customer_average_sale
and cm.customer_profit_margin < apm.customer_average_profit_margin
order by cm.customer_total_sale desc 

--What  top 5 category + customer segment combinations drive the most profit?
select top 5 category,
customer_id ,
format(sum(total_sale - cogs),'c','en-in') as total_profit
from retail_sales
group by category,customer_id
order by total_profit desc;


--Based on the analysis, which top 10 customer segments (age or gender) and product categories should be prioritized for marketing and growth strategies?

with segment_profit as (
select age, gender,
sum(total_sale) as total_sale,
sum(total_sale - cogs) as total_profit,
sum(total_sale - cogs) *100.0/nullif(sum(total_sale),0) as total_profit_margin
from retail_sales
group by age,gender
),
category_profit as ( 
select category,
sum(total_sale) as category_total_sale,
sum(total_sale - cogs) as category_total_profit,
sum(total_sale - cogs) *100.0/nullif(sum(total_sale),0) as category_profit_margin
from retail_sales
group by category
)

select top 10 
sp.gender,
sp.age,
format(sp.total_sale,'c','en-in') as total_sale,
format(sp.total_profit,'c','en-in') as total_profit,
format(sp.total_profit_margin,'n2') +'%' as total_profit_margin,
cp.category,
format(cp.category_total_sale,'c','en-in') as category_total_sale,
format(cp. category_total_profit,'c','en-in') as category_total_sale,
format(cp.category_profit_margin,'n2') + '%' as category_profit_margin
from segment_profit sp
cross join category_profit as cp 
where sp.total_profit > (select avg(total_profit) from segment_profit)
and cp.category_total_profit > (select avg(category_total_profit) from category_profit)
order by sp.total_profit desc, cp.category_total_profit desc 

--End of project 


