-- 02_data_import.sql
-- Data Transformation and Import from Staging to Final Table

-- Insert with conversion and null handling
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

-- Truncate staging table after import
TRUNCATE TABLE dbo.Retail_sales_staging;

-- Add Primary Key
ALTER TABLE dbo.Retail_sales
ADD CONSTRAINT PK_Retail_sales_transactions_id PRIMARY KEY (transactions_id);

-- Check if data imported successfully (should be 2000)
SELECT COUNT(*) AS Total_Rows FROM dbo.Retail_sales;

-- Clean any NULL rows (if any)
DELETE FROM Retail_sales
WHERE transactions_id IS NULL
   OR sales_date IS NULL
   OR sales_time IS NULL
   OR customer_id IS NULL
   OR gender IS NULL
   OR age IS NULL
   OR category IS NULL
   OR quantity IS NULL
   OR price_per_unit IS NULL
   OR cogs IS NULL
   OR total_sale IS NULL;
