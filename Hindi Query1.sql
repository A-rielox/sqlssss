--							DISTINCT

-- PARA QUE APARESCAN SOLO LAS DISTINTAS OCURRENCIAS ( SIN REPETIDOS )
-- DE LA COLUMNA JOBTITLE
USE AdventureWorks2019;

SELECT * 
	FROM [Person].Person;

SELECT Title, Suffix 
	FROM [Person].[Person];

SELECT DISTINCT Title, Suffix 
	FROM [Person].[Person];

SELECT DISTINCT JobTitle 
	FROM [HumanResources].[Employee];


--							CASE

-- ME PERMITE CAMBIAR EL VALOR DESPLEGADO PARA CIERTOS CASOS
SELECT NationalIDNumber, HireDate, VacationHours
	FROM HumanResources.Employee;

SELECT NationalIDNumber, HireDate, VacationHours,
	CASE WHEN VacationHours > 50
		 THEN 'Vacations over limit' ELSE 'Vacations within limit'
	END AS 'Vacation limit'
	FROM HumanResources.Employee;

-- CON EL BETWEEN SI ME INCLUYE LOS VALORES
SELECT NationalIDNumber, HireDate, VacationHours,
	CASE WHEN VacationHours > 50
		 THEN 'Vacations over limit'
		 WHEN VacationHours BETWEEN 20 AND 49
		 THEN 'Vacations OK'
		 ELSE 'Vacations within limit'
	END AS 'Vacation limit'
	FROM HumanResources.Employee;



--							WHERE

--		***
-- comparando con dates
SELECT BusinessEntityID, NationalIDNumber, BirthDate
	FROM HumanResources.Employee
	WHERE BirthDate > '1985-01-20';

-- solo con año mayor al 90
SELECT BusinessEntityID, NationalIDNumber, BirthDate
	FROM HumanResources.Employee
	WHERE YEAR(BirthDate) > '1985';


-- los operadores aritmeticos pueden ir en el SELECT o en el WHERE
-- CUIDADO con los ceros o null
SELECT ProductID, Name, ReorderPoint, StandardCost
	FROM Production.Product
	WHERE ReorderPoint / StandardCost > 3 AND StandardCost <> 0;

SELECT ProductID, Name, ReorderPoint, StandardCost
	FROM Production.Product
	WHERE NOT ProductID = 4;

-- AL CONCATENAR CON '+' SI HAY NULL => PONE TODO NULL,
-- CON CONCAT() SE SALTA EL NULL Y PONE EL RESTO
SELECT Title, FirstName, MiddleName, LastName,
	Title + ' ' + FirstName + ' ' + LastName AS '-- Full name --'
FROM Person.Person;

SELECT Title, FirstName, MiddleName, LastName,
	CONCAT(Title, ' ', FirstName, ' ', LastName) AS '-- Full name --'
FROM Person.Person;



-- unir con un separador particular
SELECT FirstName, BusinessEntityID,
		CONCAT_WS('.','adventure-works','com') AS 'Domain'
	FROM Person.Person;




-- BETWEEN
SELECT ProductID, Name, Color
	FROM Production.Product
	-- WHERE ProductID >= 1 AND ProductID <= 500;
	WHERE ProductID BETWEEN 1 AND 496;


-- cuidado al trabajar con fechas con time-stamp, ya que el rango 
-- mayor, si es 1980-05-01 me va a incluir solo hasta esa fecha con 
-- time 00:00:00.000, si es con 1980-05-01 00:00:00.001 hacia arriba
-- ya NO me la va a incluir
SELECT PurchaseOrderID, ModifiedDate
	FROM Purchasing.PurchaseOrderDetail
	WHERE ModifiedDate BETWEEN '1980-05-01' AND '2000-05-01';
-- para q me incluya el dia, mejor pongo hasta el dia que sigue



-- si tengo una fecha sin time-stamp como '1980-05-01' y quiero 
-- mostrarla con time-stamp => ocupo CAST()
-- en este caso BirthDate es tipo date (yyyy-mm-dd) y quiero que
-- aparesca como dateTime (yyyy-mm-dd 00:00:00.000)
SELECT BusinessEntityID, CAST(BirthDate AS datetime)
	FROM HumanResources.Employee;




