CREATE DATABASE my_database;
USE my_database;
/*
Output:
Query OK, 1 row affected
Database changed
*/

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    category VARCHAR(255),
    price DECIMAL(10, 2),
    stock_quantity INT,
    last_updated TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
/*
Output:
Query OK, 0 rows affected
*/

INSERT INTO products (product_id, product_name, category, price, stock_quantity)
VALUES
(1, 'Laptop', 'Electronics', 75000.00, 10),
(2, 'Smartphone', 'Electronics', 30000.00, 25),
(3, 'Headphones', 'Accessories', 2000.00, 50),
(4, 'Keyboard', 'Accessories', 1500.00, 40),
(5, 'Mouse', 'Accessories', 800.00, 60),
(6, 'Office Chair', 'Furniture', 7000.00, 15),
(7, 'Desk Table', 'Furniture', 12000.00, 8),
(8, 'Water Bottle', 'Home & Kitchen', 500.00, 100),
(9, 'Backpack', 'Travel', 2500.00, 30),
(10, 'Running Shoes', 'Sports', 4000.00, 20);
/*
Output:
Query OK, 10 rows affected
Note: last_updated is automatically set to CURRENT_TIMESTAMP for every row at the time of insertion.
*/

-- How it works: SELECT * retrieves all columns (*) from every row in the products table.
--               No WHERE, ORDER BY, or LIMIT clause is used, so all rows are returned in
--               the default (undefined) storage order determined by the MySQL engine.
SELECT * FROM products;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
Note: last_updated reflects the actual timestamp at the time you ran the INSERT.
*/

-- Sort products by price in ascending order
-- How it works: ORDER BY price ASC sorts all rows from the lowest price to the highest.
--               ASC (ascending) is the default direction, so writing ASC is optional.
--               The cheapest product (Water Bottle at 500.00) appears first,
--               and the most expensive (Laptop at 75000.00) appears last.
SELECT * FROM products
ORDER BY price ASC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- Sort products by stock quantity in descending order
-- How it works: ORDER BY stock_quantity DESC sorts all rows from the highest stock quantity
--               to the lowest. DESC (descending) reverses the default order.
--               Water Bottle (100 units) has the most stock and appears first;
--               Desk Table (8 units) has the least and appears last.
SELECT * FROM products
ORDER BY stock_quantity DESC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- Sort products by category only
-- How it works: ORDER BY category ASC sorts rows alphabetically by the category column.
--               Only one sort key is specified, so within the same category the row order
--               is not guaranteed — MySQL (InnoDB) typically returns them in primary-key order.
--               Categories in alphabetical order: Accessories, Electronics, Furniture,
--               Home & Kitchen, Sports, Travel.
SELECT * FROM products
ORDER BY category ASC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- Sort products by category and price
-- How it works: Multiple ORDER BY keys are separated by commas.
--               First, rows are sorted by category alphabetically (ASC by default).
--               Within the same category, rows are then sorted by price ascending (ASC default).
--               e.g., inside Accessories: Mouse(800) < Keyboard(1500) < Headphones(2000).
SELECT * FROM products
ORDER BY category, price; 
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- Sort products by category and price in descending order
-- How it works: category has no direction specified so it defaults to ASC.
--               price DESC applies ONLY to the price column, not to category.
--               Within each category, the most expensive product is listed first.
--               e.g., inside Accessories: Headphones(2000) > Keyboard(1500) > Mouse(800).
SELECT * FROM products  
ORDER BY category, price DESC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- Sort products by category in ascending order and price in descending order
-- How it works: Explicitly specifying ASC for category and DESC for price.
--               This is identical in result to the query above (ORDER BY category, price DESC)
--               since ASC is the default for category even when not written.
--               Each direction keyword (ASC/DESC) applies only to the column directly before it.
SELECT * FROM products
ORDER BY category ASC, price DESC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- Sort products by column position 
-- How it works: Instead of writing the column name, you can reference it by its position
--               in the SELECT list (1-based index). ORDER BY 3 refers to the 3rd column
--               in SELECT *, which is category. Result is identical to ORDER BY category ASC.
--               Column positions: 1=product_id, 2=product_name, 3=category, 4=price,
--               5=stock_quantity, 6=last_updated.
SELECT * FROM products
ORDER BY 3 ASC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- Sort products by column position (category is 3rd column, price is 4th column)
-- How it works: ORDER BY 3 ASC, 4 DESC is the column-position equivalent of
--               ORDER BY category ASC, price DESC. Column 3 = category, column 4 = price.
--               This produces the exact same result as the explicit column-name version.
--               Note: Using column positions is generally discouraged in production code
--               because changing SELECT column order silently changes the sort behavior.
SELECT * FROM products
ORDER BY 3 ASC, 4 DESC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- Use WHERE clause to filter products in the 'Electronics' category and sort by price
-- How it works: WHERE category = 'Electronics' first filters the result set to only rows
--               where the category is 'Electronics' (2 rows: Laptop and Smartphone).
--               ORDER BY price ASC then sorts just those filtered rows from cheapest to most expensive.
--               WHERE is always evaluated BEFORE ORDER BY.
SELECT * FROM products
WHERE category = 'Electronics'  
ORDER BY price ASC;
/*
Output:
+------------+--------------+-------------+----------+----------------+---------------------+
| product_id | product_name | category    | price    | stock_quantity | last_updated        |
+------------+--------------+-------------+----------+----------------+---------------------+
|          2 | Smartphone   | Electronics | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          1 | Laptop       | Electronics | 75000.00 |             10 | 2026-03-20 10:00:00 |
+------------+--------------+-------------+----------+----------------+---------------------+
2 rows in set
*/

