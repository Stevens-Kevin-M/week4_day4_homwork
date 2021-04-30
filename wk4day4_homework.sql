-- 1. List all customers who live in Texas (use JOINs)
SELECT customer.first_name, customer.last_name
FROM customer
INNER JOIN address
ON customer.address_id = address.address_id
WHERE address.district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
SELECT customer.first_name, customer.last_name, payment.payment_id, payment.amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.amount >6.99
ORDER BY customer.last_name;

-- 3. Show all customers names who have made payments over $175(use subqueries)
SELECT first_name, last_name, amount
FROM customer
INNER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE payment.customer_id IN(
	SELECT customer_id
	FROM payment
	GROUP BY customer_id
	HAVING SUM(amount)>=175
	ORDER BY SUM(amount) DESC
);

-- 4. List all customers that live in Nepal (use the city table)
SELECT first_name, last_name, address
FROM customer
JOIN address
ON customer.address_id = address.address_id
JOIN city
ON address.city_id = city.city_id
JOIN country
ON city.country_id = country.country_id
WHERE country = 'Nepal';

-- 5. Which staff member had the most transactions?
SELECT first_name, last_name, COUNT(rental_id)
FROM staff
JOIN rental
ON staff.staff_id = rental.staff_id
GROUP BY staff.staff_id
ORDER BY COUNT(rental_id) DESC 
LIMIT 1;

-- 6. How many movies of each rating are there?
SELECT rating, COUNT(rating)
FROM film
GROUP BY rating
ORDER BY COUNT(rating) DESC;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
SELECT *
FROM payment
WHERE payment.customer_id IN(
	SELECT customer_id
	FROM customer
	WHERE payment.amount > 6.99
);

-- 8. How many free rentals did our stores give away?
SELECT COUNT(rental_id)
FROM rental
WHERE rental.customer_id IN(
	SELECT customer_id
	FROM payment
	WHERE payment.amount = 0
);