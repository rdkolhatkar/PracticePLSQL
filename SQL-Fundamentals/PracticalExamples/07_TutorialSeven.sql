/*
    SELECT command is used to retrieve data from a database. It allows you to specify
    which columns you want to see, as well as any conditions for filtering the data.
    The basic syntax for a SELECT statement is as follows:
    SELECT column1, column2, ...
    FROM table_name
    WHERE condition;
*/

-- ============================================
-- ORIGINAL EMPLOYEES TABLE (Sample Data)
-- ============================================
/*
+----+------------+-----------+--------+------------+------------+
| id | first_name | last_name | salary | department | hire_date  |
+----+------------+-----------+--------+------------+------------+
|  1 | John       | Doe       |  60000 | Sales      | 2020-03-15 |
|  2 | Jane       | Smith     |  75000 | IT         | 2019-07-22 |
|  3 | Michael    | Brown     |  50000 | HR         | 2021-01-10 |
|  4 | Emily      | Davis     |  82000 | IT         | 2018-11-05 |
|  5 | Daniel     | Wilson    |  45000 | Sales      | 2022-06-18 |
|  6 | Sarah      | Taylor    |  70000 | HR         | 2017-09-30 |
|  7 | David      | Anderson  |  90000 | Sales      | 2016-12-01 |
+----+------------+-----------+--------+------------+------------+
*/

-- Example 1: Retrieve all columns from the "Employees" table
-- How it works: SELECT * means "select all columns". No WHERE clause means no filtering.
--               All 7 rows and all 6 columns are returned exactly as stored.
SELECT * FROM Employees;
/*
Output:
+----+------------+-----------+--------+------------+------------+
| id | first_name | last_name | salary | department | hire_date  |
+----+------------+-----------+--------+------------+------------+
|  1 | John       | Doe       |  60000 | Sales      | 2020-03-15 |
|  2 | Jane       | Smith     |  75000 | IT         | 2019-07-22 |
|  3 | Michael    | Brown     |  50000 | HR         | 2021-01-10 |
|  4 | Emily      | Davis     |  82000 | IT         | 2018-11-05 |
|  5 | Daniel     | Wilson    |  45000 | Sales      | 2022-06-18 |
|  6 | Sarah      | Taylor    |  70000 | HR         | 2017-09-30 |
|  7 | David      | Anderson  |  90000 | Sales      | 2016-12-01 |
+----+------------+-----------+--------+------------+------------+
7 rows in set
*/

-- Example 2
-- How it works: Instead of *, specific column names are listed after SELECT.
--               Only first_name and last_name are retrieved; all other columns are excluded.
--               All 7 rows are still returned because there is no WHERE clause.
SELECT first_name, last_name FROM Employees;
/*
Output:
+------------+-----------+
| first_name | last_name |
+------------+-----------+
| John       | Doe       |
| Jane       | Smith     |
| Michael    | Brown     |
| Emily      | Davis     |
| Daniel     | Wilson    |
| Sarah      | Taylor    |
| David      | Anderson  |
+------------+-----------+
7 rows in set
*/

-- Example 3
-- How it works: AS 'alias' renames a column in the output (the alias appears as the column header).
--               The actual column names in the table (first_name, last_name) are unchanged.
--               Aliases with spaces must be wrapped in single quotes (or backticks) in MySQL.
--               Data and row count are identical to Example 2 — only the headers change.
SELECT first_name AS 'First Name', last_name AS 'Last Name' FROM Employees;
/*
Output:
+------------+-----------+
| First Name | Last Name |
+------------+-----------+
| John       | Doe       |
| Jane       | Smith     |
| Michael    | Brown     |
| Emily      | Davis     |
| Daniel     | Wilson    |
| Sarah      | Taylor    |
| David      | Anderson  |
+------------+-----------+
7 rows in set
*/