-- Use case sensitive sorting to sort products by name in a case-sensitive manner
-- How it works: COLLATE utf8mb4_bin applies binary (byte-level) collation to product_name.
--               This makes the sort case-SENSITIVE: uppercase letters (A-Z, ASCII 65-90)
--               sort BEFORE lowercase letters (a-z, ASCII 97-122).
--               Since all product names here start with an uppercase letter, the result
--               looks the same as a standard alphabetical sort.
SELECT * FROM products
ORDER BY product_name COLLATE utf8mb4_bin ASC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- How it works: ORDER BY BINARY column_name casts the column to binary bytes before sorting,
--               making the comparison case-sensitive (same as utf8mb4_bin collation).
--               Note: Using BINARY as a type-cast prefix is DEPRECATED in MySQL 8.0.27+.
--               Preferred alternative: ORDER BY product_name COLLATE utf8mb4_bin ASC
SELECT * FROM products
ORDER BY binary product_name ASC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
Warning: Use of BINARY as a type cast operator is deprecated in MySQL 8.0.27+.
         Use CAST(product_name AS BINARY) or COLLATE utf8mb4_bin instead.
*/

-- Use case insensitive sorting to sort products by name in a case-insensitive manner
-- How it works: utf8mb4_general_ci is a case-INsensitive collation (ci = case insensitive).
--               'laptop' and 'Laptop' would be treated as equal during sort comparison.
--               Since all product names begin with an uppercase letter here, the result
--               is the same standard alphabetical order as the binary sort above.
SELECT * FROM products
ORDER BY product_name COLLATE utf8mb4_general_ci ASC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- Sort product name by length and sort by length of product name
-- How it works: LENGTH(product_name) calculates the number of bytes in the product name string.
--               The result is aliased as name_length, then ORDER BY name_length ASC sorts
--               products from shortest to longest name. For ties (same length), InnoDB
--               typically falls back to the primary-key order.
--               Lengths: Mouse=5, Laptop=6, Keyboard=8, Backpack=8, Headphones=10,
--               Smartphone=10, Desk Table=10, Water Bottle=12, Office Chair=12, Running Shoes=13.
SELECT product_name, LENGTH(product_name) AS name_length
FROM products
ORDER BY name_length ASC;
/*
Output:
+---------------+-------------+
| product_name  | name_length |
+---------------+-------------+
| Mouse         |           5 |
| Laptop        |           6 |
| Keyboard      |           8 |
| Backpack      |           8 |
| Smartphone    |          10 |
| Headphones    |          10 |
| Desk Table    |          10 |
| Office Chair  |          12 |
| Water Bottle  |          12 |
| Running Shoes |          13 |
+---------------+-------------+
10 rows in set
*/

