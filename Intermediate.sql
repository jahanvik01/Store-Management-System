-- INTERMEDIATE --

use store;

-- Display the total amount paid for each order in the orders table.
select order_id, sum(amount) as total_amount_paid from payment
group by order_id;

-- Retrieve the names of customers who have placed at least one order.
select distinct concat(first_name, ' ', last_name) as name from customers as c
left join orders as o
on c.customer_id = o.customer_id;

-- List all orders along with their total price, and sort them in descending order of total_price.
select order_id, total_price from orders
order by total_price desc;

-- Fetch the name of products and their supplier's name by joining products and suppliers.
select distinct p.product_name, s.supplier_name from products as p
join suppliers as s
on p.supplier_id = s.supplier_id;

-- Count the number of reviews submitted for each product.
select product_id, count(review_id) as total_review from reviews
group by product_id;

-- Retrieve the total quantity of items purchased in each order by joining orders and order_items.
select o.order_id, sum(ot.quantity) as total_quantity from orders as o
left join order_items as ot
on o.order_id = ot.order_id
group by o.order_id;

-- Identify customers who have not placed any orders (use a LEFT JOIN between customers and orders).
select o.order_id, c.first_name, c.last_name from customers as c 
left join orders as o
on c.customer_id = o.customer_id
where o.order_id is null;

-- Fetch details of orders where the total price exceeds the average total price of all orders.
select order_id, total_price from orders 
where total_price > (select avg(total_price) from orders);

-- Find the highest-rated product along with its average rating.
with ProductRating as(
select r.product_id, 
max(r.rating) as highest_rating,
avg(r.rating) as avg_rating
from reviews r
group by r.product_id
)

select p.product_id, p.product_name, pr.highest_rating, pr.avg_rating
from products p
join ProductRating pr
on p.product_id = pr.product_id
where pr.highest_rating = 
(select max(highest_rating) from ProductRating);

-- List all shipments that have not yet been delivered.
select * from shipments
where shipment_status != 'Delivered';

-- Retrieve the top 3 most expensive products.
select * from products
order by price desc
limit 3;

-- Fetch orders and their payment methods where the transaction_status is "Failed".
select order_id, payment_method, transaction_status from payment
where transaction_status = 'failed';

-- Identify the carrier that delivered the highest number of shipments.
with highest_shipments as (select carrier, count(*) as total_shipments from shipments
group by carrier)

select s.carrier, max(hs.total_shipments) as max_shipments from shipments s
join highest_shipments hs on s.carrier = hs.carrier
group by s.carrier;

-- Retrieve the names of customers and products they reviewed, along with the review text.
select concat(c.first_name, ' ', c.last_name) as name, p.product_name, r.review_text from customers as c
join reviews as r
on c.customer_id = r.customer_id
join products as p
on r.product_id = p.product_id;

-- Display the total sales amount (quantity * price_at_purchase) for each product.
select oi.product_id, p.product_name, sum(oi.quantity*oi.price_at_purchase) as total_sales from order_items oi
left join products p on oi.product_id = p.product_id
group by oi.product_id, p.product_name
order by product_id;

-- Find the names of customers who have reviewed the same product more than once.
select c.customer_id, concat(c.first_name, ' ', c.last_name) as name, count(r.review_id) as review_count from reviews as r
join customers as c
on r.customer_id = c.customer_id
join products as p
on r.product_id = p.product_id
group by c.customer_id, name
having review_count > 1;

-- Retrieve all orders along with their corresponding shipment details.
select o.*, s.* from shipments as s
left join orders as o
on s.order_id = o.order_id

union

select o.*, s.* from shipments as s
right join orders as o
on s.order_id = o.order_id;

-- Find the supplier who supplies the cheapest product.
with cheapest_product as (select s.supplier_name, min(p.price) cheapest_product from suppliers as s
join products as p
on s.supplier_id = p.supplier_id
group by s.supplier_name)

select s.supplier_name, cp.cheapest_product from suppliers s
join cheapest_product cp on s.supplier_name = cp.supplier_name
where cp.cheapest_product =
(select min(cheapest_product) from cheapest_product)
group by s.supplier_name;

-- Fetch the most recent review for each product.
select r.product_id, p.product_name, max(r.review_date) as last_review_on from reviews r
join products p on r.product_id = p.product_id
group by r.product_id, p.product_name;

-- Retrieve the name of the product and its category that was ordered the most.
with MostOrdered as (
select p.product_name, p.category, sum(oi.quantity) as total_quantity from products p
join order_items oi on p.product_id = oi.product_id
group by p.product_name, p.category
)

select product_name, category, total_quantity from MostOrdered
where total_quantity = (select max(total_quantity) from MostOrdered);
