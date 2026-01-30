# 📚 Comprehensive Guide to SQL Functions
## From Basic to Advanced - MySQL & PostgreSQL

## 📖 Table of Contents
1. [Introduction to SQL Functions](#introduction)
2. [String Functions](#string-functions)
3. [Numeric Functions](#numeric-functions)
4. [Date and Time Functions](#date-time-functions)
5. [Conditional Functions](#conditional-functions)
6. [Aggregate Functions](#aggregate-functions)
7. [Window Functions](#window-functions)
8. [JSON Functions](#json-functions)
9. [Advanced Functions](#advanced-functions)
10. [Performance Considerations](#performance)

---

## 1. Introduction to SQL Functions {#introduction}

SQL functions are built-in routines that perform operations on data. They can be categorized into:
- **Scalar Functions**: Return a single value for each row
- **Aggregate Functions**: Return a single value for a group of rows
- **Window Functions**: Perform calculations across a set of rows while retaining individual rows

### Database Setup for Examples
Let's create a sample database with multiple tables for our examples:

```sql
-- Create sample database (MySQL)
CREATE DATABASE IF NOT EXISTS employee_db;
USE employee_db;

-- Create sample database (PostgreSQL)
CREATE DATABASE employee_db;
\c employee_db;

-- Employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(20),
    hire_date DATE,
    salary DECIMAL(10,2),
    department VARCHAR(50),
    manager_id INT,
    commission_pct DECIMAL(5,2)
);

-- Products table
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock_quantity INT,
    created_at TIMESTAMP
);

-- Sales table
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    emp_id INT,
    sale_date DATE,
    quantity INT,
    amount DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO employees VALUES
(1, 'John', 'Doe', 'john.doe@email.com', '123-456-7890', '2020-01-15', 75000.00, 'Sales', NULL, 0.10),
(2, 'Jane', 'Smith', 'jane.smith@email.com', '234-567-8901', '2019-03-20', 82000.00, 'Marketing', 1, 0.08),
(3, 'Bob', 'Johnson', 'bob.j@email.com', '345-678-9012', '2021-06-10', 65000.00, 'Sales', 1, 0.12),
(4, 'Alice', 'Williams', 'alice.w@email.com', '456-789-0123', '2018-11-05', 90000.00, 'IT', NULL, NULL),
(5, 'Charlie', 'Brown', 'charlie.b@email.com', NULL, '2022-02-28', 55000.00, 'Sales', 1, 0.15);

INSERT INTO products VALUES
(1, 'Laptop Pro', 'Electronics', 1200.00, 50, '2023-01-15 10:30:00'),
(2, 'Wireless Mouse', 'Electronics', 25.99, 200, '2023-02-20 14:15:00'),
(3, 'Office Chair', 'Furniture', 299.99, 75, '2023-03-10 09:45:00'),
(4, 'Notebook', 'Stationery', 5.99, 500, '2023-01-05 08:00:00'),
(5, 'Coffee Mug', 'Kitchen', 12.50, 300, '2023-04-01 16:20:00');

INSERT INTO sales VALUES
(1, 1, 1, '2023-05-01', 2, 2400.00),
(2, 2, 1, '2023-05-02', 10, 259.90),
(3, 3, 2, '2023-05-03', 3, 899.97),
(4, 1, 3, '2023-05-04', 1, 1200.00),
(5, 4, 1, '2023-05-05', 50, 299.50),
(6, 5, 3, '2023-05-06', 20, 250.00);
```

---

## 2. String Functions {#string-functions}

String functions manipulate and analyze text data.

### 2.1 CONCAT / || (Concatenation)

**MySQL Syntax:**
```sql
CONCAT(string1, string2, ...)
```

**PostgreSQL Syntax:**
```sql
string1 || string2
-- or
CONCAT(string1, string2, ...)
```

**Example:**
```sql
-- Before running query
SELECT first_name, last_name FROM employees WHERE emp_id = 1;
-- Result: John | Doe

-- MySQL
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees WHERE emp_id = 1;
-- PostgreSQL
SELECT first_name || ' ' || last_name AS full_name FROM employees WHERE emp_id = 1;

-- After running query
-- Result: John Doe
```

### 2.2 UPPER / LOWER

**Both MySQL & PostgreSQL:**
```sql
UPPER(string)
LOWER(string)
```

**Example:**
```sql
-- Before: 'john.doe@email.com'
SELECT UPPER(email) AS email_upper,
       LOWER(first_name) AS first_lower
FROM employees WHERE emp_id = 1;
-- After: 'JOHN.DOE@EMAIL.COM' | 'john'
```

### 2.3 SUBSTRING / SUBSTR

**MySQL:**
```sql
SUBSTRING(string, start, length)
SUBSTRING(string FROM start FOR length)
```

**PostgreSQL:**
```sql
SUBSTRING(string FROM start FOR length)
-- or
SUBSTR(string, start, length)
```

**Example:**
```sql
-- Extract first 4 characters of email
SELECT email,
       -- MySQL
       SUBSTRING(email, 1, 4) AS email_part,
       -- PostgreSQL
       SUBSTRING(email FROM 1 FOR 4) AS email_part_pg
FROM employees WHERE emp_id = 1;
-- Result: 'john' (from 'john.doe@email.com')
```

### 2.4 LENGTH / CHAR_LENGTH

**MySQL:**
```sql
LENGTH(string)  -- Returns bytes
CHAR_LENGTH(string)  -- Returns characters
```

**PostgreSQL:**
```sql
LENGTH(string)  -- Returns characters
CHAR_LENGTH(string)  -- Same as LENGTH()
```

**Example:**
```sql
SELECT first_name,
       -- MySQL
       LENGTH(first_name) AS bytes_len,
       CHAR_LENGTH(first_name) AS char_len,
       -- PostgreSQL
       LENGTH(first_name) AS pg_len
FROM employees WHERE emp_id = 1;
-- Result: 'John' | 4 | 4 | 4
```

### 2.5 TRIM / LTRIM / RTRIM

**Both MySQL & PostgreSQL:**
```sql
TRIM([LEADING|TRAILING|BOTH] chars FROM string)
LTRIM(string)
RTRIM(string)
```

**Example:**
```sql
SELECT TRIM('   Hello World   ') AS trimmed,
       LTRIM('   Hello') AS left_trimmed,
       RTRIM('Hello   ') AS right_trimmed;
-- Result: 'Hello World' | 'Hello' | 'Hello'
```

### 2.6 REPLACE

**Both MySQL & PostgreSQL:**
```sql
REPLACE(string, old_substring, new_substring)
```

**Example:**
```sql
SELECT email,
       REPLACE(email, 'email.com', 'company.com') AS new_email
FROM employees WHERE emp_id = 1;
-- Before: 'john.doe@email.com'
-- After: 'john.doe@company.com'
```

### 2.7 POSITION / INSTR / LOCATE

**MySQL:**
```sql
LOCATE(substring, string)
INSTR(string, substring)
```

**PostgreSQL:**
```sql
POSITION(substring IN string)
STRPOS(string, substring)
```

**Example:**
```sql
-- Find position of '@' in email
SELECT email,
       -- MySQL
       LOCATE('@', email) AS locate_pos,
       INSTR(email, '@') AS instr_pos,
       -- PostgreSQL
       POSITION('@' IN email) AS position_pos,
       STRPOS(email, '@') AS strpos_pos
FROM employees WHERE emp_id = 1;
-- Result: 9 (position of '@' in 'john.doe@email.com')
```

### 2.8 LPAD / RPAD

**Both MySQL & PostgreSQL:**
```sql
LPAD(string, length, pad_string)
RPAD(string, length, pad_string)
```

**Example:**
```sql
SELECT first_name,
       LPAD(first_name, 10, '*') AS left_padded,
       RPAD(first_name, 10, '-') AS right_padded
FROM employees WHERE emp_id = 1;
-- Result: 'John' | '******John' | 'John------'
```

### 2.9 REVERSE

**Both MySQL & PostgreSQL:**
```sql
REVERSE(string)
```

**Example:**
```sql
SELECT first_name, REVERSE(first_name) AS reversed
FROM employees WHERE emp_id = 1;
-- Result: 'John' | 'nhoJ'
```

### 2.10 REGEXP Functions

**MySQL:**
```sql
REGEXP_LIKE(string, pattern)
REGEXP_REPLACE(string, pattern, replacement)
REGEXP_SUBSTR(string, pattern)
REGEXP_INSTR(string, pattern)
```

**PostgreSQL:**
```sql
string ~ pattern  -- Returns boolean
string ~* pattern  -- Case-insensitive
REGEXP_REPLACE(string, pattern, replacement, flags)
REGEXP_MATCHES(string, pattern)
```

**Example:**
```sql
-- Find emails ending with 'email.com'
SELECT email,
       -- MySQL
       email REGEXP 'email\.com$' AS mysql_regex,
       -- PostgreSQL
       email ~ 'email\.com$' AS pg_regex
FROM employees;

-- Replace domain
SELECT email,
       -- MySQL
       REGEXP_REPLACE(email, 'email\.com$', 'company.com') AS mysql_new_email,
       -- PostgreSQL
       REGEXP_REPLACE(email, 'email\.com$', 'company.com') AS pg_new_email
FROM employees WHERE emp_id = 1;
```

---

## 3. Numeric Functions {#numeric-functions}

### 3.1 ROUND / TRUNC / CEIL / FLOOR

**Both MySQL & PostgreSQL:**
```sql
ROUND(number, decimals)
TRUNCATE(number, decimals)  -- MySQL
TRUNC(number, decimals)  -- PostgreSQL
CEIL(number)  -- or CEILING()
FLOOR(number)
```

**Example:**
```sql
SELECT salary,
       ROUND(salary, -3) AS rounded_thousands,  -- Rounds to nearest thousand
       -- MySQL
       TRUNCATE(salary, -3) AS truncated_thousands,
       -- PostgreSQL
       TRUNC(salary, -3) AS pg_truncated,
       CEIL(salary/1000)*1000 AS ceiling_thousands,
       FLOOR(salary/1000)*1000 AS floor_thousands
FROM employees WHERE emp_id = 1;
-- Before: 75000.00
-- After: 75000 | 75000 (ROUND) | 75000 (TRUNC) | 76000 (CEIL) | 75000 (FLOOR)
```

### 3.2 ABS / SIGN

**Both MySQL & PostgreSQL:**
```sql
ABS(number)  -- Absolute value
SIGN(number)  -- Returns -1, 0, or 1
```

**Example:**
```sql
SELECT -123.45 AS original,
       ABS(-123.45) AS absolute,
       SIGN(-123.45) AS sign_value;
-- Result: -123.45 | 123.45 | -1
```

### 3.3 POWER / SQRT

**MySQL:**
```sql
POWER(base, exponent)
SQRT(number)
```

**PostgreSQL:**
```sql
POWER(base, exponent)  -- or ^ operator
SQRT(number)
```

**Example:**
```sql
SELECT 4 AS base,
       POWER(4, 2) AS squared,
       SQRT(16) AS square_root,
       -- PostgreSQL only
       4 ^ 2 AS pg_power  -- PostgreSQL operator
;
-- Result: 4 | 16 | 4
```

### 3.4 MOD / %

**MySQL:**
```sql
MOD(dividend, divisor)
dividend % divisor
```

**PostgreSQL:**
```sql
MOD(dividend, divisor)
dividend % divisor
```

**Example:**
```sql
SELECT 10 AS dividend,
       3 AS divisor,
       MOD(10, 3) AS remainder,
       10 % 3 AS remainder_operator;
-- Result: 10 | 3 | 1 | 1
```

### 3.5 LOG / EXP

**Both MySQL & PostgreSQL:**
```sql
LOG(number)  -- Natural logarithm (PostgreSQL: LN())
LOG10(number)  -- Base-10 logarithm
EXP(number)  -- Exponential
```

**Example:**
```sql
SELECT 10 AS value,
       LOG(10) AS natural_log,
       LOG10(10) AS base10_log,
       EXP(1) AS exponential;
-- Result: 10 | ~2.302585 | 1 | ~2.718281
```

### 3.6 RANDOM / RAND

**MySQL:**
```sql
RAND([seed])  -- Returns random float 0-1
```

**PostgreSQL:**
```sql
RANDOM()  -- Returns random float 0-1
```

**Example:**
```sql
-- MySQL
SELECT RAND() AS random_mysql,
       RAND(123) AS seeded_random;
       
-- PostgreSQL
SELECT RANDOM() AS random_pg;
```

---

## 4. Date and Time Functions {#date-time-functions}

### 4.1 CURRENT_DATE / CURRENT_TIME / NOW

**MySQL:**
```sql
CURDATE()  -- Current date
CURTIME()  -- Current time
NOW()  -- Current datetime
```

**PostgreSQL:**
```sql
CURRENT_DATE
CURRENT_TIME
CURRENT_TIMESTAMP  -- or NOW()
```

**Example:**
```sql
-- MySQL
SELECT CURDATE() AS today_mysql,
       CURTIME() AS time_now_mysql,
       NOW() AS datetime_mysql;

-- PostgreSQL
SELECT CURRENT_DATE AS today_pg,
       CURRENT_TIME AS time_now_pg,
       CURRENT_TIMESTAMP AS datetime_pg;
```

### 4.2 DATE_ADD / DATE_SUB / INTERVAL

**MySQL:**
```sql
DATE_ADD(date, INTERVAL value unit)
DATE_SUB(date, INTERVAL value unit)
```

**PostgreSQL:**
```sql
date + INTERVAL 'value unit'
date - INTERVAL 'value unit'
```

**Example:**
```sql
-- Add 30 days to hire_date
SELECT hire_date,
       -- MySQL
       DATE_ADD(hire_date, INTERVAL 30 DAY) AS after_30_days_mysql,
       DATE_SUB(hire_date, INTERVAL 1 MONTH) AS before_1_month_mysql,
       -- PostgreSQL
       hire_date + INTERVAL '30 days' AS after_30_days_pg,
       hire_date - INTERVAL '1 month' AS before_1_month_pg
FROM employees WHERE emp_id = 1;
```

### 4.3 DATEDIFF / DATE_PART / EXTRACT

**MySQL:**
```sql
DATEDIFF(date1, date2)  -- Difference in days
TIMESTAMPDIFF(unit, date1, date2)
EXTRACT(unit FROM date)
```

**PostgreSQL:**
```sql
date1 - date2  -- Difference in days
EXTRACT(unit FROM date)
DATE_PART('unit', date)
```

**Example:**
```sql
-- Calculate tenure in days
SELECT hire_date,
       -- MySQL
       DATEDIFF(CURDATE(), hire_date) AS tenure_days_mysql,
       TIMESTAMPDIFF(MONTH, hire_date, CURDATE()) AS tenure_months_mysql,
       EXTRACT(YEAR FROM hire_date) AS hire_year_mysql,
       -- PostgreSQL
       CURRENT_DATE - hire_date AS tenure_days_pg,
       EXTRACT(YEAR FROM hire_date) AS hire_year_pg,
       DATE_PART('month', hire_date) AS hire_month_pg
FROM employees WHERE emp_id = 1;
```

### 4.4 DATE_FORMAT / TO_CHAR

**MySQL:**
```sql
DATE_FORMAT(date, format_string)
```

**PostgreSQL:**
```sql
TO_CHAR(date, format_string)
```

**Example:**
```sql
SELECT hire_date,
       -- MySQL
       DATE_FORMAT(hire_date, '%W, %M %d, %Y') AS formatted_mysql,
       DATE_FORMAT(hire_date, '%Y-%m') AS year_month_mysql,
       -- PostgreSQL
       TO_CHAR(hire_date, 'Day, Month DD, YYYY') AS formatted_pg,
       TO_CHAR(hire_date, 'YYYY-MM') AS year_month_pg
FROM employees WHERE emp_id = 1;
-- Result: 'Monday, January 15, 2020' (or similar)
```

### 4.5 STR_TO_DATE / TO_DATE

**MySQL:**
```sql
STR_TO_DATE(string, format)
```

**PostgreSQL:**
```sql
TO_DATE(string, format)
```

**Example:**
```sql
-- Convert string to date
-- MySQL
SELECT STR_TO_DATE('15-01-2020', '%d-%m-%Y') AS date_mysql;

-- PostgreSQL
SELECT TO_DATE('15-01-2020', 'DD-MM-YYYY') AS date_pg;
```

### 4.6 LAST_DAY / DATE_TRUNC

**MySQL:**
```sql
LAST_DAY(date)  -- Last day of month
```

**PostgreSQL:**
```sql
DATE_TRUNC('unit', date)  -- Truncate to unit
LAST_DAY(date)  -- Available in some versions
```

**Example:**
```sql
SELECT hire_date,
       -- MySQL
       LAST_DAY(hire_date) AS month_end_mysql,
       -- PostgreSQL
       DATE_TRUNC('month', hire_date) AS month_start_pg,
       DATE_TRUNC('year', hire_date) AS year_start_pg
FROM employees WHERE emp_id = 1;
```

### 4.7 TIME Functions

**Both MySQL & PostgreSQL:**
```sql
HOUR(time)
MINUTE(time)
SECOND(time)
TIME_TO_SEC(time)  -- MySQL
EXTRACT(HOUR FROM time)  -- PostgreSQL
```

**Example:**
```sql
-- MySQL
SELECT NOW() AS current_time,
       HOUR(NOW()) AS current_hour,
       MINUTE(NOW()) AS current_minute,
       TIME_TO_SEC(CURTIME()) AS seconds_since_midnight;

-- PostgreSQL
SELECT CURRENT_TIMESTAMP AS current_time,
       EXTRACT(HOUR FROM CURRENT_TIMESTAMP) AS current_hour,
       EXTRACT(MINUTE FROM CURRENT_TIMESTAMP) AS current_minute;
```

---

## 5. Conditional Functions {#conditional-functions}

### 5.1 IF / CASE

**MySQL IF:**
```sql
IF(condition, value_if_true, value_if_false)
```

**Both MySQL & PostgreSQL CASE:**
```sql
CASE 
    WHEN condition1 THEN result1
    WHEN condition2 THEN result2
    ...
    ELSE default_result
END
```

**Example:**
```sql
-- Simple IF in MySQL
SELECT first_name, salary,
       IF(salary > 70000, 'High', 'Low') AS salary_category_mysql
FROM employees;

-- CASE in both (preferred for portability)
SELECT first_name, salary,
       CASE 
           WHEN salary >= 80000 THEN 'High'
           WHEN salary >= 60000 THEN 'Medium'
           ELSE 'Low'
       END AS salary_category
FROM employees;

-- Searched CASE
SELECT product_name, price,
       CASE
           WHEN price > 1000 THEN 'Premium'
           WHEN price > 100 THEN 'Standard'
           ELSE 'Budget'
       END AS price_category
FROM products;
```

### 5.2 COALESCE / NULLIF / IFNULL

**MySQL:**
```sql
COALESCE(value1, value2, ...)  -- Returns first non-null
IFNULL(expression, replacement)  -- Two-parameter version
NULLIF(expr1, expr2)  -- Returns NULL if equal
```

**PostgreSQL:**
```sql
COALESCE(value1, value2, ...)
NULLIF(expr1, expr2)
```

**Example:**
```sql
-- Handle NULL commission
SELECT first_name, commission_pct,
       COALESCE(commission_pct, 0) AS commission_with_default,
       -- MySQL only
       IFNULL(commission_pct, 0) AS commission_ifnull,
       -- NULLIF example
       NULLIF(commission_pct, 0.10) AS null_if_10_percent
FROM employees;

-- Practical COALESCE with multiple fallbacks
SELECT first_name, phone,
       COALESCE(phone, email, 'No contact info') AS contact_info
FROM employees;
```

### 5.3 GREATEST / LEAST

**Both MySQL & PostgreSQL:**
```sql
GREATEST(value1, value2, ...)
LEAST(value1, value2, ...)
```

**Example:**
```sql
-- Find highest and lowest among values
SELECT 10 AS a, 20 AS b, 15 AS c,
       GREATEST(10, 20, 15) AS highest,
       LEAST(10, 20, 15) AS lowest;

-- With column data
SELECT product_name, price, stock_quantity,
       GREATEST(price, stock_quantity) AS larger_value
FROM products;
```

### 5.4 NVL / ISNULL (Vendor Specific)

**MySQL:**
```sql
ISNULL(expression)  -- Returns 1 if NULL, 0 otherwise
```

**Oracle (for comparison):**
```sql
NVL(expression, replacement)
```

**Example:**
```sql
-- MySQL ISNULL (different from IFNULL!)
SELECT first_name, commission_pct,
       ISNULL(commission_pct) AS is_null_check
FROM employees;
-- Returns 1 if NULL, 0 if not NULL
```

---

## 6. Aggregate Functions {#aggregate-functions}

### 6.1 Basic Aggregate Functions

**Both MySQL & PostgreSQL:**
```sql
COUNT(expression)  -- Count non-null values
SUM(expression)    -- Sum of values
AVG(expression)    -- Average of values
MIN(expression)    -- Minimum value
MAX(expression)    -- Maximum value
```

**Example:**
```sql
-- Before: Individual salary values
SELECT salary FROM employees;
-- 75000, 82000, 65000, 90000, 55000

SELECT 
    COUNT(*) AS total_employees,
    COUNT(commission_pct) AS employees_with_commission,
    SUM(salary) AS total_salary,
    AVG(salary) AS average_salary,
    MIN(salary) AS minimum_salary,
    MAX(salary) AS maximum_salary
FROM employees;

-- After:
-- total_employees: 5
-- employees_with_commission: 4 (one NULL)
-- total_salary: 367000
-- average_salary: 73400
-- minimum_salary: 55000
-- maximum_salary: 90000
```

### 6.2 GROUP BY with Aggregate Functions

```sql
-- Group by department
SELECT 
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary,
    SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING COUNT(*) > 1  -- Filter groups
ORDER BY avg_salary DESC;

-- Multiple grouping levels
SELECT 
    department,
    CASE 
        WHEN salary >= 70000 THEN 'High'
        ELSE 'Low'
    END AS salary_category,
    COUNT(*) AS count,
    AVG(salary) AS avg_salary
FROM employees
GROUP BY department, 
    CASE 
        WHEN salary >= 70000 THEN 'High'
        ELSE 'Low'
    END;
```

### 6.3 Statistical Aggregate Functions

**PostgreSQL (more extensive):**
```sql
STDDEV(expression)    -- Standard deviation
VARIANCE(expression)  -- Variance
CORR(x, y)           -- Correlation coefficient
REGR_SLOPE(y, x)     -- Regression slope
```

**MySQL:**
```sql
STDDEV_POP(expression)  -- Population standard deviation
STDDEV_SAMP(expression) -- Sample standard deviation
VAR_POP(expression)     -- Population variance
VAR_SAMP(expression)    -- Sample variance
```

**Example:**
```sql
-- Salary statistics
SELECT 
    AVG(salary) AS mean,
    STDDEV(salary) AS std_deviation,  -- PostgreSQL
    STDDEV_POP(salary) AS std_pop_mysql,  -- MySQL
    VARIANCE(salary) AS variance_pg,  -- PostgreSQL
    VAR_POP(salary) AS var_pop_mysql  -- MySQL
FROM employees;
```

### 6.4 GROUP_CONCAT / STRING_AGG

**MySQL:**
```sql
GROUP_CONCAT(expression SEPARATOR ',')
```

**PostgreSQL:**
```sql
STRING_AGG(expression, delimiter)
```

**Example:**
```sql
-- Concatenate employee names by department
SELECT 
    department,
    -- MySQL
    GROUP_CONCAT(first_name ORDER BY salary DESC SEPARATOR ', ') AS employees_mysql,
    -- PostgreSQL
    STRING_AGG(first_name, ', ' ORDER BY salary DESC) AS employees_pg
FROM employees
GROUP BY department;

-- Result for Sales department: 'John, Bob, Charlie'
```

### 6.5 Aggregate with FILTER (PostgreSQL)

**PostgreSQL only:**
```sql
AGGREGATE(expression) FILTER (WHERE condition)
```

**Example:**
```sql
-- PostgreSQL: Conditional aggregates without CASE
SELECT 
    department,
    COUNT(*) AS total,
    COUNT(*) FILTER (WHERE salary > 70000) AS high_earners,
    AVG(salary) FILTER (WHERE commission_pct IS NOT NULL) AS avg_with_commission,
    SUM(salary) FILTER (WHERE hire_date >= '2020-01-01') AS total_new_hires
FROM employees
GROUP BY department;
```

---

## 7. Window Functions {#window-functions}

Window functions perform calculations across a set of table rows related to the current row.

### 7.1 Ranking Functions

**Both MySQL (8.0+) & PostgreSQL:**
```sql
ROW_NUMBER() OVER (ORDER BY column)
RANK() OVER (ORDER BY column)
DENSE_RANK() OVER (ORDER BY column)
NTILE(n) OVER (ORDER BY column)
```

**Example:**
```sql
SELECT 
    first_name,
    salary,
    department,
    ROW_NUMBER() OVER (ORDER BY salary DESC) AS row_num,
    RANK() OVER (ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank_num,
    NTILE(4) OVER (ORDER BY salary DESC) AS quartile
FROM employees;

-- Results:
-- Alice, 90000, IT, 1, 1, 1, 1
-- Jane, 82000, Marketing, 2, 2, 2, 1
-- John, 75000, Sales, 3, 3, 3, 2
-- Bob, 65000, Sales, 4, 4, 4, 3
-- Charlie, 55000, Sales, 5, 5, 5, 4
```

### 7.2 Partitioned Window Functions

```sql
-- Partition by department
SELECT 
    first_name,
    salary,
    department,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_rank_with_gaps,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_dense_rank
FROM employees;

-- Sales department results:
-- John, 75000, Sales, 1, 1, 1
-- Bob, 65000, Sales, 2, 2, 2
-- Charlie, 55000, Sales, 3, 3, 3
```

### 7.3 Aggregate Window Functions

```sql
SELECT 
    first_name,
    salary,
    department,
    AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary,
    SUM(salary) OVER (PARTITION BY department) AS dept_total_salary,
    COUNT(*) OVER (PARTITION BY department) AS dept_employee_count,
    MAX(salary) OVER (PARTITION BY department) AS dept_max_salary,
    MIN(salary) OVER (PARTITION BY department) AS dept_min_salary
FROM employees;

-- Cumulative sum (running total)
SELECT 
    first_name,
    salary,
    SUM(salary) OVER (ORDER BY salary ROWS UNBOUNDED PRECEDING) AS cumulative_salary
FROM employees
ORDER BY salary;

-- Moving average (3-month window)
SELECT 
    sale_date,
    amount,
    AVG(amount) OVER (ORDER BY sale_date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg_3
FROM sales;
```

### 7.4 Value Window Functions

**Both MySQL & PostgreSQL:**
```sql
LAG(column, offset, default) OVER (ORDER BY ...)
LEAD(column, offset, default) OVER (ORDER BY ...)
FIRST_VALUE(column) OVER (ORDER BY ...)
LAST_VALUE(column) OVER (ORDER BY ...)
NTH_VALUE(column, n) OVER (ORDER BY ...)
```

**Example:**
```sql
SELECT 
    sale_date,
    amount,
    LAG(amount, 1, 0) OVER (ORDER BY sale_date) AS previous_day_sales,
    LEAD(amount, 1, 0) OVER (ORDER BY sale_date) AS next_day_sales,
    FIRST_VALUE(amount) OVER (ORDER BY sale_date) AS first_sale_amount,
    LAST_VALUE(amount) OVER (ORDER BY sale_date ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS last_sale_amount,
    NTH_VALUE(amount, 2) OVER (ORDER BY sale_date) AS second_sale_amount
FROM sales;

-- Calculate difference from previous day
SELECT 
    sale_date,
    amount,
    amount - LAG(amount, 1, amount) OVER (ORDER BY sale_date) AS daily_difference,
    (amount - LAG(amount, 1, amount) OVER (ORDER BY sale_date)) / 
        LAG(amount, 1, amount) OVER (ORDER BY sale_date) * 100 AS percent_change
FROM sales;
```

### 7.5 Window Frame Specifications

```sql
-- Different window frames
SELECT 
    first_name,
    salary,
    -- Default: RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
    SUM(salary) OVER (ORDER BY salary) AS cumulative_default,
    
    -- Explicit frame
    SUM(salary) OVER (ORDER BY salary 
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_rows,
    
    -- Moving sum of 3 rows
    SUM(salary) OVER (ORDER BY salary 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_sum_3,
    
    -- Range based on values (same salary values)
    SUM(salary) OVER (ORDER BY salary 
        RANGE BETWEEN 10000 PRECEDING AND 10000 FOLLOWING) AS range_sum
FROM employees;
```

### 7.6 Named Windows

```sql
-- Define window once, use multiple times
SELECT 
    first_name,
    salary,
    department,
    ROW_NUMBER() OVER w AS row_num,
    RANK() OVER w AS rank_num,
    DENSE_RANK() OVER w AS dense_rank_num,
    AVG(salary) OVER w AS avg_salary
FROM employees
WINDOW w AS (PARTITION BY department ORDER BY salary DESC);
```

---

## 8. JSON Functions {#json-functions}

### 8.1 Creating JSON Data

**MySQL:**
```sql
JSON_OBJECT(key1, value1, key2, value2, ...)
JSON_ARRAY(value1, value2, ...)
```

**PostgreSQL:**
```sql
json_build_object(key1, value1, key2, value2, ...)
json_build_array(value1, value2, ...)
to_json(any_value)
```

**Example:**
```sql
-- Create JSON object from row data
SELECT 
    -- MySQL
    JSON_OBJECT(
        'id', emp_id,
        'name', CONCAT(first_name, ' ', last_name),
        'salary', salary,
        'department', department
    ) AS employee_json_mysql,
    
    -- PostgreSQL
    json_build_object(
        'id', emp_id,
        'name', first_name || ' ' || last_name,
        'salary', salary,
        'department', department
    ) AS employee_json_pg
FROM employees
WHERE emp_id = 1;
```

### 8.2 Extracting JSON Data

**MySQL:**
```sql
JSON_EXTRACT(json_doc, path)
column->path  -- Shorthand
column->>path  -- Unquoted value
JSON_UNQUOTE(JSON_EXTRACT(json_doc, path))
```

**PostgreSQL:**
```sql
json_column->'key'  -- Get JSON object field as JSON
json_column->>'key' -- Get JSON object field as text
json_column#>'{path,to,element}'  -- Get JSON path as JSON
json_column#>>'{path,to,element}' -- Get JSON path as text
```

**Example:**
```sql
-- Assuming we have a JSON column
ALTER TABLE employees ADD COLUMN metadata JSON;

-- Update with sample data
UPDATE employees SET metadata = 
    -- MySQL
    '{"skills": ["SQL", "Python"], "projects": {"current": "DB Migration", "completed": 3}}'
WHERE emp_id = 1;

-- Extract values
SELECT 
    -- MySQL
    metadata->'$.skills' AS skills_mysql,
    metadata->'$.skills[0]' AS first_skill_mysql,
    metadata->>'$.projects.current' AS current_project_mysql,
    
    -- PostgreSQL
    metadata->'skills' AS skills_pg,
    metadata->'skills'->0 AS first_skill_pg,
    metadata#>>'{projects,current}' AS current_project_pg
FROM employees WHERE emp_id = 1;
```

### 8.3 Modifying JSON Data

**MySQL:**
```sql
JSON_SET(json_doc, path, value)  -- Set or update
JSON_INSERT(json_doc, path, value)  -- Insert if doesn't exist
JSON_REPLACE(json_doc, path, value)  -- Replace if exists
JSON_REMOVE(json_doc, path)  -- Remove element
```

**PostgreSQL:**
```sql
jsonb_set(target, path, new_value, create_missing)
jsonb_insert(target, path, new_value, insert_after)
```

**Example:**
```sql
-- Update JSON data
SELECT 
    -- MySQL
    JSON_SET(
        metadata,
        '$.skills[2]', 'Java',
        '$.level', 'Senior'
    ) AS updated_json_mysql,
    
    -- PostgreSQL
    jsonb_set(
        metadata::jsonb,
        '{skills,2}',
        '"Java"',
        true
    ) AS updated_json_pg
FROM employees WHERE emp_id = 1;
```

### 8.4 Searching in JSON

**MySQL:**
```sql
JSON_CONTAINS(json_doc, value, path)
JSON_SEARCH(json_doc, 'one|all', search_str)
```

**PostgreSQL:**
```sql
json_column @> '{"key": "value"}'  -- Contains
json_column ? 'key'  -- Has key
json_column ?| array['key1', 'key2']  -- Has any key
json_column ?& array['key1', 'key2']  -- Has all keys
```

**Example:**
```sql
-- Search for employees with SQL skill
SELECT first_name, metadata
FROM employees
WHERE 
    -- MySQL
    JSON_CONTAINS(metadata->'$.skills', '"SQL"')
    OR
    -- PostgreSQL
    metadata::jsonb @> '{"skills": ["SQL"]}';
```

### 8.5 Aggregating JSON

```sql
-- MySQL
SELECT 
    department,
    JSON_ARRAYAGG(
        JSON_OBJECT('name', first_name, 'salary', salary)
    ) AS employees_json
FROM employees
GROUP BY department;

-- PostgreSQL
SELECT 
    department,
    json_agg(
        json_build_object('name', first_name, 'salary', salary)
    ) AS employees_json
FROM employees
GROUP BY department;
```

---

## 9. Advanced Functions {#advanced-functions}

### 9.1 Recursive CTEs (Common Table Expressions)

**Both MySQL (8.0+) & PostgreSQL:**
```sql
WITH RECURSIVE cte_name AS (
    -- Anchor member (initial query)
    SELECT ...
    UNION ALL
    -- Recursive member (references CTE)
    SELECT ...
    FROM cte_name
    WHERE condition
)
SELECT * FROM cte_name;
```

**Example: Employee Hierarchy:**
```sql
WITH RECURSIVE emp_hierarchy AS (
    -- Anchor: Top-level managers (no manager)
    SELECT 
        emp_id,
        first_name,
        last_name,
        manager_id,
        1 AS level,
        CAST(first_name AS CHAR(200)) AS path
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive: Employees reporting to managers in hierarchy
    SELECT 
        e.emp_id,
        e.first_name,
        e.last_name,
        e.manager_id,
        eh.level + 1,
        CONCAT(eh.path, ' -> ', e.first_name)
    FROM employees e
    INNER JOIN emp_hierarchy eh ON e.manager_id = eh.emp_id
)
SELECT 
    emp_id,
    first_name,
    last_name,
    level,
    path AS reporting_chain
FROM emp_hierarchy
ORDER BY level, first_name;

-- Result shows hierarchical structure
```

### 9.2 PIVOT (PostgreSQL) / Conditional Aggregation

**PostgreSQL PIVOT:**
```sql
-- Using crosstab extension
CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT * FROM crosstab(
    'SELECT department, 
            EXTRACT(YEAR FROM hire_date) as year,
            COUNT(*) as count
     FROM employees
     GROUP BY department, EXTRACT(YEAR FROM hire_date)
     ORDER BY 1,2',
    'SELECT DISTINCT EXTRACT(YEAR FROM hire_date) 
     FROM employees ORDER BY 1'
) AS ct(department VARCHAR, y2020 INT, y2021 INT, y2022 INT);
```

**MySQL Conditional Aggregation:**
```sql
-- Manual pivot using CASE
SELECT 
    department,
    SUM(CASE WHEN YEAR(hire_date) = 2020 THEN 1 ELSE 0 END) AS hired_2020,
    SUM(CASE WHEN YEAR(hire_date) = 2021 THEN 1 ELSE 0 END) AS hired_2021,
    SUM(CASE WHEN YEAR(hire_date) = 2022 THEN 1 ELSE 0 END) AS hired_2022,
    COUNT(*) AS total
FROM employees
GROUP BY department;
```

### 9.3 Full-Text Search Functions

**MySQL:**
```sql
MATCH(columns) AGAINST(search_string IN NATURAL LANGUAGE MODE)
MATCH(columns) AGAINST(search_string IN BOOLEAN MODE)
```

**PostgreSQL:**
```sql
to_tsvector(column) @@ to_tsquery('search & terms')
ts_rank(vector, query)
```

**Example:**
```sql
-- Add full-text index
ALTER TABLE products 
ADD COLUMN search_vector tsvector;  -- PostgreSQL

-- MySQL full-text search
SELECT product_name, price,
       MATCH(product_name, category) AGAINST('laptop wireless' IN NATURAL LANGUAGE MODE) AS relevance
FROM products
WHERE MATCH(product_name, category) AGAINST('laptop wireless' IN NATURAL LANGUAGE MODE)
ORDER BY relevance DESC;

-- PostgreSQL full-text search
UPDATE products SET search_vector = 
    to_tsvector('english', product_name || ' ' || category);

SELECT product_name, price,
       ts_rank(search_vector, to_tsquery('laptop & wireless')) AS relevance
FROM products
WHERE search_vector @@ to_tsquery('laptop & wireless')
ORDER BY relevance DESC;
```

### 9.4 Spatial Functions (GIS)

**MySQL:**
```sql
ST_Distance(point1, point2)
ST_Contains(geometry1, geometry2)
ST_Intersects(geometry1, geometry2)
```

**PostgreSQL (with PostGIS extension):**
```sql
ST_Distance(geography1, geography2)
ST_Contains(geometry1, geometry2)
ST_Intersects(geometry1, geometry2)
ST_Buffer(geometry, radius)
```

**Example:**
```sql
-- Create spatial table
CREATE TABLE locations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    -- MySQL
    point POINT SRID 4326,
    -- PostgreSQL
    geog GEOGRAPHY(POINT, 4326)
);

-- Find points within radius
-- MySQL
SELECT name, 
       ST_AsText(point) AS coordinates,
       ST_Distance(point, ST_GeomFromText('POINT(0 0)', 4326)) AS distance
FROM locations
WHERE ST_Distance_Sphere(point, ST_GeomFromText('POINT(0 0)', 4326)) < 10000;

-- PostgreSQL
SELECT name,
       ST_AsText(geog::geometry) AS coordinates,
       ST_Distance(geog, ST_GeogFromText('POINT(0 0)')) AS distance
FROM locations
WHERE ST_DWithin(geog, ST_GeogFromText('POINT(0 0)'), 10000);
```

### 9.5 Encryption and Hash Functions

**MySQL:**
```sql
MD5(string)
SHA1(string)
SHA2(string, hash_length)
AES_ENCRYPT(data, key)
AES_DECRYPT(data, key)
```

**PostgreSQL:**
```sql
MD5(string)
SHA256(string)  -- Using pgcrypto extension
ENCRYPT(data, key, method)
DECRYPT(data, key, method)
```

**Example:**
```sql
-- Hash passwords
SELECT 
    first_name,
    -- MySQL
    MD5(email) AS email_md5_mysql,
    SHA2(email, 256) AS email_sha256_mysql,
    -- PostgreSQL
    MD5(email) AS email_md5_pg
FROM employees;

-- PostgreSQL with pgcrypto
CREATE EXTENSION IF NOT EXISTS pgcrypto;
SELECT 
    first_name,
    crypt('password', gen_salt('bf', 8)) AS encrypted_password
FROM employees;
```

### 9.6 System and Information Functions

**MySQL:**
```sql
VERSION()
DATABASE()
USER()
CONNECTION_ID()
LAST_INSERT_ID()
```

**PostgreSQL:**
```sql
VERSION()
CURRENT_DATABASE()
CURRENT_USER
pg_backend_pid()
LASTVAL()  -- Last sequence value
```

**Example:**
```sql
-- System information
-- MySQL
SELECT 
    VERSION() AS mysql_version,
    DATABASE() AS current_db,
    USER() AS current_user,
    CONNECTION_ID() AS connection_id;

-- PostgreSQL
SELECT 
    VERSION() AS pg_version,
    CURRENT_DATABASE() AS current_db,
    CURRENT_USER AS current_user,
    pg_backend_pid() AS process_id;
```

---

## 10. Performance Considerations {#performance}

### 10.1 Function-Based Indexes

**MySQL:**
```sql
-- Create index on function result
CREATE INDEX idx_upper_name ON employees(UPPER(first_name));

-- Use in queries
SELECT * FROM employees WHERE UPPER(first_name) = 'JOHN';
```

**PostgreSQL:**
```sql
-- Create expression index
CREATE INDEX idx_upper_name ON employees(UPPER(first_name));

-- For full-text search
CREATE INDEX idx_search_vector ON products USING GIN(search_vector);
```

### 10.2 Function Volatility Categories (PostgreSQL)

```sql
-- Immutable: Always returns same result for same input
CREATE FUNCTION get_tax_rate(price DECIMAL) RETURNS DECIMAL
IMMUTABLE
LANGUAGE SQL
AS $$
    SELECT CASE 
        WHEN price < 100 THEN 0.05
        WHEN price < 1000 THEN 0.10
        ELSE 0.15
    END;
$$;

-- Stable: Returns same result within a transaction
-- Volatile: Can return different results each time (default)
```

### 10.3 Avoiding Function Calls on Indexed Columns

```sql
-- ❌ Bad: Can't use index on first_name
SELECT * FROM employees WHERE UPPER(first_name) = 'JOHN';

-- ✅ Better: Store uppercase version or use case-insensitive collation
SELECT * FROM employees WHERE first_name = 'John' COLLATE utf8_general_ci;

-- ✅ Best: Create function-based index
CREATE INDEX idx_name_upper ON employees(UPPER(first_name));
```

### 10.4 Tips for Optimal Performance

1. **Use built-in functions** over custom functions when possible
2. **Avoid functions in WHERE clauses** on indexed columns
3. **Consider materialized views** for expensive calculations
4. **Use appropriate data types** to avoid implicit conversions
5. **Batch operations** when using expensive functions

```sql
-- Instead of calling function for each row in WHERE
SELECT * FROM products WHERE expensive_calculation(price) > 100;

-- Consider materializing
CREATE MATERIALIZED VIEW product_calculations AS
SELECT product_id, expensive_calculation(price) AS calc_value
FROM products;

SELECT p.* 
FROM products p
JOIN product_calculations pc ON p.product_id = pc.product_id
WHERE pc.calc_value > 100;
```

---

## 📊 Summary Table: MySQL vs PostgreSQL Function Differences

| Function Category | MySQL | PostgreSQL | Notes |
|------------------|-------|------------|-------|
| String Concatenation | CONCAT() | \|\| or CONCAT() | |
| String Position | LOCATE(), INSTR() | POSITION(), STRPOS() | |
| Current Date/Time | CURDATE(), NOW() | CURRENT_DATE, CURRENT_TIMESTAMP | |
| Date Arithmetic | DATE_ADD() | date + INTERVAL | |
| Date Difference | DATEDIFF() | date1 - date2 | |
| Date Formatting | DATE_FORMAT() | TO_CHAR() | |
| Conditional | IF(), IFNULL() | CASE, COALESCE() | |
| Window Functions | ✓ (8.0+) | ✓ | |
| JSON Functions | JSON_* functions | json_* functions | Different syntax |
| Full-Text Search | MATCH() AGAINST() | tsvector, tsquery | |
| PIVOT | Manual CASE | crosstab() extension | |
| Common Table Expressions | ✓ (8.0+) | ✓ | |
| GIS Functions | Basic spatial | PostGIS extension | |

---

## 🎯 Best Practices

1. **Use standard SQL functions** when possible for portability
2. **Document custom functions** with comments and examples
3. **Test functions** with edge cases (NULL values, empty strings)
4. **Consider performance implications** of function usage
5. **Use appropriate data types** to minimize conversions
6. **Keep functions simple and focused** on single responsibility
7. **Handle NULL values** explicitly in function logic

---

## 📚 Additional Resources

1. **MySQL Official Documentation**: https://dev.mysql.com/doc/
2. **PostgreSQL Official Documentation**: https://www.postgresql.org/docs/
3. **SQL Standard Functions**: https://www.w3schools.com/sql/
4. **Function Performance Tuning**: Database-specific optimization guides

---

## 🚀 Quick Reference Cheat Sheet

### Most Commonly Used Functions:

| Task | MySQL | PostgreSQL |
|------|-------|------------|
| Current Date | CURDATE() | CURRENT_DATE |
| Current Time | NOW() | CURRENT_TIMESTAMP |
| String Length | CHAR_LENGTH() | LENGTH() |
| Substring | SUBSTRING() | SUBSTRING() |
| Trim Spaces | TRIM() | TRIM() |
| Round Number | ROUND() | ROUND() |
| Handle NULL | IFNULL() or COALESCE() | COALESCE() |
| Conditional Logic | CASE | CASE |
| Aggregate Count | COUNT() | COUNT() |
| Group Concatenation | GROUP_CONCAT() | STRING_AGG() |

This comprehensive guide covers SQL functions from basic to advanced levels. Remember to always test functions in your specific database environment as there may be version-specific differences or behaviors.