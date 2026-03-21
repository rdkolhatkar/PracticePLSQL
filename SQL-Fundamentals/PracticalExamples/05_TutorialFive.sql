/* =========================================================
   SECTION 0: TABLE CREATION & SAMPLE DATA
   ========================================================= */

-- How it works: DROP TABLE IF EXISTS removes the table only if it already exists.
--               Without IF EXISTS, MySQL throws an error when the table is not found.
--               Dropping employees first is important because it holds a FOREIGN KEY
--               that references departments — dropping departments first would fail
--               while the referencing table still exists.
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
/*
Output:
Query OK, 0 rows affected (employees dropped or didn't exist)
Query OK, 0 rows affected (departments dropped or didn't exist)
*/

-- How it works: Creates the departments table with dept_id as the PRIMARY KEY.
--               PRIMARY KEY enforces uniqueness and prevents NULL values on dept_id.
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);
/*
Output:
Query OK, 0 rows affected
*/

-- How it works: Creates the employees table with 7 columns.
--               emp_id is the PRIMARY KEY — unique identifier for each employee.
--               bonus and manager_id are plain INT columns with no NOT NULL constraint,
--               so they allow NULL (used to represent "no bonus" and "no manager").
--               FOREIGN KEY (dept_id) enforces that every dept_id value in employees
--               must already exist in departments(dept_id).
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    salary INT,
    dept_id INT,
    bonus INT,
    joining_year INT,
    manager_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);
/*
Output:
Query OK, 0 rows affected
*/

INSERT INTO departments VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Finance');
/*
Output:
Query OK, 3 rows affected

Resulting departments table:
+---------+-----------+
| dept_id | dept_name |
+---------+-----------+
|       1 | IT        |
|       2 | HR        |
|       3 | Finance   |
+---------+-----------+
*/

INSERT INTO employees VALUES
(101, 'Amit',   70000, 1, 5000, 2020, NULL),
(102, 'Neha',   60000, 1, NULL,  2021, 101),
(103, 'Rahul',  50000, 2, 3000, 2019, 101),
(104, 'Pooja',  45000, 2, NULL,  2022, 103),
(105, 'Vikas',  80000, 3, 7000, 2018, NULL);
/*
Output:
Query OK, 5 rows affected

Resulting employees table:
+--------+----------+--------+---------+-------+--------------+------------+
| emp_id | emp_name | salary | dept_id | bonus | joining_year | manager_id |
+--------+----------+--------+---------+-------+--------------+------------+
|    101 | Amit     |  70000 |       1 |  5000 |         2020 |       NULL |
|    102 | Neha     |  60000 |       1 |  NULL |         2021 |        101 |
|    103 | Rahul    |  50000 |       2 |  3000 |         2019 |        101 |
|    104 | Pooja    |  45000 |       2 |  NULL |         2022 |        103 |
|    105 | Vikas    |  80000 |       3 |  7000 |         2018 |       NULL |
+--------+----------+--------+---------+-------+--------------+------------+
Note: Amit and Vikas have manager_id = NULL (they are top-level managers).
      Neha and Pooja have bonus = NULL (no bonus assigned).
*/

/* =========================================================
   1. ARITHMETIC OPERATORS (+ - * / %)
   ========================================================= */

-- Q1: Calculate total compensation (salary + bonus, treat NULL as 0)
-- How it works: salary + bonus would produce NULL for any row where bonus IS NULL,
--               because NULL + anything = NULL in SQL.
--               COALESCE(bonus, 0) returns the first non-NULL value in its argument list.
--               So COALESCE(bonus, 0) returns the actual bonus if it exists, otherwise 0.
--               salary + COALESCE(bonus, 0) then safely computes the total for all rows.
SELECT emp_name, salary + COALESCE(bonus, 0) AS total_compensation
FROM employees;
/*
Output:
+----------+--------------------+
| emp_name | total_compensation |
+----------+--------------------+
| Amit     |              75000 |
| Neha     |              60000 |
| Rahul    |              53000 |
| Pooja    |              45000 |
| Vikas    |              87000 |
+----------+--------------------+
5 rows in set
*/

-- Q2: Find employees whose salary is divisible by 5
-- How it works: % is the modulo operator — it returns the remainder after integer division.
--               salary % 5 = 0 means the salary divides evenly by 5 (no remainder).
--               All 5 salaries (70000, 60000, 50000, 45000, 80000) are multiples of 5000,
--               so every row satisfies the condition.
SELECT emp_name, salary
FROM employees
WHERE salary % 5 = 0;

