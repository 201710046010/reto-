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