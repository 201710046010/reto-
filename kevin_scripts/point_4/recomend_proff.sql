delimiter //
DROP FUNCTION IF EXISTS recomend_proff//
CREATE FUNCTION recomend_proff(c_id int, beg timestamp, en timestamp) RETURNS INT
 
BEGIN
DECLARE result INT DEFAULT 0;
DECLARE cat_id INT;

DECLARE vb_termina BOOL DEFAULT FALSE;

/* the category that a client c_id likes the most */
DECLARE cur1 cursor for select category.category_id from ((((rental inner join customer
on rental.customer_id = customer.customer_id and customer.customer_id = c_id) inner join inventory 
on inventory.inventory_id = rental.inventory_id) inner join film 
on film.film_id = inventory.film_id) inner join film_category
on film_category.film_id = film.film_id) inner join category
on film_category.category_id = category.category_id
where rental.rental_date between beg and en
GROUP BY customer.customer_id, category.category_id order by count(*) DESC LIMIT 0,1;



DECLARE CONTINUE HANDLER 
       FOR SQLSTATE '02000'
       SET vb_termina = TRUE;
OPEN cur1;
read_loop : LOOP
fetch cur1 into cat_id;
IF vb_termina THEN
            LEAVE read_loop;
END IF;
SET result = cat_id; 
END LOOP;
close cur1;
RETURN result;
END//

create procedure w_pelis(id int)
BEGIN
select film.title from film inner join film_category
on film.film_id = film_category.film_id
where film_category.category_id = id;
END//

call w_pelis(recomend_proff(1))