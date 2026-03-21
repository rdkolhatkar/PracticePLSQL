CREATE DATABASE storage_db;
/*
Output:
Query OK, 1 row affected
*/
-- How it works: Creates a new database schema named storage_db.
--               All tables and data created afterward will live inside this schema.

USE storage_db;
/*
Output:
Database changed
*/
-- How it works: Switches the active database context to storage_db.
--               Every subsequent CREATE TABLE, INSERT, and SELECT will target this database.

CREATE TABLE products (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price DECIMAL(10, 2),
    stock INT
);
/*
Output:
Query OK, 0 rows affected
*/
-- How it works: Creates the products table with 5 columns.
--               AUTO_INCREMENT on product_id means MySQL automatically assigns the next
--               integer value (1, 2, 3 ...) each time a row is inserted without supplying
--               an explicit product_id.
--               DECIMAL(10,2) stores exact numeric values with up to 10 total digits
--               and exactly 2 digits after the decimal point — ideal for prices.

INSERT INTO products (product_name, category, price, stock) VALUES
('Laptop Pro', 'Electronics', 75000.00, 10),
('Wireless Mouse', 'Electronics', 1200.50, 50),
('Office Chair', 'Furniture', 8500.00, 15),
('Water Bottle', 'Kitchen', 350.75, 100),
('Gaming Keyboard', 'Electronics', 4500.00, 25),
('LED TV 42 Inch', 'Electronics', 32000.00, 5),
('Study Table', 'Furniture', 12000.00, 8),
('Mixer Grinder', 'Kitchen', 5500.00, 20),
('Notebook Pack', 'Stationery', 250.00, 200),
('Smart Watch', NULL, 15000.00, 0);
/*
Output:
Query OK, 10 rows affected

Resulting table:
+------------+-----------------+-------------+----------+-------+
| product_id | product_name    | category    | price    | stock |
+------------+-----------------+-------------+----------+-------+
|          1 | Laptop Pro      | Electronics | 75000.00 |    10 |
|          2 | Wireless Mouse  | Electronics |  1200.50 |    50 |
|          3 | Office Chair    | Furniture   |  8500.00 |    15 |
|          4 | Water Bottle    | Kitchen     |   350.75 |   100 |
|          5 | Gaming Keyboard | Electronics |  4500.00 |    25 |
|          6 | LED TV 42 Inch  | Electronics | 32000.00 |     5 |
|          7 | Study Table     | Furniture   | 12000.00 |     8 |
|          8 | Mixer Grinder   | Kitchen     |  5500.00 |    20 |
|          9 | Notebook Pack   | Stationery  |   250.00 |   200 |
|         10 | Smart Watch     | NULL        | 15000.00 |     0 |
+------------+-----------------+-------------+----------+-------+
10 rows in set
Note: product_id values are auto-assigned (1–10) because the column uses AUTO_INCREMENT.
      Smart Watch has category = NULL (no category was provided).
*/

-- Find the Products with price of exactly 12000
-- How it works: WHERE price = 12000 uses the equality operator (=) to match only rows
--               where the price column holds exactly the value 12000.
--               MySQL implicitly converts the integer literal 12000 to DECIMAL for comparison.
--               Only one product (Study Table, 12000.00) satisfies this condition.
SELECT * FROM products WHERE price = 12000;
/*
Output:
+------------+--------------+-----------+----------+-------+
| product_id | product_name | category  | price    | stock |
+------------+--------------+-----------+----------+-------+
|          7 | Study Table  | Furniture | 12000.00 |     8 |
+------------+--------------+-----------+----------+-------+
1 row in set
*/

-- Get all products that are not priced at 8500
-- How it works: The != (not-equal) operator excludes rows where price equals 8500.
--               Office Chair (price = 8500.00) is the only row excluded.
--               All 9 remaining rows are returned.
--               Note: != and <> are functionally identical in MySQL — both mean "not equal".
SELECT * FROM products WHERE price != 8500;
/*
Output:
+------------+-----------------+-------------+----------+-------+
| product_id | product_name    | category    | price    | stock |
+------------+-----------------+-------------+----------+-------+
|          1 | Laptop Pro      | Electronics | 75000.00 |    10 |
|          2 | Wireless Mouse  | Electronics |  1200.50 |    50 |
|          4 | Water Bottle    | Kitchen     |   350.75 |   100 |
|          5 | Gaming Keyboard | Electronics |  4500.00 |    25 |
|          6 | LED TV 42 Inch  | Electronics | 32000.00 |     5 |
|          7 | Study Table     | Furniture   | 12000.00 |     8 |
|          8 | Mixer Grinder   | Kitchen     |  5500.00 |    20 |
|          9 | Notebook Pack   | Stationery  |   250.00 |   200 |
|         10 | Smart Watch     | NULL        | 15000.00 |     0 |
+------------+-----------------+-------------+----------+-------+
9 rows in set
*/

