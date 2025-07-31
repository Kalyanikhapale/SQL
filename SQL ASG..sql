CREATE DATABASE physics_wallah;
USE physics_wallah;

/*Q.1  Create a table called employees with the following structure
 emp_id (integer, should not be NULL and should be a primary key)
 emp_name (text, should not be NULL)
 age (integer, should have a check constraint to ensure the age is at least 18)
 email (text, should be unique for each employee)
 salary (decimal, with a default value of 30,000).
 Write the SQL query to create the above table with all constraints*/
 
CREATE TABLE employees (
    emp_id INTEGER PRIMARY KEY NOT NULL,
    emp_name VARCHAR(100) NOT NULL,
    age INTEGER CHECK (age >= 18),
    email VARCHAR(255) UNIQUE,
    salary DECIMAL DEFAULT 30000
);

# Q.2  Explain the purpose of constraints and how they help maintain data integrity in a database. Provide examples of common types of constraints.
/* 
Purpose of Constraints in a Database:
Constraints are rules applied to database columns to enforce data integrity, consistency, and validity. They ensure that only valid data is entered into the database, preventing errors, duplicates, or unwanted values.
How Constraints Help Maintain Data Integrity:
1.Prevent invalid data entry
Example: Ensuring age cannot be negative.
2.Avoid duplicate records
Example: No two users can have the same email if it's marked as UNIQUE.
3.Ensure mandatory data is present
Example: Making sure names or IDs are not left blank.
4.Maintain relationships between tables
Example: Orders must belong to a valid customer (foreign key constraint).

| Constraint Type | Description                                           | Example                                                 |
| --------------- | ----------------------------------------------------- | ------------------------------------------------------- |
| **PRIMARY KEY** | Uniquely identifies each row in a table.              | `emp_id INTEGER PRIMARY KEY`                            |
| **NOT NULL**    | Ensures a column cannot have NULL values.             | `emp_name TEXT NOT NULL`                                |
| **UNIQUE**      | Ensures all values in a column are different.         | `email TEXT UNIQUE`                                     |
| **CHECK**       | Ensures values meet a specific condition.             | `age INTEGER CHECK (age >= 18)`                         |
| **DEFAULT**     | Sets a default value if none is provided.             | `salary DECIMAL DEFAULT 30000`                          |
| **FOREIGN KEY** | Ensures referential integrity between related tables. | `FOREIGN KEY (dept_id) REFERENCES departments(dept_id)` |
*/

#Q.3 Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer.
/*
Why Apply the NOT NULL Constraint?
The NOT NULL constraint is applied to a column to ensure that a value is always provided for that column — it cannot be left blank.

Reasons to use NOT NULL:
1.Data completeness: Ensures that essential data is not missing (e.g., employee name, email).
2.Enforces business rules: For example, every product must have a price, or every student must have an ID.
3.Improves reliability: Queries and applications depending on that column won't fail due to NULL values.

Can a Primary Key Contain NULL Values?
No, a primary key cannot contain NULL values.

Justification:
1.A primary key uniquely identifies each row in a table.
2.To maintain uniqueness, each row must have a non-NULL, unique value in the primary key column.
3.NULL represents "unknown" or "no value", and allowing it would violate uniqueness and identity.

Why NULL is not allowed in a Primary Key:
1.If NULL were allowed, you could insert multiple rows with NULL, violating the uniqueness requirement.
2.Relational databases (like MySQL, PostgreSQL, Oracle) automatically apply NOT NULL to a primary key column.
*/

#Q.4 Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an example for both adding and removing a constraint.
/*
To ADD a constraint:
Use ALTER TABLE with ADD CONSTRAINT.

Example - Add a CHECK constraint:
ALTER TABLE employees
ADD CONSTRAINT chk_salary CHECK (salary >= 10000);

To REMOVE a constraint:
Use ALTER TABLE with DROP CONSTRAINT or DROP CHECK (MySQL).

Example - Remove the CHECK constraint:
ALTER TABLE employees
DROP CHECK chk_salary;

Note: Constraint names can be found using:
SHOW CREATE TABLE employees;
*/

#Q.5 Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints. Provide an example of an error message that might occur when violating a constraint.
/*
If data is inserted or updated in a way that violates constraints, MySQL will raise an error.

Examples:
1. Inserting a row with age < 18 violates the CHECK constraint:
   INSERT INTO employees (emp_id, emp_name, age, email)
   VALUES (1, 'John', 16, 'john@example.com');

   ERROR 3819 (HY000): Check constraint 'employees_chk_1' is violated.

2. Inserting a duplicate email violates the UNIQUE constraint.

3. Leaving emp_name blank violates the NOT NULL constraint.

Constraints ensure data validity and consistency.
*/

#Q.6 You created a products table without constraints as follows:
 CREATE TABLE products (
 product_id INT,
 product_name VARCHAR(50),
 price DECIMAL(10, 2));
 
 /*Now, you realise that
 - The product_id should be a primary key
 - The price should have a default value of 50.00 */

ALTER TABLE products
ADD CONSTRAINT pk_products PRIMARY KEY (product_id);

ALTER TABLE products
MODIFY price DECIMAL(10, 2) DEFAULT 50.00;

