
--			68. Concatenation in SQL Server


-- customer_id	first_name	middle_name	last_name
-- 1			Linda		Mary		Flynn
-- 2			Jack		NULL		Thomas

--SELECT	customer_id,
--		first_name,
--		middle_name, 
--		last_name,
--		CONCAT(first_name, ' ', middle_name, ' ', last_name) AS full_name
--FROM XD;

-- ... full_name
--		Linda Mary Flynn
--		Jack  Thomas     <----- va a tener 2 espacios

-- para evitarlo

-- CONCAT(first_name, ' ' + middle_name, ' ', last_name) AS full_name

-- ya q algo + null es null y no me pone el espacio extra







-- sacar solo el primer nombre

SELECT LEFT('Adam Lee', CHARINDEX(' ', 'Adam Lee') - 1);

-- customer_id	customer_name
-- 1			Adam Lee
-- 2			Marcie Lowe

--SELECT	customer_id,
--		customer_name,
--		LEFT(customer_name, CHARINDEX(' ', customer_name) - 1)
--FROM XD;






--					70. Date and Time Functions



-- Date and Time Functions

USE SAMPLEDB
GO


SELECT GETDATE() AS get_date_value; -- viene del sistema operativo
SELECT CONVERT(DATE, GETDATE()) AS get_date_value;

-- son ='s ( CURRENT_TIMESTAMP sirve p' cualquier sql )
SELECT GETDATE() AS get_date_value, CURRENT_TIMESTAMP AS current_timestamp_value;


SELECT SYSDATETIME() AS sysdatetime_value; -- el mismo pero + preciso


SELECT CAST(SYSDATETIME() AS DATE) AS sysdatetime_value;

-- CAST function syntax: CAST( expression AS data_type)

SELECT CAST(SYSDATETIME() AS TIME) AS sysdatetime_value;


--UTC date and time functions:
SELECT GETUTCDATE() AS getutcdate_value, SYSUTCDATETIME() AS sysutcdatetime_value;


--selecting some columns from the hcm.employees table:
SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date
FROM hcm.employees;


--The DATEPART function returns an integer 
--representing the specified datepart of the specified date:

SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date,
	DATEPART(year, hire_date) AS hire_year
FROM hcm.employees;


SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date,
	DATEPART(year, hire_date) AS hire_year,
	DATEPART(month, hire_date) AS hire_month,
	DATEPART(day, hire_date) AS hire_day
FROM hcm.employees;

-- el nombre que aparece depende del lenguaje de la sesion de Windows
SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date,
	DATENAME(year, hire_date) AS hire_year,
	DATENAME(month, hire_date) AS hire_month,
	DATENAME(day, hire_date) AS hire_day
FROM hcm.employees;


-- Count of employees hired in each year:
SELECT 
	DATEPART(year, hire_date) as hire_year,
	COUNT(*) AS hire_count
FROM hcm.employees
GROUP BY DATEPART(year, hire_date);


-- Count of employees hired in each year:
SELECT 
	YEAR(hire_date) as hire_year,
	COUNT(*) AS hire_count
FROM hcm.employees
GROUP BY YEAR(hire_date);
 


--selecting some columns from the hcm.employees table:
SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date
FROM hcm.employees;


-- DATEADD function syntax: DATEADD( interval, number, date_expression )
-- Use DATEADD to add 5 years to the hire_date to know when each employees 5 year anniversary is:
SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date,
	DATEADD(year, 5, hire_date) AS five_years_date
FROM hcm.employees;


-- Use the DATEDIFF function to calculate how many days each employee has worked at the company as of today.
SELECT 
	employee_id, 
	first_name,
	last_name,
	birth_date,
	hire_date,
	DATEDIFF(day, hire_date, CURRENT_TIMESTAMP) AS days_employed
FROM hcm.employees;


/*
Some possible time intervals we can use in the first argument of the DATEADD and DATEDIFF functions:
year
month
dayofyear
day
week
weekday
hour
minute
second
millisecond
*/