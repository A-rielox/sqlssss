USE sql_store;


SELECT *
FROM customers
-- WHERE customer_id = 1
ORDER BY first_name;



SELECT first_name, last_name, YEAR(BIRTH_DATE) AS 'ANHO'
FROM customers
WHERE birth_date > '1990-01-01';


-- ordenes puestas este ano
SELECT *
FROM orders
WHERE year(order_date) = '2019';


--				AND OR
-- primero se evaluan los AND y luego los OR

SELECT *
FROM customers
WHERE birth_date > '1990-01-01' OR points > 1000 AND state = 'VA';

-- es 
SELECT *
FROM customers
WHERE birth_date > '1990-01-01' OR ( points > 1000 AND state = 'VA' );

--     			 NOT
SELECT *
FROM customers
WHERE NOT ( birth_date > '1990-01-01' OR points > 1000 );

-- es (	niega el or y los signos )
SELECT *
FROM customers
WHERE birth_date <= '1990-01-01' AND points <= 1000;


-- from the order_items table, get the items
-- for order #6, where the total price is greater than 30

SELECT *, quantity * unit_price AS 'TOTAL'
FROM order_items
WHERE order_id = 6 AND (quantity * unit_price) > 30;



-- 					IN

-- customer q vivan en virginia 'VA', georgia 'GA' o florida 'FL'

SELECT *
FROM customers
WHERE state IN ('VA', 'GA', 'FL');


-- NO puede ser 
-- WHERE state = 'VA' OR 'GA' OR 'FL'
-- xq el OR es para combinar expresiones



--					BETWEEN

SELECT *
FROM customers
WHERE points >= 1000 AND points <= 3000;


SELECT *
FROM customers
WHERE points BETWEEN 1000 AND 3000;





-- 				% y _
-- % cantidad indeterminada de caracteres
-- _ un caracter, varios _ para 2do o 3er ... caracter

-- clientes con apellido con segunda letra o
SELECT *
FROM customers
WHERE last_name LIKE '_o%';


-- clientes cuyo telefono termine en 9
SELECT *
FROM customers
-- WHERE RIGHT(phone,1) = 9;
WHERE phone LIKE '%9';


-- 					REGEXP

-- clientes q contengan "field" en el last_name

SELECT *
FROM customers
-- WHERE last_name LIKE '%field%'
WHERE last_name REGEXP 'FIELD';

-- p'q empiece con ^chars
-- p'q termine con chars$

-- last_name empiezan con b
SELECT *
FROM customers
WHERE last_name REGEXP '^B';

-- last_name termina con y
SELECT *
FROM customers
WHERE last_name REGEXP 'y$';


-- p'q tengan uno u otro patron |

-- q tengan "field" o "mac" o "rose" en el apellido
SELECT *
FROM customers
WHERE last_name REGEXP 'field|mac|rose';


-- q empiecen con "mac" o "rose"
SELECT *
FROM customers
WHERE last_name REGEXP '^mac|^rose';

-- q tenga uno de los caracteres []
-- q tengan una "i" o "g" seguida de una "e"
SELECT *
FROM customers
WHERE last_name REGEXP '[ig]e';
-- Brushfield
-- Boagey

-- rango de caracteres con [ - ]





--  		LIMIT
-- me entrega solo esa cantidad ( depende de como esten sorteados )
-- con 2 parametros, el primero es el off-set ( los q se salta )
-- sorting x default es por primary-key

-- q me entregue los primeros 3
SELECT *
FROM customers
LIMIT 3;


-- para q me pagine los resultados ( pag de 3 resultados )
-- pag 1: 1 - 3, pag 2: 4 - 6, pag 3: 7 - 9

-- los de la pagina 3
SELECT *
FROM customers
LIMIT 6, 3;


-- los 3 customers con mas puntos
SELECT *
FROM customers
ORDER BY points DESC
LIMIT 3;



-- 									INNER JOIN


SELECT order_id, o.customer_id, last_name, shipped_date
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;



-- unir "order_items" con "products", p'q salga lo d "order_items" mas 
-- el nombre del producto
USE sql_store;

