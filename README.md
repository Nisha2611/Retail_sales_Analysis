# 🛒 Retail Sales Analysis – SQL Project

This project demonstrates a complete end-to-end data analysis workflow using **SQL** on a retail sales dataset. From **data import and cleaning**, to **index optimization**, and finally to **generating valuable business insights**, this project shows how raw transactional data can be transformed into actionable intelligence.

> 👨‍💼 Ideal for stakeholders, data analysts, and business users looking to understand customer behavior, product performance, and profitability trends.

---

## 📁 Project Structure

```
Retail-Sales-Analysis/
├── data/
│   └── retail_sales.csv              # Raw dataset (1997 rows of retail transactions)
├── scripts/
│   ├── 01_create_tables.sql          # Table creation & staging setup
│   ├── 02_data_import.sql            # Data insert with transformation
│   ├── 03_indexing.sql               # Indexes for performance tuning
│   ├── 04_data_exploration.sql       # Exploratory & business queries
│   ├── 05_insights_summary.sql       # Strategic business insights
│   └── compiled.sql                  # Complete project SQL in one file 
└── README.md                         # Project overview and instructions

```

## 🧾 Dataset Overview

- **Size**: 1997 retail transactions  
- **Source**: CSV file imported into SQL Server  
- **Fields include**: transaction ID, customer ID, gender, age, category, quantity, unit price, COGS (cost), sale value, timestamp

---

## 🧰 Tech Stack

| Tool             | Purpose                         |
|------------------|----------------------------------|
| **SQL Server**   | Data transformation and querying |
| **T-SQL (SSMS)** | Writing complex SQL logic        |
| **CSV File**     | Raw data source                  |

---

## 🧱 Database Design

### ✅ Tables

- `Retail_sales_staging` – Temporary table for raw CSV import (all columns as `VARCHAR`)
- `Retail_sales` – Final, cleaned table with strict data types

### 🔐 Constraints & Keys
- Primary Key: `transactions_id`
- Data type conversions via `TRY_CAST` and `NULLIF`

### ⚙️ Indexing
Indexes created to optimize performance for common query patterns:
- By `customer_id`
- By `sales_date`
- By `category`
- Composite index on `(gender, age)`

---

## 🧼 Data Cleaning

- Removed nulls and blank values
- Ensured type casting for correct formats (`DATE`, `TIME`, `INT`, `FLOAT`)
- Truncated staging table after use

---

## 📊 Analytical Insights

### 🧾 General Sales Overview

- ✅ **Total Transactions**: `COUNT(total_sale)` confirms 1997 sales
- 💵 **Total Revenue**: `SUM(total_sale)`- ₹ 9,11,720.00
- 💰 **Total Profit**: `SUM(total_sale - cogs)`- ₹ 7,21,957.30
- 📊 **Average Sales/Transaction**: `AVG(total_sale)`- ₹ 456.54
- 📦 **Average Quantity/Transaction**: `AVG(quantity)`- 2

---

### 👤 Customer Analysis

- 👥 **Unique Customers**: `COUNT(DISTINCT customer_id)`- 155
- 🚻 **Gender Distribution**: Breakdown by `gender`
  | gender | count_of_gender |
  |--------|-----------------|
  | Female | 1017            |
  | Male   | 980             |
  
- 💳 **Avg. Spend by Gender**: `AVG(total_sale)` grouped by `gender`
  | Gender | Avg. Spend (₹) |
  |--------|----------------|
  | Male   | ₹ 455.43       |
  | Female | ₹ 457.62       |
  