-- How it works: <> is the standard SQL "not equal" operator — equivalent to !=.
--               Here it excludes Study Table (price = 12000.00).
--               All 9 remaining rows are returned.
SELECT * FROM products WHERE price <> 12000;
/*
Output:
+------------+-----------------+-------------+----------+-------+
| product_id | product_name    | category    | price    | stock |
+------------+-----------------+-------------+----------+-------+
|          1 | Laptop Pro      | Electronics | 75000.00 |    10 |
|          2 | Wireless Mouse  | Electronics |  1200.50 |    50 |
|          3 | Office Chair    | Furniture   |  8500.00 |    15 |
|          4 | Water Bottle    | Kitchen     |   350.75 |   100 |
|          5 | Gaming Keyboard | Electronics |  4500.00 |    25 |
|          6 | LED TV 42 Inch  | Electronics | 32000.00 |     5 |
|          8 | Mixer Grinder   | Kitchen     |  5500.00 |    20 |
|          9 | Notebook Pack   | Stationery  |   250.00 |   200 |
|         10 | Smart Watch     | NULL        | 15000.00 |     0 |
+------------+-----------------+-------------+----------+-------+
9 rows in set
*/

-- Get all products whose price is below 50000
-- How it works: WHERE price < 50000 uses the strict less-than operator.
--               Only Laptop Pro (75000.00) exceeds 50000, so it is excluded.
--               All other 9 products have prices below 50000 and are returned.
SELECT * FROM products WHERE price < 50000;
/*
Output:
+------------+-----------------+-------------+----------+-------+
| product_id | product_name    | category    | price    | stock |
+------------+-----------------+-------------+----------+-------+
|          2 | Wireless Mouse  | Electronics |  1200.50 |    50 |
|          3 | Office Chair    | Furniture   |  8500.00 |    15 |
|          4 | Water Bottle    | Kitchen     |   350.75 |   100 |
|          5 | Gaming Keyboard | Electronics |  4500.00 |    25 |
|          6 | LED TV 42 Inch  | Electronics | 32000.00 |     5 |
|          7 | Study Table     | Furniture   | 12000.00 |     8 |
|          8 | Mixer Grinder   | Kitchen     |  5500.00 |    20 |
|          9 | Notebook Pack   | Stationery  |   250.00 |   200 |
|         10 | Smart Watch     | NULL        | 15000.00 |     0 |
+------------+-----------------+-------------+----------+-------+
9 rows in set
*/

-- Get all products whose price is above 50000
-- How it works: WHERE price > 50000 uses the strict greater-than operator.
--               Only Laptop Pro (75000.00) exceeds 50000.
--               A single row is returned.
SELECT * FROM products WHERE price > 50000;
/*
Output:
+------------+--------------+-------------+----------+-------+
| product_id | product_name | category    | price    | stock |
+------------+--------------+-------------+----------+-------+
|          1 | Laptop Pro   | Electronics | 75000.00 |    10 |
+------------+--------------+-------------+----------+-------+
1 row in set
*/

/*
Important Note: Even though our DataType of 'price' field is DECIMAL and in our SQL query
we are passing the value as a plain integer literal (e.g. 12000, 8500, 50000),
MySQL automatically and implicitly converts the integer to DECIMAL before the comparison.
This implicit type coercion is safe for numeric types and produces correct results.
*/

-- Get all products priced at or above 4000
-- How it works: >= (greater-than-or-equal-to) includes rows where price equals 4000 exactly
--               as well as rows where price is higher.
--               Products at or above 4000.00:
--               Laptop Pro(75000), Office Chair(8500), Gaming Keyboard(4500),
--               LED TV 42 Inch(32000), Study Table(12000), Mixer Grinder(5500), Smart Watch(15000).
--               Wireless Mouse(1200.50), Water Bottle(350.75), Notebook Pack(250.00) are below 4000.
SELECT * FROM products WHERE price >= 4000;
/*
Output:
+------------+-----------------+-------------+----------+-------+
| product_id | product_name    | category    | price    | stock |
+------------+-----------------+-------------+----------+-------+
|          1 | Laptop Pro      | Electronics | 75000.00 |    10 |
|          3 | Office Chair    | Furniture   |  8500.00 |    15 |
|          5 | Gaming Keyboard | Electronics |  4500.00 |    25 |
|          6 | LED TV 42 Inch  | Electronics | 32000.00 |     5 |
|          7 | Study Table     | Furniture   | 12000.00 |     8 |
|          8 | Mixer Grinder   | Kitchen     |  5500.00 |    20 |
|         10 | Smart Watch     | NULL        | 15000.00 |     0 |
+------------+-----------------+-------------+----------+-------+
7 rows in set
*/

