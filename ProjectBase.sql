USE Insurance;


--							WHERE - AND - OR
-- select all the records form the Claimant table that were closed in 2018
SELECT *
FROM Claimant
WHERE YEAR(ClosedDate) = 2018


SELECT [LogID]
      ,[PK]
      ,[FieldName]
      ,[OldValue]
      ,[NewValue]
      ,[EntryDate]
  FROM [Insurance].[dbo].[ClaimLog]
  WHERE FieldName = 'ExaminerCode' AND OldValue = 'unassigned';


   

-- select all the record form the Claimant table that were closed
-- in 2018 and have not been reopened
SELECT [ClaimID]
    --,[ClosedDate]
	,CONVERT(DATE, ClosedDate) AS 'ClosedDate'
    ,[ReopenedDate]
    ,[EnteredBy]
FROM [Insurance].[dbo].[Claimant]
WHERE YEAR(ClosedDate) = 2018 AND ReopenedDate IS NULL







--							AGGREGATE
-- average reserve amount in the Reserve table
SELECT ReserveID, ReserveAmount
	FROM Insurance.dbo.Reserve;

SELECT AVG(ReserveAmount) AS 'Average reserve amount'
	FROM Insurance.dbo.Reserve;






--							DISTINCT - GROUP BY
SELECT ExaminerCode
FROM Insurance.dbo.Claim;

SELECT DISTINCT ExaminerCode
FROM Insurance.dbo.Claim;


-- remueve SOLO las filas q sean exactamente iguales
SELECT DISTINCT ExaminerCode
	,InjuryState
	,JurisdictionID
	,YEAR(EntryDate) AS 'Entry year'
FROM Insurance.dbo.Claim;



SELECT DISTINCT ExaminerCode
FROM Insurance.dbo.Claim;
--							DAN =
SELECT ExaminerCode
FROM Insurance.dbo.Claim
GROUP BY ExaminerCode;



SELECT DISTINCT ExaminerCode
	,InjuryState
	,JurisdictionID
	,YEAR(EntryDate) AS 'Entry year'
FROM Insurance.dbo.Claim;
--							DAN =
SELECT ExaminerCode
	,InjuryState
	,JurisdictionID
	,YEAR(EntryDate) AS 'Entry year'
FROM Insurance.dbo.Claim
GROUP BY ExaminerCode
	,InjuryState
	,JurisdictionID
	,YEAR(EntryDate);


--								***
--								***
-- cuando hay que seleccionar por aggregate fcn => se usa GROUP BY
-- ya que DISTINCT no funciona con aggregate fcn
-- SELECT aa, bb, cc, SUM(dd)
-- FROM ________
-- GROUP BY aa, bb, cc

-- cuantas claims ha examinado cada uno
SELECT ExaminerCode, COUNT(ExaminerCode) AS 'Total claims by _'
FROM Insurance.dbo.Claim
GROUP BY ExaminerCode;


-- how many publishes does each user have in the 
-- ReservingTool table
SELECT ClaimNumber
	  ,EnteredBy
	  ,IsPublished
FROM Insurance.dbo.ReservingTool;

SELECT ClaimNumber
	  ,EnteredBy
	  ,IsPublished
FROM Insurance.dbo.ReservingTool
WHERE IsPublished = 1;



SELECT EnteredBy
	  ,COUNT(EnteredBy) AS 'Tot number of published'
FROM Insurance.dbo.ReservingTool
WHERE IsPublished = 1 --    sin esta me cuenta todas las filas
GROUP BY EnteredBy;





--					INTO

-- p' crear facilmente copias de una tabla usando algunos o todos
-- los records de la tabla original

SELECT *
FROM Insurance.dbo.Office;

-- crea una copia de la tabla ( Office2 ) de la otra
SELECT *
INTO Insurance.dbo.Office2
FROM Insurance.dbo.Office;


-- crea una tabla a partir de patient-table, con las columnas
-- especificadas y q en el businessName tienen la palabra "inc"
SELECT TOP 10 BusinessName, COUNT(BusinessName) AS Employees
--INTO Insurance.dbo.Top10Inc
FROM Insurance.dbo.Patient
WHERE BusinessName LIKE '%inc%'
GROUP BY BusinessName
ORDER BY COUNT(BusinessName) DESC;



--					IN

-- SELECT _____
-- FROM  ______
-- WHERE _______ IN ( ___ )


-- se usa a menudo xq es mas intuitivo y facil de escribir que
-- un OR

SELECT *
FROM Insurance.dbo.Attachment
WHERE EnteredBy = 'qkemp' OR EnteredBy = 'kgus' OR EnteredBy = 'unassigned';

SELECT *
FROM Insurance.dbo.Attachment
WHERE EnteredBy IN ('qkemp', 'kgus', 'unassigned');


-- con LIKE no se puede usar el IN , TIENE que usarse OR
SELECT *
FROM Insurance.dbo.Attachment
WHERE FileName LIKE '%.ppt' OR FileName LIKE '%.doc';



--					HAVING
-- SELECT ______
-- FROM ______
-- GROUP BY ________
-- HAVING SUM( ____ ) = _______

-- creada xq WHERE no puede incluir aggregate fncs

