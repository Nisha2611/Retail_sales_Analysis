-- 05_insights_summary.sql
-- Profitability & Strategy Insights

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
