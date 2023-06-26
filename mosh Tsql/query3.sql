

-- 	    				SUB QUERIES


-- find products that are more expensive than lettuce ( id = 3 )

USE sql_store;

SELECT *
FROM products
WHERE unit_price >
(
    SELECT unit_price
    FROM products
    WHERE product_id = 3
);


--
--
-- in sql_hr DB , find employees whose earn more than average

USE sql_hr;

SELECT * FROM employees;

SELECT first_name, 
       job_title, 
       salary
FROM employees
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees
)
ORDER BY salary;


--
--
-- find the products that have never been ordered

USE sql_store;

SELECT * FROM products; SELECT * FROM order_items;

SELECT *
FROM products
WHERE product_id NOT IN
(
    SELECT DISTINCT product_id
    FROM order_items
);




--
--

-- encontrar clientes sin invoices

USE sql_invoicing;

SELECT * FROM clients; SELECT * FROM invoices;

SELECT *
FROM clients
WHERE client_id NOT IN
(
    SELECT DISTINCT client_id
    FROM invoices
);








--					SUBQUERIES VS JOINS

-- el anterior pero con JOIN

SELECT * FROM clients; SELECT * FROM invoices ORDER BY client_id;

SELECT *
FROM clients c
     LEFT JOIN invoices i ON c.client_id = i.client_id
WHERE i.invoice_id IS NULL;



--
--
-- find customers who have ordered lettuce ( id = 3 ) and select customer_id, first_name, last_name

USE sql_store;

SELECT * FROM customers; SELECT * FROM orders; SELECT * FROM order_items;

SELECT customer_id, 
       first_name, 
       last_name
FROM customers
WHERE customer_id IN
(
    SELECT DISTINCT 
           o.customer_id
    FROM orders o
         JOIN order_items oi ON o.order_id = oi.order_id
    WHERE oi.product_id = 3
);



SELECT DISTINCT c.customer_id, c.first_name, c.last_name
FROM customers c
     JOIN orders o ON c.customer_id = o.customer_id
     JOIN order_items oi ON o.order_id = oi.order_id
WHERE oi.product_id = 3;



--
--
--
--
-- 	    ALL KEYWORD



-- select invoices larger than all invoices of client 3

USE sql_invoicing;

SELECT * FROM invoices ORDER BY client_id;

SELECT *
FROM invoices
WHERE invoice_total > ALL
(
    SELECT invoice_total   -- podria usar MAX() y no ocupar ALL
    FROM invoices
    WHERE client_id = 3
);



--
--


-- 	    ANY KEYWORD

-- select clients with at least two invoices

SELECT * FROM invoices ORDER BY client_id;

SELECT *
FROM clients
WHERE client_id IN
(
    SELECT client_id  -- podria ser con solo el subQuery ; )
    FROM invoices
    GROUP BY client_id
    HAVING COUNT(client_id) >= 2
);



-- con ANY
SELECT *
FROM clients
WHERE client_id = ANY
(
    SELECT client_id
    FROM invoices
    GROUP BY client_id
    HAVING COUNT(client_id) >= 2
);





--
--
--
--


-- 				CORRELATED SUB-QUERIES			******


-- SEELCT EMPLOYEES WHOSE SALARY IS ABOVE THE AVERAGE IN THEIR OFFICE

USE sql_hr;

SELECT * FROM employees;

SELECT *
FROM employees e
WHERE salary >
(
    SELECT AVG(salary)
    FROM employees em
    WHERE em.office_id = e.office_id
);



-- get invoices that are larger than the client's average invoice amount
-- p'c/cliente entregar los invoices q sean + grandes q su promedio

USE sql_invoicing;

SELECT * FROM invoices;

-- p' checar
SELECT client_id, 
       AVG(invoice_total)
FROM invoices
GROUP BY client_id;

SELECT *
FROM invoices i
WHERE invoice_total >
(
    SELECT AVG(invoice_total)
    FROM invoices iv
    WHERE i.client_id = iv.client_id
);





--
--
--
--					EXISTS					******


-- select clients that have an invoice

USE sql_invoicing;

SELECT * FROM invoices; SELECT * FROM clients;

-- con joins
SELECT DISTINCT c.client_id
FROM clients c
     JOIN invoices i ON c.client_id = i.client_id
ORDER BY c.client_id;

-- con subquery
SELECT *
FROM clients
WHERE client_id IN
(
    SELECT client_id
    FROM invoices
);



-- con EXISTS y CORRELATED QUERY
-- p' c/cliente checa si el dato existe ( el del WHERE EXISTS ), si existe => retorna ese cliente y sigue con el otro

SELECT *
FROM clients c
WHERE EXISTS
(
    SELECT *
    FROM invoices i
    WHERE i.client_id = c.client_id
);









-- find the products that have never been ordered in sql_store

USE sql_store;

SELECT * FROM order_items; SELECT * FROM products;

SELECT *
FROM products p
WHERE NOT EXISTS
(
    SELECT *
    FROM order_items oi
    WHERE oi.product_id = p.product_id
);



--
--
--

-- 			subQ en el SELECT



-- obtener
-- invoice_id, invoice_total, invoice_average, difference
-- 1			101.79			152.388235		-50.598235
-- 2			175.32			152.388235		22.931765
-- 3			147.99			152.388235		-4.398235
-- ...


USE sql_invoicing;

SELECT * FROM invoices;

SELECT invoice_id, 
       invoice_total, 
		(
			SELECT AVG(invoice_total)
			FROM invoices
		) AS invoice_average, 
       invoice_total -
					(
						SELECT AVG(invoice_total)
						FROM invoices
					) AS difference
FROM invoices;


--
--
--
-- obtener				******
-- client_id, name, 	total_sales, average, difference
-- 1		Vinte		802.89		152.388235	650.501765
-- 2		Myworks		101.79		152.388235	-50.598235
-- 3		Yadel		705.90		152.388235	553.511765
-- 4		Kwideo		null		152.388235	null
-- 5		Topiclounge	980.02		152.388235	827.631765

SELECT * FROM clients; SELECT * FROM invoices;

SELECT client_id, 
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
		(
			SELECT SUM(invoice_total)
			FROM invoices
			WHERE client_id = c.client_id
		) -
		(
			SELECT AVG(invoice_total)
			FROM invoices
		) AS difference
FROM clients c;

--			EN MYSQL
--SELECT 
--	client_id,
--    name,
--    (
--		SELECT SUM(invoice_total)
--        FROM invoices
--        WHERE client_id = c.client_id
--    ) AS total_sales,
--    (
--		SELECT AVG(invoice_total)
--        FROM invoices
--    ) AS average,
--    (SELECT total_sales) - (SELECT average) AS difference
--FROM clients c;