- 🎂 **Age Distribution**: Count by `age`
  | age | total_no_of_customer |
  |-----|---------------------|
  | 23  | 48                  |
  | 46  | 50                  |
  | 29  | 32                  |
  | 15  | 10                  |
  | 52  | 44                  |
  | 32  | 38                  |
  | 26  | 44                  |
  | 35  | 44                  |
  | 63  | 34                  |
  | 43  | 62                  |
  | 55  | 42                  |
  | 49  | 38                  |
  | 21  | 40                  |
  | 27  | 46                  |
  | 58  | 26                  |
  | 64  | 62                  |
  | 38  | 38                  |
  | 44  | 30                  |
  | 50  | 46                  |
  | 24  | 30                  |
  | 47  | 52                  |
  | 18  | 41                  |
  | 30  | 44                  |
  | 61  | 36                  |
  | 41  | 42                  |
  | 19  | 41                  |
  | 25  | 40                  |
  | 36  | 30                  |
  | 62  | 54                  |
  | 42  | 52                  |
  | 56  | 38                  |  
  | 22  | 54                  |
  | 59  | 34                  |
  | 33  | 19                  |
  | 39  | 36                  |
  | 53  | 34                  |
  | 45  | 34                  |
  | 48  | 36                  |
  | 31  | 44                  |
  | 60  | 42                  |
  | 34  | 56                  |
  | 40  | 47                  |
  | 54  | 54                  |
  | 20  | 42                  |
  | 28  | 42                  |
  | 57  | 58                  |
  | 37  | 32                  |
  | 51  | 59                  |
  
- 💸 **Top Age Groups by Sales**: `SUM(total_sale)` grouped by `age`
  | age | Total_sales_by_age |
  |-----|--------------------|
  | 43  | ₹ 35,940.00        |
  | 34  | ₹ 33,570.00        |
  | 51  | ₹ 32,055.00        |
  | 19  | ₹ 29,690.00        |
  | 26  | ₹ 27,960.00        |
  | 22  | ₹ 27,400.00        |
  | 46  | ₹ 26,180.00        |
  | 21  | ₹ 25,170.00        |
  | 47  | ₹ 25,010.00        |
  | 37  | ₹ 23,300.00        |
  | 35  | ₹ 22,580.00        |
  | 18  | ₹ 22,340.00        |
  | 38  | ₹ 22,200.00        |
  | 60  | ₹ 21,180.00        |
  | 31  | ₹ 20,440.00        |
  | 54  | ₹ 20,010.00        |
  | 25  | ₹ 19,800.00        |
  | 50  | ₹ 19,690.00        |
  | 30  | ₹ 19,580.00        |
  | 55  | ₹ 19,560.00        |
  | 53  | ₹ 19,020.00        |
  | 59  | ₹ 18,940.00        |
  | 56  | ₹ 18,880.00        |
  
- 🏅 **Top 5 Customers by Revenue**: `SUM(total_sale)` by `customer_id`
  | customer_id | total_spending |
  |-------------|----------------|
  | 91          | ₹ 9,965.00     |
  | 61          | ₹ 9,860.00     |
  | 111         | ₹ 9,845.00     |
  | 82          | ₹ 9,360.00     |
  | 65          | ₹ 9,320.00     |


- ⚠️ **High-Spending, Low-Margin Customers**: High `total_sale` with below-average `profit margin`
| customer_id | customer_total_sale | customer_profit_margin |
|-------------|---------------------|-------------------------|
| 71          | ₹ 12,790.00         | 76.56 %                |
| 52          | ₹ 10,325.00         | 75.11 %                |
| 67          | ₹ 10,225.00         | 76.95 %                |
| 86          | ₹ 10,085.00         | 67.84 %                |
| 65          | ₹ 9,320.00          | 76.81 %                |
| 83          | ₹ 9,160.00          | 71.24 %                |
| 113         | ₹ 9,085.00          | 76.90 %                |
| 85          | ₹ 8,590.00          | 69.96 %                |
| 110         | ₹ 8,570.00          | 75.67 %                |
| 56          | ₹ 8,460.00          | 73.04 %                |
| 68          | ₹ 8,005.00          | 77.16 %                |
| 108         | ₹ 7,685.00          | 71.27 %                |
| 81          | ₹ 7,570.00          | 76.20 %                |
| 104         | ₹ 7,520.00          | 74.22 %                |
| 72          | ₹ 7,485.00          | 72.24 %                |
| 63          | ₹ 7,480.00          | 77.27 %                |
| 60          | ₹ 7,300.00          | 74.52 %                |
| 106         | ₹ 7,180.00          | 75.67 %                |
| 70          | ₹ 7,040.00          | 71.22 %                |
| 66          | ₹ 6,915.00          | 77.17 %                |
| 114         | ₹ 6,820.00          | 69.93 %                |
| 64          | ₹ 6,795.00          | 75.29 %                |
| 145         | ₹ 6,045.00          | 77.08 %                |

  
---

### 📦 Product & Category Analysis