-- IN , PARA MULTIPLES VALORES DE UN MISMO FIELD
SELECT ProductID, Name, StandardCost, SafetyStockLevel
	FROM Production.Product
	-- WHERE ProductID = 1 OR ProductID = 3 OR ProductID = 20;
	WHERE ProductID IN (1, 3, 20);





--
--
--

-- [charss]
-- hace match con UNO de los chars que se ponen dentro de los corchetes

-- EL % ES PORQUE ESTAN EN BD CON UN ESPACIO AL FINAL
SELECT * 
	FROM Person.StateProvince
	WHERE StateProvinceCode LIKE 'A[BKL]%'

-- AB 
-- AK 
-- AL


-- [char-char]
-- busca en el rango entre los chars
SELECT * 
	FROM Production.Product
	--WHERE ProductNumber LIKE 'L[IJKLM]%';
	WHERE ProductNumber LIKE 'L[I-M]%';
-- LI-7160
-- LI-8000
-- LJ-1213
-- LJ-1220


SELECT *
	FROM Production.Product
	WHERE ProductNumber LIKE 'L[A-Z]%';
-- LI-7160
-- LI-8000
-- LJ-1213
-- LJ-1220
-- LT-H902
-- LT-H903

SELECT *
	FROM Production.Product
	WHERE ProductNumber LIKE 'L[A-Z]-[0-9]%';
-- LE-7160
-- LI-1000
-- LJ-1220
-- LN-1024
-- LN-1032
-- LW-9160
-- LJ-0192-S



--
--
--			ORDER BY
--
--
USE AdventureWorks2019;

SELECT JobCandidateID, ModifiedDate
	FROM HumanResources.JobCandidate
	ORDER BY ModifiedDate DESC;


SELECT CONCAT(City,', ',AddressLine1, ' - ', AddressLine2) AS 'Direccion'
	FROM Person.Address
	WHERE AddressLine2 IS NOT NULL
	ORDER BY City;

-- ORDENANDO POR VARIAS
SELECT ProductID, Name, StandardCost, ListPrice
	FROM Production.Product
	WHERE StandardCost BETWEEN 200 AND 300
	ORDER BY StandardCost, ListPrice DESC;

-- HACE REFERENCIA A LAS COLUMNAS DEL SELECT
-- ORDENARIA POR StandardCost
SELECT ProductID, Name, StandardCost, ListPrice
	FROM Production.Product
	ORDER BY 3;

-- tambien se puede ordenar por columnas que no esten en el SELECT



-- tambien acepta funciones

-- ORDENAR POR EL LENGTH DE AddressLine1
SELECT AddressLine1, LEN(AddressLine1) AS 'Length'
	FROM Person.Address
	ORDER BY LEN(AddressLine1);


--							OFFSET - FETCH

--	OFFSET numero de filas que se salta
-- FETCH numero de filas que agarra (opcional)

-- para q se salte las 5 primeras
SELECT ProductID, Name, StandardCost, ListPrice
	FROM Production.Product
	ORDER BY 3
	OFFSET 5 ROWS;


SELECT ProductID, Name, StandardCost, ListPrice
	FROM Production.Product
	ORDER BY 3
	OFFSET 5 ROWS
	FETCH NEXT 20 ROWS ONLY;


--            WITH TIES		***
-- Básicamente cuando incluyes la clausula WITH TIES le indicas
-- al motor que no te excluya aquellas filas que se encuentra
-- "empatadas" a nivel de los resultados, cosa que sucede si solamente
-- usas un SELECT TOP,

-- los dos primeros tiene el mismo precio (el + alto), => asi agarro 
-- todas las que tengan el mismo precio
SELECT TOP 2 ProductID, Name, StandardCost
	FROM Production.Product
	ORDER BY StandardCost DESC;

SELECT TOP 2 WITH TIES ProductID, Name, StandardCost
	FROM Production.Product
	ORDER BY StandardCost DESC;