-- Example 4
-- How it works: WHERE department = 'Sales' filters rows to only those where the department
--               column exactly matches the string 'Sales' (case-insensitive by default).
--               3 employees belong to Sales: John (id=1), Daniel (id=5), David (id=7).
SELECT * FROM Employees WHERE department = 'Sales';
/*
Output:
+----+------------+-----------+--------+------------+------------+
| id | first_name | last_name | salary | department | hire_date  |
+----+------------+-----------+--------+------------+------------+
|  1 | John       | Doe       |  60000 | Sales      | 2020-03-15 |
|  5 | Daniel     | Wilson    |  45000 | Sales      | 2022-06-18 |
|  7 | David      | Anderson  |  90000 | Sales      | 2016-12-01 |
+----+------------+-----------+--------+------------+------------+
3 rows in set
*/

-- Example 5
-- How it works: WHERE salary > 50000 filters rows to employees earning more than 50000.
--               Michael Brown earns exactly 50000 (not > 50000) and is excluded.
--               Daniel Wilson earns 45000 and is also excluded.
--               5 employees qualify: John(60000), Jane(75000), Emily(82000),
--               Sarah(70000), David(90000).
SELECT * FROM Employees WHERE salary > 50000;
/*
Output:
+----+------------+-----------+--------+------------+------------+
| id | first_name | last_name | salary | department | hire_date  |
+----+------------+-----------+--------+------------+------------+
|  1 | John       | Doe       |  60000 | Sales      | 2020-03-15 |
|  2 | Jane       | Smith     |  75000 | IT         | 2019-07-22 |
|  4 | Emily      | Davis     |  82000 | IT         | 2018-11-05 |
|  6 | Sarah      | Taylor    |  70000 | HR         | 2017-09-30 |
|  7 | David      | Anderson  |  90000 | Sales      | 2016-12-01 |
+----+------------+-----------+--------+------------+------------+
5 rows in set
*/

-- Example 6
-- How it works: AND requires BOTH conditions to be true simultaneously.
--               Condition 1: department = 'Sales' → John, Daniel, David.
--               Condition 2: salary > 50000 → removes Daniel (45000).
--               Only John (60000) and David (90000) satisfy both conditions.
SELECT * FROM Employees WHERE department = 'Sales' AND salary > 50000;
/*
Output:
+----+------------+-----------+--------+------------+------------+
| id | first_name | last_name | salary | department | hire_date  |
+----+------------+-----------+--------+------------+------------+
|  1 | John       | Doe       |  60000 | Sales      | 2020-03-15 |
|  7 | David      | Anderson  |  90000 | Sales      | 2016-12-01 |
+----+------------+-----------+--------+------------+------------+
2 rows in set
*/

-- Example 7
-- How it works: WHERE first filters to the 3 Sales employees (John, Daniel, David),
--               then ORDER BY salary DESC sorts them from highest salary to lowest.
--               David (90000) appears first, John (60000) second, Daniel (45000) last.
SELECT * FROM Employees WHERE department = 'Sales' ORDER BY salary DESC;
/*
Output:
+----+------------+-----------+--------+------------+------------+
| id | first_name | last_name | salary | department | hire_date  |
+----+------------+-----------+--------+------------+------------+
|  7 | David      | Anderson  |  90000 | Sales      | 2016-12-01 |
|  1 | John       | Doe       |  60000 | Sales      | 2020-03-15 |
|  5 | Daniel     | Wilson    |  45000 | Sales      | 2022-06-18 |
+----+------------+-----------+--------+------------+------------+
3 rows in set
*/

-- Example 8
-- How it works: Same filter as Example 7 but ORDER BY salary ASC sorts from lowest to highest.
--               Daniel (45000) appears first, John (60000) second, David (90000) last.
--               ASC is the default direction and could be omitted, but is written explicitly here.
SELECT * FROM Employees WHERE department = 'Sales' ORDER BY salary ASC;
/*
Output:
+----+------------+-----------+--------+------------+------------+
| id | first_name | last_name | salary | department | hire_date  |
+----+------------+-----------+--------+------------+------------+
|  5 | Daniel     | Wilson    |  45000 | Sales      | 2022-06-18 |
|  1 | John       | Doe       |  60000 | Sales      | 2020-03-15 |
|  7 | David      | Anderson  |  90000 | Sales      | 2016-12-01 |
+----+------------+-----------+--------+------------+------------+
3 rows in set
*/

