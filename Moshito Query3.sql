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

-- MONTH(), DAY(), HOUR(), MINUTE(), SECOND() --> retornan enteros


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
-- si el 1ro es true => devuelve este, sino, el 2do
-- si el 2do tb es null => pasa el tercero
-- ( retorna el 1ro not null )
SELECT order_id,status,shipper_id, COALESCE(shipper_id, comments, 'Not asigned') AS shipper
FROM orders;















--		59