--		TOP XD PERCENT
SELECT TOP 10 PERCENT SalesOrderID, SalesOrderDetailID,OrderQty
	FROM Sales.SalesOrderDetail
	ORDER BY OrderQty DESC;



--
--
--			GROUP BY
--
--
--						***
-- en el SELECT van solo las columnas del group by o agregate func
--

SELECT SalesOrderID, OrderQty
	FROM Sales.SalesOrderDetail
	ORDER BY SalesOrderID, OrderQty;

SELECT SalesOrderID, SUM(OrderQty)
	FROM Sales.SalesOrderDetail
	GROUP BY SalesOrderID;



SELECT *
	FROM HumanResources.Department;



-- NO puedo poner p.e. OrderQty o *
SELECT GroupName
	FROM HumanResources.Department
	GROUP BY GroupName;

SELECT GroupName, COUNT(GroupName)
	FROM HumanResources.Department
	GROUP BY GroupName;

-- primero es "group by" y luego "order by"

-- agrupar por varias
SELECT ProductID, Shelf,Quantity
	FROM Production.ProductInventory;

SELECT ProductID, Shelf,SUM(Quantity) AS 'Tot quantity'
	FROM Production.ProductInventory
	GROUP BY ProductID, Shelf
	ORDER BY ProductID;



--
--
--			NUMERIACAL FUNC
--
--

--		SUM ignora los null

SELECT StandardCost
	FROM Production.Product;

SELECT SUM(StandardCost)
	FROM Production.Product;
	-- estos son iguales
SELECT SUM(ALL StandardCost)
	FROM Production.Product;

	--
	-- suma solo los distintos
SELECT SUM(DISTINCT StandardCost)
	FROM Production.Product;


--		AVG IGNORA LOS NULL			***


--		COUNT IGNORA LOS NULL			***

SELECT *
	FROM Production.Product;
	

-- la cantidad de columnas
SELECT COUNT(*)
	FROM Production.Product;

-- la cantidad de elementos en la columna color
SELECT COUNT(Color)
	FROM Production.Product;
	-- la cantidad de columnas en esta de abajo				***
SELECT COUNT(*)
	FROM Production.Product
	WHERE Color IS NOT NULL;




SELECT MIN(StandardCost)
	FROM Production.Product;

-- NO SE PUEDEN OCUPAR "WHERE" CON AGGREGATE FUNC
SELECT MIN(StandardCost)
	FROM Production.Product
	-- WHERE MinStdCost > 0;
-- para esto se ocupa "HAVING"

-- ABS valor absoluto , o numero si es que es $234
-- CEILING, FLOOR

SELECT RAND(); -- ME ENTREGA UN VALOR RANDOM ENTRE 0 Y 1

SELECT ROUND(345.678, 2) -- REDONDEA A 2 DECIMALES



--
--		CHARINDEX() posicion de sub-string en string

--CHARINDEX(subStr, mainStr, startPosition)

SELECT CHARINDEX('D','DAD')		-- 1
SELECT CHARINDEX('D','DAD',2)	-- 3


-- numero de bytes incluidos los espacios al principio y final
SELECT FirstName, DATALENGTH(FirstName)
	FROM Person.Person;


-- formatea			***
SELECT FORMAT(19800501,'####-##-##') -- 1980-05-01


-- selecciona un numero de caracteres del lado izq(del comienzo del str)
-- LEFT(mainString, numOfChars)
SELECT RIGHT('Arielox',2); -- > ox

--					***
-- calcula el length de un string, IGNORA espacios al principio y final
-- LEN(STR)

SELECT LEN('Arielox'); -- > 7

-- LOWER() Y UPPER() p' cambiar la capitalizacion

-- LTRIM() remueve blaks antes del str
-- RTRIM()
-- TRIM()

-- PATINDEX() posicion de la primera ocurrencia de un patron en un str
-- REPLACE()  reemplaza todas la ocurrencias ...
-- REPLICATE() repite un str un numero de veces

SELECT Name, PATINDEX('%Ball%', Name)
	FROM Production.Product
	WHERE Name LIKE '%Ball%';

-- REVERSE() reverses the str
-- STR() retorna un numero como un str
-- SUBSTRING(MainStr, StartingPos, Length) ...

