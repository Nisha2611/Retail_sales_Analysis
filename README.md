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
  
- 💸 **Top 10 Age Groups by Sales**: `SUM(total_sale)` grouped by `age`
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

  
- 🏅 **Top 5 Customers by Revenue**: `SUM(total_sale)` by `customer_id`
  | customer_id | total_spending |
  |-------------|----------------|
  | 91          | ₹ 9,965.00     |
  | 61          | ₹ 9,860.00     |
  | 111         | ₹ 9,845.00     |
  | 82          | ₹ 9,360.00     |
  | 65          | ₹ 9,320.00     |


- **⚠️ ** Top 10High-Spending, Low-Margin Customers**: High `total_sale` with below-average `profit margin`**
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


  
---

### 📦 Product & Category Analysis

- 🔢 **Unique Categories**: `COUNT(DISTINCT category)` - 3
- 🏆 **Best-Selling Category (Quantity)**: `SUM(quantity)` grouped by `category`
  | category | total_quantity_sold |
  |----------|--------------------|
  | Clothing | 1785               |

- 💸 **Top Revenue-Generating Category**: Ranked `SUM(total_sale)` by category
  | category    | highest_revenue    |
  |-------------|--------------------|
  | Electronics | ₹ 3,13,810.00      |

- 📈 **Avg. Price per Unit by Category**: `AVG(price_per_unit)`
  | category    | average_price_per_unit |
  |-------------|-----------------------|
  | Beauty      | ₹ 184.57              |
  | Electronics | ₹ 181.90              |
  | Clothing    | ₹ 174.49              |

- 💹 **Highest Profit Margin by Category**: Category with max `profit margin`
  | category | total_profit_margin |
  |----------|--------------------|
  | Beauty   | 79.71%             |

- 🚨 **High Sales, Low Margin Categories**: Above-average sales but below-average profit margins
  | category    | Total_sale       | total_profit_margin |
  |-------------|------------------|---------------------|
  | Electronics | ₹ 3,13,810.00    | 78.60%              |

---

### 🕒 Time-Based Trends

- 🗓️ **Monthly Sales & Profit Trends**: Grouped by `FORMAT(sales_date, 'yyyy-MM')`
  | Month | Total Sale (2022) | Total COGS (2022) | Total Profit (2022) | Total Sale (2023) | Total COGS (2023) | Total Profit (2023) |
  |-------|--------------------|--------------------|----------------------|--------------------|--------------------|----------------------|
  | 01    | ₹ 22,635.00        | ₹ 3,206.70         | ₹ 19,428.30          | ₹ 23,790.00        | ₹ 3,773.75         | ₹ 20,016.25          |
  | 02    | ₹ 16,110.00        | ₹ 2,998.20         | ₹ 13,111.80          | ₹ 25,170.00        | ₹ 3,745.55         | ₹ 21,424.45          |
  | 03    | ₹ 24,505.00        | ₹ 3,575.25         | ₹ 20,929.75          | ₹ 20,530.00        | ₹ 3,720.65         | ₹ 16,809.35          |
  | 04    | ₹ 28,705.00        | ₹ 5,033.90         | ₹ 23,671.10          | ₹ 21,925.00        | ₹ 3,361.45         | ₹ 18,563.55          |
  | 05    | ₹ 24,980.00        | ₹ 3,951.80         | ₹ 21,028.20          | ₹ 27,010.00        | ₹ 4,484.75         | ₹ 22,525.25          |
  | 06    | ₹ 20,700.00        | ₹ 3,561.05         | ₹ 17,138.95          | ₹ 24,555.00        | ₹ 4,237.60         | ₹ 20,317.40          |
  | 07    | ₹ 22,195.00        | ₹ 3,791.70         | ₹ 18,403.30          | ₹ 35,925.00        | ₹ 5,763.30         | ₹ 30,161.70          |
  | 08    | ₹ 21,195.00        | ₹ 3,136.70         | ₹ 18,058.30          | ₹ 28,270.00        | ₹ 5,247.40         | ₹ 23,022.60          |
  | 09    | ₹ 61,770.00        | ₹ 14,479.60        | ₹ 47,290.40          | ₹ 67,560.00        | ₹ 15,804.20        | ₹ 51,755.80          |
  | 10    | ₹ 68,235.00        | ₹ 18,525.65        | ₹ 49,709.35          | ₹ 57,880.00        | ₹ 15,839.45        | ₹ 42,040.55          |
  | 11    | ₹ 68,915.00        | ₹ 15,795.75        | ₹ 53,119.25          | ₹ 57,135.00        | ₹ 12,738.80        | ₹ 44,396.20          |
  | 12    | ₹ 72,880.00        | ₹ 17,953.10        | ₹ 54,926.90          | ₹ 69,145.00        | ₹ 15,036.40        | ₹ 54,108.60          |

- 📆 **Top Weekday by Sales**: `FORMAT(sales_date, 'dddd')` with highest `SUM(total_sale)`
  | Day of Week | Highest Sales Volume |
  |-------------|----------------------|
  | Sunday      | 153,800              |

