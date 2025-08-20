-- 03_indexing.sql
-- Indexing for Performance Optimization

-- Index for customer analysis
CREATE NONCLUSTERED INDEX IX_RetailSales_CustomerID
ON dbo.Retail_sales (customer_id);

-- Index for date-based queries
CREATE NONCLUSTERED INDEX IX_RetailSales_SalesDate
ON dbo.Retail_sales (sales_date);

-- Index for category-based queries
CREATE NONCLUSTERED INDEX IX_RetailSales_Category
ON dbo.Retail_sales (category);

-- Composite index for gender & age
CREATE NONCLUSTERED INDEX IX_RetailSales_Gender_Age
ON dbo.Retail_sales (gender, age);
