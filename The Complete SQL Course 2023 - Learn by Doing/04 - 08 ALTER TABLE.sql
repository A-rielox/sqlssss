
--					ALTER TABLE

-- Añadir columna

ALTER TABLE table_name
ADD column_name column_data_type;




-- Añadir varias columnas

ALTER TABLE table_name
ADD	column_name1 column1_data_type,
	column_name2 column2_data_type
;



-- modificar la definicion de una columna

ALTER TABLE table_name
ALTER COLUMN column_name column_data_type;

-- ej
ALTER TABLE dbo.products
ALTER COLUMN product_name VARCHAR(50) NOT NULL;

-- si ya tiene nulls primero voy a tener q remover los null q ya existan


/*

-- Create table oes.products
CREATE TABLE oes.products 
(
  product_id INT NOT NULL IDENTITY,
  product_name VARCHAR(100) NOT NULL,
  category_id INT NOT NULL,
  list_price NUMERIC(19,4) NOT NULL CONSTRAINT dft_products_list_price DEFAULT(0),
  discontinued BIT NOT NULL CONSTRAINT dft_products_discontinued DEFAULT(0),
  CONSTRAINT pk_products_product_id PRIMARY KEY (product_id),
  CONSTRAINT fk_products_product_categories FOREIGN KEY (category_id)
    REFERENCES oes.product_categories (category_id),
  CONSTRAINT chk_products_list_price CHECK(list_price >= 0)
);

CREATE INDEX ix_products_category_id ON oes.products(category_id);



*/



--	drop a column

ALTER TABLE table_name
DROP COLUMN column_name;




--				RENOMBRAR UNA COLUMNA

-- sp_rename 'schema_name.table_name.old_column_name', 'new_column_name', 'COLUMN';







--			OTTOS

ALTER TABLE dbo.emp
DROP CONSTRAINT fk_emp_dept_id;
GO



-- Challenge Solution - Add a UNIQUE constraint on to the department_name column in the hcm.departments table:
ALTER TABLE hcm.departments 
ADD CONSTRAINT uk_departments_department_name UNIQUE (department_name);



-- Add a check constraint on the salary column in the hcm.employees table 
-- to ensure that salary is greater than or equal to zero:
ALTER TABLE hcm.employees 
ADD CONSTRAINT chk_employees_salary CHECK (salary >= 0);
-- ADD CONSTRAINT constraint_name CHECK (column_name condition);

-- si pongo "> 0" o ">= 0" como sea puede meter nulls, pa eso es constraint de null


-- p' tabla con col de colores p.e., puedo poner una 
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
CHECK (color IN ('red', 'blue', 'yellow', 'black'));

-- p'q solo permita esos colores
