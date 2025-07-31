# Joins
USE mavenmovies;

/* Q.9 Display the title of the movie, customer's first name, and last name who rented it.*/
SELECT f.title, c.first_name, c.last_name
FROM rental r
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN customer c ON r.customer_id = c.customer_id;

/* Q.10 Retrieve the names of all actors who have appeared in the film "Gone with the Wind."*/
SELECT a.first_name, a.last_name
FROM actor a
JOIN film_actor fa ON a.actor_id = fa.actor_id
JOIN film f ON fa.film_id = f.film_id
WHERE f.title = 'Gone with the Wind';

/* Q.11 Retrieve the customer names along with the total amount they've spent on rentals.*/
SELECT c.first_name, c.last_name, SUM(p.amount) AS total_spent
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

/* Q.12 List the titles of movies rented by each customer in a particular city (e.g., 'London').*/
SELECT cu.first_name, cu.last_name, f.title
FROM customer cu
JOIN address a ON cu.address_id = a.address_id
JOIN city ci ON a.city_id = ci.city_id
JOIN rental r ON cu.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
WHERE ci.city = 'London';

# Advanced Joins + GROUP BY
/* Q.13 Display the top 5 rented movies along with the number of times they've been rented*/
SELECT f.title, COUNT(r.rental_id) AS rental_count
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY rental_count DESC
LIMIT 5;

/* Q.14 Determine the customers who have rented movies from both stores (store ID 1 and store ID 2)*/
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
WHERE c.customer_id IN (
    SELECT r.customer_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    WHERE i.store_id = 1
)
AND c.customer_id IN (
    SELECT r.customer_id
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    WHERE i.store_id = 2
);