-- How it works: Same as above but SELECT * returns all columns instead of just product_name
--               and the computed alias. The ORDER BY LENGTH(product_name) is evaluated per row
--               and used as the sort key; no alias is needed here since it is referenced directly.
SELECT * FROM products
ORDER BY LENGTH(product_name) ASC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- Sort products by last updated timestamp in descending order
-- How it works: ORDER BY last_updated DESC sorts rows from the most recently updated to
--               the oldest. Because all 10 products were inserted in a single multi-row
--               INSERT statement, they all share the exact same last_updated timestamp.
--               When all sort keys are equal, the order is non-deterministic (MySQL may
--               return rows in any internal order). In InnoDB, this typically falls back
--               to primary-key order. All rows are returned regardless; just the ordering
--               within the equal-timestamp group is undefined.
SELECT * FROM products
ORDER BY last_updated DESC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
Note: All timestamps are equal (single INSERT), so the row order is implementation-defined.
      The output above shows InnoDB's typical primary-key fallback order.
*/

-- Sort product By year of last updated timestamp
-- How it works: YEAR(last_updated) extracts just the year portion (e.g., 2026) from the
--               TIMESTAMP value and uses it as the sort key. Since all rows were inserted
--               in the same session, they all belong to the same year. The sort produces
--               no meaningful reordering — all year values are equal, so the output order
--               is again indeterminate (same InnoDB primary-key fallback applies).
SELECT * FROM products
ORDER BY YEAR(last_updated) DESC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
Note: All rows share the same year (2026), so ordering is non-deterministic.
*/

-- Sort by Stock quantity
-- How it works: Same as the earlier ORDER BY stock_quantity DESC query.
--               Rows are sorted from the product with the most units in stock (Water Bottle: 100)
--               down to the product with the fewest (Desk Table: 8).
SELECT * FROM products
ORDER BY stock_quantity DESC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- How it works: LIMIT 1 restricts the result to only the first row after ORDER BY is applied.
--               Combined with ORDER BY stock_quantity DESC, this returns the single product
--               with the highest stock quantity — Water Bottle with 100 units.
SELECT * FROM products
ORDER BY stock_quantity DESC LIMIT 1;
/*
Output:
+------------+--------------+----------------+--------+----------------+---------------------+
| product_id | product_name | category       | price  | stock_quantity | last_updated        |
+------------+--------------+----------------+--------+----------------+---------------------+
|          8 | Water Bottle | Home & Kitchen | 500.00 |            100 | 2026-03-20 10:00:00 |
+------------+--------------+----------------+--------+----------------+---------------------+
1 row in set
*/