SELECT FirstName, REVERSE(FirstName)
FROM Person.Person; -- ARIEL | LEIRA




--
--
--				DATES
--
--

--		DateAdd()
-- añade date o tiempo a otra date
-- DateAdd(format-interval, number, dateVal)

--		DateDiff()
-- DateDiff(datePart, date1, date2)

-- añado 3 años a la col anterior
SELECT ProductID, SellStartDate, DATEADD(YYYY, 3, SellStartDate)
FROM Production.Product;


SELECT ProductID, SellStartDate, SellEndDate,
	DATEDIFF(YYYY, SellStartDate, SellEndDate)
FROM Production.Product
WHERE SellEndDate IS NOT NULL;


--			DatePart()
-- retorna una parte de la fecha como integer
--	DatePart(date-interval, dateField)
--	DatePart(yyyy, sellStartDate)

--			Day()
-- retorna el dia de la fecha
--	Day(fecha)

--			Month()
-- ...

--			Year()
-- ...


--			DateName()				***
-- retorna una parte de la fecha como str
-- como DatePart() pero retorna str
--	DateName(date-interval, dateField)
--	DateName(yyyy, sellStartDate)

-- con datePart(month, 1980-05-01) --> 5
-- con dateName(month, 1980-05-01) --> May

--			eoMonth()
-- retorna la fecha con ultimo dia desde una fecha particular
-- eoMonth(fecha)
-- eoMonth(2011-05-12) 2011-05-31

--			Current_Timestamp
-- retorna la fecha y tiempo del sistema (sin timeZone)

--			GetDate()
-- igual que Current_Timestamp

-- SysDateTime()
-- igual pero con mas precision

-- SysDateTimeOffSet()
-- system date with time ( con time zone )




--
--			isDate()
-- retorna 1 si es fecha valida, sino, 0
SELECT ISDATE('1980-05-01') -- 1
SELECT ISDATE('1980-05-32') -- 0


--
--			isNull()
-- si la primera expresion es NULL => devuelve la segunda, si no,
-- devuelve el mismo primer arg
-- SELECT ISNULL(NULL, 'Abc') --> Abc

--
--			isNumeric()
-- retorna 1 (true) o 0 (false) si es numero o nel prro







--									***
--			COALESCE()
-- retorna el primer non-NULL value de una lista
-- COALESCE(val1, val2, ..., valN)

SELECT Title, MiddleName, COALESCE(Title, MiddleName)
FROM Person.Person;
-- NULL		J		J
-- NULL		Lee		Lee
-- NULL		NULL	NULL
-- NULL		NULL	NULL
-- Ms.		A		Ms.


--									***
-- nullIf()
-- retorna NULL si las expresiones son iguales, si NO retorna la 1ra
-- NULLIF(expression1, expression2)

-- SELECT NULLIF(10, 10)  NULL
-- SELECT NULLIF(10, 12)  10



--			CONVERT()
-- convierte a otra data-type
-- CONVERT(toDataType, expression)

-- convertir de money a int
-- EN ESTE CASO ME VA A REMOVER LOS DECIMALES 
SELECT StandardCost, CONVERT(INT, StandardCost)
FROM Production.Product
WHERE StandardCost <> 0;


--									***
--			iif()
-- es como el terciario
-- toma 3 args, si el 1ro es true => devuelve el 2do, sino, el 3ro

SELECT StandardCost, ListPrice, 
	IIF(ListPrice >= StandardCost, 'Profit', 'Loss')
FROM Production.Product;





--					***
--
--						HAVING


-- p' filtrar los records de aggretate-fcns o de GroupBy 

-- no se puede usar el where => uso el HAVING
SELECT MAX(StandardCost)
FROM Production.Product  -- --> 2171,2942
-- WHERE MAX(StandardCost) > 0;


SELECT MAX(StandardCost)
FROM Production.Product
HAVING MAX(StandardCost) > 2172;  -- no hay

--


SELECT DueDate, OrderQty
	FROM Purchasing.PurchaseOrderDetail
	ORDER BY DueDate;
	
