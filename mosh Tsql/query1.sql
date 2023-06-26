
USE sql_store;

SELECT *
FROM customers
ORDER BY first_name;

-- nacidos despues de 1990

SELECT first_name, 
       last_name, 
       YEAR(birth_date) AS año
FROM customers;

-- ordenes puestas este ano
SELECT *
FROM orders
WHERE YEAR(order_date) = '2019';

--
--
--
--
--				AND OR
-- primero se evaluan los AND y luego los OR

SELECT *
FROM customers
WHERE birth_date > '1990-01-01'
      OR points > 1000
      AND state = 'VA';

-- es 
SELECT *
FROM customers
WHERE birth_date > '1990-01-01'
      OR (points > 1000
          AND state = 'VA');

--
--
--
--
--     			 NOT
SELECT *
FROM customers
WHERE NOT(birth_date > '1990-01-01'
          OR points > 1000);

-- es (	niega el or y los; signos )
SELECT *
FROM customers
WHERE birth_date <= '1990-01-01'
      AND points <= 1000;
	  
--
--
--
--
-- from the order_items table, get the items
-- for order #6, where the total price is greater than 30

SELECT *, 
       (quantity * unit_price) AS total_price
FROM order_items
WHERE order_id = 6
      AND (quantity * unit_price > 30);

	  
--
--
--
--

-- 					IN

-- customer q vivan en virginia 'VA', georgia 'GA' o florida 'FL'
USE sql_store;

SELECT *
FROM customers
WHERE state IN('va', 'ga', 'fl');
-- NO puede ser 
-- WHERE state = 'VA' OR 'GA' OR 'FL'
-- xq el OR es para combinar expresiones


--
--
--
--
--					BETWEEN

SELECT *
FROM customers
WHERE points >= 1000
      AND points <= 3000;

SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;



--
--
--
--
-- 				% y _
-- % cantidad indeterminada de caracteres
-- _ un caracter, varios _ para 2do o 3er ... caracter

-- clientes con apellido con segunda letra o

SELECT *
FROM customers
WHERE last_name LIKE '_o%';

--
--
--
-- clientes cuyo telefono termine en 9

SELECT *
FROM customers
--WHERE RIGHT(phone, 1) = 9;
WHERE phone LIKE '%9';


--
--
--
--

-- 					REGEXP

-- starting with character A or L --> like '[AL]%'

-- first character A and second character L --> like '[A][L]%'
-- starting characters [All] together --> like '[A][L][L]%'

-- starting character between A and D --> like '[A-D]%'

-- The first character should be from A and D alphabets
-- The second character should be from F and L alphabet --> like '[A-D][F-I]%'

-- ending character between G and S --> like '%[G-S]'

-- starting letters AF and ending character S --> like '[A][F]%[S]'

-- starting letters excluding A to T --> like '[^A-T]%'





--
--
-- clientes q contengan "field" en el last_name


SELECT *
FROM customers
-- WHERE last_name LIKE '%field%'
WHERE last_name LIKE '%FIELD%';

--
--



-- last_name empiezan con b
USE sql_store;

SELECT *
FROM customers
WHERE last_name LIKE '[b]%';



-- last_name termina con y
SELECT *
FROM customers
WHERE last_name LIKE '%[y]';



-- /\b(?:one|two|three)\b/gi

-- q tengan "field" o "mac" o "rose" en el apellido
SELECT *
FROM customers
WHERE last_name LIKE '%field%'
      OR last_name LIKE '%mac%'
      OR last_name LIKE '%rose%';


-- q empiecen con "mac" o "rose"
SELECT *
FROM customers
WHERE last_name LIKE 'mac%'
      OR last_name LIKE 'rose%';


-- lastname q tengan una "i" o "g" seguida de una "e"
SELECT *
FROM customers
WHERE last_name LIKE '%[ig][e]%';



--
--
--
--
--  		TOP 
-- me entrega solo esa cantidad ( depende de como esten sorteados )


-- los 3 customers con mas puntos

