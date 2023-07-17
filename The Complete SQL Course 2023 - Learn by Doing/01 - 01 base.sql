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


-- Window Functions operate on multiple rows at a time but returns one output per row

















