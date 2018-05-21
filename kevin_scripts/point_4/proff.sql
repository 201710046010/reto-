delimiter //
/*How much rentals every client did from beg to en (dates)*/
CREATE PROCEDURE report(beg timestamp, en timestamp)
BEGIN
select customer.customer_id,count(*) from rental inner join customer
on rental.customer_id = customer.customer_id
where rental.rental_date between beg and en
GROUP BY customer.customer_id;
END//

/* the category that a client 64 likes the most */
select customer.customer_id, category.name,count(*) from ((((rental inner join customer
on rental.customer_id = customer.customer_id and customer.customer_id = 64) inner join inventory 
on inventory.inventory_id = rental.inventory_id) inner join film 
on film.film_id = inventory.film_id) inner join film_category
on film_category.film_id = film.film_id) inner join category
on film_category.category_id = category.category_id
GROUP BY customer.customer_id, category.name order by count(*) DESC LIMIT 0,1;



