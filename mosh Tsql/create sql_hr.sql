--DROP DATABASE IF EXISTS `sql_hr`;

CREATE DATABASE sql_hr;

USE sql_hr;


CREATE TABLE offices (
  office_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
  address VARCHAR(50) NOT NULL,
  city VARCHAR(50) NOT NULL,
  state VARCHAR(50) NOT NULL,
);

INSERT INTO offices VALUES ('03 Reinke Trail','Cincinnati','OH');
INSERT INTO offices VALUES ('5507 Becker Terrace','New York City','NY');
INSERT INTO offices VALUES ('54 Northland Court','Richmond','VA');
INSERT INTO offices VALUES ('08 South Crossing','Cincinnati','OH');
INSERT INTO offices VALUES ('553 Maple Drive','Minneapolis','MN');
INSERT INTO offices VALUES ('23 North Plaza','Aurora','CO');
INSERT INTO offices VALUES ('9658 Wayridge Court','Boise','ID');
INSERT INTO offices VALUES ('9 Grayhawk Trail','New York City','NY');
INSERT INTO offices VALUES ('16862 Westend Hill','Knoxville','TN');
INSERT INTO offices VALUES ('4 Bluestem Parkway','Savannah','GA');



-- ----------------------------------------------


CREATE TABLE employees (
  employee_id INT PRIMARY KEY NOT NULL IDENTITY(1,1),
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  job_title VARCHAR(50) NOT NULL,
  salary INT NOT NULL,
  reports_to INT DEFAULT NULL FOREIGN KEY REFERENCES employees(employee_id),
  office_id INT NOT NULL FOREIGN KEY REFERENCES offices(office_id),
);


SET IDENTITY_INSERT employees ON;

INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (37270,'Yovonnda','Magrannell','Executive Secretary',63996,NULL,10);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (33391,'D''arcy','Nortunen','Account Executive',62871,37270,1);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (37851,'Sayer','Matterson','Statistician III',98926,37270,1);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (40448,'Mindy','Crissil','Staff Scientist',94860,37270,1);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (56274,'Keriann','Alloisi','VP Marketing',110150,37270,1);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (63196,'Alaster','Scutchin','Assistant Professor',32179,37270,2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (67009,'North','de Clerc','VP Product Management',114257,37270,2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (67370,'Elladine','Rising','Social Worker',96767,37270,2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (68249,'Nisse','Voysey','Financial Advisor',52832,37270,2);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (72540,'Guthrey','Iacopetti','Office Assistant I',117690,37270,3);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (72913,'Kass','Hefferan','Computer Systems Analyst IV',96401,37270,3);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (75900,'Virge','Goodrum','Information Systems Manager',54578,37270,3);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (76196,'Mirilla','Janowski','Cost Accountant',119241,37270,3);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (80529,'Lynde','Aronson','Junior Executive',77182,37270,4);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (80679,'Mildrid','Sokale','Geologist II',67987,37270,4);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (84791,'Hazel','Tarbert','General Manager',93760,37270,4);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (95213,'Cole','Kesterton','Pharmacist',86119,37270,4);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (96513,'Theresa','Binney','Food Chemist',47354,37270,5);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (98374,'Estrellita','Daleman','Staff Accountant IV',70187,37270,5);
INSERT INTO employees (employee_id, first_name, last_name, job_title, salary, reports_to, office_id) VALUES (115357,'Ivy','Fearey','Structural Engineer',92710,37270,5);

select * from employees;