-- Custom sorting and Custom ordering using FIELD function
-- How it works: FIELD(category, 'Electronics', 'Accessories', 'Furniture', 'Home & Kitchen', 'Travel', 'Sports')
--               returns the 1-based position of category in the given list.
--               Electronics=1, Accessories=2, Furniture=3, Home & Kitchen=4, Travel=5, Sports=6.
--               Rows are first sorted by this position (ASC, so our custom order is respected),
--               then within each category they are sorted by price DESC (highest price first).
--               This lets you define a completely custom category ordering that ignores alphabet.
SELECT * FROM products
ORDER BY FIELD(category, 'Electronics', 'Accessories', 'Furniture', 'Home & Kitchen', 'Travel', 'Sports'), price DESC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- Sorting by custom case statement
-- How it works: The expression (stock_quantity > 20 AND price >= 100) evaluates to 1 (TRUE)
--               or 0 (FALSE) for each row. ORDER BY ... DESC puts 1s (TRUE) first, then 0s.
--               Rows satisfying BOTH conditions (stock_quantity > 20 AND price >= 100):
--               Smartphone, Headphones, Keyboard, Mouse, Water Bottle, Backpack → group 1.
--               Rows NOT satisfying both: Laptop, Office Chair, Desk Table, Running Shoes → group 0.
--               Note: Running Shoes has stock_quantity=20, which is NOT > 20, so it goes to group 0.
SELECT * FROM products
ORDER BY (stock_quantity > 20 and price >= 100) DESC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
10 rows in set
*/

-- How it works: Same boolean expression as above but added to the SELECT clause as an
--               extra computed column. This makes the 0/1 sort value visible in the output
--               so you can clearly see which rows evaluated to TRUE (1) and which to FALSE (0).
--               The column header in MySQL will be the raw expression text.
SELECT *, stock_quantity > 20 and price >= 100 FROM products
ORDER BY (stock_quantity > 20 and price >= 100) DESC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+--------------------------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        | stock_quantity > 20 and price >= 100 |
+------------+---------------+----------------+----------+----------------+---------------------+--------------------------------------+
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |                                    1 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |                                    1 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |                                    1 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |                                    1 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |                                    1 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |                                    1 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |                                    0 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |                                    0 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |                                    0 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |                                    0 |
+------------+---------------+----------------+----------+----------------+---------------------+--------------------------------------+
10 rows in set
*/

-- ERROR QUERY (syntax errors — kept as-is per instructions, correction on next line):
-- This query has TWO critical syntax errors:
--   1. The CASE expression appears directly after FROM products instead of inside SELECT.
--   2. There are two ELSE clauses (ELSE 4 and ELSE 0), which is not valid SQL.
SELECT *, stock_quantity > 20 and price >= 100 FROM products
CASE
    WHEN stock_quantity > 20 AND price >= 100 THEN 1
    WHEN stock_quantity > 20 AND price < 100 THEN 2
    WHEN stock_quantity <= 20 AND price >= 100 THEN 3
    ELSE 4
    ELSE 0
END AS high_stock_and_price;
/*
Output:
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds
to your MySQL server version for the right syntax to use near 'CASE WHEN stock_quantity > 20
AND price >= 100 THEN 1 ...' at line 2
*/
-- CORRECTION: The CASE expression must be placed inside the SELECT clause (not after FROM),
--             and only ONE ELSE clause is allowed per CASE block.
--             Corrected query with ORDER BY added to make the sort intention explicit:
SELECT *, CASE
    WHEN stock_quantity > 20 AND price >= 100 THEN 1
    WHEN stock_quantity > 20 AND price < 100 THEN 2
    WHEN stock_quantity <= 20 AND price >= 100 THEN 3
    ELSE 4
END AS high_stock_and_price
FROM products
ORDER BY high_stock_and_price;
/*
Corrected Output:
+------------+---------------+----------------+----------+----------------+---------------------+--------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        | high_stock_and_price |
+------------+---------------+----------------+----------+----------------+---------------------+--------------------+
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |                  1 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |                  1 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |                  1 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |                  1 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |                  1 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |                  1 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |                  3 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |                  3 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |                  3 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |                  3 |
+------------+---------------+----------------+----------+----------------+---------------------+--------------------+
10 rows in set
Note: Priority 2 (stock>20 AND price<100) and Priority 4 (ELSE) produce 0 rows here because
      all products have prices >= 500, which is always >= 100.
*/