-- Example 9
-- How it works: Two sort keys are provided: salary ASC (primary) and first_name DESC (secondary).
--               The secondary key (first_name DESC) is only used when two rows have equal salaries.
--               Since all 3 Sales employees have unique salaries, first_name DESC never comes
--               into play — the output is identical to Example 8.
SELECT * FROM Employees WHERE department = 'Sales' ORDER BY salary ASC, first_name DESC;
/*
Output:
+----+------------+-----------+--------+------------+------------+
| id | first_name | last_name | salary | department | hire_date  |
+----+------------+-----------+--------+------------+------------+
|  5 | Daniel     | Wilson    |  45000 | Sales      | 2022-06-18 |
|  1 | John       | Doe       |  60000 | Sales      | 2020-03-15 |
|  7 | David      | Anderson  |  90000 | Sales      | 2016-12-01 |
+----+------------+-----------+--------+------------+------------+
3 rows in set
Note: first_name DESC has no visible effect here because all salaries are distinct.
      It would only matter if two or more rows shared the same salary value.
*/

-- Example 10
-- How it works: LIMIT 5 restricts the result to at most 5 rows after ORDER BY is applied.
--               The WHERE clause first narrows to 3 Sales employees, then ORDER BY salary ASC
--               sorts them, and finally LIMIT 5 would cap at 5 rows. Since there are only 3
--               Sales employees, all 3 are returned (LIMIT 5 has no practical effect here).
SELECT * FROM Employees WHERE department = 'Sales' ORDER BY salary ASC LIMIT 5;
/*
Output:
+----+------------+-----------+--------+------------+------------+
| id | first_name | last_name | salary | department | hire_date  |
+----+------------+-----------+--------+------------+------------+
|  5 | Daniel     | Wilson    |  45000 | Sales      | 2022-06-18 |
|  1 | John       | Doe       |  60000 | Sales      | 2020-03-15 |
|  7 | David      | Anderson  |  90000 | Sales      | 2016-12-01 |
+----+------------+-----------+--------+------------+------------+
3 rows in set
Note: LIMIT 5 allows up to 5 rows but only 3 Sales employees exist, so all 3 are returned.
*/

-- Example 11
-- How it works: DISTINCT eliminates duplicate values in the result set.
--               Without DISTINCT, department would appear 7 times (once per row).
--               With DISTINCT, each unique department value is returned only once.
--               The 3 unique departments in the table are: Sales, IT, HR.
SELECT DISTINCT department FROM Employees;
/*
Output:
+------------+
| department |
+------------+
| Sales      |
| IT         |
| HR         |
+------------+
3 rows in set
*/

-- Example 12
-- How it works: salary * 1.10 computes a 10% raise for each employee's salary as an
--               expression evaluated per row. The result is aliased as 'New Salary'.
--               The original salary column in the table is NOT modified — this is a
--               read-only computed column shown only in the query output.
--               Only Sales employees are returned (John, Daniel, David).
SELECT first_name, last_name, salary * 1.10 AS 'New Salary' FROM Employees WHERE department = 'Sales';
/*
Output:
+------------+-----------+------------+
| first_name | last_name | New Salary |
+------------+-----------+------------+
| John       | Doe       |   66000.00 |
| Daniel     | Wilson    |   49500.00 |
| David      | Anderson  |   99000.00 |
+------------+-----------+------------+
3 rows in set
*/

-- Example 13
-- How it works: CONCAT(first_name, ' ', last_name) joins the first_name column, a space
--               character literal (' '), and the last_name column into a single string per row.
--               The result is aliased as 'Full Name'. All 7 employees are returned.
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name' FROM Employees;
/*
Output:
+----------------+
| Full Name      |
+----------------+
| John Doe       |
| Jane Smith     |
| Michael Brown  |
| Emily Davis    |
| Daniel Wilson  |
| Sarah Taylor   |
| David Anderson |
+----------------+
7 rows in set
*/

