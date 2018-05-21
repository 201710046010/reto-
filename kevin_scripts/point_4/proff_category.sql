delimiter //
CREATE FUNCTION recomend_proff(c_id int) RETURNS INT	
BEGIN
DECLARE result INT DEFAULT 0;

/* the category that a client c_id likes the most */
SELECT 
    COUNT(*), category.category_id
INTO result FROM
    ((((rental
    INNER JOIN customer ON rental.customer_id = customer.customer_id
        AND customer.customer_id = c_id)
    INNER JOIN inventory ON inventory.inventory_id = rental.inventory_id)
    INNER JOIN film ON film.film_id = inventory.film_id)
    INNER JOIN film_category ON film_category.film_id = film.film_id)
        INNER JOIN
    category ON film_category.category_id = category.category_id
WHERE
    rental.rental_date BETWEEN beg AND en
GROUP BY category.category_id
ORDER BY COUNT(*) DESC
LIMIT 0 , 1;

RETURN result;
END//


select recomend_proff(64);