- ⏰ **Busiest Sales Hours**: `DATEPART(hour, sales_time)` with most sales
  | Busiest Hour | Total Sale    |
  |--------------|---------------|
  | 21           | ₹ 97,650.00   |

- 💸 **Most Profitable Hour**: Hour with highest `SUM(total_sale - cogs)`
  | Sale Hour | Total Profit    |
  |-----------|-----------------|
  | 19        | ₹ 83,498.95     |


- 📈 **Top Day by Profit Margin**: Day with max `(total_sale - cogs)/total_sale`
  | Sales Day | Total Profit Margin |
  |-----------|----------------------|
  | Tuesday   | 80.41%               |


---

### 📈 Strategic Business Insights

- 🧑‍🤝‍🧑 **Most Profitable Segments (Age + Gender)**: Segment with max `profit margin`
  | Age | Gender | Total Sales | Total COGS | Total Profit | Total Profit Margin |
  |-----|--------|-------------|------------|--------------|---------------------|
  | 24  | Female | ₹ 3,500.00  | ₹ 367.25   | ₹ 3,132.75   | 89.51%              |

- 🛍️ **Top 5 Profitable Category + Segment Combos**: High combined `total_profit`
  | Category    | Customer ID | Total Profit |
  |-------------|-------------|--------------|
  | Beauty      | 58          | ₹ 989.05     |
  | Clothing    | 117         | ₹ 971.00     |
  | Clothing    | 70          | ₹ 965.40     |
  | Clothing    | 9           | ₹ 96.00      |
  | Electronics | 136         | ₹ 955.80     |

- 🎯 **Customer Segments and product category to Prioritize**: Above-average `total_profit` segments  


  | Gender | Age | Total Sale   | Total Profit | Total Profit Margin | Category    | Category Total Sale | Category Total Profit | Category Profit Margin |
  |--------|-----|--------------|--------------|---------------------|-------------|--------------------|----------------------|-----------------------|
  | Female | 34  | ₹ 24,100.00  | ₹ 18,870.50  | 78.30%              | Clothing    | ₹ 3,11,070.00      | ₹ 2,46,679.50        | 79.30%                |
  | Female | 34  | ₹ 24,100.00  | ₹ 18,870.50  | 78.30%              | Electronics | ₹ 3,13,810.00      | ₹ 2,46,647.65        | 78.60%                |
  | Female | 43  | ₹ 20,520.00  | ₹ 16,369.25  | 79.77%              | Clothing    | ₹ 3,11,070.00      | ₹ 2,46,679.50        | 79.30%                |
  | Female | 43  | ₹ 20,520.00  | ₹ 16,369.25  | 79.77%              | Electronics | ₹ 3,13,810.00      | ₹ 2,46,647.65        | 78.60%                |
  | Female | 26  | ₹ 20,750.00  | ₹ 15,086.65  | 72.71%              | Clothing    | ₹ 3,11,070.00      | ₹ 2,46,679.50        | 79.30%                |
  | Female | 26  | ₹ 20,750.00  | ₹ 15,086.65  | 72.71%              | Electronics | ₹ 3,13,810.00      | ₹ 2,46,647.65        | 78.60%                |
  | Male   | 51  | ₹ 17,515.00  | ₹ 14,752.15  | 84.23%              | Clothing    | ₹ 3,11,070.00      | ₹ 2,46,679.50        | 79.30%                |
  | Male   | 51  | ₹ 17,515.00  | ₹ 14,752.15  | 84.23%              | Electronics | ₹ 3,13,810.00      | ₹ 2,46,647.65        | 78.60%                |
  | Male   | 22  | ₹ 16,550.00  | ₹ 13,764.25  | 83.17%              | Clothing    | ₹ 3,11,070.00      | ₹ 2,46,679.50        | 79.30%                |
  | Male   | 22  | ₹ 16,550.00  | ₹ 13,764.25  | 83.17%              | Electronics | ₹ 3,13,810.00      | ₹ 2,46,647.65        | 78.60%                |


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


**📈 Business Takeaways**

✅ Target Marketing to the 30–40 Age Group, Especially Females:
This segment shows high spending and strong profit margins, indicating they are valuable and responsive customers.

✅ Invest More in High-Margin Categories Like Beauty and Clothing:
These categories not only generate good revenue but also maintain superior profit margins, making them ideal for promotions and inventory focus.

✅ Address Pricing and Cost Optimization for Electronics:
Electronics have high sales volume but comparatively lower profit margins. Consider negotiating better supplier costs or adjusting prices to improve profitability.

✅ Focus on High-Spending Customers with Below-Average Profit Margins:
Engage these customers through loyalty programs or targeted offers to improve their profitability, e.g., upselling higher-margin products.

✅ Leverage Time-Based Promotions During Peak Sales Hours and Days:
Sunday is the highest sales day and evening hours (around 7–9 PM) show strong sales and profits. Running time-limited offers during these windows can maximize revenue.

✅ Explore Opportunities in Underperforming Segments:
Segments with lower sales but high margins (like certain age-gender groups) could be nurtured with personalized campaigns to boost their lifetime value.

✅ Monitor Monthly and Seasonal Trends to Align Inventory and Marketing:
Adjust stock and promotions based on monthly sales and profit trends to capitalize on peak demand periods.

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
