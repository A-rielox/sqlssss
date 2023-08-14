USE SAMPLEDB;
GO



SELECT
	TABLE_SCHEMA,
	TABLE_NAME,
	COLUMN_NAME,
	DATA_TYPE,
	COLLATION_NAME
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'oes' AND TABLE_NAME = 'products'
;

--TABLE_SCHEMA	TABLE_NAME	COLUMN_NAME	DATA_TYPE	COLLATION_NAME
--oes	products	product_id	int	NULL
--oes	products	product_name	varchar	Modern_Spanish_CI_AS
-- ...

-- CI --> case insensitive

-- AS --> accent Sensitive



SELECT product_id, product_name
FROM oes.products
WHERE product_name LIKE '%iphone%'
; -- > todos xq es case insensitive



SELECT product_id, product_name
FROM oes.products
WHERE product_name LIKE '%iphone%'
	COLLATE Modern_Spanish_CS_AS
; -- > ni uno xq es sensitive

SELECT product_id, product_name
FROM oes.products
WHERE product_name LIKE '%iPhone%'
	COLLATE Modern_Spanish_CS_AS
; --> ya todos xq le puse mayuscula '%iPhone%'



-- si quiero buscar que tenga "used_tablet" con el _, me lo va a tomar como 
-- wild card, necesito el scape character

--WHERE product_name LIKE '%used!_tablet%'
--ESCAPE '!';

-- me va a traer solo used_tablet

select * from hcm.departments;









--							INTERSECT


-- retorna las filas comunes a las dos tablas ( las distinct filas )
-- p' este al comparar un null con otro SI los toma como =es

-- SELECT col1, col2 FROM Table_name1
-- INTERSECT
-- SELECT col1, col2 FROM Table_name2;





--							EXCEPT


-- retorna las filas distintas, que aparecen en la 1ra y NO estan en la 2da
-- p' este al comparar un null con otro SI los toma como =es

-- SELECT col1, col2 FROM Table_name1
-- EXCEPT
-- SELECT col1, col2 FROM Table_name2;




-- precedencia
-- 1ro intersect
-- 2do union, union all, except , estos de derecha a izq
-- se altera el orden con parentesis







--				61. Correlated Subqueries


USE SAMPLEDB;
GO


-- productos con el mayor precio p' su categoria

SELECT * FROM oes.products;

SELECT	product_id, category_id, list_price
FROM oes.products p1
WHERE list_price = (
	SELECT MAX(list_price)
	FROM oes.products p2
	WHERE p2.category_id = p1.category_id	
)
ORDER BY category_id, product_id
;



-- retornar todos los productos q hayan sido ordenados (en tabla order_items)

SELECT * FROM oes.products;
SELECT * FROM oes.order_items ORDER BY product_id;
SELECT DISTINCT product_id FROM oes.order_items ORDER BY product_id;

SELECT product_id, product_name
FROM oes.products p
WHERE EXISTS (
	SELECT * FROM oes.order_items oi
	WHERE oi.product_id = p.product_id
)
;






--						63. Introduction to Window Functions

--			RANK()


-- Window Functions operate on multiple rows at a time but returns one output per row




-- productos con el mayor precio p' su categoria

SELECT * FROM oes.products;

SELECT * 
FROM oes.products p1
WHERE p1.list_price = (
	SELECT MAX(p2.list_price)
	FROM oes.products p2
	WHERE p2.category_id = p1.category_id
)
;


SELECT	product_id,
		category_id,
		list_price,
RANK() OVER (PARTITION BY category_id ORDER BY list_price DESC) AS rnk
FROM oes.products
;

-- los va a partir por categoria y ordenar por precio en c/categoria, y luego enumerar
-- dentro de c/categoria

--product_id	category_id	list_price	rnk
--2		1	1499.0000	1
--34	1	1499.0000	1
--1		1	1299.0000	3
--24	1	999.9900	4
--25	1	898.9900	5
-- ...
--63	2	1899.0000	1
--3		2	799.0000	2
--44	2	578.9900	3
-- ...
--26	3	2491.6700	1
--48	3	1499.0000	2
-- ...



-- ahora selecciono el q tenga rnk 1 en cada categoria

SELECT * 
FROM (
	SELECT	product_id,
		category_id,
		list_price,
	RANK() OVER (PARTITION BY category_id ORDER BY list_price DESC) AS rnk
	FROM oes.products
) AS s
WHERE S.rnk = 1
;







--						NOT IN TRAP			*********

-- todos los deptos sin empleados



SELECT * FROM hcm.departments;
SELECT * FROM hcm.employees;

-- me entrega vacio x el hecho de q hay empleados con department_id = NULL
SELECT * FROM hcm.departments
WHERE department_id NOT IN (
	SELECT department_id FROM hcm.employees
);

-- =>
SELECT * FROM hcm.departments
WHERE department_id NOT IN (
	SELECT department_id FROM hcm.employees
	WHERE department_id IS NOT NULL
);

-- o

SELECT * FROM hcm.departments d
WHERE NOT EXISTS (
	SELECT * FROM hcm.employees e
	WHERE e.department_id = d.department_id
);
