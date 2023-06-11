--	39



--   			AGGEGATE FUNCTIONS


-- MAX() - MIN() - AVG() - SUM() - COUNT()
-- si hay valores null => se los saltan


USE sql_invoicing;

-- a parte de sobre numeros se pueden aplicar sobre strings o dates

SELECT * FROM invoices;

-- COUNT(*) incluye los null 			***

SELECT 
    MAX(payment_date) AS 'Highest date',
    SUM(invoice_total) AS 'Total suma',
    COUNT(invoice_total) AS 'Cantidad de records',
    COUNT(payment_date) AS 'Invoices pagados',
    COUNT(*) AS 'Total records'
FROM invoices;


-- si pongo filtros => los calculos se hacen con los datos filtrados

SELECT COUNT(invoice_id)   -- 17
FROM invoices;

SELECT  COUNT(invoice_id) -- 5
FROM invoices
WHERE
    invoice_date BETWEEN '2019-05-01' AND '2019-07-01';


-- DISCTINCT p' q no incluya en los calculos los datos repetidos
SELECT * FROM invoices;

SELECT 
    COUNT(client_id) AS 'con usuarios repetidos',
    COUNT(DISTINCT client_id) AS 'con usuarios unicos',
    COUNT(*) AS 'Total records'
FROM invoices;

-- 17	4	17



-- generar la tabla
-- Date Range, 		   Total sales, Total Payments, What we expext
-- First half of 2019	1539.07		662.69		876.38
-- Second half of 2019	1051.53		355.02		696.51
-- Total				2590.60		1017.71		1572.89

SELECT * FROM invoices;

SELECT 
    'First half of 2019' AS 'Date Range',
    SUM(invoice_total) AS 'Total sales',
    SUM(payment_total) AS 'Total Payments',
    SUM(invoice_total - payment_total) AS 'What we expext'
FROM
    invoices
WHERE
    invoice_date BETWEEN '2019-01-01' AND '2019-06-30' 
UNION SELECT 
    'Second half of 2019' AS 'Date Range',
    SUM(invoice_total) AS 'Total sales',
    SUM(payment_total) AS 'Total Payments',
    SUM(invoice_total - payment_total) AS 'What we expext'
FROM
    invoices
WHERE
    invoice_date BETWEEN '2019-07-01' AND '2019-12-31' 
UNION SELECT 
    'Total' AS 'Date Range',
    SUM(invoice_total) AS 'Total sales',
    SUM(payment_total) AS 'Total Payments',
    SUM(invoice_total - payment_total) AS 'What we expext'
FROM
    invoices
WHERE
    invoice_date BETWEEN '2019-01-01' AND '2019-12-31';








--								GROUP BY



-- las aggregate fnc se van a ejecutar sobre c/grupo


USE sql_invoicing;

SELECT * FROM invoices;
-- los client_id se repiten xc/invoice de un mismo cliente
-- p' filtrar, primero WHERE y despues GROUP BY

SELECT 
    client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(client_id) AS total_records
FROM
    invoices
WHERE
    invoice_date >= '2019-07-01'
GROUP BY client_id
ORDER BY total_sales;


-- sacar las total sales x state y city
SELECT * FROM clients; SELECT * FROM invoices;

SELECT 
    c.city,
    c.state,
    SUM(i.invoice_total) AS total_ventas, -- ventas en c/grupo
    COUNT(i.invoice_total) AS total_records -- datos en c/grupo
FROM invoices i
JOIN
    clients c USING (client_id)
GROUP BY c.city , c.state;








-- generar la tabla , con tabla payments
-- date, 		payment_method, total_payment
-- 2019-01-03	Credit Card		74.55
-- ...
-- 2019-01-08	Cash			10.00
-- 2019-01-11	Credit Card		0.03
-- ...

USE sql_invoicing;

SELECT * FROM payments; SELECT * FROM payment_methods;

SELECT 
    p.date, pm.name AS payment_method, SUM(p.amount) AS total_payment
FROM
    payments p
JOIN
    payment_methods pm 
ON p.payment_method = pm.payment_method_id
GROUP BY p.date , payment_method
ORDER BY p.date ASC;






--				HAVING

-- p' cuando hay q filtrar por los resultados d las aggregate fcns ( p' filtrar despues del GROUP BY ) las columnas ocupadas en el HAVING tienen que estar en el select, el WHERE puede tener cualquier columna



-- total de ventas p' c/cliente
SELECT 
    client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(client_id) AS total_records
FROM invoices
GROUP BY client_id;
-- client_id, total_sales, total_records
-- 1	802.89	5
-- 2	101.79	1
-- 3	705.90	5
-- 5	980.02	6
	

-- p' incluir solo los que hayan vendido + de 500 dls

SELECT 
    client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(*) AS total_records
