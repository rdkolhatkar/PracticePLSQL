/*
    SELECT command is used to retrieve data from a database. It allows you to specify which columns you want to see, as well as any conditions for filtering the data.
    The basic syntax for a SELECT statement is as follows:  
    SELECT column1, column2, ...
    FROM table_name
    WHERE condition;
*/

-- ============================================
-- ORIGINAL EMPLOYEES TABLE (Sample Data)
-- ============================================

-- +----+------------+-----------+--------+------------+------------+
-- | id | first_name | last_name | salary | department | hire_date  |
-- +----+------------+-----------+--------+------------+------------+
-- | 1  | John       | Doe       | 60000  | Sales      | 2020-03-15 |
-- | 2  | Jane       | Smith     | 75000  | IT         | 2019-07-22 |
-- | 3  | Michael    | Brown     | 50000  | HR         | 2021-01-10 |
-- | 4  | Emily      | Davis     | 82000  | IT         | 2018-11-05 |
-- | 5  | Daniel     | Wilson    | 45000  | Sales      | 2022-06-18 |
-- | 6  | Sarah      | Taylor    | 70000  | HR         | 2017-09-30 |
-- | 7  | David      | Anderson  | 90000  | Sales      | 2016-12-01 |
-- +----+------------+-----------+--------+------------+------------+



-- Example 1: Retrieve all columns from the "Employees" table
SELECT * FROM Employees;

-- OUTPUT:
-- (Same as original table above)



-- Example 2
SELECT first_name, last_name FROM Employees;

-- OUTPUT:
-- +------------+-----------+
-- | first_name | last_name |
-- +------------+-----------+
-- | John       | Doe       |
-- | Jane       | Smith     |
-- | Michael    | Brown     |
-- | Emily      | Davis     |
-- | Daniel     | Wilson    |
-- | Sarah      | Taylor    |
-- | David      | Anderson  |
-- +------------+-----------+



-- Example 3
SELECT first_name AS 'First Name', last_name AS 'Last Name' FROM Employees;

-- OUTPUT:
-- +------------+-----------+
-- | First Name | Last Name |
-- +------------+-----------+
-- | John       | Doe       |
-- | Jane       | Smith     |
-- | Michael    | Brown     |
-- | Emily      | Davis     |
-- | Daniel     | Wilson    |
-- | Sarah      | Taylor    |
-- | David      | Anderson  |
-- +------------+-----------+



-- Example 4
SELECT * FROM Employees WHERE department = 'Sales';

-- OUTPUT:
-- +----+------------+-----------+--------+------------+------------+
-- | 1  | John       | Doe       | 60000  | Sales      | 2020-03-15 |
-- | 5  | Daniel     | Wilson    | 45000  | Sales      | 2022-06-18 |
-- | 7  | David      | Anderson  | 90000  | Sales      | 2016-12-01 |
-- +----+------------+-----------+--------+------------+------------+



-- Example 5
SELECT * FROM Employees WHERE salary > 50000;

-- OUTPUT:
-- John, Jane, Emily, Sarah, David



-- Example 6
SELECT * FROM Employees WHERE department = 'Sales' AND salary > 50000;

-- OUTPUT:
-- John (60000)
-- David (90000)



-- Example 7
SELECT * FROM Employees WHERE department = 'Sales' ORDER BY salary DESC;

-- OUTPUT:
-- David (90000)
-- John (60000)
-- Daniel (45000)



-- Example 8
SELECT * FROM Employees WHERE department = 'Sales' ORDER BY salary ASC;

-- OUTPUT:
-- Daniel (45000)
-- John (60000)
-- David (90000)



-- Example 9
SELECT * FROM Employees WHERE department = 'Sales' ORDER BY salary ASC, first_name DESC;

-- OUTPUT:
-- Daniel (45000)
-- John (60000)
-- David (90000)



-- Example 10
SELECT * FROM Employees WHERE department = 'Sales' ORDER BY salary ASC LIMIT 5;

-- OUTPUT:
-- Daniel
-- John
-- David



-- Example 11
SELECT DISTINCT department FROM Employees;

-- OUTPUT:
-- Sales
-- IT
-- HR



-- Example 12
SELECT first_name, last_name, salary * 1.10 AS 'New Salary' FROM Employees WHERE department = 'Sales';

-- OUTPUT:
-- John   Doe      66000
-- Daniel Wilson   49500
-- David  Anderson 99000