SELECT EnteredBy
	  ,COUNT(EnteredBy) AS 'Tot number of published'
FROM Insurance.dbo.ReservingTool
WHERE IsPublished = 1 --    sin esta me cuenta todas las filas
GROUP BY EnteredBy;

-- la misma pero q solo muestre las q tengan numero total > q 50
SELECT EnteredBy
	  ,COUNT(EnteredBy) AS 'Tot number of published'
FROM Insurance.dbo.ReservingTool
WHERE IsPublished = 1 --    sin esta me cuenta todas las filas
GROUP BY EnteredBy
HAVING COUNT(EnteredBy) > 50;





-- EJERCICIO 1
-- seleccionar todos los archivos pdf en la tabla Attachment 
-- q fueron ingresados po "lnikki"

SELECT FileName, EnteredBy
FROM Insurance.dbo.Attachment
WHERE FileName LIKE '%.pdf' AND EnteredBy = 'lnikki';




-- EJERCICIO 2
-- encontrar todos los records medical reserve type en la tabla reserveType
-- a medical record will either have a description indicationg it is
-- medical, or it will have the medical parent code ( as indicated by 
-- matching the 'parentID' to the 'ReserveTypeID' )
SELECT reserveTypeID, ParentID, ReserveTypeCode
FROM Insurance.dbo.ReserveType
WHERE reserveTypeID = 1 OR ParentID = 1;


-- ejercicio 3
-- which claimants ( denoted by 'claimantID ) have at least
-- 15 reserve changes?
-- each entry in the reserve table is a reserve change

SELECT ClaimantID, COUNT(ClaimantID)
FROM Insurance.dbo.Reserve
GROUP BY ClaimantID
HAVING COUNT(ClaimantID) >= 15
ORDER BY COUNT(ClaimantID) DESC;



-- ejercicio 4
-- copy the claim table schema (EL SCHEMA osea la tabla sin datos)
-- into a table called 'Claim2'

SELECT TOP 0 *
INTO Insurance.dbo.Claim2
FROM Insurance.dbo.Claim;



-- ejercicio 5
-- how many of each document type are in the attachment table?
-- RIGHT(FieldName, n)

SELECT RIGHT(FileName, 3) AS 'File type', COUNT(1)
FROM Insurance.dbo.Attachment
GROUP BY RIGHT(FileName, 3)
ORDER BY COUNT(1) DESC;


















--
--
--
-- ///////////////////////////////////////
-- ////////////		MOSHITO
-- ///////////////////////////////////////


--   INNER JOIN



-- SELECT c.customer_id,
--		  c.first_name,
--		  o.order_id
-- FROM customers c
-- JOIN orders o
--		ON c.customer_id = o.customer_id

-- me va a entregar solo donde customer_id se encuentren ambos, pero si
-- hay customers q no tienen order aun, estos no van a aparecer
-- ( ya q en la tabla orders no van a apacerece y por lo tanto
-- no van a tener la customer_id )
--
-- si quiero unir los datos y q aparescan todos los customers, tengan o no
-- una orden => ocupo un LEFT JOIN en este caso


-- con  LEFT JOIN
-- SELECT c.customer_id,
--		  c.first_name,
--		  o.order_id
-- FROM customers c
-- LEFT JOIN orders o
--		ON c.customer_id = o.customer_id

-- los datos de la segunda tabla q no tengan una correspondencia en
-- la primera simplemente van a aparecer como NULL




--
--
--				SUB QUERIES
--
--




-- Encontrar los productos que son mas caros que lechuga ( id = 3 )

-- SELECT *
-- FROM products
-- WHERE unit_price > ()



-- SELECT *
-- FROM products
-- WHERE unit_price > (
--			SELECT unit_price
--			FROM products
--			WHERE product_id = 3
-- )



-- encontrar en sql_hr database los empleados q ganan mas q la media
-- USE sql_hr

-- SELECT *
-- FROM employees
-- WHERE salary > (     ------------------> retorna un valor
--		SELECT AVG(salary)
--		FROM employees
-- )



--				IN
--
-- encontrar los productos q nunca han sido ordenados

-- SELECT *
-- FROM Products
-- WHERE product_id NOT IN (     ------------------> retorna una lista de valores
--			SELECT DISTINCT product_id
--			FROM order_items
-- )





-- encontrar clientes sin invoices en sql_invoicing

-- SELECT *
-- FROM clients
-- WHERE client_id NOT IN (
--			SELECT DISTINCT client_id
--			FROM invoices
-- )



--				sigue 46

-- SELECT *
-- FROM clients
-- WHERE client_id NOT IN (
--			SELECT DISTINCT client_id
--			FROM invoices
-- )

-- lo mismo con JOIN
-- con una INNER J -> me da solo los clients q tienen invoice
-- con una LEFT J -> me da todos los clientes con o sin invoice

-- SELECT *
-- FROM clients c
-- LEFT JOIN invoices i						| LEFT JOIN invoices USING (client_id)
--			ON c.client_id = i.client_id	|
--			WHERE invoice_id IS NULL;






-- find customers who have ordered lettuce ( id = 3 )
--	Select customer_id, first_name, last_name

-- USING sql_store






