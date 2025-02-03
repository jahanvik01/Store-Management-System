-- BASIC --

use store;

-- Retrieve all columns from the customers table. --
select * from customers;

-- Display the first name and last name of all customers.
select first_name, last_name from customers;

-- Count the total number of customers in the customers table.
select count(*) as total_customers from customers;

-- Retrieve all products and their prices from the products table.
select product_name, price from products;

-- Select all orders placed after January-1-2023, from the orders table.
select order_id from orders 
where order_date > '2023-01-01';

-- Retrieve the email and phone number of a customer whose customer_id is 101.
select customer_id, email, phone_number from customers
where customer_id = 101;

-- Fetch the details of an order with order_id 500 from the orders table.
select * from orders
where order_id = 500;

-- List all suppliers in alphabetical order of their names.
select supplier_name from suppliers
order by supplier_name asc;

-- Display all reviews with a rating of 5 from the reviews table.
select review_text, rating from reviews
where rating = 5;

-- Show all shipments with a shipment_status of "Delivered".
select shipment_id, carrier, shipment_status from shipments
where shipment_status = 'Delivered';

-- Find the distinct category values in the products table.
select distinct category from products;

-- Retrieve all products in the category "Electronics".
select product_name from products
where category = 'Electronics';

-- Select the supplier_name and email of suppliers located in "DC".
select supplier_name, email, address from suppliers
where address like '%DC%';

-- Fetch all customers who have a phone number ending with '1234'.
select first_name, last_name, phone_number from customers
where phone_number like '%1234';