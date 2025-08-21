# 🛒 Retail Sales Analysis – SQL Project

This project demonstrates a complete end-to-end data analysis workflow using **SQL** on a retail sales dataset. From **data import and cleaning**, to **index optimization**, and finally to **generating valuable business insights**, this project shows how raw transactional data can be transformed into actionable intelligence.

> 👨‍💼 Ideal for stakeholders, data analysts, and business users looking to understand customer behavior, product performance, and profitability trends.

---

## 📁 Project Structure

```
Retail-Sales-Analysis/
├── data/
│   └── retail_sales.csv              # Raw dataset (2,000 rows of retail transactions)
├── scripts/
│   ├── 01_create_tables.sql          # Table creation & staging setup
│   ├── 02_data_import.sql            # Data insert with transformation
│   ├── 03_indexing.sql               # Indexes for performance tuning
│   ├── 04_data_exploration.sql       # Exploratory & business queries
│   ├── 05_insights_summary.sql       # Strategic business insights
│   └── 06_full_analysis.sql          # Complete analysis (exploration + insights)
└── README.md                         # Project overview and instructions
```

## 🧾 Dataset Overview

- **Size**: 2,000 retail transactions  
- **Source**: CSV file imported into SQL Server  
- **Fields include**: transaction ID, customer ID, gender, age, category, quantity, unit price, COGS (cost), sale value, timestamp

---

## 🧰 Tech Stack

| Tool             | Purpose                         |
|------------------|----------------------------------|
| **SQL Server**   | Data transformation and querying |
| **T-SQL (SSMS)** | Writing complex SQL logic        |
| **Power BI**     | *(Coming soon)* Data visualization |
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

- ✅ **Total Transactions**: `COUNT(total_sale)` confirms 2,000 sales
- 💵 **Total Revenue**: `SUM(total_sale)`
- 💰 **Total Profit**: `SUM(total_sale - cogs)`
- 📊 **Average Sales/Transaction**: `AVG(total_sale)`
- 📦 **Average Quantity/Transaction**: `AVG(quantity)`

---

### 👤 Customer Analysis

- 👥 **Unique Customers**: `COUNT(DISTINCT customer_id)`
- 🚻 **Gender Distribution**: Breakdown by `gender`
- 💳 **Avg. Spend by Gender**: `AVG(total_sale)` grouped by `gender`
- 🎂 **Age Distribution**: Count by `age`
- 💸 **Top Age Groups by Sales**: `SUM(total_sale)` grouped by `age`
- 🏅 **Top 5 Customers by Revenue**: `SUM(total_sale)` by `customer_id`
- ⚠️ **High-Spending, Low-Margin Customers**: High `total_sale` with below-average `profit margin`

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
-- Which day of the week has the highest sales?
SELECT TOP 1 FORMAT(sales_date, 'dddd') AS Day, SUM(total_sale) AS Sales
FROM Retail_sales
GROUP BY FORMAT(sales_date, 'dddd')
ORDER BY Sales DESC;
```

```sql
-- Top 5 customers by spending
SELECT TOP 5 customer_id, SUM(total_sale) AS total_spending
FROM retail_sales
GROUP BY customer_id
ORDER BY total_spending DESC;
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
