/* Returns minimum id */
delimiter //
CREATE FUNCTION min_a(c6 INT, c7 INT) RETURNS INT
BEGIN
	IF c7 < c6 then 
		return 7;
	ELSE
		return 6;
    END IF;
END//

/* Returns minimum id */
delimiter //
CREATE FUNCTION min_b(c3 INT, c4 INT, c5 INT) RETURNS INT
BEGIN
IF c3 < c4 then
	IF c3 < c5 then 
		return 3;
	ELSE
		return 5;
    END IF;
ELSE
	IF c4 < c5 then
		return 4;
	ELSE
		return 5;
	END IF;
END IF;
END//

delimiter //
CREATE FUNCTION dest_store(greater boolean) RETURNS INT
BEGIN
DECLARE c3, c4, c5, c6, c7 INT;
IF greater then
	SELECT COUNT(*) INTO c3 FROM store INNER JOIN customer ON customer.store_id = store. store_id
    WHERE store.store_id = 3;
	SELECT COUNT(*) INTO c4 FROM store INNER JOIN customer ON customer.store_id = store. store_id
    WHERE store.store_id = 4;
	SELECT COUNT(*) INTO c5 FROM store INNER JOIN customer ON customer.store_id = store. store_id
    WHERE store.store_id = 5;
    RETURN min_b(c3, c4,c5);
ELSE
	SELECT COUNT(*) INTO c6 FROM store INNER JOIN customer ON customer.store_id = store. store_id
    WHERE store.store_id = 6;
	SELECT COUNT(*) INTO c7 FROM store INNER JOIN customer ON customer.store_id = store. store_id
    WHERE store.store_id = 7;
    RETURN min_a(c6, c7);	
END IF;
END//

delimiter //
CREATE FUNCTION divide_client (value_c INT, cust INT) RETURNS INT
 BEGIN
	DECLARE destination_store INT default 0;
	DECLARE average INT;
    
    SELECT AVG(amount) INTO average from (payment INNER JOIN rental ON payment.rental_id = rental.rental_id) 
	INNER JOIN customer ON customer.customer_id = rental.customer_id and customer.customer_id = cust;
    
    IF average > value_c then
	-- I must modify that
	SET destination_store = dest_store(true);
    ELSE
		SET destination_store = dest_store(false);
	END IF;
    
    RETURN (destination_store);
 END//

delimiter //
/*Actually it is punto3 xD*/
DROP PROCEDURE IF EXISTS punto2//
CREATE PROCEDURE punto2(val int)
BEGIN
DECLARE id INT;
DECLARE vb_termina BOOL DEFAULT FALSE;
DECLARE dest_store INT;
DECLARE cur1 cursor for select customer.customer_id from customer;
DECLARE CONTINUE HANDLER 
       FOR SQLSTATE '02000'
       SET vb_termina = TRUE;
OPEN cur1;
read_loop : LOOP
fetch cur1 into id;
IF vb_termina THEN
            LEAVE read_loop;
END IF;
SET dest_store = divide_client(val, id); 
UPDATE customer SET customer.store_id = dest_store;
END LOOP;
close cur1;
END//