-- Get all products priced at or below 4000
-- How it works: <= (less-than-or-equal-to) returns rows where price is 4000 or lower.
--               Products at or below 4000.00:
--               Wireless Mouse(1200.50), Water Bottle(350.75), Notebook Pack(250.00).
--               Gaming Keyboard is 4500 (above 4000) and is excluded.
SELECT * FROM products WHERE price <= 4000;
/*
Output:
+------------+----------------+-------------+---------+-------+
| product_id | product_name   | category    | price   | stock |
+------------+----------------+-------------+---------+-------+
|          2 | Wireless Mouse | Electronics | 1200.50 |    50 |
|          4 | Water Bottle   | Kitchen     |  350.75 |   100 |
|          9 | Notebook Pack  | Stationery  |  250.00 |   200 |
+------------+----------------+-------------+---------+-------+
3 rows in set
*/

-- Get All Products where category is Exactly Electronics
-- How it works: WHERE category = 'Electronics' does a string equality match.
--               MySQL's default collation (utf8mb4_general_ci) is case-insensitive, so
--               'electronics', 'ELECTRONICS', and 'Electronics' would all match.
--               Smart Watch has category = NULL; NULL = 'Electronics' evaluates to NULL
--               (not TRUE), so it is excluded automatically.
--               4 products belong to the 'Electronics' category.
SELECT * FROM products WHERE category = 'Electronics';
/*
Output:
+------------+-----------------+-------------+----------+-------+
| product_id | product_name    | category    | price    | stock |
+------------+-----------------+-------------+----------+-------+
|          1 | Laptop Pro      | Electronics | 75000.00 |    10 |
|          2 | Wireless Mouse  | Electronics |  1200.50 |    50 |
|          5 | Gaming Keyboard | Electronics |  4500.00 |    25 |
|          6 | LED TV 42 Inch  | Electronics | 32000.00 |     5 |
+------------+-----------------+-------------+----------+-------+
4 rows in set
*/

-- Creating New Table called Orders
-- How it works: Creates a second table named orders with 3 columns.
--               order_id uses AUTO_INCREMENT to auto-assign sequential IDs.
--               order_date is of type DATE, which stores only the date portion (YYYY-MM-DD)
--               with no time component — suitable for tracking when an order was placed.
--               customer_name stores up to 50 characters of text.
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    order_date DATE,
    customer_name VARCHAR(50)
);
/*
Output:
Query OK, 0 rows affected
*/

INSERT INTO orders (order_date, customer_name) VALUES
('2026-01-05', 'Amit Sharma'),
('2026-01-10', 'Priya Verma'),
('2026-01-15', 'Rahul Patil'),
('2026-01-20', 'Sneha Joshi'),
('2026-01-25', 'Vikram Singh'),
('2026-02-01', 'Neha Kulkarni'),
('2026-02-05', 'Arjun Mehta'),
('2026-02-10', 'Pooja Deshmukh'),
('2026-02-15', 'Karan Malhotra'),
('2026-02-20', 'Anjali Gupta');
/*
Output:
Query OK, 10 rows affected

Resulting table:
+----------+------------+----------------+
| order_id | order_date | customer_name  |
+----------+------------+----------------+
|        1 | 2026-01-05 | Amit Sharma    |
|        2 | 2026-01-10 | Priya Verma    |
|        3 | 2026-01-15 | Rahul Patil    |
|        4 | 2026-01-20 | Sneha Joshi    |
|        5 | 2026-01-25 | Vikram Singh   |
|        6 | 2026-02-01 | Neha Kulkarni  |
|        7 | 2026-02-05 | Arjun Mehta    |
|        8 | 2026-02-10 | Pooja Deshmukh |
|        9 | 2026-02-15 | Karan Malhotra |
|       10 | 2026-02-20 | Anjali Gupta   |
+----------+------------+----------------+
10 rows in set
*/

-- Find orders which are placed before 10 FEB 2026
-- How it works: MySQL compares DATE values chronologically.
--               WHERE order_date < '2026-02-10' returns all rows whose order_date is
--               strictly earlier than February 10, 2026.
--               '2026-02-10' itself is NOT included because the operator is strict < (less than).
--               7 orders placed in January and early February qualify.
SELECT * FROM orders WHERE order_date < '2026-02-10';
/*
Output:
+----------+------------+---------------+
| order_id | order_date | customer_name |
+----------+------------+---------------+
|        1 | 2026-01-05 | Amit Sharma   |
|        2 | 2026-01-10 | Priya Verma   |
|        3 | 2026-01-15 | Rahul Patil   |
|        4 | 2026-01-20 | Sneha Joshi   |
|        5 | 2026-01-25 | Vikram Singh  |
|        6 | 2026-02-01 | Neha Kulkarni |
|        7 | 2026-02-05 | Arjun Mehta   |
+----------+------------+---------------+
7 rows in set
Note: Pooja Deshmukh (2026-02-10) is excluded because the condition is strictly less than (<),
      not less-than-or-equal (<=).
*/

