delimiter //
delimiter //
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