-- Example 14
-- How it works: Extends Example 13 by also selecting the hire_date column alongside
--               the computed Full Name alias. Two columns are returned per row:
--               the concatenated name and the raw hire date.
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', hire_date FROM Employees;
/*
Output:
+----------------+------------+
| Full Name      | hire_date  |
+----------------+------------+
| John Doe       | 2020-03-15 |
| Jane Smith     | 2019-07-22 |
| Michael Brown  | 2021-01-10 |
| Emily Davis    | 2018-11-05 |
| Daniel Wilson  | 2022-06-18 |
| Sarah Taylor   | 2017-09-30 |
| David Anderson | 2016-12-01 |
+----------------+------------+
7 rows in set
*/

-- Example 15
-- How it works: YEAR(hire_date) extracts only the 4-digit year from a DATE value.
--               Instead of seeing the full date (e.g. 2020-03-15), only 2020 is shown.
--               Aliased as 'Hire Year'. Useful for grouping or displaying yearly data.
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', YEAR(hire_date) AS 'Hire Year' FROM Employees;
/*
Output:
+----------------+-----------+
| Full Name      | Hire Year |
+----------------+-----------+
| John Doe       |      2020 |
| Jane Smith     |      2019 |
| Michael Brown  |      2021 |
| Emily Davis    |      2018 |
| Daniel Wilson  |      2022 |
| Sarah Taylor   |      2017 |
| David Anderson |      2016 |
+----------------+-----------+
7 rows in set
*/

-- Example 16
-- How it works: ROUND(salary, 2) rounds the salary value to 2 decimal places.
--               Since all salaries are whole integers (no decimal portion), the result
--               is the same numeric value displayed as a DECIMAL with .00 suffix.
--               ROUND is more useful when salaries already contain fractional cents.
SELECT first_name, last_name, ROUND(salary, 2) AS 'Rounded Salary' FROM Employees;
/*
Output:
+------------+-----------+----------------+
| first_name | last_name | Rounded Salary |
+------------+-----------+----------------+
| John       | Doe       |       60000.00 |
| Jane       | Smith     |       75000.00 |
| Michael    | Brown     |       50000.00 |
| Emily      | Davis     |       82000.00 |
| Daniel     | Wilson    |       45000.00 |
| Sarah      | Taylor    |       70000.00 |
| David      | Anderson  |       90000.00 |
+------------+-----------+----------------+
7 rows in set
*/

-- Example 17
-- How it works: AVG(salary) is an aggregate function that computes the arithmetic mean
--               of the salary column across ALL rows in the table.
--               Sum = 60000+75000+50000+82000+45000+70000+90000 = 472000.
--               Average = 472000 / 7 ≈ 67428.57 (rounded to 2 decimal places by MySQL).
SELECT AVG(salary) AS 'Average Salary' FROM Employees;
/*
Output:
+----------------+
| Average Salary |
+----------------+
|    67428.5714  |
+----------------+
1 row in set
Note: MySQL returns AVG as a floating-point value. Display precision may vary by client.
      Rounded to 2 decimal places: 67428.57.
*/

-- Example 18
-- How it works: The subquery (SELECT AVG(salary) FROM Employees) runs first and returns 67428.57.
--               The outer query then filters employees whose salary exceeds that average.
--               Jane Smith (75000) ✓, Emily Davis (82000) ✓, David Anderson (90000) ✓.
--               John (60000), Michael (50000), Daniel (45000), Sarah (70000) are below — excluded.
SELECT CONCAT(first_name, ' ', last_name) AS 'Full Name', salary FROM Employees
WHERE salary > (SELECT AVG(salary) FROM Employees);
/*
Average salary = 67428.57

Output:
+----------------+--------+
| Full Name      | salary |
+----------------+--------+
| Jane Smith     |  75000 |
| Emily Davis    |  82000 |
| David Anderson |  90000 |
+----------------+--------+
3 rows in set
*/