FROM invoices
GROUP BY client_id
HAVING total_sales > 500;



SELECT 
    client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(client_id) AS total_records
FROM invoices
-- WHERE 			p' filtrar antes de agrupar
GROUP BY client_id
-- HAVING ; 			p' filtrar despues de agrupar
;





-- get the customers located in virginia
-- who have spent more than $100

USE sql_store;

SELECT * FROM customers; SELECT * FROM orders; SELECT * FROM order_items;

SELECT * FROM customers c
JOIN orders o USING (customer_id)
JOIN order_items oi USING (order_id);

SELECT 
    customer_id,
    COUNT(*) AS total_orders_from_customer,
    SUM(oi.quantity * oi.unit_price) AS total_spent
FROM customers c
JOIN
    orders o USING (customer_id)
JOIN
    order_items oi USING (order_id)
WHERE c.state = 'VA'
GROUP BY customer_id
HAVING total_spent > 100;





--				ROLLUP
-- ( solo en MySql )

-- sumariza columnas con aggregate fcns

-- total de ventas p' c/cliente
USE sql_invoicing;
SELECT 
    client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(client_id) AS total_records
FROM invoices
GROUP BY client_id;

USE sql_invoicing;
SELECT 
    client_id,
    SUM(invoice_total) AS total_sales,
    COUNT(client_id) AS total_records
FROM invoices
GROUP BY client_id WITH ROLLUP;


-- al agrupar por varias
SELECT 
    state, city, SUM(invoice_total) AS total_sales
FROM
    invoices i
        JOIN
    clients c USING (client_id)
GROUP BY state , city WITH ROLLUP;

-- me va entregando el total p' todas
-- las ciudades en c/estado ( el total p'c/grupo )
-- y al final el TOTAL-TOTAL


-- 2.17
-- entregar la tabla
-- payment_method, total
-- Cash				10.00
-- Credit Card		351.38
-- 					361.38

USE sql_invoicing;

SELECT * FROM payments; SELECT * FROM payment_methods;

SELECT 
    pm.name AS payment_method, SUM(p.amount) AS total
FROM
    payments p
JOIN
    payment_methods pm ON p.payment_method = pm.payment_method_id
GROUP BY pm.name WITH ROLLUP; -- al ocupar rollup NO se puede ocupar el alias
--									en el group by







-- 	    				SUB QUERIES


-- find products that are more expensive than lettuce ( id = 3 )

USE sql_store;

SELECT *
FROM products
WHERE unit_price > (
    SELECT unit_price
    FROM products
    WHERE product_id = 3
	);






-- in sql_hr DB , find employees whose earn more than average

USE sql_hr;

SELECT first_name, job_title, salary
FROM employees
WHERE salary > (
		SELECT AVG(salary)
		FROM employees
)
ORDER BY salary;







-- find the products that have never been ordered

USE sql_store;

SELECT * FROM products; SELECT * FROM order_items;

SELECT *
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
	FROM order_items
);




-- encontrar clientes sin invoices

USE sql_invoicing;

SELECT * FROM clients; SELECT * FROM invoices;

SELECT *
FROM clients
WHERE client_id NOT IN(
	SELECT DISTINCT client_id
    FROM invoices
);






--					SUBQUERIES VS JOINS

-- el anterior pero con JOIN
SELECT *
FROM clients c
LEFT JOIN invoices i
USING (client_id)
WHERE i.client_id IS NULL;




-- find customers who have ordered lettuce ( id = 3 ) and select customer_id, first_name, last_name

USE sql_store;

SELECT * FROM customers; SELECT * FROM orders; SELECT * FROM order_items;

SELECT customer_id, first_name, last_name
FROM customers
WHERE customer_id IN (
	SELECT customer_id
    FROM orders
    WHERE order_id IN (
		SELECT order_id
        FROM order_items
		WHERE product_id = 3
	)
);
-- ó
SELECT *
FROM customers
WHERE customer_id IN (
	SELECT customer_id FROM orders o
    JOIN order_items oi USING(order_id)
    WHERE oi.product_id = 3
);

SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customers c
JOIN orders o
	USING(customer_id)
JOIN order_items oi
	USING (order_id)
WHERE oi.product_id = 3;



-- 	    ALL KEYWORD



-- select invoices larger than all invoices of client 3

USE sql_invoicing;

SELECT * FROM invoices;

SELECT *
FROM invoices
WHERE invoice_total > ALL (
	SELECT invoice_total -- podria usar MAX() y no ocupar ALL
	FROM invoices
	WHERE client_id = 3
);







-- 	    ANY KEYWORD

-- select clients with at least two invoices

SELECT * FROM invoices;

SELECT *
FROM clients
WHERE client_id IN (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(client_id) >= 2
);