-- How it works: A CASE expression inside SELECT acts like an if-else chain evaluated per row.
--               Each WHEN condition is checked in order; the first matching THEN value is used.
--               The ELSE provides a fallback when no WHEN matches.
--               The ORDER BY CASE block (same logic) sorts rows by the computed priority number
--               so priority 1 rows come first, then 2, 3, and 4 last.
--               Priority 1 (High Stock and Price): stock_quantity > 20 AND price >= 100 — 6 rows.
--               Priority 2 (High Stock and Low Price): stock_quantity > 20 AND price < 100 — 0 rows.
--               Priority 3 (Low Stock and High Price): stock_quantity <= 20 AND price >= 100 — 4 rows.
--               Priority 4 (ELSE / Low Stock and Low Price): 0 rows (all prices are >= 500).
SELECT *, CASE
WHEN stock_quantity > 20 AND price >= 100 THEN 'High Stock and Price'
WHEN stock_quantity > 20 AND price < 100 THEN 'High Stock and Low Price'
WHEN stock_quantity <= 20 AND price >= 100 THEN 'Low Stock and High Price'
ELSE 'Low Stock and Low Price'
END AS priority FROM products
ORDER BY
CASE
WHEN stock_quantity > 20 AND price >= 100 THEN 1
WHEN stock_quantity > 20 AND price < 100 THEN 2
WHEN stock_quantity <= 20 AND price >= 100 THEN 3
ELSE 4
END;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+--------------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        | priority                 |
+------------+---------------+----------------+----------+----------------+---------------------+--------------------------+
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 | High Stock and Price     |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 | High Stock and Price     |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 | High Stock and Price     |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 | High Stock and Price     |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 | High Stock and Price     |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 | High Stock and Price     |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 | Low Stock and High Price |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 | Low Stock and High Price |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 | Low Stock and High Price |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 | Low Stock and High Price |
+------------+---------------+----------------+----------+----------------+---------------------+--------------------------+
10 rows in set
Note: Priority 2 (High Stock and Low Price) and Priority 4 (Low Stock and Low Price) have
      0 matching rows because every product has price >= 500.00 (which is always >= 100).
      Running Shoes has stock_quantity = 20, which is NOT > 20, so it goes to priority 3.
*/

-- Handling null values in sorting
-- How it works: Inserting a row with NULL for product_name, price, and stock_quantity.
--               The last_updated column is auto-filled via DEFAULT CURRENT_TIMESTAMP.
--               NULL means "unknown / missing value" and behaves specially in comparisons and sorts.
INSERT INTO products (product_id, product_name, category, price, stock_quantity)
VALUES (11, NULL, 'Miscellaneous', NULL, NULL); 
/*
Output:
Query OK, 1 row affected
Note: product_id=11 now exists with product_name=NULL, price=NULL, stock_quantity=NULL.
      last_updated is auto-set to the current timestamp at insertion time.
*/

-- How it works: In MySQL, NULL values are treated as LOWER than any non-NULL value for
--               sorting purposes. With ORDER BY price ASC, NULLs therefore appear FIRST
--               (at the "lowest" end). The remaining 10 rows are sorted 500 → 75000.
SELECT * FROM products
ORDER BY price ASC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|         11 | NULL          | Miscellaneous  |     NULL |           NULL | 2026-03-20 10:05:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
11 rows in set
*/

-- ERROR QUERY — NULLS FIRST is not valid MySQL syntax (kept as-is, correction on next line):
SELECT * FROM products
ORDER BY price ASC NULLS FIRST;
/*
Output:
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds
to your MySQL server version for the right syntax to use near 'NULLS FIRST' at line 2.
Note: NULLS FIRST / NULLS LAST syntax is supported in PostgreSQL and Oracle but NOT in MySQL.
*/
-- CORRECTION: To force NULLs to appear first in MySQL, use ISNULL() as a sort key.
--             ISNULL(price) returns 1 when price IS NULL, 0 otherwise.
--             Sorting ISNULL(price) DESC puts 1s (NULLs) first, then 0s (non-NULLs) sorted ASC.
SELECT * FROM products ORDER BY ISNULL(price) DESC, price ASC;
/*
Corrected Output (NULLs first):
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|         11 | NULL          | Miscellaneous  |     NULL |           NULL | 2026-03-20 10:05:00 |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
11 rows in set
*/

