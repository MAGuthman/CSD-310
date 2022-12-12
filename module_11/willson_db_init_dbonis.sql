/*
    Title: willson_db_init_dbonis.sql
    Author: Dylan Bonis
    Date: 7 December 2022
    Description: willson_financial database initialization script.

    Changelog: Fixed some dates where it was 2021 instead of 2022 due to an error that got copied throughout
    
*/

DROP DATABASE IF EXISTS willson_financial;
CREATE DATABASE willson_financial;
USE willson_financial;

-- drop database user if exists 
DROP USER IF EXISTS 'willson_owner'@'localhost';


-- create willson_owner and grant them all privileges to the willson database 
CREATE USER 'willson_owner'@'localhost' IDENTIFIED WITH mysql_native_password BY 'finances';

-- grant all privileges to the willson database to user willson_owner on localhost 
GRANT ALL PRIVILEGES ON willson_financial.* TO 'willson_owner'@'localhost';


-- create the employee table, works
CREATE TABLE employee(
    employee_id           INT             NOT NULL        AUTO_INCREMENT,
    employee_name         VARCHAR(75)     NOT NULL,
    employee_address      VARCHAR(75)     NOT NULL,
    employee_phone_number VARCHAR(11)     NOT NULL,
     
    PRIMARY KEY(employee_id)
); 

-- create the job table, works 
CREATE TABLE job (
    job_id     INT             NOT NULL        AUTO_INCREMENT,
    job_name   VARCHAR(75)     NOT NULL,
    job_hours  INT             NOT NULL,
    employee_id INT            NOT NULL,
     
    PRIMARY KEY(job_id)
); 

-- create the customer table, works
CREATE TABLE customer (
    customer_id       INT           NOT NULL        AUTO_INCREMENT,
    customer_name     VARCHAR(75)   NOT NULL,
    customer_address  VARCHAR(75)   NOT NULL,
    customer_phone    VARCHAR(11)   NOT NULL,
    date_added        DATE          NOT NULL, 
    
    PRIMARY KEY(customer_id)	
);



-- create the function table, works
CREATE TABLE functions (
    function_ID       INT             NOT NULL        AUTO_INCREMENT,
    function_Name     VARCHAR(75)     NOT NULL,

    PRIMARY KEY(function_id)
);



-- create the transaction table, works
CREATE TABLE transactions (
    transaction_id       INT             NOT NULL        AUTO_INCREMENT,
    customer_id          INT             NOT NULL,
    transaction_date     DATE            NOT NULL,
    transaction_with_id  INT             NOT NULL,
    function_id          INT             NOT NULL,
    transaction_amount   FLOAT(10)       NOT NULL,

    PRIMARY KEY(transaction_id),

     CONSTRAINT fk_customer
   FOREIGN KEY(customer_id)
     REFERENCES customer(customer_id),
     

    CONSTRAINT fk_function_id
   FOREIGN KEY(function_id)
     REFERENCES functions(function_id)
);


-- create the assets table, works
CREATE TABLE asset (
    asset_id    INT                NOT NULL        AUTO_INCREMENT,
    asset_name  VARCHAR(75)        NOT NULL,
    asset_worth DOUBLE(12,2)       NOT NULL,
    customer_id INT                NOT NULL,
    
    PRIMARY KEY(asset_id),

     CONSTRAINT fka_customer
   FOREIGN KEY(customer_id)
     REFERENCES customer(customer_id)
);


-- insert employee records, works
INSERT INTO employee(employee_name, employee_address, employee_phone_number)
    VALUES('Phoenix Two Star', '123 Sesame St, St. Paldea, New Mexico', 1234567890);

INSERT INTO employee(employee_name, employee_address, employee_phone_number)
    VALUES('June Santos', '1512 Vinewood Blv,  St. Paldea, New Mexico', 6394302581);


-- insert job records, works
INSERT INTO job(job_name, job_hours, employee_id)
    VALUES('Office Employee', 40, (SELECT employee_id FROM employee WHERE employee_name = 'Phoenix Two Star'));

INSERT INTO job(job_name, job_hours, employee_id)
    VALUES('Compliance Manager', 23, (SELECT employee_id FROM employee WHERE employee_name = 'June Santos'));


-- insert customer records
INSERT INTO customer(customer_name, customer_address, customer_phone, date_added)
    VALUES('Willson Financial', '3366 Middle Rd, St. Paldea, New Mexico', 5635694563, '2022/01/01');

INSERT INTO customer(customer_name, customer_address, customer_phone, date_added)
    VALUES('Papa John', '3368 Middle Rd, St. Paldea, New Mexico', 5635699874, '2022/01/04');

INSERT INTO customer(customer_name, customer_address, customer_phone, date_added)
    VALUES('Michael Jöran', '8516 South Creek Drive, St. Paldea, New Mexico', 7758414466, '2022/01/14');

INSERT INTO customer(customer_name, customer_address, customer_phone, date_added)
    VALUES('Jeremiah Addams', '7457 Canal Street, St. Paldea, New Mexico', 5896521236, '2022/01/30');

INSERT INTO customer(customer_name, customer_address, customer_phone, date_added)
    VALUES('Mukul Jaqueline', '8699 S. Trenton St., St. Paldea, New Mexico', 6066019271, '2022/04/10');

