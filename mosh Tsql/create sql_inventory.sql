
--DROP DATABASE IF EXISTS sql_inventory;

CREATE DATABASE sql_inventory;

USE sql_inventory;


CREATE TABLE products (
  product_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
  name VARCHAR(50) NOT NULL,
  quantity_in_stock INT NOT NULL,
  unit_price DECIMAL(4,2) NOT NULL,
);

INSERT INTO products VALUES ('Foam Dinner Plate',70,1.21);
INSERT INTO products VALUES ('Pork - Bacon,back Peameal',49,4.65);
INSERT INTO products VALUES ('Lettuce - Romaine, Heart',38,3.35);
INSERT INTO products VALUES ('Brocolinni - Gaylan, Chinese',90,4.53);
INSERT INTO products VALUES ('Sauce - Ranch Dressing',94,1.63);
INSERT INTO products VALUES ('Petit Baguette',14,2.39);
INSERT INTO products VALUES ('Sweet Pea Sprouts',98,3.29);
INSERT INTO products VALUES ('Island Oasis - Raspberry',26,0.74);
INSERT INTO products VALUES ('Longan',67,2.26);
INSERT INTO products VALUES ('Broom - Push',6,1.09);





