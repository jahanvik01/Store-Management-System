create database store;

use store;

create table customers(
customer_id int primary key,
first_name varchar(15),
last_name varchar(15),
address varchar(100),
email varchar(50),
phone_number int
);

create table order_items(
order_item_id int primary key,
order_id int,
product_id int,
quantity int,
price_at_purchase float
);

create table orders(
order_id int primary key,
order_date date,
customer_id int,
total_price float
);

create table payment(
payment_id int primary key,
order_id int,
payment_method varchar(50),
amount float,
transaction_status varchar(50)
);

create table products(
product_id int primary key,
product_name varchar(50),
category varchar(50),
price float,
supplier_id int
);

create table reviews(
review_id int primary key,
product_id int,
customer_id int,
rating int,
review_text varchar(100),
review_date date
);

create table shipments(
shipment_id int primary key,
order_id int, 
shipment_date date,
carrier varchar(30),
tracking_number varchar(50),
delivery_date date,
shipment_status varchar(50)
);

create table suppliers(
supplier_id int primary key,
supplier_name varchar(50),
contact_name varchar(50),
address varchar(100),
phone_number varchar(20),
email varchar(50)
);

select * from customers;

select * from order_items;

select * from orders;

select * from payment;

select * from products;

select * from reviews;

select * from shipments;

select * from suppliers;