INSERT INTO customer(customer_name, customer_address, customer_phone, date_added)
    VALUES('Yorath Degataga', '9339 West Grove Dr, St. Paldea, New Mexico', 5054094904, '2022/07/11');

INSERT INTO customer(customer_name, customer_address, customer_phone, date_added)
    VALUES('Chidiebele Moran', '7758 S. Academy Road, St. Paldea, New Mexico', 7122635162, '2022/07/24');

INSERT INTO customer(customer_name, customer_address, customer_phone, date_added)
    VALUES('Denzil Mariyam', '1634 Longbranch Street, St. Paldea, New Mexico', 5563489563, '2022/09/13');

INSERT INTO customer(customer_name, customer_address, customer_phone, date_added)
    VALUES('Anjali Zdenka', '9456 Fieldstone Dr, St. Paldea, New Mexico', 6958369871, '2022/10/12');

INSERT INTO customer(customer_name, customer_address, customer_phone, date_added)
    VALUES('Abeni Diletta', '7038 Pierce Road, St. Paldea, New Mexico', 3659875893, '2022/11/20');


-- insert function records, works

INSERT INTO functions(function_name)
    VALUES('Deposit');

INSERT INTO functions(function_name)
    VALUES('Withdraw');

INSERT INTO functions(function_name)
    VALUES('Exchange');


-- insert transaction records

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), '2022/01/02', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 1000000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), '2022/01/04', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Withdraw'), 20000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Jeremiah Addams'), '2022/01/14', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 70000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), '2022/01/14', (SELECT customer_id FROM customer WHERE customer_name= 'Michael Jöran'), (SELECT function_id FROM functions WHERE function_name= 'Exchange'), 10000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), '2022/01/16', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Withdraw'), 5000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), '2022/01/18', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 70000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), '2022/01/20', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Withdraw'), 5000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), '2022/01/21', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 1000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), '2022/01/28', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 10000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), '2022/01/29', (SELECT customer_id FROM customer WHERE customer_name= 'Michael Jöran'), (SELECT function_id FROM functions WHERE function_name= 'Exchange'), 20000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Jeremiah Addams'), '2022/01/30', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 50000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), '2022/01/30', (SELECT customer_id FROM customer WHERE customer_name= 'Jeremiah Addams'), (SELECT function_id FROM functions WHERE function_name= 'Exchange'), 50000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), '2022/01/30', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Withdraw'), 5000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Yorath Degataga'), '2022/04/10', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 10000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Yorath Degataga'), '2022/07/11', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 20000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), '2022/07/15', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Withdraw'), 50000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Yorath Degataga'), '2022/07/14', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Withdraw'), 10000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Chidiebele Moran'), '2022/07/24', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 50000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Chidiebele Moran'), '2022/08/24', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 1000000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Denzil Mariyam'), '2022/09/13', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 3000000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Denzil Mariyam'), '2022/09/15', (SELECT customer_id FROM customer WHERE customer_name= 'Yorath Degataga'), (SELECT function_id FROM functions WHERE function_name= 'Exchange'), 40000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Anjali Zdenka'), '2022/10/12', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 300000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Anjali Zdenka'), '2022/10/14', (SELECT customer_id FROM customer WHERE customer_name= 'Papa John'), (SELECT function_id FROM functions WHERE function_name= 'Exchange'), 50000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Abeni Diletta'), '2022/11/20', (SELECT customer_id FROM customer WHERE customer_name= 'Willson Financial'), (SELECT function_id FROM functions WHERE function_name= 'Deposit'), 8000);

INSERT INTO transactions(customer_id, transaction_date, transaction_with_id, function_id, transaction_amount)
    VALUES((SELECT customer_id FROM customer WHERE customer_name= 'Abeni Diletta'), '2022/11/21', (SELECT customer_id FROM customer WHERE customer_name= 'Anjali Zdenka'), (SELECT function_id FROM functions WHERE function_name= 'Exchange'), 1000);



-- insert asset records
INSERT INTO asset(asset_name, asset_worth, customer_id)
    VALUES('John Estate', 100000, (SELECT customer_id FROM customer WHERE customer_name= 'Papa John'));

INSERT INTO asset(asset_name, asset_worth, customer_id)
    VALUES('Ford F150', 10000, (SELECT customer_id FROM customer WHERE customer_name= 'Papa John'));

INSERT INTO asset(asset_name, asset_worth, customer_id)
    VALUES('Gold Coins', 50000, (SELECT customer_id FROM customer WHERE customer_name= 'Jeremiah Addams'));

INSERT INTO asset(asset_name, asset_worth, customer_id)
    VALUES('Ancient Sundial Band', 75000, (SELECT customer_id FROM customer WHERE customer_name= 'Yorath Degataga'));

INSERT INTO asset(asset_name, asset_worth, customer_id)
    VALUES('Family Heirloom', 100000, (SELECT customer_id FROM customer WHERE customer_name= 'Chidiebele Moran'));

INSERT INTO asset(asset_name, asset_worth, customer_id)
    VALUES('Mariyam Estate', 60000, (SELECT customer_id FROM customer WHERE customer_name= 'Denzil Mariyam'));

INSERT INTO asset(asset_name, asset_worth, customer_id)
    VALUES('Diletta Secret Recipe', 8000, (SELECT customer_id FROM customer WHERE customer_name= 'Abeni Diletta'));