-- Example 19
-- How it works: IN ('IT', 'HR') is shorthand for department = 'IT' OR department = 'HR'.
--               This filters out Sales employees (John, Daniel, David).
--               The remaining 4 employees (Jane, Emily — IT; Michael, Sarah — HR) are returned.
--               ORDER BY salary DESC then sorts them from highest to lowest salary.
SELECT first_name, last_name, salary, department FROM Employees
WHERE department IN ('IT', 'HR')
ORDER BY salary DESC;
/*
Output:
+------------+-----------+--------+------------+
| first_name | last_name | salary | department |
+------------+-----------+--------+------------+
| Emily      | Davis     |  82000 | IT         |
| Jane       | Smith     |  75000 | IT         |
| Sarah      | Taylor    |  70000 | HR         |
| Michael    | Brown     |  50000 | HR         |
+------------+-----------+--------+------------+
4 rows in set
*/

-- Example 20
-- How it works: UNION combines the result sets of two SELECT statements into one.
--               The first SELECT returns all Sales employees (John, Daniel, David).
--               The second SELECT returns all IT employees (Jane, Emily).
--               UNION (without ALL) removes duplicate rows — none exist here since
--               the two departments are distinct. Both selects must have the same number
--               of columns and compatible data types.
SELECT first_name, last_name, department FROM Employees WHERE department = 'Sales'
UNION   
SELECT first_name, last_name, department FROM Employees WHERE department = 'IT';
/*
Output:
+------------+-----------+------------+
| first_name | last_name | department |
+------------+-----------+------------+
| John       | Doe       | Sales      |
| Daniel     | Wilson    | Sales      |
| David      | Anderson  | Sales      |
| Jane       | Smith     | IT         |
| Emily      | Davis     | IT         |
+------------+-----------+------------+
5 rows in set
*/

-- Example 21
-- How it works: GROUP BY department groups all rows that share the same department value.
--               COUNT(*) then counts the number of rows in each group.
--               Sales has 3 employees (John, Daniel, David).
--               IT has 2 employees (Jane, Emily).
--               HR has 2 employees (Michael, Sarah).
--               The alias 'Total Employees' labels the count column in the output.
SELECT department, COUNT(*) AS 'Total Employees' FROM Employees GROUP BY department;
/*
Output:
+------------+-----------------+
| department | Total Employees |
+------------+-----------------+
| Sales      |               3 |
| IT         |               2 |
| HR         |               2 |
+------------+-----------------+
3 rows in set
Note: Row order in GROUP BY results is non-deterministic unless ORDER BY is added.
*/

-- Calculator Examples
-- How it works: SELECT can evaluate arithmetic expressions directly without referencing
--               any table. The result is a single-row, single-column output.
--               Aliasing with AS gives the computed column a meaningful header.

-- How it works: 100 + 200 performs integer addition and returns the sum 300.
SELECT 100 + 200 AS 'Sum';
/*
Output:
+-----+
| Sum |
+-----+
| 300 |
+-----+
1 row in set
*/

-- How it works: 100 - 50 performs integer subtraction and returns 50.
SELECT 100 - 50 AS 'Difference';
/*
Output:
+------------+
| Difference |
+------------+
|         50 |
+------------+
1 row in set
*/

-- How it works: 10 * 5 performs integer multiplication and returns 50.
SELECT 10 * 5 AS 'Product';
/*
Output:
+---------+
| Product |
+---------+
|      50 |
+---------+
1 row in set
*/

-- How it works: 100 / 4 performs division. MySQL returns a DECIMAL result for /.
--               100 / 4 = 25.0000 (MySQL shows 4 decimal places by default for division).
SELECT 100 / 4 AS 'Quotient';
/*
Output:
+----------+
| Quotient |
+----------+
|  25.0000 |
+----------+
1 row in set
*/