/* Q7. You have two tables:
Students:
+------------+---------------+----------+
| student_id | student_name  | class_id |
+------------+---------------+----------+
|     1      | Alice         |   101    |
|     2      | Bob           |   102    |
|     3      | Charlie       |   101    |
+------------+---------------+----------+

Classes:
+----------+-------------+
| class_id | class_name  |
+----------+-------------+
|   101    | Math        |
|   102    | Science     |
|   103    | History     |
+----------+-------------+

Write a query to fetch the student_name and class_name for each student using an INNER JOIN. */
-- Create the students table
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50),
    class_id INT
);
-- Insert sample data into students
INSERT INTO students (student_id, student_name, class_id) VALUES
(1, 'Alice', 101),
(2, 'Bob', 102),
(3, 'Charlie', 101);

-- Create the classes table
CREATE TABLE classes (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50)
);
-- Insert sample data into classes
INSERT INTO classes (class_id, class_name) VALUES
(101, 'Math'),
(102, 'Science'),
(103, 'History');

-- Perform INNER JOIN to get student_name and class_name
SELECT 
    students.student_name,
    classes.class_name
FROM students
INNER JOIN classes
ON students.class_id = classes.class_id;


/*Q8. Consider the following three tables:

Orders:
+----------+------------+-------------+
| order_id | order_date | customer_id |
+----------+------------+-------------+
|    1     | 2024-01-01 |     101     |
|    2     | 2024-01-03 |     102     |

Customers:
+-------------+----------------+
| customer_id | customer_name  |
+-------------+----------------+
|    101      | Alice          |
|    102      | Bob            |

Products:
+------------+--------------+----------+
| product_id | product_name | order_id |
+------------+--------------+----------+
|     1      | Laptop        |    1     |
|     2      | Phone         |  NULL    |

Write a query that shows all order_id, customer_name, and product_name,
ensuring that all products are listed even if they are not associated with an order.

Hint: (use INNER JOIN and LEFT JOIN). */

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    order_id INT   -- This links to orders.order_id
);

INSERT INTO customers (customer_id, customer_name) VALUES
(101, 'Alice'),
(102, 'Bob');
INSERT INTO orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-01', 101),
(2, '2024-01-03', 102);
INSERT INTO products (product_id, product_name, order_id) VALUES
(1, 'Laptop', 1),
(2, 'Phone', NULL);  -- Not yet ordered

SELECT 
    products.order_id,
    customers.customer_name,
    products.product_name
FROM products
LEFT JOIN orders
    ON products.order_id = orders.order_id
LEFT JOIN customers
    ON orders.customer_id = customers.customer_id;
    
/*Q9. Given the following tables:

Sales:
+---------+-------------+--------+
| sale_id | product_id  | amount |
+---------+-------------+--------+
|    1    |     101     |  500   |
|    2    |     102     |  300   |
|    3    |     101     |  700   |

Products:
+------------+--------------+
| product_id | product_name |
+------------+--------------+
|    101     | Laptop        |
|    102     | Phone         |

Write a query to find the total sales amount for each product 
using an INNER JOIN and the SUM() function. */

-- Step 1: Create tables
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    product_id INT,
    amount DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Step 2: Insert data
INSERT INTO products (product_id, product_name) VALUES
(101, 'Laptop'),
(102, 'Phone');
INSERT INTO sales (sale_id, product_id, amount) VALUES
(1, 101, 500),
(2, 102, 300),
(3, 101, 700);

-- Step 3: Query total sales amount per product
SELECT 
    products.product_name,
    SUM(sales.amount) AS total_sales
FROM sales
INNER JOIN products
    ON sales.product_id = products.product_id
GROUP BY products.product_name;

/*Q10. You are given 3 tables:

1. Orders:
+----------+-------------+-------------+
| order_id | order_date  | customer_id |
+----------+-------------+-------------+
|    1     | 2024-01-02  |      1      |
|    2     | 2024-01-05  |      2      |

2. Customers:
+-------------+---------------+
| customer_id | customer_name |
+-------------+---------------+
|     1       | Alice         |
|     2       | Bob           |

3. Order_Details:
+----------+-------------+----------+
| order_id | product_id  | quantity |
+----------+-------------+----------+
|    1     |     101     |     2    |
|    1     |     102     |     1    |
|    2     |     101     |     3    |

Task: Write a query to display the order_id, customer_name, and the quantity of products 
ordered by each customer using an INNER JOIN between all three tables. */

-- Step 1: Create the tables
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_details (
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);

-- Step 2: Insert sample data
INSERT INTO customers (customer_id, customer_name) VALUES
(1, 'Alice'),
(2, 'Bob');

INSERT INTO orders (order_id, order_date, customer_id) VALUES
(1, '2024-01-02', 1),
(2, '2024-01-05', 2);

INSERT INTO order_details (order_id, product_id, quantity) VALUES
(1, 101, 2),
(1, 102, 1),
(2, 101, 3);

-- Step 3: Final Query using INNER JOIN
SELECT 
    orders.order_id,
    customers.customer_name,
    order_details.quantity
FROM order_details
INNER JOIN orders
    ON order_details.order_id = orders.order_id
INNER JOIN customers
    ON orders.customer_id = customers.customer_id;