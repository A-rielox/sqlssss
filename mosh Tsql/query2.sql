--	39



--   			AGGEGATE FUNCTIONS


-- MAX() - MIN() - AVG() - SUM() - COUNT()
-- si hay valores null => se los saltan


USE sql_invoicing;

-- a parte de sobre numeros se pueden aplicar sobre strings o dates

SELECT * FROM invoices;

-- COUNT(*) incluye los null 						***

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
SELECT * FROM invoices ORDER BY client_id;

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

SELECT 'First half of 2019' AS 'Date Range', 
       SUM(invoice_total) AS 'Total sales', 
       SUM(payment_total) AS 'Total Payments', 
       SUM(invoice_total - payment_total) AS 'What we expext'
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-06-30'
UNION
SELECT 'Second half of 2019' AS 'Date Range', 
       SUM(invoice_total) AS 'Total sales', 
       SUM(payment_total) AS 'Total Payments', 
       SUM(invoice_total - payment_total) AS 'What we expext'
FROM invoices
WHERE invoice_date BETWEEN '2019-07-01' AND '2019-12-31'
UNION
SELECT 'Total' AS 'Date Range', 
       SUM(invoice_total) AS 'Total sales', 
       SUM(payment_total) AS 'Total Payments', 
       SUM(invoice_total - payment_total) AS 'What we expext'
FROM invoices
WHERE invoice_date BETWEEN '2019-01-01' AND '2019-12-31';








--								GROUP BY



-- las aggregate fnc se van a ejecutar sobre c/grupo
-- p' filtrar, primero WHERE y despues GROUP BY					***


USE sql_invoicing;

SELECT * FROM invoices order by client_id;
-- los client_id se repiten xc/invoice de un mismo cliente, sacar las ventas
-- totales de c/client p' la segunda mitad del 2019 

SELECT client_id, 
       SUM(invoice_total) AS total_sales, 
       COUNT(client_id) AS total_records
FROM invoices
WHERE invoice_date >= '2019-07-01'
GROUP BY client_id
ORDER BY total_sales;



--
--
-- sacar las total sales x state y city

USE sql_invoicing;

SELECT * FROM clients; SELECT * FROM invoices;

SELECT c.state, 
       c.city, 
       SUM(i.invoice_total) AS total_ventas, 
       COUNT(i.invoice_total) AS total_datos
FROM invoices i
     JOIN clients c ON i.client_id = c.client_id
GROUP BY c.state, 
         c.city;




-- generar la tabla , con tabla payments
-- date, 		payment_method, total_payment
-- 2019-01-03	Credit Card		74.55
-- ...
-- 2019-01-08	Cash			10.00
-- 2019-01-11	Credit Card		0.03
-- ...

USE sql_invoicing;

SELECT * FROM payments; SELECT * FROM payment_methods;


SELECT p.date AS date, 
       pm.name AS payment_method, 
       SUM(p.amount) AS total_payment
FROM payments p
     LEFT JOIN payment_methods pm ON p.payment_method = pm.payment_method_id
GROUP BY p.date, 
         pm.name
ORDER BY p.date ASC;


--
--
--

--				HAVING

-- p' cuando hay q filtrar por los resultados d las aggregate fcns
-- ( p' filtrar despues del GROUP BY ) las columnas ocupadas en el HAVING tienen
-- que estar en el select, el WHERE puede tener cualquier columna



-- total de ventas p' c/cliente

SELECT client_id, 
       SUM(invoice_total) AS total_ventas, 
       COUNT(invoice_total) AS total_datos
FROM invoices
GROUP BY client_id;
-- client_id, total_sales, total_records
-- 1	802.89	5
-- 2	101.79	1
-- 3	705.90	5
-- 5	980.02	6


-- p' incluir solo los que hayan vendido + de 500 dls

SELECT client_id, 
       SUM(invoice_total) AS total_ventas, 
       COUNT(invoice_total) AS total_datos
FROM invoices
GROUP BY client_id
HAVING SUM(invoice_total) > 500;




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


SELECT c.customer_id, 
       COUNT(*) AS total_orders_from_customer, 
       SUM(quantity * unit_price) AS total_spent
FROM customers c
     JOIN orders o ON c.customer_id = o.customer_id
     LEFT JOIN order_items oi ON o.order_id = oi.order_id
WHERE c.state = 'va'
GROUP BY c.customer_id
having SUM(quantity * unit_price) > 100;