-- ERROR QUERY — NULLS LAST is not valid MySQL syntax (kept as-is, correction on next line):
SELECT * FROM products
ORDER BY price ASC NULLS LAST;
/*
Output:
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds
to your MySQL server version for the right syntax to use near 'NULLS LAST' at line 2.
Note: NULLS FIRST / NULLS LAST syntax is supported in PostgreSQL and Oracle but NOT in MySQL.
*/
-- CORRECTION: To force NULLs to appear LAST in MySQL, sort ISNULL(price) ASC.
--             ISNULL(price) ASC puts 0s (non-NULLs) first and 1s (NULLs) last.
SELECT * FROM products ORDER BY ISNULL(price) ASC, price ASC;
/*
Corrected Output (NULLs last):
+------------+---------------+----------------+----------+----------------+---------------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        |
+------------+---------------+----------------+----------+----------------+---------------------+
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 |
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 |
|         11 | NULL          | Miscellaneous  |     NULL |           NULL | 2026-03-20 10:05:00 |
+------------+---------------+----------------+----------+----------------+---------------------+
11 rows in set
*/

-- Sorting based on price * stock quantity
-- How it works: price * stock_quantity is a computed expression evaluated per row and
--               aliased as total_value (the total inventory value for that product).
--               ORDER BY total_value DESC shows the highest-value inventory items first.
--               For the NULL row (product_id=11), NULL * NULL = NULL, so total_value is NULL.
--               In MySQL, NULLs sort as LOWER than any value, so with DESC they appear LAST.
--               Laptop and Smartphone both have total_value = 75000 * 10 = 750000 and
--               30000 * 25 = 750000 — a tie, resolved by InnoDB's primary-key order.
SELECT *, price * stock_quantity AS total_value
FROM products   
ORDER BY total_value DESC;
/*
Output:
+------------+---------------+----------------+----------+----------------+---------------------+-------------+
| product_id | product_name  | category       | price    | stock_quantity | last_updated        | total_value |
+------------+---------------+----------------+----------+----------------+---------------------+-------------+
|          1 | Laptop        | Electronics    | 75000.00 |             10 | 2026-03-20 10:00:00 | 750000.00   |
|          2 | Smartphone    | Electronics    | 30000.00 |             25 | 2026-03-20 10:00:00 | 750000.00   |
|          6 | Office Chair  | Furniture      |  7000.00 |             15 | 2026-03-20 10:00:00 | 105000.00   |
|          3 | Headphones    | Accessories    |  2000.00 |             50 | 2026-03-20 10:00:00 | 100000.00   |
|          7 | Desk Table    | Furniture      | 12000.00 |              8 | 2026-03-20 10:00:00 |  96000.00   |
|         10 | Running Shoes | Sports         |  4000.00 |             20 | 2026-03-20 10:00:00 |  80000.00   |
|          9 | Backpack      | Travel         |  2500.00 |             30 | 2026-03-20 10:00:00 |  75000.00   |
|          4 | Keyboard      | Accessories    |  1500.00 |             40 | 2026-03-20 10:00:00 |  60000.00   |
|          8 | Water Bottle  | Home & Kitchen |   500.00 |            100 | 2026-03-20 10:00:00 |  50000.00   |
|          5 | Mouse         | Accessories    |   800.00 |             60 | 2026-03-20 10:00:00 |  48000.00   |
|         11 | NULL          | Miscellaneous  |     NULL |           NULL | 2026-03-20 10:05:00 |        NULL |
+------------+---------------+----------------+----------+----------------+---------------------+-------------+
11 rows in set
*/