SELECT DueDate, SUM(OrderQty)
	FROM Purchasing.PurchaseOrderDetail
	GROUP BY DueDate
	ORDER BY DueDate;



--

SELECT DueDate, OrderQty
FROM Purchasing.PurchaseOrderDetail
WHERE YEAR(DueDate) > 2011 AND MONTH(DueDate) < 9


-- PUEDO poner en el WHERE las q NO sean aggregate fnc
-- si quiero filtrar con una aggregate => pongo HAVING
SELECT DueDate, SUM(OrderQty)
FROM Purchasing.PurchaseOrderDetail
WHERE YEAR(DueDate) > 2011 AND MONTH(DueDate) < 9
GROUP BY DueDate
HAVING SUM(OrderQty) < 6000; --> va despues del GROUP BY







--
--
--				SUBQUERIES
--
--




-- p' SELECT, INSERT, UPDATE & DELETE

-- los empleados de la primera tabla, pero que la columna
-- BusinessEntityID tambien aparesca en la otra tabla y q alla sea <= q 100
-- tambien se podria hacer con un JOIN

SELECT BusinessEntityID, NationalIDNumber, JobTitle, HireDate
FROM HumanResources.Employee
WHERE BusinessEntityID IN
	( 
	  SELECT BusinessEntityID
	  FROM HumanResources.EmployeeDepartmentHistory
	  WHERE BusinessEntityID <= 100
	)
ORDER BY BusinessEntityID;



-- pa sacar el 2nd max values del unitPrice
-- "de los 2 max vals, obtener el 2do"
SELECT ProductID, UnitPrice
FROM Purchasing.PurchaseOrderDetail
ORDER BY UnitPrice DESC;

SELECT MIN(UnitPrice)
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice IN
	( 
		SELECT TOP 2 UnitPrice
		FROM Purchasing.PurchaseOrderDetail
		ORDER BY UnitPrice DESC
	);


-- pa sacar el 2nd max values del unitPrice, tomando solo los distintos
SELECT MIN(UnitPrice)
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice IN
	( 
	  SELECT DISTINCT TOP 2 UnitPrice
	  FROM Purchasing.PurchaseOrderDetail
	  ORDER BY UnitPrice DESC
	);
-- ó
SELECT MIN(UnitPrice)
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice IN
	( 
	  SELECT TOP 2 UnitPrice
	  FROM Purchasing.PurchaseOrderDetail
	  GROUP BY UnitPrice
	  ORDER BY UnitPrice DESC
	);


-- MOSTRAR purchaseOrderID, unitPrice de PurchaseOrderDetail Table, donde unitPrice
-- es mayor q avg of list price form products table

SELECT PurchaseOrderID, UnitPrice
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice > 
	(
		SELECT AVG(ListPrice) -- -> 438,6662
		FROM Production.Product
	);

-- SERIA LO MISMO QUE
SELECT PurchaseOrderID, UnitPrice
FROM Purchasing.PurchaseOrderDetail
WHERE UnitPrice > 438.6662;
		




--						EXISTS
--			EJECUTAR UN QUERY SOLO SI EXISTE UN VALOR
-- EXISTS solo retorna true o false


-- ME ENTREGA LA TABLA SOLO SI EXISTE UN DEPARTMENT QUE SE LLAME SALES
SELECT BusinessEntityID, JobTitle
FROM HumanResources.Employee
WHERE EXISTS
	(
	  SELECT DepartmentID, Name
	  FROM HumanResources.Department
	  WHERE Name = 'Sales'
	);

-- PUEDO SEGUIR FILTRANDO
SELECT BusinessEntityID, JobTitle
FROM HumanResources.Employee
WHERE EXISTS
	(
	  SELECT DepartmentID
	  FROM HumanResources.Department
	  WHERE Name = 'Sales'
	) AND JobTitle LIKE '%Sales%';



-- p' sacar una columna de una subquery ( de una expresion )

-- SELECT *
--	FROM Purchasing.PurchaseOrderDetail AS pod

