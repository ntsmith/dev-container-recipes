-- MariaDB Demo
-- Run with: mysql -h mariadb -u user -ppassword demo_db < demo.sql
-- Or interactively: mysql -h mariadb -u user -ppassword demo_db

-- Create a table
CREATE TABLE IF NOT EXISTS people (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    age INT
);

-- Insert data
INSERT INTO people (name, age) VALUES ('Alice', 30);
INSERT INTO people (name, age) VALUES ('Bob', 25);
INSERT INTO people (name, age) VALUES ('Charlie', 35);

-- Query the table
SELECT * FROM people;

-- Query with filter
SELECT * FROM people WHERE age > 25;

-- Aggregations
SELECT AVG(age) as avg_age, MAX(age) as max_age FROM people;