-- Example 13
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name' FROM Employees;

-- OUTPUT:
-- John Doe
-- Jane Smith
-- Michael Brown
-- Emily Davis
-- Daniel Wilson
-- Sarah Taylor
-- David Anderson



-- Example 14
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', hire_date FROM Employees;

-- OUTPUT:
-- John Doe        2020-03-15
-- Jane Smith      2019-07-22
-- Michael Brown   2021-01-10
-- Emily Davis     2018-11-05
-- Daniel Wilson   2022-06-18
-- Sarah Taylor    2017-09-30
-- David Anderson  2016-12-01



-- Example 15
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', YEAR(hire_date) AS 'Hire Year' FROM Employees;

-- OUTPUT:
-- John Doe        2020
-- Jane Smith      2019
-- Michael Brown   2021
-- Emily Davis     2018
-- Daniel Wilson   2022
-- Sarah Taylor    2017
-- David Anderson  2016



-- Example 16
SELECT first_name, last_name, ROUND(salary, 2) AS 'Rounded Salary' FROM Employees;

-- OUTPUT:
-- John    Doe      60000.00
-- Jane    Smith    75000.00
-- Michael Brown    50000.00
-- Emily   Davis    82000.00
-- Daniel  Wilson   45000.00
-- Sarah   Taylor   70000.00
-- David   Anderson 90000.00



-- Example 17
SELECT AVG(salary) AS 'Average Salary' FROM Employees;

-- OUTPUT:
-- 67428.57



-- Example 18
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', salary FROM Employees WHERE salary > (SELECT AVG(salary) FROM Employees);

-- OUTPUT:
-- Jane Smith      75000
-- Emily Davis     82000
-- David Anderson  90000



-- Example 19
SELECT first_name, last_name, salary, department FROM Employees WHERE department IN ('IT', 'HR') ORDER BY salary DESC;

-- OUTPUT:
-- Emily   Davis   82000  IT
-- Jane    Smith   75000  IT
-- Sarah   Taylor  70000  HR
-- Michael Brown   50000  HR



-- Example 20
SELECT first_name, last_name, department FROM Employees WHERE department = 'Sales'
UNION   
SELECT first_name, last_name, department FROM Employees WHERE department = 'IT';

-- OUTPUT:
-- John     Doe      Sales
-- Daniel   Wilson   Sales
-- David    Anderson Sales
-- Jane     Smith    IT
-- Emily    Davis    IT



-- Example 21
SELECT department, COUNT(*) AS 'Total Employees' FROM Employees GROUP BY department;

-- OUTPUT:
-- Sales  3
-- IT     2
-- HR     2



-- Calculator Examples
SELECT 100 + 200 AS 'Sum';
-- OUTPUT: 300

SELECT 100 - 50 AS 'Difference';
-- OUTPUT: 50

SELECT 10 * 5 AS 'Product';
-- OUTPUT: 50

SELECT 100 / 4 AS 'Quotient';
-- OUTPUT: 25



SELECT NOW() AS 'Current Date and Time';
-- OUTPUT: 2026-02-21 10:30:00 (Example Output)



SELECT LENGTH(first_name) AS 'First Name Length' FROM Employees;
-- OUTPUT:
-- John (4)
-- Jane (4)
-- Michael (7)
-- Emily (5)
-- Daniel (6)
-- Sarah (5)
-- David (5)



SELECT SUBSTRING(first_name, 1, 3) AS 'First 3 Letters' FROM Employees;
-- OUTPUT:
-- Joh
-- Jan
-- Mic
-- Emi
-- Dan
-- Sar
-- Dav



SELECT UPPER(last_name) AS 'Last Name in Uppercase' FROM Employees;
-- OUTPUT:
-- DOE
-- SMITH
-- BROWN
-- DAVIS
-- WILSON
-- TAYLOR
-- ANDERSON



SELECT LOWER(first_name) AS 'First Name in Lowercase' FROM Employees;
-- OUTPUT:
-- john
-- jane
-- michael
-- emily
-- daniel
-- sarah
-- david



SELECT 5 > 3 AS 'Is 5 greater than 3?';
-- OUTPUT: 1

SELECT 10 < 5 AS 'Is 10 less than 5?';
-- OUTPUT: 0

SELECT 7 = 7 AS 'Is 7 equal to 7?';
-- OUTPUT: 1

SELECT 5 != 3 AS 'Is 5 not equal to 3?';
-- OUTPUT: 1