/*
Output:
+----------+--------+
| emp_name | salary |
+----------+--------+
| Amit     |  70000 |
| Neha     |  60000 |
| Rahul    |  50000 |
| Pooja    |  45000 |
| Vikas    |  80000 |
+----------+--------+
5 rows in set
Note: All salaries are multiples of 1000 and therefore also of 5, so all rows match.
*/

/* =========================================================
   2. COMPARISON OPERATORS (= != <> > < >= <=)
   ========================================================= */

-- Q3: Find employees earning more than 60000
-- How it works: WHERE salary > 60000 uses the strict greater-than operator.
--               Neha earns exactly 60000 — strict > means she is excluded.
--               Amit (70000) and Vikas (80000) exceed 60000 and are returned.
SELECT emp_name, salary
FROM employees
WHERE salary > 60000;
/*
Output:
+----------+--------+
| emp_name | salary |
+----------+--------+
| Amit     |  70000 |
| Vikas    |  80000 |
+----------+--------+
2 rows in set
*/

-- Q4: Employees not working in IT department (dept_id != 1)
-- How it works: <> is the standard SQL "not equal" operator — identical to !=.
--               Rows where dept_id = 1 (Amit and Neha, both in IT) are excluded.
--               Rahul (dept_id=2, HR), Pooja (dept_id=2, HR), and Vikas (dept_id=3, Finance)
--               satisfy the condition and are returned.
SELECT emp_name
FROM employees
WHERE dept_id <> 1;
/*
Output:
+----------+
| emp_name |
+----------+
| Rahul    |
| Pooja    |
| Vikas    |
+----------+
3 rows in set
*/

/* =========================================================
   3. LOGICAL OPERATORS (AND OR NOT)
   ========================================================= */

-- Q5: Employees from IT department AND salary > 65000
-- How it works: AND requires BOTH conditions to be TRUE simultaneously.
--               Condition 1: dept_id = 1 → Amit and Neha (IT employees).
--               Condition 2: salary > 65000 → Amit (70000) ✓, Neha (60000) ✗.
--               Only Amit satisfies both conditions.
SELECT emp_name
FROM employees
WHERE dept_id = 1 AND salary > 65000;
/*
Output:
+----------+
| emp_name |
+----------+
| Amit     |
+----------+
1 row in set
*/

-- Q6: Employees from HR OR Finance
-- How it works: OR returns a row if AT LEAST ONE condition is TRUE.
--               dept_id = 2 → Rahul and Pooja (HR).
--               dept_id = 3 → Vikas (Finance).
--               Amit and Neha (dept_id=1, IT) satisfy neither and are excluded.
SELECT emp_name
FROM employees
WHERE dept_id = 2 OR dept_id = 3;
/*
Output:
+----------+
| emp_name |
+----------+
| Rahul    |
| Pooja    |
| Vikas    |
+----------+
3 rows in set
*/

-- Q7: Employees NOT receiving bonus
-- How it works: NOT bonus IS NOT NULL is logically equivalent to bonus IS NULL.
--               "bonus IS NOT NULL" is TRUE for rows that HAVE a bonus.
--               NOT inverts that — so the overall condition is TRUE for rows where bonus IS NULL.
--               Neha and Pooja have bonus = NULL → returned.
--               Amit (5000), Rahul (3000), Vikas (7000) have non-NULL bonuses → excluded.
--               Note: A simpler and clearer way to write this is: WHERE bonus IS NULL.
SELECT emp_name
FROM employees
WHERE NOT bonus IS NOT NULL;
/*
Output:
+----------+
| emp_name |
+----------+
| Neha     |
| Pooja    |
+----------+
2 rows in set
Note: WHERE NOT bonus IS NOT NULL is logically equivalent to WHERE bonus IS NULL.
      The simpler form is preferred for readability.
*/

/* =========================================================
   4. SET OPERATORS (UNION, INTERSECT, EXCEPT)
   ========================================================= */

-- Q8: Employees either in IT or earning above 75000 (UNION)
-- How it works: UNION combines the results of two SELECT statements into one result set,
--               removing duplicate rows (use UNION ALL to keep duplicates).
--               First SELECT: IT employees → Amit, Neha.
--               Second SELECT: salary > 75000 → Vikas (80000).
--               Amit appears in both sets but UNION deduplicates, so he appears once.
--               Final result: Amit, Neha, Vikas.
--               Note: UNION requires both SELECTs to have the same number of columns
--               and compatible data types.
SELECT emp_name FROM employees WHERE dept_id = 1
UNION
SELECT emp_name FROM employees WHERE salary > 75000;
/*
Output:
+----------+
| emp_name |
+----------+
| Amit     |
| Neha     |
| Vikas    |
+----------+
3 rows in set
*/

