--	39



--   			AGGEGATE FUNCTIONS


-- MAX() - MIN() - AVG() - SUM() - COUNT()
-- si hay valores null => se los saltan


USE sql_invoicing;

-- a parte de sobre numeros se pueden aplicar sobre strings o dates

SELECT 
    *
FROM
    invoices;

-- COUNT(*) incluye los null 			***

SELECT 
    MAX(payment_date) AS 'Highest date',
    SUM(invoice_total) AS 'Total suma',
    COUNT(invoice_total) AS 'Cantidad de records',
    COUNT(payment_date) AS 'Invoices pagados',
    COUNT(*) AS 'Total records'
FROM
    invoices;


-- si pongo filtros => los calculos se hacen con los 
-- datos filtrados

SELECT COUNT(invoice_id)   -- 17
FROM invoices;

SELECT  COUNT(invoice_id) -- 5
FROM invoices
WHERE
    invoice_date BETWEEN '2019-05-01' AND '2019-07-01';


-- DISCTINCT p' q no incluya en los calculos los datos repetidos
SELECT 
    COUNT(client_id) AS 'con usuarios repetidos',
    COUNT(DISTINCT client_id) AS 'con usuarios unicos',
    COUNT(*) AS 'Total records'
FROM invoices;

-- 17	4	17



-- generar la tabla
-- Date Range, Total sales, Total Payments, What we expext
-- First half of 2019	1539.07		662.69		876.38
-- Second half of 2019	1051.53		355.02		696.51
-- Second half of 2019	2590.60		1017.71		1572.89

SELECT *
FROM invoices;


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

SELECT *
FROM invoices;
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
SELECT *
FROM clients;

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
-- 2019-01-08	Credit Card		32.77
-- 2019-01-08	Cash			10.00
-- 2019-01-11	Credit Card		0.03
-- 2019-01-15	Credit Card		148.41
-- 2019-01-26	Credit Card		87.44
-- 2019-02-12	Credit Card		8.18
USE sql_invoicing;
SELECT 
    *
FROM
    payments;


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

-- p' cuando hay q filtrar por los resultados
-- d las aggregate fcns ( p' filtrar despues del GROUP BY )
-- las columnas ocupadas en el HAVING tienen que estar en el select
-- el WHERE puede tener cualquier columna



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

select *
from customers;
select *
from orders;
select *
from order_items;


select *
from customers c
join orders o
using (customer_id)
join order_items oi
using(order_id);

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

SELECT *
FROM payments;
SELECT *
FROM payment_methods;

SELECT 
    pm.name AS payment_method, SUM(p.amount) AS total
FROM
    payments p
JOIN
    payment_methods pm ON p.payment_method = pm.payment_method_id
GROUP BY pm.name WITH ROLLUP; -- al ocupar rollup NO se puede ocupar el alias
--									en el group by







-- 		43