SELECT PurchaseOrderID, TaxAmt,
(
	SELECT SUM(OrderQty)
	FROM Purchasing.PurchaseOrderDetail AS pod
	WHERE pod.PurchaseOrderID = poh.PurchaseOrderID
	GROUP BY pod.PurchaseOrderID 
) AS SumOrderQty
FROM Purchasing.PurchaseOrderHeader AS poh


-- para una aggregate fcn de una aggregate fcn
SELECT PurchaseOrderID, UnitPrice
FROM Purchasing.PurchaseOrderDetail;


SELECT MIN(UnitPrice), PurchaseOrderID
FROM Purchasing.PurchaseOrderDetail
GROUP BY PurchaseOrderID;

--AHORA EL AVG DE TODA LA COL MIN() DE ARRIBA
SELECT AVG(minUnitPrice) AS AvgMinUnitPricePerOrder
FROM
(	-- en este, como agrupo => agarro el min de c/PurchaseOrderID
	SELECT MIN(UnitPrice) AS minUnitPrice, PurchaseOrderID
	FROM Purchasing.PurchaseOrderDetail
	GROUP BY PurchaseOrderID
) AS MinPriceOrder; -- TIENE Q IR ESTE ALIAS Y EL OTRO P' HACER REFERENCIA EN AVG()


-- ANY --> retorna true si qualquiera de los valores en la sub-query 
--			cumple la condicion

-- ALL --> retorna true si TODOS de los valores en la sub-query 
--			cumplen la condicion


SELECT PurchaseOrderID, DueDate, UnitPrice
FROM Purchasing.PurchaseOrderDetail;

SELECT OrderDate
FROM Purchasing.PurchaseOrderHeader;

-- el DueDate de la 1ra debe estar como fecha en OrderDate de la 2da
-- la fecha del PurchaseOrderID del dato 5-72 NO se encuentran entre las fechas
-- del 2do
SELECT PurchaseOrderID, DueDate, UnitPrice
FROM Purchasing.PurchaseOrderDetail
WHERE DueDate = ANY (
	SELECT OrderDate
	FROM Purchasing.PurchaseOrderHeader
);


-- me entrega las fechas de la primera q no aparescan en ni una fecha de la 2da
SELECT PurchaseOrderID, DueDate, UnitPrice
FROM Purchasing.PurchaseOrderDetail
WHERE DueDate <> ALL (
	SELECT OrderDate
	FROM Purchasing.PurchaseOrderHeader
);



--					VOY EN 
--								7. Union and Intersections
-- union combina multiples SELECT y remueve duplicados
-- UNION ALL deja los duplicados

-- los SELECT deben tener las mismas columnas en el mismo orden








--
--
--






--
--
--					8	JOINS



--	IMPLICIT
--
-- SELECT col1, col2
-- FROM tableA, tableB
-- WHERE condition

SELECT PurchaseOrderID,
		PurchaseOrderDetailID,
		OrderQty
FROM Purchasing.PurchaseOrderDetail


SELECT PurchaseOrderID,
		OrderDate,
		ShipDate
FROM Purchasing.PurchaseOrderHeader

SELECT POD.PurchaseOrderID,
		PurchaseOrderDetailID,
		OrderQty,
		OrderDate,
		ShipDate
FROM Purchasing.PurchaseOrderDetail AS POD,Purchasing.PurchaseOrderHeader AS POH
WHERE POD.PurchaseOrderID = POH.PurchaseOrderID



--
--

--			INNER JOIN

-- da lo mismo que el implicit join
-- entrega los matching records en ambas tablas


-- SELECT tA.col1, tA.col2, ...
-- FROM tableA AS tA
--		INNER JOIN
-- tableB as tB
-- ON tA.col1 = tB.col1

SELECT POD.PurchaseOrderID,
		PurchaseOrderDetailID,
		OrderQty,
		OrderDate, --2
		ShipDate	--2
FROM Purchasing.PurchaseOrderDetail AS POD
	INNER JOIN
Purchasing.PurchaseOrderHeader AS POH
ON POD.PurchaseOrderID = POH.PurchaseOrderID
WHERE YEAR(POH.OrderDate) = 2012



--     4.		LEFT JOIN


