-- How it works: NOW() is a built-in MySQL function that returns the current date and time
--               as a DATETIME value in the format YYYY-MM-DD HH:MM:SS.
--               The value changes every time the query is run — the output below is an example.
SELECT NOW() AS 'Current Date and Time';
/*
Output:
+-----------------------+
| Current Date and Time |
+-----------------------+
| 2026-03-20 10:30:00   |
+-----------------------+
1 row in set
Note: The exact value depends on when the query is executed.
*/

-- How it works: LENGTH(first_name) returns the number of bytes (characters for ASCII text)
--               in each employee's first name. One row is returned per employee.
SELECT LENGTH(first_name) AS 'First Name Length' FROM Employees;
/*
Output:
+-------------------+
| First Name Length |
+-------------------+
|                 4 |  -- John
|                 4 |  -- Jane
|                 7 |  -- Michael
|                 5 |  -- Emily
|                 6 |  -- Daniel
|                 5 |  -- Sarah
|                 5 |  -- David
+-------------------+
7 rows in set
*/

-- How it works: SUBSTRING(first_name, 1, 3) extracts a substring starting at position 1
--               (MySQL uses 1-based indexing, not 0-based) and taking 3 characters.
--               This effectively returns the first 3 letters of each employee's first name.
SELECT SUBSTRING(first_name, 1, 3) AS 'First 3 Letters' FROM Employees;
/*
Output:
+-----------------+
| First 3 Letters |
+-----------------+
| Joh             |
| Jan             |
| Mic             |
| Emi             |
| Dan             |
| Sar             |
| Dav             |
+-----------------+
7 rows in set
*/

-- How it works: UPPER(last_name) converts every character in the last_name column to
--               uppercase. The original data in the table is not changed.
SELECT UPPER(last_name) AS 'Last Name in Uppercase' FROM Employees;
/*
Output:
+------------------------+
| Last Name in Uppercase |
+------------------------+
| DOE                    |
| SMITH                  |
| BROWN                  |
| DAVIS                  |
| WILSON                 |
| TAYLOR                 |
| ANDERSON               |
+------------------------+
7 rows in set
*/

-- How it works: LOWER(first_name) converts every character in the first_name column to
--               lowercase. The original data in the table is not changed.
SELECT LOWER(first_name) AS 'First Name in Lowercase' FROM Employees;
/*
Output:
+-------------------------+
| First Name in Lowercase |
+-------------------------+
| john                    |
| jane                    |
| michael                 |
| emily                   |
| daniel                  |
| sarah                   |
| david                   |
+-------------------------+
7 rows in set
*/

-- How it works: Comparison expressions used directly in SELECT return 1 (TRUE) or 0 (FALSE).
--               These are evaluated as boolean expressions, not column lookups.

-- How it works: 5 > 3 is TRUE → MySQL returns 1.
SELECT 5 > 3 AS 'Is 5 greater than 3?';
/*
Output:
+----------------------+
| Is 5 greater than 3? |
+----------------------+
|                    1 |
+----------------------+
1 row in set
*/

-- How it works: 10 < 5 is FALSE → MySQL returns 0.
SELECT 10 < 5 AS 'Is 10 less than 5?';
/*
Output:
+--------------------+
| Is 10 less than 5? |
+--------------------+
|                  0 |
+--------------------+
1 row in set
*/

-- How it works: 7 = 7 is TRUE → MySQL returns 1.
SELECT 7 = 7 AS 'Is 7 equal to 7?';
/*
Output:
+------------------+
| Is 7 equal to 7? |
+------------------+
|                1 |
+------------------+
1 row in set
*/

-- How it works: 5 != 3 checks if 5 is not equal to 3. Since they differ, the result is TRUE → 1.
SELECT 5 != 3 AS 'Is 5 not equal to 3?';
/*
Output:
+----------------------+
| Is 5 not equal to 3? |
+----------------------+
|                    1 |
+----------------------+
1 row in set
*/