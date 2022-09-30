
##Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT c.first_name, c.last_name, c.email FROM customer AS c 
INNER JOIN rental AS r 
ON r.customer_id = c.customer_id
GROUP BY c.first_name, c.last_name, c.email ;


##What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT CONCAT(c.customer_id, ' ', c.first_name , ' ', c.last_name) name_id,  AVG(p.amount) AS avg_payment FROM customer AS c 
LEFT JOIN rental AS r 
ON r.customer_id = c.customer_id
LEFT JOIN payment AS p 
ON p.rental_id = r.rental_id
GROUP BY name_id;



##Select the name and email address of all the customers who have rented the "Action" movies.
#Write the query using multiple join statements
SELECT c.first_name, c.last_name, c.email FROM customer AS c 
LEFT JOIN rental AS r 
ON r.customer_id = c.customer_id
LEFT JOIN inventory AS i 
ON i.inventory_id = r.inventory_id
LEFT JOIN film_category AS fc
ON fc.film_id = i.film_id
LEFT JOIN category AS ct
ON ct.category_id = fc.category_id 
WHERE ct.name = 'Action'
GROUP BY c.first_name, c.last_name, c.email;





##Select the name and email address of all the customers who have rented the "Action" movies.
#Write the query using sub queries with multiple WHERE clause and IN condition
SELECT c.first_name, c.last_name, c.email FROM customer AS c 
LEFT JOIN rental AS r 
ON r.customer_id = c.customer_id
LEFT JOIN inventory AS i 
ON i.inventory_id = r.inventory_id
WHERE i.film_id IN (
SELECT f.film_id FROM film AS f 
LEFT JOIN film_category AS fc 
ON fc.film_id = f.film_id
LEFT JOIN category AS ct
ON ct.category_id = fc.category_id 
WHERE  ct.name = 'Action'
)  
GROUP BY c.first_name, c.last_name, c.email;


#Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
SELECT p.*, 
CASE WHEN p.amount BETWEEN 2 and 4 then 'Medium'
     WHEN p.amount < 2 THEN 'Low'
     ELSE 'High' 
END AS category
FROM payment AS p