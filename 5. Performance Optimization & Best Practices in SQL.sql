-- Project: Customer Churn Analysis
-- Focus: Performance Optimization & Best Practices in SQL

-- Task 1: Indexing for Faster Queries
-- Goal: Optimize query performance by creating indexes on frequently filtered columns.

-- Create an index on CustomerID and Churn column
CREATE INDEX idx_customer_churn ON customer_churn (CustomerID, Churn);

-- Use Case: Queries filtering by CustomerID or Churn will run faster.
-- Example Optimized Query:

SELECT CustomerID, Churn, MonthlyCharges
FROM customer_churn
WHERE Churn = 'Yes';

-- Task 2: Avoid SELECT 
-- Goal: Select only required columns to reduce I/O and improve performance.
-- Inefficient Query:

SELECT * FROM customer_churn WHERE Churn = 'Yes';

--  Optimized Query:
SELECT CustomerID, MonthlyCharges, Contract
FROM customer_churn
WHERE Churn = 'Yes';

--  Use WHERE Instead of Filtering in Application
--  Goal: Reduce data transfer by filtering in SQL rather than in Python/Excel after fetching all rows.
--  Optimized Query:

SELECT CustomerID, Tenure, MonthlyCharges
FROM customer_churn
WHERE MonthlyCharges > 70 AND Churn = 'Yes';

-- Use LIMIT to Reduce Result Set
-- Goal: For testing queries or dashboards, fetch only required rows.

SELECT CustomerID, MonthlyCharges
FROM customer_churn
WHERE Churn = 'No'
LIMIT 100;

-- Use Aggregation Efficiently
-- Goal: Use GROUP BY and indexed columns to reduce processing time.
-- Best Practice: Make sure Contract is indexed if dataset is large.
-- Optimized Query:

SELECT Contract, COUNT(*) AS TotalCustomers, AVG(MonthlyCharges) AS AvgCharges
FROM customer_churn
GROUP BY Contract;

-- Avoid Repeated Calculations
-- Goal: Use calculated columns or subqueries wisely.
-- Inefficient Query:

SELECT CustomerID, MonthlyCharges*12 AS AnnualCharges, MonthlyCharges*12 AS YearlyCharges
FROM customer_churn;

-- Optimized Query:

SELECT CustomerID, MonthlyCharges*12 AS AnnualCharges
FROM customer_churn;

-- Use COALESCE for Null Handling
-- Goal: Avoid unnecessary NULL handling in application code.

SELECT CustomerID, COALESCE(TotalCharges, 0) AS TotalCharges
FROM customer_churn;

-- Use EXISTS Instead of IN for Subqueries
-- Goal: Improve performance in large datasets.
-- Optimized Query:

SELECT CustomerID
FROM customer_churn c
WHERE EXISTS (
    SELECT 1
    FROM customer_churn
    WHERE Churn = 'Yes' AND MonthlyCharges > 80 AND CustomerID = c.CustomerID
);

/*
Summary of SQL Performance Best Practices:

Index frequently filtered columns.
Avoid SELECT *.
Filter rows in SQL, not in the application.
Use LIMIT when fetching sample or dashboard data.
Aggregate efficiently with GROUP BY and indexes.
Avoid repeated calculations in queries.
Handle NULLs using COALESCE.
Prefer EXISTS over IN for large datasets.
*/





