# SQL COMMANDS
USE mavenmovies;


/* Q.1 Identify the primary keys and foreign keys in Maven Movies DB. Discuss the differences.*/
-- Primary Key Example:
-- film_id in the film table is a PRIMARY KEY.

-- Foreign Key Example:
-- customer.address_id is a FOREIGN KEY referencing address(address_id)

-- To view keys:
SHOW CREATE TABLE customer;

-- Difference:
-- PRIMARY KEY uniquely identifies each row in a table.
-- FOREIGN KEY is used to establish and enforce a link between the data in two tables.

/* Q.2 List all details of actors.*/
SELECT * FROM actor;

/* Q.3 List all customer information from DB.*/
SELECT * FROM customer;

/* Q.4 List different countries.*/
SELECT DISTINCT country FROM country;

/* Q.5 Display all active customers.*/
SELECT * FROM customer
WHERE active = 1;

/* Q.6 List of all rental IDs for customer with ID 1*/
SELECT rental_id FROM rental
WHERE customer_id = 1;

/* Q.7 Display all the films whose rental duration is greater than 5*/
SELECT * FROM film
WHERE rental_duration > 5;

/* Q.8 List the total number of films whose replacement cost is greater than $15 and less than $20*/
SELECT COUNT(*) AS total_films
FROM film
WHERE replacement_cost > 15 AND replacement_cost < 20;

/* Q.9 Display the count of unique first names of actors*/
SELECT COUNT(DISTINCT first_name) AS unique_first_names
FROM actor;

/*Q.10 Display the first 10 records from the customer table*/
SELECT * FROM customer
LIMIT 10;

/* Q.11 Display the first 3 records from the customer table whose first name starts with ‘b’*/
SELECT * FROM customer
WHERE first_name LIKE 'b%'
LIMIT 3;

/* Q.12 Display the names of the first 5 movies which are rated as ‘G’*/
SELECT title FROM film
WHERE rating = 'G'
LIMIT 5;

/* Q.13 Find all customers whose first name starts with "a"*/
SELECT * FROM customer
WHERE first_name LIKE 'a%';

/* Q.14 Find all customers whose first name ends with "a"*/
SELECT * FROM customer
WHERE first_name LIKE '%a';

/* Q.15 Display the list of first 4 cities which start and end with ‘a’*/
SELECT city FROM city
WHERE city LIKE 'a%' AND city LIKE '%a'
LIMIT 4;

/* Q.16 Find all customers whose first name has "NI" in any position*/
SELECT * FROM customer
WHERE first_name LIKE '%NI%';

/* Q.17 Find all customers whose first name has "r" in the second position*/
SELECT * FROM customer
WHERE first_name LIKE '_r%';

/* Q.18 Find all customers whose first name starts with "a" and are at least 5 characters in length*/
SELECT * FROM customer
WHERE first_name LIKE 'a%' AND LENGTH(first_name) >= 5;

/* Q.19 Find all customers whose first name starts with "a" and ends with "o"*/
SELECT * FROM customer
WHERE first_name LIKE 'a%o';

/* Q.20 Get the films with PG and PG-13 rating using IN operator*/
SELECT * FROM film
WHERE rating IN ('PG', 'PG-13');
 
 /* Q.21 Get the films with length between 50 to 100 using BETWEEN operator*/
SELECT * FROM film
WHERE length BETWEEN 50 AND 100;

/* Q.22 Get the top 50 actors using LIMIT operator*/
SELECT * FROM actor
LIMIT 50;

/* Q.23 Get the distinct film IDs from inventory table*/
SELECT DISTINCT film_id FROM inventory;




