/*
Important Note on String Comparison:
When comparison operators (=, <, >, !=, etc.) are used on string (VARCHAR/CHAR) columns,
MySQL compares them LEXICOGRAPHICALLY — character by character from left to right using
their character code values (similar to dictionary/alphabetical order).
The default collation in MySQL (utf8mb4_general_ci) makes string comparisons CASE-INSENSITIVE.
*/

-- How it works: WHERE product_name > 'Water Bottle' does a lexicographic (dictionary-order)
--               comparison against every product_name value.
--               The comparison is case-insensitive by default (utf8mb4_general_ci collation).
--               'W' is compared first: all names starting with letters before 'W' are excluded.
--               For names starting with 'W', the next character decides:
--               'Wireless Mouse' → 'Wi' vs 'Wa': 'i' > 'a' → YES (returned).
--               'Water Bottle' itself is excluded (strict > not >=).
--               All other names (Laptop, Office, Gaming, LED, Study, Mixer, Notebook, Smart)
--               start with letters before 'W' alphabetically and are excluded.
SELECT * FROM products WHERE product_name > 'Water Bottle'; 
/*
Output:
+------------+----------------+-------------+---------+-------+
| product_id | product_name   | category    | price   | stock |
+------------+----------------+-------------+---------+-------+
|          2 | Wireless Mouse | Electronics | 1200.50 |    50 |
+------------+----------------+-------------+---------+-------+
1 row in set
Note: Only 'Wireless Mouse' comes after 'Water Bottle' in lexicographic order.
      'Smart Watch' starts with 'S', which is before 'W', so it is excluded.
*/

-- Comparison between Strings
-- How it works: Both '100' and '2' are string literals (quoted).
--               MySQL compares them character by character (lexicographically).
--               First characters: '1' vs '2'. The ASCII value of '1' (49) < '2' (50).
--               MySQL stops here and returns TRUE (1).
--               This is NOT a numeric comparison — 100 vs 2 is never evaluated.
SELECT '100' < '2';
/*
Output:
+------------+
| '100' < '2'|
+------------+
|          1 |
+------------+
1 row in set
*/

-- How it works: Both '100' and '212' are strings.
--               Compare first character: '1' (49) < '2' (50) → TRUE immediately.
--               MySQL does not look beyond the first differing character.
--               Result: 1 (TRUE).
SELECT '100' < '212';
/*
Output:
+--------------+
| '100' < '212'|
+--------------+
|            1 |
+--------------+
1 row in set
*/

-- How it works: Compare '100' vs '102' character by character:
--               Position 1: '1' = '1' → continue.
--               Position 2: '0' = '0' → continue.
--               Position 3: '0' (48) < '2' (50) → TRUE.
--               Result: 1 (TRUE).
SELECT '100' < '102';
/*
Output:
+--------------+
| '100' < '102'|
+--------------+
|            1 |
+--------------+
1 row in set
*/

-- To treat strings as numbers, add 0 to force implicit numeric conversion
-- How it works: Adding 0 to a string forces MySQL to convert the string to a number.
--               '100' + 0 → 100 (numeric).
--               '2' + 0 → 2 (numeric).
--               Now the comparison is numeric: 100 < 2 → FALSE.
--               Result: 0 (FALSE).
SELECT '100' + 0 < '2' + 0;
/*
Output:
+--------------------+
| '100' + 0 < '2' + 0|
+--------------------+
|                  0 |
+--------------------+
1 row in set
*/

-- Comparison between String and number 
-- How it works: When comparing a number (100) with a string ('21abcdefgh'),
--               MySQL automatically converts the STRING to a number.
--               Conversion reads left-to-right until it hits a non-numeric character:
--               '21abcdefgh' → 21 (conversion stops at 'a').
--               The comparison becomes numeric: 100 < 21 → FALSE.
--               Result: 0 (FALSE).
SELECT 100 < '21abcdefgh';
/*
Output:
+--------------------+
| 100 < '21abcdefgh' |
+--------------------+
|                  0 |
+--------------------+
1 row in set
Note: MySQL raises a warning that the string value '21abcdefgh' was truncated during
      implicit conversion, but still executes the query and returns 0.
*/