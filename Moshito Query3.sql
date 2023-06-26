--		NUMERIC


--				ROUND()

-- 2do digito es cantidad de decimales
SELECT ROUND(5.73,1);

-- 2do la cantidad de digitos q deja
SELECT TRUNCATE(5.7345,2);

SELECT CEILING(5.7);

SELECT FLOOR(5.7);

SELECT ABS(-5.2);

-- random entre 0 y 1
SELECT RAND();





-- 			STRING



-- numero de chars
SELECT LENGTH('SKY');

SELECT UPPER('Sky');

SELECT LOWER('SKY');

SELECT LTRIM(' SKY ');

SELECT RTRIM(' SKY ');

SELECT TRIM(' SKY ');


SELECT LEFT('Kindergarten', 6); 	-- Kinder

SELECT RIGHT('Kindergarten', 6); 	-- garten

--				( '...', starter_pos, length (es opt) )
SELECT SUBSTRING('Kindergarten', 4, 3);


--			( lo q busco, el str), 0 si no existe
SELECT LOCATE('N', 'Kindergarten');		-- 3

--				(	...  , lo q quiero reemplazar, lo q pongo en su lugar)
SELECT REPLACE('Kindergarten', 'garten', 'garden');	 -- Kindergarden


SELECT CONCAT('Ariel', ' ', 'Godoy');




--				DATES


-- NOW()

-- current date and time
SELECT NOW();

-- current date
SELECT CURDATE();

-- current time
SELECT CURTIME();


--			p' sacar partes de fechas'

SELECT YEAR(NOW());

-- MONTH(), DAY(), HOUR(), MINUTE(), SECOND() --> retornan int


-- retornan str
SELECT DAYNAME(NOW()); -- Friday
SELECT MONTHNAME(NOW()); -- June

--				YEAR, MONTY ,DAY, ...
SELECT EXTRACT(DAY FROM NOW()); -- 2





--								DATES



-- %y año 2 digitos, %Y año entero
-- %m mes 2 digitos, %M nombre del mes
-- %d dia en num
SELECT DATE_FORMAT(NOW(), '%M %D %Y'); -- June 2nd 2023

-- h -> hora, i -> minutos, p -> p.m. o a.m
SELECT TIME_FORMAT(NOW(), '%h:%i %p');  -- 01:59 PM

SELECT TIME_FORMAT(NOW(), '%H:%i %p');  -- 14:00 PM




--		Añadir fecha
SELECT DATE_ADD(NOW(), INTERVAL 1 DAY);

SELECT DATE_ADD(NOW(), INTERVAL 1 YEAR);

-- Año pasado
SELECT DATE_ADD(NOW(), INTERVAL -1 YEAR);
-- o
SELECT DATE_SUB(NOW(), INTERVAL 1 YEAR);



-- diferencia entre fechas , devuelve solo dias
SELECT DATEDIFF('2019-01-05', '2019-01-01'); -- 4

SELECT DATEDIFF('2019-01-05', '2011-01-01'); -- 2926


-- segundos transcurridos desde la media noche
SELECT TIME_TO_SEC('01:00'); -- 3600

-- p' diferencia de tiempos
SELECT TIME_TO_SEC('09:00') - TIME_TO_SEC('09:02'); -- -120






-- 			IFNULL & COALESCE

-- algunas orders en sql_store no tiene shipper
-- p' en vez de mostrar NULL q salga 'not asigned'

-- 			IFNULL   --> si el valor es null => manda el volor especificado

USE sql_store;

SELECT order_id, IFNULL(shipper_id, 'Not asigned') AS shipper
FROM orders;

--			COALESCE() es como el terciary, 

-- ( retorna el 1ro not null )

SELECT order_id, status, shipper_id, comments, COALESCE(shipper_id, comments, 'Not asigned') AS shipper
FROM orders;





--						IF


-- p' devolver diferentes valores dependiendo de una condicion

-- IF(expression, first, second)

-- si la condicion se cumple => devuelve el 1ro, si no, el 2do

-- devolver valor "active" o "archived" de acuerdo a la fecha de la orden, si es de este año poner active

SELECT * FROM orders;

SELECT 	order_id,
		order_date,
        IF(
			YEAR(order_date) = 2019,
            'Active',
            'Archived'
        ) AS 'Category'
FROM orders;




-- crear la sig tabla
-- product_id, name, 				orders, Frequency
-- 1	Foam Dinner Plate				3	Many Times
-- 2	Pork - Bacon,back Peameal		2	Many Times
-- 3	Lettuce - Romaine, Heart		4	Many Times
-- 4	Brocolinni - Gaylan, Chinese	2	Many Times
-- 5	Sauce - Ranch Dressing			2	Many Times
-- 6	Petit Baguette					2	Many Times
-- 8	Island Oasis - Raspberry		1	Once
-- 9	Longan							1	Once
-- 10	Broom - Push					1	Once

SELECT * FROM order_items; SELECT * FROM products;

SELECT * 
FROM products
JOIN order_items USING(product_id);

SELECT 	p.product_id,
		p.name,
        COUNT(order_id) AS orders,
		IF(
			COUNT(order_id) <= 1,
            'Once',
            'Many Times'
        ) AS 'Frequency'
FROM products p
JOIN order_items oi USING(product_id)
GROUP BY p.product_id, p.name
ORDER BY p.product_id;



--		60