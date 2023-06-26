--		NUMERIC


--				ROUND()

-- 2do digito es cantidad de decimales
SELECT ROUND(5.73,1);

-- no en sql server
-- 2do la cantidad de digitos q deja
-- SELECT TRUNCATE(5.7345,2);

SELECT CEILING(5.7);

SELECT FLOOR(5.7);

SELECT ABS(-5.2);

-- random entre 0 y 1
SELECT RAND();



-- 			STRING



-- numero de chars
SELECT LEN('SKY');

SELECT UPPER('Sky');

SELECT LOWER('SKY');

SELECT LTRIM(' SKY ');

SELECT RTRIM(' SKY ');

SELECT TRIM(' SKY ');


SELECT LEFT('Kindergarten', 6); 	-- Kinder

SELECT RIGHT('Kindergarten', 6); 	-- garten

--				( '...', starter_pos, length (es opt) )
SELECT SUBSTRING('Kindergarten', 4, 3);	-- der


--			( lo q busco, el str), 0 si no existe
SELECT CHARINDEX('N', 'Kindergarten');		-- 3

--				(	...  , lo q quiero reemplazar, lo q pongo en su lugar)
SELECT REPLACE('Kindergarten', 'garten', 'garden');	 -- Kindergarden


SELECT CONCAT('Ariel', ' ', 'Godoy');








--				DATES


-- NOW()

-- current date and time
SELECT GETDATE(); -- 2023-06-25 00:04:45.370

-- current date
select CONVERT (date, GETDATE());  -- 2023-06-25

-- current time
select CONVERT (time, GETDATE());  -- 00:05:20.3833333


--			p' sacar partes de fechas'

SELECT YEAR(GETDATE());
SELECT DAY(GETDATE());

-- MONTH(), DAY(), HOUR(), MINUTE(), SECOND() --> retornan int



SELECT
  FORMAT(CAST('2022-01-01' AS DATE), 'ddd'); -- Sat
SELECT
  FORMAT(CAST('2022-04-01' AS DATE), 'dddd'); -- Saturday

SELECT DATENAME(MONTH, '2022-01-01'); -- January
SELECT DATENAME(WEEKDAY, '2022-01-01'); -- Saturday






SELECT FORMAT (getdate(), 'dd/MM/yyyy ') as date --	21/03/2021
SELECT FORMAT (getdate(), 'dd/MM/yyyy, hh:mm:ss ') as date --	21/03/2021, 11:36:14
SELECT FORMAT (getdate(), 'dddd, MMMM, yyyy') as date --	Wednesday, March, 2021
SELECT FORMAT (getdate(), 'MMM dd yyyy') as date --	Mar 21 2021
SELECT FORMAT (getdate(), 'MM.dd.yy') as date --	03.21.21
SELECT FORMAT (getdate(), 'MM-dd-yy') as date --	03-21-21
SELECT FORMAT (getdate(), 'hh:mm:ss tt') as date --	11:36:14 AM
SELECT FORMAT (getdate(), 'd','us') as date --	03/21/2021
SELECT FORMAT (getdate(), 'yyyy-MM-dd hh:mm:ss tt') as date --	2021-03-21 11:36:14 AM
SELECT FORMAT (getdate(), 'yyyy.MM.dd hh:mm:ss t') as date --	2021.03.21 11:36:14 A
SELECT FORMAT (getdate(), 'dddd, MMMM, yyyy','es-es') as date -- Spanish	domingo, marzo, 2021




SELECT DATEADD(month, 1, getdate()) as query1; 
SELECT DATEADD(month, 1, '2022-07-26') as query2;


-- add 10 days to August 1, 2022 
SELECT DATEADD(DD, 10, '2022-08-01') as query1; 


DECLARE @datetime datetime;  
SET @datetime = getdate()
   
SELECT DATEADD(hour,23,@datetime);  
SELECT DATEADD(minute,59,@datetime);
SELECT DATEADD(second,59,@datetime); 
SELECT DATEADD(day,365,@datetime); 
SELECT DATEADD(month,13,@datetime); 
SELECT DATEADD(quarter,4,@datetime); 
SELECT DATEADD(week,5,@datetime);  
SELECT DATEADD(dayofyear,365,@datetime); 
SELECT DATEADD(weekday,31,@datetime);




--					**********

--			ISNULL				TENGO Q DEVOLVEL EL MISMO TIPO

-- algunas orders en sql_store no tiene shipper
-- p' en vez de mostrar NULL q salga 'not asigned'

-- 			ISNULL   --> si el valor es null => manda el volor especificado

USE sql_store;

SELECT * FROM orders;

-- con isnull o case darian lo mismo
SELECT order_id, 
       ISNULL(shipper_id, -1), 
       shipper_id,
       CASE
           WHEN shipper_id IS NULL
           THEN -1
           ELSE shipper_id
       END AS 'shipper name'
FROM orders;

-- haciendo un cast puedo ocupar otro tipo
SELECT order_id, 
       shipper_id, 
       ISNULL(CAST(shipper_id AS VARCHAR), 'Not asigned')
FROM orders;



--									COALESCE
-- devuelve el primero not null
-- The data types of the expressions must be the same
-- con otros tipos TENGO q hacer el cast

SELECT order_id, 
       STATUS, 
       shipper_id, 
       comments, 
       COALESCE(CAST(shipper_id AS VARCHAR), comments, 'Not asigned') AS shipper
FROM orders;








--						IF  


-- In SQL Server there is an IF…ELSE control flow statement. However, it cannot be used inside a SELECT statement