SELECT *
FROM products;

SELECT order_id, o.product_id, name, quantity, o.unit_price
FROM order_items o
JOIN products p
	ON o.product_id = p.product_id;


-- uniendo multiples DB ( el anterior era varias tablas de una DB )

-- order_items de sql_store DB con products de sql_inventory
-- suponiendo q tengo un USE sql_store al principio

-- na mas especificar (en la q NO estoy sql_inventory.__ )
SELECT *
FROM order_items oi
JOIN sql_inventory.products p
	ON oi.product_id = p.product_id;






--								SELF JOIN

-- las tablas tienen q llevar != alias

-- p.e. en la misma tabla tengo los empleados y los jefes ( en != filas )
-- y quiero una tabla que tenga la col con nombre del empleado y su jefe


USE sql_hr;

SELECT *
FROM employees;

SELECT e.employee_id, e.first_name, e.last_name,
		e.reports_to, m.last_name AS 'Boss'
FROM employees e
JOIN employees m
	ON e.reports_to = m.employee_id;



-- 								JOIN MULTIPLE TABLES

-- en tabla orderes sale "customer_id de customers" y
-- "status de order_statuses"
USE sql_store;

SELECT *
FROM orders;

SELECT o.order_id, o.order_date, c.first_name, c.last_name, o.status, os.name
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id
    JOIN order_statuses os
		ON o.status = os.order_status_id;




-- en sql_invoicing.payments corresponde a los pagos hechos xlos 
-- invoices, unir sql_invoicing para q salga el nombre del cliente y el 
-- metodo d pago
USE sql_invoicing;

SELECT *
FROM payments p
JOIN clients c
	on p.client_id = c.client_id
join payment_methods pm
	on p.payment_method = pm.payment_method_id;





-- 			COMPOUND JOIN

-- p' cuando una tabla tiene 2 PK ( composite PK )

-- tabla order_items tiene PK order_id y product_id
-- tabla order_item_notes tiene 1 PK y los 2 campos de arriba
USE sql_store;

SELECT *
FROM order_items oi
JOIN order_item_notes oin
	ON oi.order_id = oin.order_Id
	AND oi.product_id = oin.product_id;




--				IMPLICIT JOIN

SELECT *
FROM orders o
JOIN customers c
	ON o.customer_id = c.customer_id;
    
-- como implicita
SELECT *
FROM orders o, customers c
WHERE o.customer_id = c.customer_id;





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

SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
JOIN orders o
	ON c.customer_id = o.customer_id
	ORDER BY c.customer_id;


-- esta me va a mostrar todos los clientes tengan o no una orden
SELECT c.customer_id, c.first_name, o.order_id
FROM customers c
LEFT JOIN orders o
	 ON c.customer_id = o.customer_id
	 ORDER BY c.customer_id;


-- tabla q tenga "product_id", "name" y "quantity"

SELECT *
FROM order_items
ORDER BY product_id;

SELECT *
FROM products;

SELECT p.product_id, p.name, oi.quantity
FROM products p
LEFT JOIN order_items oi
	ON oi.product_id = p.product_id
	ORDER BY p.product_id;




-- OUTER JOIN entre varias tablas

-- todos los customers tengan o no una orden
SELECT c.customer_id, c.first_name, o.order_id, o.shipper_id, s.name
FROM customers c
LEFT JOIN orders o
	 ON c.customer_id = o.customer_id
     LEFT JOIN shippers s
		ON o.shipper_id = s.shipper_id
	 ORDER BY c.customer_id;



SELECT *
FROM orders;
SELECT *
FROM shippers;
SELECT *
FROM order_statuses;

SELECT o.order_date, o.order_id, c.first_name, s.name, os.name
FROM orders o
LEFT JOIN customers c
	ON o.customer_id = c.customer_id
LEFT JOIN shippers s
	ON o.shipper_id = s.shipper_id
JOIN order_statuses os -- join o left-join xq todas las ordenes tienen status
	ON o.status = os.order_status_id






-- 				25





















