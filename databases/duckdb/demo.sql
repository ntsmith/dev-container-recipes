-- DuckDB Demo
-- Run with: duckdb < demo.sql
-- Or interactively: duckdb

-- Load and query CSV data directly
SELECT * FROM 'sample_data.csv';

-- Query with a filter
SELECT * FROM 'sample_data.csv' WHERE age > 25;

-- Aggregations
SELECT AVG(age) as avg_age, MAX(age) as max_age FROM 'sample_data.csv';
