-- ============================================================================
-- Problem: Display the highest paid employee in each department.
--
-- Note: No tables were provided with the question, so the classic
-- "Employee" / "Department" schema is assumed below with sample data.
-- ============================================================================


-- ============================================================================
-- ORIGINAL TABLES (input data)
-- ============================================================================
--
-- Table: Employee
-- +----+-------+--------+--------------+
-- | id | name  | salary | departmentId |
-- +----+-------+--------+--------------+
-- | 1  | Joe   | 70000  | 1            |
-- | 2  | Henry | 80000  | 2            |
-- | 3  | Sam   | 60000  | 2            |
-- | 4  | Max   | 90000  | 1            |
-- | 5  | Janet | 69000  | 1            |
-- | 6  | Randy | 85000  | 1            |
-- | 7  | Will  | 70000  | 1            |
-- +----+-------+--------+--------------+
--
-- Table: Department
-- +----+-------+
-- | id | name  |
-- +----+-------+
-- | 1  | IT    |
-- | 2  | Sales |
-- +----+-------+


-- ============================================================================
-- SOLUTION QUERY
-- ============================================================================

-- Step 1 (inner subquery "m"):
--   Group the Employee rows by departmentId and take MAX(salary) for each
--   group. This gives the top salary per department:
--       departmentId | max_salary
--       1            | 90000       (IT)
--       2            | 80000       (Sales)
--
-- Step 2 (JOIN with "m"):
--   Join Employee (e) to that subquery on BOTH the department and the salary.
--   Only employees whose salary equals their department's max survive.
--   Using the salary match (not just the department) is what makes this
--   return the top earner rather than every employee.
--
-- Step 3 (JOIN with Department "d"):
--   Replace departmentId with the readable department name.
--
-- Step 4 (SELECT + ORDER BY):
--   Pick the columns to display, with aliases, and sort by department name.
--
-- Tie note: if two employees in the same department share the max salary,
-- both are returned, which is usually the desired behaviour.

SELECT
    d.name      AS Department,
    e.name      AS Employee,
    e.salary    AS Salary
FROM Employee AS e
JOIN (
    SELECT departmentId, MAX(salary) AS max_salary
    FROM Employee
    GROUP BY departmentId
) AS m
    ON  e.departmentId = m.departmentId
    AND e.salary       = m.max_salary
JOIN Department AS d
    ON  d.id = e.departmentId
ORDER BY d.name;


-- ============================================================================
-- EXPECTED OUTPUT
-- ============================================================================
--
-- +------------+----------+--------+
-- | Department | Employee | Salary |
-- +------------+----------+--------+
-- | IT         | Max      | 90000  |
-- | Sales      | Henry    | 80000  |
-- +------------+----------+--------+
--
-- Explanation of the output:
--   * IT    : Max earns 90000, the highest salary among IT employees
--             (Joe 70000, Max 90000, Janet 69000, Randy 85000, Will 70000).
--   * Sales : Henry earns 80000, higher than Sam's 60000.
--   * Joe, Janet, Randy, Will and Sam are not shown because they are not
--     the highest paid in their department.

-- ============================================================================
-- Problem: Display the highest paid employee in each department.
--
-- This version uses ONE table that stores the department number, salary and
-- employee name together.
-- ============================================================================


-- ============================================================================
-- ORIGINAL TABLE (input data)
-- ============================================================================
--
-- Table: Employee
-- +---------------+--------+---------------+
-- | Department_NO | Salary | Employee_name |
-- +---------------+--------+---------------+
-- | 1             | 70000  | Joe           |
-- | 2             | 80000  | Henry         |
-- | 2             | 60000  | Sam           |
-- | 1             | 90000  | Max           |
-- | 1             | 69000  | Janet         |
-- | 1             | 85000  | Randy         |
-- | 1             | 70000  | Will          |
-- +---------------+--------+---------------+


-- ============================================================================
-- SOLUTION QUERY
-- ============================================================================

-- Step 1 (inner subquery "m"):
--   Group the rows by Department_NO and take MAX(Salary) for each group.
--   This gives the top salary in each department:
--       Department_NO | max_salary
--       1             | 90000
--       2             | 80000
--
-- Step 2 (self-join "e" with "m"):
--   Since everything is in one table, we join the table to its own aggregated
--   result. A row from "e" is kept only if its Department_NO AND Salary both
--   match a row in "m", so only the top earner in each department remains.
--
-- Step 3 (SELECT + ORDER BY):
--   Show the department, the employee name and the salary, sorted by
--   department number.
--
-- Tie note: if two employees in a department share the top salary, both are
-- returned.

SELECT
    e.Department_NO,
    e.Employee_name,
    e.Salary
FROM Employee AS e
JOIN (
    SELECT Department_NO, MAX(Salary) AS max_salary
    FROM Employee
    GROUP BY Department_NO
) AS m
    ON  e.Department_NO = m.Department_NO
    AND e.Salary        = m.max_salary
ORDER BY e.Department_NO;


-- ============================================================================
-- EXPECTED OUTPUT
-- ============================================================================
--
-- +---------------+---------------+--------+
-- | Department_NO | Employee_name | Salary |
-- +---------------+---------------+--------+
-- | 1             | Max           | 90000  |
-- | 2             | Henry         | 80000  |
-- +---------------+---------------+--------+
--
-- Explanation of the output:
--   * Department 1: Max earns 90000, the highest salary in that department.
--   * Department 2: Henry earns 80000, higher than Sam's 60000.
--   * Joe, Janet, Randy, Will and Sam are excluded because they are not the
--     highest paid in their department.