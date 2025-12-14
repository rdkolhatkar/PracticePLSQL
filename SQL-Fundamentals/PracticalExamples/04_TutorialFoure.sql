-- =====================================================
-- EMPLOYEES TABLE SETUP
-- =====================================================

-- Drop the table if it already exists
DROP TABLE IF EXISTS employees;

-- Create the employees table
CREATE TABLE employees (
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    salary DECIMAL(10, 2) CHECK (salary > 0),
    joining_date DATE NOT NULL,
    age INT CHECK (age >= 18)
);

-- Insert sample data into employees table
INSERT INTO employees (first_name, last_name, department, salary, joining_date, age) VALUES
('Amit', 'Sharma', 'IT', 60000.00, '2022-05-01', 29),
('Neha', 'Patel', 'HR', 55000.00, '2021-08-15', 32),
('Ravi', 'Kumar', 'Finance', 70000.00, '2020-03-10', 35),
('Anjali', 'Verma', 'IT', 65000.00, '2019-11-22', 28),
('Suresh', 'Reddy', 'Operations', 50000.00, '2023-01-10', 26);

-- =====================================================
-- Q1: Retrieve all employees’ first_name and their departments
-- =====================================================
-- Answer:
SELECT first_name, department
FROM employees;

-- Explanation:
-- This query fetches only the first_name and department columns
-- from the employees table.

-- =====================================================
-- Q2: Update the salary of all employees in the 'IT' department
--     by increasing it by 10%
-- =====================================================
-- Answer:
UPDATE employees
SET salary = salary * 1.10
WHERE department = 'IT';

-- Explanation:
-- This increases the salary of IT employees by 10%
-- using multiplication for better readability.

-- =====================================================
-- Q3: Delete all employees who are older than 34 years
-- =====================================================
-- Answer:
DELETE FROM employees
WHERE age > 34;

-- Explanation:
-- This removes records of employees whose age is greater than 34.
-- Always verify with a SELECT query before DELETE in real projects.

-- =====================================================
-- Q4: Add a new column `email` to the employees table
-- =====================================================
-- Answer:
ALTER TABLE employees
ADD COLUMN email VARCHAR(100);

-- Explanation:
-- Adds a new column to store employee email addresses.

-- =====================================================
-- Q5: Rename the `department` column to `dept_name`
-- =====================================================
-- Answer:
ALTER TABLE employees
RENAME COLUMN department TO dept_name;

-- Explanation:
-- Renames the column for better clarity or naming standards.
-- After this step, 'department' no longer exists.

-- =====================================================
-- Q6: Retrieve the names of employees who joined after
--     January 1, 2021
-- =====================================================
-- Answer:
SELECT first_name, last_name, joining_date
FROM employees
WHERE joining_date > '2021-01-01';

-- Explanation:
-- Filters employees based on joining_date using a date condition.

-- =====================================================
-- Q7: Change the data type of the salary column to INTEGER
-- =====================================================
-- Answer:
ALTER TABLE employees
ALTER COLUMN salary TYPE INTEGER
USING salary::INTEGER;

-- Explanation:
-- Converts salary from DECIMAL to INTEGER.
-- Decimal values will be truncated (not rounded).

-- =====================================================
-- Q8: List all employees with their age and salary in
--     descending order of salary
-- =====================================================
-- Answer:
SELECT first_name, age, salary
FROM employees
ORDER BY salary DESC;

-- Explanation:
-- Orders employees from highest salary to lowest salary.

-- =====================================================
-- Q9: Insert a new employee with the following details:
--     ('Raj', 'Singh', 'Marketing', 60000, '2023-09-15', 30)
-- =====================================================
-- Answer:
INSERT INTO employees (first_name, last_name, dept_name, salary, joining_date, age)
VALUES ('Raj', 'Singh', 'Marketing', 60000, '2023-09-15', 30);

-- Explanation:
-- Inserts a new employee record using the renamed column `dept_name`.

-- =====================================================
-- Q10: Update age of every employee by adding 1 year
-- =====================================================
-- Answer:
UPDATE employees
SET age = age + 1;

-- Explanation:
-- Increments the age of all employees by 1.

-- =====================================================
-- Q11 (NEW): List all employees with their age and salary
--            in ascending order of salary
-- =====================================================
-- Answer:
SELECT first_name, age, salary
FROM employees
ORDER BY salary ASC;

-- Explanation:
-- Orders employees from lowest salary to highest salary.
-- ASC is optional because ascending order is default.
