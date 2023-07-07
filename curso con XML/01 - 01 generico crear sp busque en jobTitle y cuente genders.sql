-- crear un sp q busque en [HumanResources].[Employee] de acuerdo a uno o dos parametros introducidos

-- si busco la palabra "vice" => debe buscar todos los jobTitle q tengan esa palabra y la cantidad de male y female que tenga c/u


USE AdventureWorks2019;
GO

-- PROBANDO
SELECT TOP 10 * FROM [HumanResources].[Employee];

SELECT JobTitle, Gender FROM HumanResources.Employee order by JobTitle;

SELECT	JobTitle,
		COUNT(CASE WHEN GENDER = 'M' THEN 1 END) AS Male,
		COUNT(CASE WHEN GENDER = 'F' THEN 1 END) AS Female
FROM HumanResources.Employee
GROUP BY JobTitle;

-- EJECUTANDO
EXEC dbo.Filter_procedure '  design  '

EXEC dbo.Filter_procedure '  design  ', '  engineer  '






