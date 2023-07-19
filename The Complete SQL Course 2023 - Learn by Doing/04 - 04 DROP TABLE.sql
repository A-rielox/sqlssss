
USE SAMPLEDB
GO


SELECT *
FROM dbo.dept;


SELECT *
FROM dbo.emp;


DROP TABLE SAMPLEDB.dbo.dept;
GO

/*
We need to either drop the child table first i.e. dbo.emp or
drop the foreign key constraint on the child table that is 
referencing the parent table dbo.dept
*/

ALTER TABLE dbo.emp
DROP CONSTRAINT fk_emp_dept_id;
GO

--Now we can drop the dbo.dept table:
DROP TABLE SAMPLEDB.dbo.dept;
GO

SELECT *
FROM dbo.dept;


-- If we try and drop a table that no longer exists then we get an error message:
DROP TABLE dbo.dept;
GO

-- To avoid this we can use IF EXISTS to only drop a table if it currently exists.
-- Note that the IF EXISTS option is only available from SQL Server 2016 onwards:
DROP TABLE IF EXISTS dbo.dept;
GO

-- Older versions of SQL Server can use the following equivalent method:
IF OBJECT_ID (N'SAMPLEDB.dbo.dept', N'U') IS NOT NULL DROP TABLE dbo.dept;




