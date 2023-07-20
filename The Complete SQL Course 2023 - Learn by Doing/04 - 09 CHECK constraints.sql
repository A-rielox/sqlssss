


USE SAMPLEDB
GO


-- Selecting from the hcm.departments table:
SELECT *
FROM hcm.departments;


-- Query information schema views to get metadata on constraints on hcm.departments table:
SELECT 
	tc.TABLE_SCHEMA,
	tc.TABLE_NAME,
	tc.CONSTRAINT_TYPE,
	ccu.COLUMN_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS tc 
JOIN INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE ccu
ON tc.CONSTRAINT_NAME = ccu.CONSTRAINT_NAME
AND tc.TABLE_NAME = ccu.TABLE_NAME
AND tc.TABLE_SCHEMA = ccu.TABLE_SCHEMA
WHERE tc.TABLE_SCHEMA = 'hcm' AND tc.TABLE_NAME = 'departments';


-- Check that the department_name column has only unique values
SELECT COUNT(*) as total_count, COUNT(DISTINCT department_name) as unique_value_count
FROM hcm.departments;


-- Challenge Solution - Add a UNIQUE constraint on to the department_name column in the hcm.departments table:
ALTER TABLE hcm.departments 
ADD CONSTRAINT uk_departments_department_name UNIQUE (department_name);




/*
--Attempting to insert a duplicate value for department_name:
INSERT INTO hcm.departments (department_name, location_id) VALUES ('Administration', 1800);

--Insert statement does not work because of the newly added UNIQUE constraint.
*/