SELECT *
FROM customers
ORDER BY points DESC;

SELECT TOP 3 *
FROM customers
ORDER BY points DESC;



--
--
--				OFFSET	FETCH (LIMIT mySql)

-- OFFSET número de filas que se salta
-- FETCH numero de filas que agarra (opcional)

-- para q se salte los 5 primeros

SELECT *
FROM customers
ORDER BY points DESC;

SELECT *
FROM customers
ORDER BY points DESC
OFFSET 5 ROWS;

-- para q se salte los 5 primeros y SOLO LOS 2 Q SIGUEN
SELECT *
FROM customers
ORDER BY points DESC
OFFSET 5 ROWS FETCH NEXT 2 ROWS ONLY;


--
--
--
--
--            WITH TIES
-- Básicamente cuando incluyes la cláusula WITH TIES le indicas
-- al motor que no te excluya aquellas filas que se encuentra
-- "empatadas" a nivel de los resultados, cosa que sucede si solamente usas un SELECT TOP,




-- los customers nacidos en los 4 años mas recientes
-- en el cuarto hay dos en el mismo año, p'q traiga los 2

SELECT *
FROM customers
ORDER BY YEAR(birth_date) DESC;

SELECT TOP 4 first_name, 
             birth_date
FROM customers
ORDER BY YEAR(birth_date) DESC;

SELECT TOP 4 WITH TIES first_name, 
                       birth_date
FROM customers
ORDER BY YEAR(birth_date) DESC;





--
--
--
--
--

-- 									INNER JOIN

SELECT * FROM orders;
SELECT * FROM customers;

SELECT order_id, 
       o.customer_id, 
       last_name, 
       shipped_date
FROM orders o
     INNER JOIN customers c ON o.customer_id = c.customer_id;


--
--
--
-- unir "order_items" con "products", p'q salga lo d "order_items" mas 
-- el nombre del producto

SELECT * FROM order_items; SELECT * FROM products;

SELECT order_id, 
       oi.product_id, 
       name, 
       quantity, 
       oi.unit_price
FROM order_items oi
     INNER JOIN products p ON oi.product_id = p.product_id;




--
--
--

--					UNIENDO MULTIPLES DB ( el anterior era varias tablas de una DB )

-- order_items de sql_store DB con products de sql_inventory
-- suponiendo q tengo un USE sql_inventory al principio

-- na mas especificar (en la q NO estoy sql_inventory.__ )



USE sql_inventory;

SELECT * FROM [sql_store].[dbo].[order_items]; SELECT * FROM products;

SELECT *
FROM [sql_store].[dbo].[order_items] oi
     INNER JOIN products p ON oi.product_id = p.product_id;






--
--
--
--								SELF JOIN

-- las tablas tienen q llevar != alias

-- p.e. en la misma tabla tengo los empleados y los jefes ( en != filas )
-- y quiero una tabla que tenga la col con nombre del empleado y su jefe


USE sql_hr;

SELECT * FROM employees;

SELECT e.employee_id, 
       e.first_name, 
       e.last_name, 
       e.reports_to, 
       m.last_name AS 'Boss'
FROM employees e
     INNER JOIN employees m ON e.reports_to = m.employee_id;





	 


--
--
--
-- 								JOIN MULTIPLE TABLES

-- en tabla orders sale "customer_id de customers" y
-- "status de order_statuses"
USE sql_store;

SELECT * FROM orders;
SELECT * FROM customers;
SELECT * FROM order_statuses;

SELECT o.order_id, 
       c.first_name, 
       os.name
FROM orders o
     INNER JOIN customers c ON o.customer_id = c.customer_id
     INNER JOIN order_statuses os ON o.status = os.order_status_id;



-- en sql_invoicing.payments corresponde a los pagos hechos xlos 
-- invoices, unir sql_invoicing para q salga el nombre del cliente y el 
-- metodo d pago

USE sql_invoicing;

SELECT * FROM payments; SELECT * FROM clients; SELECT * FROM payment_methods;