-- Q9: Employees in IT AND earning above 65000 (INTERSECT)
-- How it works: INTERSECT returns only rows that appear in BOTH result sets.
--               First SELECT: IT employees → Amit (70000), Neha (60000).
--               Second SELECT: salary > 65000 → Amit (70000), Vikas (80000).
--               Only Amit appears in both sets → returned.
--               ⚠ INTERSECT is NOT supported in MySQL 5.x or MySQL 8.0 before 8.0.31.
--               MySQL 8.0.31+ added INTERSECT support.
--               Alternative for older MySQL: use a JOIN or a subquery with IN.
SELECT emp_name FROM employees WHERE dept_id = 1
INTERSECT
SELECT emp_name FROM employees WHERE salary > 65000;
/*
Output:
+----------+
| emp_name |
+----------+
| Amit     |
+----------+
1 row in set

MySQL alternative (if INTERSECT is not supported):
SELECT emp_name FROM employees
WHERE dept_id = 1 AND salary > 65000;
*/

-- Q10: Employees in IT but NOT earning above 65000 (EXCEPT)
-- How it works: EXCEPT (also written as MINUS in Oracle) returns rows from the first
--               SELECT that do NOT appear in the second SELECT.
--               First SELECT: IT employees → Amit, Neha.
--               Second SELECT: salary > 65000 → Amit, Vikas.
--               Amit is in both sets and is therefore removed. Neha remains.
--               ⚠ EXCEPT is NOT supported in MySQL 5.x or early MySQL 8.x.
--               MySQL 8.0.31+ added EXCEPT support.
--               Alternative for older MySQL: use NOT IN or LEFT JOIN ... IS NULL.
SELECT emp_name FROM employees WHERE dept_id = 1
EXCEPT
SELECT emp_name FROM employees WHERE salary > 65000;
/*
Output:
+----------+
| emp_name |
+----------+
| Neha     |
+----------+
1 row in set

MySQL alternative (if EXCEPT is not supported):
SELECT emp_name FROM employees
WHERE dept_id = 1 AND salary <= 65000;
*/

/* =========================================================
   5. PATTERN MATCHING (LIKE, ILIKE)
   ========================================================= */

-- Q11: Employees whose name starts with 'A'
-- How it works: LIKE 'A%' matches any emp_name that starts with the letter 'A'.
--               % is a wildcard matching zero or more characters after 'A'.
--               MySQL's default collation (utf8mb4_general_ci) makes LIKE case-insensitive,
--               so 'a%' would also match. Only Amit starts with 'A' in this dataset.
SELECT emp_name
FROM employees
WHERE emp_name LIKE 'A%';
/*
Output:
+----------+
| emp_name |
+----------+
| Amit     |
+----------+
1 row in set
*/

-- Q12: Case-insensitive search for names containing 'ha'
-- How it works: LOWER(emp_name) converts the emp_name to all lowercase before comparison.
--               LIKE '%ha%' then searches for the lowercase substring 'ha' anywhere.
--               This ensures the search works correctly even in databases with
--               case-sensitive collations (e.g. utf8mb4_bin).
--               In MySQL with the default ci (case-insensitive) collation, plain LIKE '%ha%'
--               would produce the same result — LOWER() is used here for cross-database
--               compatibility (works in PostgreSQL too, where ILIKE may not be available).
--               Names containing 'ha': Neha (ne-HA), Rahul (RA-HUL → 'rah' contains 'ha') ✓.
-- PostgreSQL only:
-- WHERE emp_name ILIKE '%ha%'

-- MySQL + PostgreSQL compatible:
SELECT emp_name
FROM employees
WHERE LOWER(emp_name) LIKE '%ha%';
/*
Output:
+----------+
| emp_name |
+----------+
| Neha     |
| Rahul    |
+----------+
2 rows in set
Note: LOWER('Neha') = 'neha' → contains 'ha' ✓
      LOWER('Rahul') = 'rahul' → contains 'ha' ✓
      LOWER('Amit') = 'amit', LOWER('Pooja') = 'pooja', LOWER('Vikas') = 'vikas'
      → none contain 'ha' ✗
*/

/* =========================================================
   6. NULL CHECK (IS NULL)
   ========================================================= */