-- con ANY
SELECT *
FROM clients
WHERE client_id = ANY (
	SELECT client_id
	FROM invoices
	GROUP BY client_id
	HAVING COUNT(client_id) >= 2
);







-- 		CORRELATED SUB-QUERIES			******


-- SEELCT EMPLOYEES WHOSE SALARY IS ABOVE THE AVERAGE IN THEIR OFFICE
USE sql_hr;



-- este es el avg en c/office, pero no me sirve de esta forma
SELECT office_id, AVG(salary)
FROM employees
GROUP BY office_id;

SELECT * FROM employees;

SELECT *
FROM employees e
WHERE salary > (
	SELECT AVG(salary)
    FROM employees
    WHERE office_id = e.office_id
);




-- get invoices that are larger than the client's average invoice amount
-- p'c/cliente entregar los invoices q sean + grandes q su promedio

USE sql_invoicing;

SELECT * FROM invoices;

-- p' checar mi resp
SELECT client_id, AVG(invoice_total)
FROM invoices
GROUP BY client_id;
-- client_id, AVG(invoice_total)
-- 		1		160.578000
-- 		2		101.790000
-- 		3		141.180000
-- 		5		163.336667

SELECT *
FROM invoices i
WHERE invoice_total > (
	SELECT AVG(invoice_total)
    FROM invoices
    WHERE client_id = i.client_id
);






--		EXISTS					******


-- select clients that have an invoice

USE sql_invoicing;

SELECT * FROM invoices; SELECT * FROM clients;

SELECT DISTINCT client_id
FROM clients c
JOIN invoices i
USING(client_id);

-- con subquery
SELECT *
FROM clients
WHERE client_id IN (
	SELECT DISTINCT client_id
    FROM invoices
);

-- con EXISTS y CORRELATED QUERY
-- p' c/cliente checa si el dato existe ( el del WHERE EXISTS ), si existe => retorna ese cliente y sigue con el otro

SELECT *
FROM clients c
WHERE EXISTS (
	SELECT client_id
    FROM invoices
    WHERE client_id = c.client_id
);


-- find the products that have never been ordered in sql_store

USE sql_store;

SELECT * FROM order_items; SELECT * FROM products;

SELECT *
FROM products p
LEFT JOIN order_items oi USING(product_id)
WHERE oi.order_id IS NULL;
-- con subQ
SELECT *
FROM products
WHERE product_id NOT IN (
	SELECT DISTINCT product_id
    FROM order_items    
);

SELECT *
FROM products p
WHERE NOT EXISTS (
	SELECT DISTINCT product_id
    FROM order_items
    WHERE product_id = p.product_id
);







-- 			subQ en el SELECT



-- obtener
-- invoice_id, invoice_total, invoice_average, difference
-- 1			101.79			152.388235		-50.598235
-- 2			175.32			152.388235		22.931765
-- 3			147.99			152.388235		-4.398235
-- ...


USE sql_invoicing;

SELECT * FROM invoices;

SELECT 
	invoice_id,
    invoice_total,
    (
		SELECT AVG(invoice_total)
        FROM invoices
    ) AS invoice_average,
    -- invoice_total - invoice_average no puede ser con alias directo tengo q ocupar el SELECT "alias"
    invoice_total - (SELECT invoice_average) AS difference
FROM invoices;





-- obtener				******
-- client_id, name, 	total_sales, average, difference
-- 1		Vinte		802.89		152.388235	650.501765
-- 2		Myworks		101.79		152.388235	-50.598235
-- 3		Yadel		705.90		152.388235	553.511765
-- 4		Kwideo		null		152.388235	null
-- 5		Topiclounge	980.02		152.388235	827.631765

SELECT * FROM clients; SELECT * FROM invoices;

SELECT 
	client_id,
    name,
    (
		SELECT SUM(invoice_total)
        FROM invoices
        WHERE client_id = c.client_id
    ) AS total_sales,
    (
		SELECT AVG(invoice_total)
        FROM invoices
    ) AS average,
    (SELECT total_sales) - (SELECT average) AS difference
FROM clients c;





-- 			subQ en el FROM

-- se requiere darle un alias a la tabla del subQ
-- es básicamente ocupar la tabla anterior ( o cualquier tabla obtenida x un query ) y ocuparla en un FROM.

-- esto suele hacerce con views, a no ser que sea una subQ muy sencilla

SELECT * 
FROM (
	SELECT 
		client_id,
		name,
		(
			SELECT SUM(invoice_total)
			FROM invoices
			WHERE client_id = c.client_id
		) AS total_sales,
		(
			SELECT AVG(invoice_total)
			FROM invoices
		) AS average,
		(SELECT total_sales - average) AS difference
	FROM clients c
) AS summary
WHERE total_sales IS NOT NULL;









-- 			53