SELECT *
FROM payments p
     INNER JOIN clients c ON p.client_id = c.client_id
     INNER JOIN payment_methods pm ON p.payment_method = pm.payment_method_id;





--
--
--
--
-- 					COMPOUND JOIN

-- p' cuando una tabla tiene 2 PK ( composite PK )

-- tabla order_items tiene PK order_id y product_id
-- tabla order_item_notes tiene 1 PK y los 2 campos de arriba

USE sql_store;

SELECT * FROM order_items; SELECT * FROM order_item_notes;

SELECT *
FROM order_items oi
     INNER JOIN order_item_notes oin ON oi.order_id = oin.order_Id;


	 
SELECT *
FROM order_items oi
     INNER JOIN order_item_notes oin ON oi.order_id = oin.order_Id
                                        AND oi.product_id = oin.product_id;



--
--
--
--
--
--
-- 				OUTER JOIN

-- con inner join salen solo los datos de la primera q tambien 
-- esten en la 2da ( en la union ( ON ) )
-- con outer salen todos los de la 1ra aun y cuando no tengan 
-- correspondencia en la segunda

-- con inner al unir customers y orders me van a salir solo los clientes
-- que tengan ordenes
-- con left me van a salir todos los clientes tengan o no ordenes
-- los q no tengan => los datos de la 2da aparecen como null

USE sql_store;

SELECT * FROM customers; SELECT * FROM orders;

SELECT c.customer_id, 
       c.first_name, 
       o.order_id
FROM customers c
     JOIN orders o ON c.customer_id = o.customer_id   -->	es INNER JOIN
ORDER BY c.customer_id;



SELECT c.customer_id, 
       c.first_name, 
       o.order_id
FROM customers c
     LEFT JOIN orders o ON c.customer_id = o.customer_id   -->	es INNER JOIN
ORDER BY c.customer_id;


--
--
-- tabla q tenga todos los productos y aparezca "product_id", "name" y "quantity"

SELECT * FROM order_items ORDER BY product_id; SELECT * FROM products;

SELECT p.product_id, 
       p.name, 
       oi.quantity
FROM products p
     LEFT JOIN order_items oi ON oi.product_id = p.product_id
ORDER BY product_id;




--
--
--
--
--

-- OUTER JOIN entre varias tablas


--
-- todos los customers tengan o no una orden, q salga el shipper name

SELECT * FROM customers; SELECT * FROM orders; SELECT * FROM shippers;

SELECT c.customer_id, 
       c.first_name, 
       o.order_id, 
       o.shipper_id, 
       s.name
FROM customers c
     LEFT JOIN orders o ON c.customer_id = o.customer_id
     LEFT JOIN shippers s ON o.shipper_id = s.shipper_id;


--
--

-- ordenes con nombre de cliente, nombre de shipper y el status del shipment

SELECT * FROM orders; SELECT * FROM shippers; SELECT * FROM order_statuses;

SELECT o.order_date, 
       o.order_id, 
       c.first_name, 
       s.name, 
       os.name
FROM orders o
     LEFT JOIN customers c ON o.customer_id = c.customer_id
     LEFT JOIN shippers s ON o.shipper_id = s.shipper_id
     LEFT JOIN order_statuses os ON o.STATUS = os.order_status_id;  -- join o left-join xq todas las ordenes tienen status



SELECT o.order_date, 
       o.order_id, 
       c.first_name,
       CASE
           WHEN s.name IS NULL
           THEN 'SHIPPER NOT ASIGNED'
           ELSE s.name
       END AS 'shipper name', 
       os.name
FROM orders o
     LEFT JOIN customers c ON o.customer_id = c.customer_id
     LEFT JOIN shippers s ON o.shipper_id = s.shipper_id
     LEFT JOIN order_statuses os ON o.STATUS = os.order_status_id;  -- join o left-join xq todas las ordenes tienen status







--
--
-- SQL Server doesn't have a USING clause nor does it have natural joins.
