
CREATE DATABASE sql_store;
GO;

USE sql_store;

CREATE TABLE customers(
	customer_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
	first_name NVARCHAR(50) NOT NULL,
	last_name NVARCHAR(50) NOT NULL,
	birth_date DATE,
	phone NVARCHAR(50),
	address NVARCHAR(50) NOT NULL,
	city NVARCHAR(50) NOT NULL,
	state CHAR(2) NOT NULL,
	points INT NOT NULL
);

INSERT INTO customers VALUES ('Babara','MacCaffrey','1986-03-28','781-932-9754','0 Sage Terrace','Waltham','MA',2273);
INSERT INTO customers VALUES ('Ines','Brushfield','1986-04-13','804-427-9456','14187 Commercial Trail','Hampton','VA',947);
INSERT INTO customers VALUES ('Freddi','Boagey','1985-02-07','719-724-7869','251 Springs Junction','Colorado Springs','CO',2967);
INSERT INTO customers VALUES ('Ambur','Roseburgh','1974-04-14','407-231-8017','30 Arapahoe Terrace','Orlando','FL',457);
INSERT INTO customers VALUES ('Clemmie','Betchley','1973-11-07',NULL,'5 Spohn Circle','Arlington','TX',3675);
INSERT INTO customers VALUES ('Elka','Twiddell','1991-09-04','312-480-8498','7 Manley Drive','Chicago','IL',3073);
INSERT INTO customers VALUES ('Ilene','Dowson','1964-08-30','615-641-4759','50 Lillian Crossing','Nashville','TN',1672);
INSERT INTO customers VALUES ('Thacher','Naseby','1993-07-17','941-527-3977','538 Mosinee Center','Sarasota','FL',205);
INSERT INTO customers VALUES ('Romola','Rumgay','1992-05-23','559-181-3744','3520 Ohio Trail','Visalia','CA',1486);
INSERT INTO customers VALUES ('Levy','Mynett','1969-10-13','404-246-3370','68 Lawn Avenue','Atlanta','GA',796);

-- -----------------------------

CREATE TABLE products (
  product_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
  name NVARCHAR(50) NOT NULL,
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


-- -----------------------------

CREATE TABLE shippers (
  shipper_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
  name NVARCHAR(50) NOT NULL,
);

INSERT INTO shippers VALUES ('Hettinger LLC');
INSERT INTO shippers VALUES ('Schinner-Predovic');
INSERT INTO shippers VALUES ('Satterfield LLC');
INSERT INTO shippers VALUES ('Mraz, Renner and Nolan');
INSERT INTO shippers VALUES ('Waters, Mayert and Prohaska');

-- -----------------------------

CREATE TABLE order_statuses (
  order_status_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
  name NVARCHAR(50) NOT NULL,
);
INSERT INTO order_statuses VALUES ('Processed');
INSERT INTO order_statuses VALUES ('Shipped');
INSERT INTO order_statuses VALUES ('Delivered');


-- -----------------------------


CREATE TABLE orders (
  order_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
  customer_id INT NOT NULL FOREIGN KEY REFERENCES customers(customer_id),
  order_date DATE NOT NULL,
  status INT NOT NULL DEFAULT 1 FOREIGN KEY REFERENCES order_statuses(order_status_id),
  comments varchar(2000) DEFAULT NULL,
  shipped_date date DEFAULT NULL,
  shipper_id INT DEFAULT NULL FOREIGN KEY REFERENCES shippers(shipper_id),
);

INSERT INTO orders VALUES (6,'2019-01-30',1,NULL,NULL,NULL);
INSERT INTO orders VALUES (7,'2018-08-02',2,NULL,'2018-08-03',4);
INSERT INTO orders VALUES (8,'2017-12-01',1,NULL,NULL,NULL);
INSERT INTO orders VALUES (2,'2017-01-22',1,NULL,NULL,NULL);
INSERT INTO orders VALUES (5,'2017-08-25',2,'','2017-08-26',3);
INSERT INTO orders VALUES (10,'2018-11-18',1,'Aliquam erat volutpat. In congue.',NULL,NULL);
INSERT INTO orders VALUES (2,'2018-09-22',2,NULL,'2018-09-23',4);
INSERT INTO orders VALUES (5,'2018-06-08',1,'Mauris enim leo, rhoncus sed, vestibulum sit amet, cursus id, turpis.',NULL,NULL);
INSERT INTO orders VALUES (10,'2017-07-05',2,'Nulla mollis molestie lorem. Quisque ut erat.','2017-07-06',1);
INSERT INTO orders VALUES (6,'2018-04-22',2,NULL,'2018-04-23',2);



-- -----------------------------


CREATE TABLE order_items (
  order_id INT NOT NULL FOREIGN KEY REFERENCES orders(order_id),
  product_id INT NOT NULL FOREIGN KEY REFERENCES products(product_id),
  quantity INT NOT NULL,
  unit_price DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (order_id, product_id)
  --PRIMARY KEY (`order_id`,`product_id`),
  --KEY `fk_order_items_products_idx` (`product_id`),
  --CONSTRAINT `fk_order_items_orders` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`) ON UPDATE CASCADE,
  --CONSTRAINT `fk_order_items_products` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`) ON UPDATE CASCADE
) ;
INSERT INTO order_items VALUES (1,4,4,3.74);
INSERT INTO order_items VALUES (2,1,2,9.10);
INSERT INTO order_items VALUES (2,4,4,1.66);
INSERT INTO order_items VALUES (2,6,2,2.94);
INSERT INTO order_items VALUES (3,3,10,9.12);
INSERT INTO order_items VALUES (4,3,7,6.99);
INSERT INTO order_items VALUES (4,10,7,6.40);
INSERT INTO order_items VALUES (5,2,3,9.89);
INSERT INTO order_items VALUES (6,1,4,8.65);
INSERT INTO order_items VALUES (6,2,4,3.28);
INSERT INTO order_items VALUES (6,3,4,7.46);
INSERT INTO order_items VALUES (6,5,1,3.45);
INSERT INTO order_items VALUES (7,3,7,9.17);
INSERT INTO order_items VALUES (8,5,2,6.94);
INSERT INTO order_items VALUES (8,8,2,8.59);
INSERT INTO order_items VALUES (9,6,5,7.28);
INSERT INTO order_items VALUES (10,1,10,6.01);
INSERT INTO order_items VALUES (10,9,9,4.28);



-- -----------------------------



CREATE TABLE order_item_notes (
  note_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
  order_Id INT NOT NULL,
  product_id INT NOT NULL,
  note VARCHAR(255) NOT NULL
);
  --PRIMARY KEY (note_id));

INSERT INTO order_item_notes (order_Id, product_id, note) 
	VALUES ( 1, 2, 'first note');
INSERT INTO order_item_notes (order_Id, product_id, note) 
	VALUES ( 1, 2, 'second note');