-- Q13: Employees without a manager
-- How it works: IS NULL checks whether the manager_id column holds a NULL value.
--               NULL cannot be tested with = (WHERE manager_id = NULL always returns FALSE).
--               IS NULL is the correct SQL syntax for detecting missing values.
--               Amit and Vikas have manager_id = NULL (they are top-level/senior managers).
SELECT emp_name
FROM employees
WHERE manager_id IS NULL;
/*
Output:
+----------+
| emp_name |
+----------+
| Amit     |
| Vikas    |
+----------+
2 rows in set
*/

/* =========================================================
   7. BITWISE OPERATORS (& | ^ << >>)
   ========================================================= */

-- Q14: Bitwise AND of salary and bonus (NULL treated as 0)
-- How it works: & performs a bitwise AND operation — each bit of the result is 1 only
--               if the corresponding bit in BOTH operands is also 1.
--               COALESCE(bonus, 0) safely converts NULL bonuses to 0.
--               Any value & 0 = 0 because 0 has no bits set.
--               Practical note: bitwise operators on large salary values produce results
--               that are not meaningful for business logic — this demonstrates the syntax.
SELECT emp_name, salary & COALESCE(bonus, 0) AS bitwise_and
FROM employees;
/*
Output:
+----------+-------------+
| emp_name | bitwise_and |
+----------+-------------+
| Amit     |        4096 |  -- 70000 & 5000 in binary
| Neha     |           0 |  -- 60000 & 0 (bonus is NULL, treated as 0)
| Rahul    |        2048 |  -- 50000 & 3000 in binary
| Pooja    |           0 |  -- 45000 & 0 (bonus is NULL, treated as 0)
| Vikas    |        6144 |  -- 80000 & 7000 in binary
+----------+-------------+
5 rows in set
Note: Bitwise results depend on the binary representation of each salary/bonus pair.
      These values are mathematically correct but have no real business meaning here.
      Bitwise operations are typically used with flag/permission columns, not salaries.
*/

-- Q15: Left shift salary by 1
-- How it works: << is the left-shift bitwise operator. Shifting a number left by 1 bit
--               is equivalent to multiplying it by 2 (each bit moves one position left).
--               salary << 1 effectively doubles every salary.
--               70000 << 1 = 140000, 60000 << 1 = 120000, etc.
SELECT emp_name, salary << 1 AS shifted_salary
FROM employees;
/*
Output:
+----------+----------------+
| emp_name | shifted_salary |
+----------+----------------+
| Amit     |         140000 |
| Neha     |         120000 |
| Rahul    |         100000 |
| Pooja    |          90000 |
| Vikas    |         160000 |
+----------+----------------+
5 rows in set
Note: Left-shifting by N is equivalent to multiplying by 2^N.
      salary << 1 = salary * 2^1 = salary * 2.
      salary << 2 = salary * 4, and so on.
*/

/* =========================================================
   8. CONDITIONAL OPERATOR (CASE WHEN)
   ========================================================= */

-- Q16: Categorize employees based on salary
-- How it works: The CASE expression evaluates each WHEN condition in order from top to bottom.
--               The first condition that evaluates to TRUE determines the THEN value returned.
--               If no WHEN matches, the ELSE value is returned.
--               salary >= 75000 → 'High' : only Vikas (80000) qualifies.
--               salary BETWEEN 50000 AND 74999 → 'Medium': Amit (70000), Neha (60000),
--               Rahul (50000) qualify. BETWEEN is inclusive on both ends.
--               ELSE → 'Low': Pooja (45000) falls below 50000 and hits the ELSE clause.
SELECT emp_name,
CASE
    WHEN salary >= 75000 THEN 'High'
    WHEN salary BETWEEN 50000 AND 74999 THEN 'Medium'
    ELSE 'Low'
END AS salary_category
FROM employees;
/*
Output:
+----------+-----------------+
| emp_name | salary_category |
+----------+-----------------+
| Amit     | Medium          |
| Neha     | Medium          |
| Rahul    | Medium          |
| Pooja    | Low             |
| Vikas    | High            |
+----------+-----------------+
5 rows in set
Note: Amit (70000) is Medium, not High, because 70000 < 75000.
      Rahul (50000) is Medium because BETWEEN 50000 AND 74999 is inclusive of 50000.
      Pooja (45000) is Low because 45000 < 50000 — no WHEN matches, so ELSE applies.
*/

/* =========================================================
   END OF SQL OPERATOR ASSESSMENT
   ========================================================= */
