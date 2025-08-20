-- 01_create_tables.sql
-- Create Database and Tables for Retail Sales Project

CREATE DATABASE SQL_Projects_1;
GO
USE SQL_Projects_1;
GO

-- Drop final table if exists
IF OBJECT_ID('dbo.Retail_sales', 'U') IS NOT NULL
    DROP TABLE dbo.Retail_sales;

-- Final Table for Cleaned Data
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

-- Drop staging table if exists
IF OBJECT_ID('dbo.Retail_sales_staging', 'U') IS NOT NULL
    DROP TABLE dbo.Retail_sales_staging;

-- Staging Table for Raw Import
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
