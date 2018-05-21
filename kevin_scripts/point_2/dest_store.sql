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