-- explain command to understand the sorting process
-- How it works: EXPLAIN shows MySQL's query execution plan without running the actual query.
--               Key columns to watch:
--               - type: how MySQL reads the table. 'ALL' = full table scan (no index used).
--               - key: which index MySQL chose. NULL means no index is being used.
--               - rows: estimated number of rows MySQL will examine.
--               - Extra: additional info. 'Using filesort' means MySQL must do an extra
--                 sorting pass in memory (or on disk) because no suitable index exists for
--                 the ORDER BY column (price has no index, so filesort is required).
EXPLAIN SELECT * FROM products
ORDER BY price ASC;
/*
Output:
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
|  1 | SIMPLE      | products | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   11 |   100.00 | Using filesort |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
1 row in set
Explanation:
  type=ALL     → Full table scan: MySQL reads every row in the table.
  key=NULL     → No index used (price column has no index).
  rows=11      → MySQL estimates examining all 11 rows.
  Using filesort → MySQL performs an additional sort step since no index covers ORDER BY price.
*/

-- How it works: Sorting by product_id (the PRIMARY KEY). MySQL can use the primary-key
--               index (the InnoDB clustered index) to return rows in product_id order
--               without any extra sorting step. The EXPLAIN confirms this with type=index
--               and key=PRIMARY, and Extra shows no 'Using filesort'.
EXPLAIN SELECT * FROM products ORDER BY product_id;
/*
Output:
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-------+
| id | select_type | table    | partitions | type  | possible_keys | key     | key_len | ref  | rows | filtered | Extra |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-------+
|  1 | SIMPLE      | products | NULL       | index | NULL          | PRIMARY | 4       | NULL |   11 |   100.00 | NULL  |
+----+-------------+----------+------------+-------+---------------+---------+---------+------+------+----------+-------+
1 row in set
Explanation:
  type=index   → MySQL scans the PRIMARY KEY index in order (no full heap scan needed).
  key=PRIMARY  → The PRIMARY KEY index (product_id) is used for traversal.
  key_len=4    → 4 bytes, matching INT (4-byte integer) primary key.
  Extra=NULL   → No 'Using filesort' — rows are already in the correct order via the index.
*/

-- How it works: EXPLAIN for a query that sorts by a computed CASE expression.
--               Because the ORDER BY key is a runtime expression (not a stored indexed column),
--               MySQL has no index it can use. It must scan the full table, compute the CASE
--               result for every row, then sort those values — shown as 'Using filesort'.
EXPLAIN SELECT *, CASE
WHEN stock_quantity > 20 AND price >= 100 THEN 'High Stock and Price'
WHEN stock_quantity > 20 AND price < 100 THEN 'High Stock and Low Price'
WHEN stock_quantity <= 20 AND price >= 100 THEN 'Low Stock and High Price'
ELSE 'Low Stock and Low Price'
END AS priority FROM products
ORDER BY
CASE
WHEN stock_quantity > 20 AND price >= 100 THEN 1
WHEN stock_quantity > 20 AND price < 100 THEN 2
WHEN stock_quantity <= 20 AND price >= 100 THEN 3
ELSE 4
END;
/*
Output:
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
| id | select_type | table    | partitions | type | possible_keys | key  | key_len | ref  | rows | filtered | Extra          |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
|  1 | SIMPLE      | products | NULL       | ALL  | NULL          | NULL | NULL    | NULL |   11 |   100.00 | Using filesort |
+----+-------------+----------+------------+------+---------------+------+---------+------+------+----------+----------------+
1 row in set
Explanation:
  type=ALL     → Full table scan: every row must be read to evaluate the CASE expression.
  key=NULL     → No index can help with a computed CASE sort key.
  rows=11      → All 11 rows examined.
  Using filesort → MySQL must compute the CASE priority for each row and then sort,
                   since there is no pre-built index for this runtime expression.
*/