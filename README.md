# 🛒 Retail Sales Analysis – SQL Project

This project demonstrates a complete end-to-end data analysis workflow using **SQL** on a retail sales dataset. From **data import and cleaning**, to **index optimization**, and finally to **generating valuable business insights**, this project shows how raw transactional data can be transformed into actionable intelligence.

> 👨‍💼 Ideal for stakeholders, data analysts, and business users looking to understand customer behavior, product performance, and profitability trends.

---

## 📁 Project Structure

Retail-Sales-Analysis/
├── data/
│ └── retail_sales.csv # Raw dataset (2,000 rows of retail transactions)
│
├── scripts/
│ ├── 01_create_tables.sql # Table creation & staging setup
│ ├── 02_data_import.sql # Data insert with transformation
│ ├── 03_indexing.sql # Indexes for performance tuning
│ ├── 04_data_exploration.sql # Exploratory & business queries
│ └── 05_insights_summary.sql # Strategic business insights
|
├── README.md # Project overview and instructions

---

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
- ✅ **Total Transactions**: 2,000  
- ✅ **Total Revenue**: Aggregated from `total_sale`  
- ✅ **Total Profit**: `total_sale - cogs`  
- ✅ **Average Sales/Transaction** and **Quantity/Transaction**

---

### 👤 Customer Analysis

- 👥 **Unique Customers**: Count of distinct `customer_id`
- 🧑‍🤝‍🧑 **Gender Breakdown**: Male vs. Female
- 📊 **Spending Trends by Gender**
- 🎂 **Age Distribution** and **Top Age Groups by Spending**
- 💰 **Top 5 Customers by Revenue**
- ⚠️ **High-spending but low-margin customers**

---

### 📦 Product & Category Analysis

- 🔢 Unique product categories
- 🏆 Best-selling category by **quantity**
- 💸 Highest **revenue-generating** category
- 📈 **Average price per unit** by category
- 💹 **Profit margins** across categories
- 🚨 Categories with **high sales but low profit margin**

---

### 🕒 Time-Based Trends

- 📅 Monthly sales & profitability trends
- 📈 Busiest **days of the week** and **hours of the day**
- 🕐 Most profitable hour of the day
- 🗓️ Days with highest profit margin

---

### 📈 Strategic Business Insights

- 👥 Most profitable **age + gender** segments
- 🛍️ Category + segment combinations that drive highest profit
- 🎯 Customer groups to **prioritize** for future marketing
- 📉 Segments with **below-average margins** despite high revenue

---

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