- 🔢 **Unique Categories**: `COUNT(DISTINCT category)`
- 🏆 **Best-Selling Category (Quantity)**: `SUM(quantity)` grouped by `category`
- 💸 **Top Revenue-Generating Category**: Ranked `SUM(total_sale)` by category
- 📈 **Avg. Price per Unit by Category**: `AVG(price_per_unit)`
- 💹 **Highest Profit Margin by Category**: Category with max `profit margin`
- 🚨 **High Sales, Low Margin Categories**: Above-average sales but below-average profit margins

---

### 🕒 Time-Based Trends

- 🗓️ **Monthly Sales & Profit Trends**: Grouped by `FORMAT(sales_date, 'yyyy-MM')`
- 📆 **Top Weekday by Sales**: `FORMAT(sales_date, 'dddd')` with highest `SUM(total_sale)`
- ⏰ **Busiest Sales Hours**: `DATEPART(hour, sales_time)` with most sales
- 💸 **Most Profitable Hour**: Hour with highest `SUM(total_sale - cogs)`
- 📈 **Top Day by Profit Margin**: Day with max `(total_sale - cogs)/total_sale`

---

### 📈 Strategic Business Insights

- 🧑‍🤝‍🧑 **Most Profitable Segments (Age + Gender)**: Segment with max `profit margin`
- 🛍️ **Profitable Category + Segment Combos**: High combined `total_profit`
- 🎯 **Customer Segments to Prioritize**: Above-average `total_profit` segments
- 📉 **Low-Margin, High-Revenue Segments**: Identified via category + segment filtering



## 📌 Sample Queries (Highlights)
```sql

-- 🗓️ Which day of the week has the highest profit margin?
SELECT TOP 1 
    DATENAME(weekday, sales_date) AS sales_day,
    (SUM(total_sale - cogs) * 100.0) / NULLIF(SUM(total_sale), 0) AS total_profit_margin
FROM retail_sales
GROUP BY DATENAME(weekday, sales_date)
ORDER BY total_profit_margin DESC;

-- 💰 Top 5 customers by total spending
SELECT TOP 5 
    customer_id, 
    SUM(total_sale) AS total_spending
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spending DESC;

-- ⚠️ Customers with high revenue but low profit margins
WITH customerwise_margin AS (
    SELECT 
        customer_id,
        SUM(total_sale) AS customer_total_sale,
        SUM(total_sale - cogs) AS customer_total_profit,
        (SUM(total_sale - cogs) * 100.0) / NULLIF(SUM(total_sale), 0) AS customer_profit_margin
    FROM retail_sales
    GROUP BY customer_id
),
average_profit_margin AS (
    SELECT AVG(customer_profit_margin) AS customer_avg_profit_margin 
    FROM customerwise_margin
),
average_sales AS (
    SELECT AVG(customer_total_sale) AS customer_avg_sale 
    FROM customerwise_margin
)
SELECT 
    cm.customer_id,
    cm.customer_total_sale,
    cm.customer_profit_margin
FROM customerwise_margin cm
CROSS JOIN average_profit_margin apm
CROSS JOIN average_sales asm
WHERE cm.customer_total_sale > asm.customer_avg_sale
AND cm.customer_profit_margin < apm.customer_avg_profit_margin
ORDER BY cm.customer_total_sale DESC;

```

## 🛠️ How to Use This Project

Clone or download the repo

Import the dataset from data/retail_sales.csv into your SQL Server

Run the SQL files in the following order:

01_create_tables.sql

02_data_import.sql

03_indexing.sql

04_data_exploration.sql

05_insights_summary.sql


> ## 📈 Business Takeaways
> 
> ✅ Focus marketing on 30–40 age group (especially females)  
> ✅ Invest in top-performing categories with high margin  
> ✅ Optimize pricing or cost for categories with high sales but low profits  
> ✅ Re-engage high-spending customers with low margins  
> ✅ Use time-based promotions to leverage busiest hours

---

> ## 👩‍💻 Author
> 
> **Nisha2611**  
> Aspiring Data Analyst | Passionate about SQL & Data Cleaning  
> 
> 🔗 [LinkedIn](https://www.linkedin.com/in/nisha-khatoon-a866b633b)  
> 🔗 [GitHub](https://github.com/Nisha2611)

**💬 Feedback**

Have suggestions? Open an issue or drop a ⭐ if you found it helpful!
