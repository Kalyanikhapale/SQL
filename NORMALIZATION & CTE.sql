# Normalisation & CTE
USE mavenmovies;

/* Q.1 First Normal Form (1NF):
a. Identify a table in the Sakila database that violates 1NF. Explain how you would normalize it to achieve 1NF.*/

/* A table violates 1NF if it contains repeating groups or multivalued attributes.
In Sakila, the film_list view (or a hypothetical denormalized table) might contain a column like:
[ actors: 'Actor1, Actor2, Actor3' ]
This violates 1NF as it stores multiple values in a single column.

To normalize to 1NF:
Split the multivalued column into separate rows using a junction table, like:
[ film_actor (film_id, actor_id) ] */


/* Q.2 Second Normal Form (2NF):
a. Choose a table in Sakila and describe how you would determine whether it is in 2NF. If it violates 2NF, explain the steps to normalize it.*/

/* A table violates 2NF if it has a composite primary key and non-key attributes depend only on part of the key.
Example: [ film_actor (film_id, actor_id, last_update) ]
This table is in 2NF because:
- It has a composite key: (film_id, actor_id)
- last_update depends on the entire key
If any non-key column depended only on film_id or actor_id, we'd move it to a new table. */


/* Q.3 Third Normal Form (3NF):
a. Identify a table in Sakila that violates 3NF. Describe the transitive dependencies present and outline the steps to normalize the table to 3NF.*/

/* A table violates 3NF if non-key attributes depend on other non-key attributes (transitive dependency).
Hypothetical Example:
[ customer(customer_id, address_id, postal_code) ]
If postal_code can be derived from address_id, then it should not be in the customer table.
To normalize to 3NF:
Move transitive attributes like postal_code into a separate table like address */


/* Q.4  Normalization Process:
a. Take a specific table in Sakila and guide through the process of normalizing it from the initial unnormalized form up to at least 2NF*/

/* Let’s take a hypothetical unnormalized rental data:
rental_id | customer_name | customer_address | film_title | category

Step 1 - 1NF:
Split multivalued columns into atomic ones:
rental(rental_id, customer_id, film_id)
customer(customer_id, customer_name, address_id)
film(film_id, title, category_id)

Step 2 - 2NF:
Ensure every non-key attribute is fully functionally dependent on the entire primary key:
Move customer_name and customer_address into customer table
Move film_title and category into film and category tables */


/* Q.5 CTE Basics:
a. Write a query using a CTE to retrieve the distinct list of actor names and the number of films they have acted in.*/

WITH actor_film_count AS (
  SELECT a.actor_id, CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
         COUNT(fa.film_id) AS film_count
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  GROUP BY a.actor_id
)
SELECT * FROM actor_film_count;


/* Q.6 CTE with Joins:
a. Create a CTE that combines information from the film and language tables to display the film title, language name, and rental rate.*/

WITH film_language AS (
  SELECT f.title, l.name AS language_name, f.rental_rate
  FROM film f
  JOIN language l ON f.language_id = l.language_id
)
SELECT * FROM film_language;


/* Q.7 CTE for Aggregation:
a. Write a query using a CTE to find the total revenue generated by each customer (sum of payments).*/

WITH customer_revenue AS (
  SELECT customer_id, SUM(amount) AS total_revenue
  FROM payment
  GROUP BY customer_id
)
SELECT c.customer_id, c.first_name, c.last_name, cr.total_revenue
FROM customer c
JOIN customer_revenue cr ON c.customer_id = cr.customer_id;


/* Q.8 CTE with Window Functions:
a. Utilize a CTE with a window function to rank films based on their rental duration from the film table*/

WITH film_ranks AS (
  SELECT film_id, title, rental_duration,
         RANK() OVER (ORDER BY rental_duration DESC) AS duration_rank
  FROM film
)
SELECT * FROM film_ranks;


/* Q.9 CTE and Filtering:
a. Create a CTE to list customers who have made more than two rentals, and then join this CTE with the customer table to retrieve additional customer details.*/

WITH frequent_customers AS (
  SELECT customer_id, COUNT(*) AS rental_count
  FROM rental
  GROUP BY customer_id
  HAVING COUNT(*) > 2
)
SELECT c.customer_id, c.first_name, c.last_name, fc.rental_count
FROM customer c
JOIN frequent_customers fc ON c.customer_id = fc.customer_id;


/* Q.10 CTE for Date Calculations:
a. Write a query using a CTE to find the total number of rentals made each month, considering the rental_date from the rental table.*/

WITH monthly_rentals AS (
  SELECT DATE_FORMAT(rental_date, '%Y-%m') AS rental_month,
         COUNT(*) AS total_rentals
  FROM rental
  GROUP BY DATE_FORMAT(rental_date, '%Y-%m')
)
SELECT * FROM monthly_rentals;


/* Q.11 CTE and Self-Join:
a. Create a CTE to generate a report showing pairs of actors who have appeared in the same film together.*/

WITH film_actors AS (
  SELECT film_id, actor_id
  FROM film_actor
)
SELECT fa1.actor_id AS actor1, fa2.actor_id AS actor2, fa1.film_id
FROM film_actors fa1
JOIN film_actors fa2 ON fa1.film_id = fa2.film_id
WHERE fa1.actor_id < fa2.actor_id;


/* Q.12 CTE for Recursive Search:
a. Implement a recursive CTE to find all employees in the staff table who report to a specific manager, considering the reports_to column.*/

-- First, create this manually if it doesn't exist
-- CREATE TABLE staff_hierarchy (staff_id INT, first_name VARCHAR(50), reports_to INT);
DROP TABLE IF EXISTS staff_hierarchy;
CREATE TABLE staff_hierarchy (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50),
    reports_to INT
);
INSERT INTO staff_hierarchy (staff_id, first_name, reports_to) VALUES
(1, 'Manager A', NULL),
(2, 'Staff B', 1),
(3, 'Staff C', 1),
(4, 'Staff D', 2),
(5, 'Staff E', 2),
(6, 'Staff F', 3);

WITH RECURSIVE subordinates AS (
    SELECT sh.staff_id, sh.first_name, sh.reports_to
    FROM staff_hierarchy sh
    WHERE sh.staff_id = 1

    UNION ALL

    SELECT sh2.staff_id, sh2.first_name, sh2.reports_to
    FROM staff_hierarchy sh2
    JOIN subordinates s ON sh2.reports_to = s.staff_id
)
SELECT * FROM subordinates;





