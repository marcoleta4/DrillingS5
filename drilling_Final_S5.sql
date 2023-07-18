--Crea un Customer
INSERT INTO customer (store_id, first_name, last_name, email, address_id, active) 
VALUES (1,'Ronaldo', 'Messi', 'goleador@gmail.com', 56, 1);


--Crea un Staff
INSERT INTO staff(first_name, last_name, address_id, email, store_id, username) 
VALUES ('Mia', 'Fager', 134, 'mia1992@gmail.com', 2,  'Mia');

--Crea un Actor
INSERT INTO actor(first_name, last_name) 
VALUES ('Carolina', 'Mink');


--Modifica el Customer
UPDATE customer SET active = 2  WHERE first_name = 'Ronaldo' AND last_name = 'Messi';

--Modifica el Staff
UPDATE staff SET store_id = 5  WHERE username = 'Mia';

--Modifica el Actor 
UPDATE actor SET last_name = 'Mestrovick' WHERE first_name = 'Carolina'; 

-- Listar para confirmar que los datos son correctos
SELECT * FROM customer WHERE first_name = 'Ronaldo' AND last_name = 'Messi';
SELECT * FROM staff WHERE username = 'Mia';
SELECT * FROM actor WHERE first_name = 'Carolina' AND last_name = 'Mestrovick';

--Elimina el Customer
DELETE FROM customer WHERE first_name = 'Ronaldo' AND last_name = 'Messi';
DELETE FROM staff WHERE username = 'Mia';
DELETE FROM actor WHERE first_name = 'Carolina' AND last_name = 'Mestrovick';

-- Listar de nuevo para confirmar que los datos han sido eliminados
SELECT * FROM customer WHERE first_name = 'Ronaldo' AND last_name = 'Messi';
SELECT * FROM staff WHERE username = 'Mia';
SELECT * FROM actor WHERE first_name = 'Carolina' AND last_name = 'Mestrovick';
----------------------------
--Listar todas las “rental” con los datos del “customer” dado un año y mes.
SELECT rental.rental_id, rental.rental_date, rental.return_date, customer.customer_id, customer.first_name, customer.last_name
FROM rental
INNER JOIN customer ON rental.customer_id = customer.customer_id
WHERE EXTRACT(YEAR FROM rental.rental_date) = 2005 
AND EXTRACT(MONTH FROM rental.rental_date) = 5;

--Listar Número, Fecha (payment_date) y Total (amount) de todas las “payment”.
SELECT payment_id, payment_date, amount FROM payment;

-- Listar todas las “film” del año 2006 que contengan un (rental_rate) mayor a 4.0.
SELECT * FROM film WHERE release_year = 2006 AND rental_rate > 4.0;

--Realiza un Diccionario de datos que contenga el nombre de las tablas y columnas, 
--si éstas pueden ser nulas, y su tipo de dato correspondiente.
SELECT
 t1.TABLE_NAME AS tabla_nombre,
 t1.COLUMN_NAME AS columna_nombre,
 t1.COLUMN_DEFAULT AS columna_defecto,
 t1.IS_NULLABLE AS columna_nulo,
 t1.DATA_TYPE AS columna_tipo_dato,
 COALESCE(t1.NUMERIC_PRECISION,
 t1.CHARACTER_MAXIMUM_LENGTH) AS columna_longitud,
 PG_CATALOG.COL_DESCRIPTION(t2.OID,
 t1.DTD_IDENTIFIER::int) AS columna_descripcion,
 t1.DOMAIN_NAME AS columna_dominio
FROM
 INFORMATION_SCHEMA.COLUMNS t1
 INNER JOIN PG_CLASS t2 ON (t2.RELNAME = t1.TABLE_NAME)
WHERE
 t1.TABLE_SCHEMA = 'public'
ORDER BY
 t1.TABLE_NAME;