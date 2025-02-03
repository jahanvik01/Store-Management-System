-- ADVANCE --

use store;

-- Retrieve the top 5 products with the highest total revenue (quantity * price_at_purchase) from the order_items table.
select product_id, (quantity * price_at_purchase) as total_revenue from order_items 
order by total_revenue desc
limit 5;
 
-- Find the most frequently used payment method.
select o.order_date, p.payment_method from payment as p
join orders as o 
on p.order_id = o.order_id
group by o.order_date, p.payment_method
order by  o.order_date desc
limit 1;

-- Calculate the average delivery time (in days) for all shipments.
select * from shipments;
select order_id, avg(DATEDIFF(delivery_date, shipment_date)) as avg_days from shipments 
where shipment_status = 'Delivered'
group by order_id;

-- Identify the customer who has spent the most overall.
select customer_id, sum(total_price) as total_spent from orders 
group by customer_id;

-- List customers who placed orders but didn’t leave any reviews.
select distinct o.customer_id from orders as o
left join reviews r 
on o.customer_id = r.customer_id
where r.customer_id is null;

-- Retrieve products that have never been ordered.
select product_id, product_name from products
where product_id not in (select product_id from order_items);

-- Calculate the total revenue generated for each category.
select p.category, sum(oi.quantity*oi.price_at_purchase) as revenue from products as p 
join order_items as oi
on p.product_id = oi.product_id
group by p.category;

-- Find orders where the total payment amount does not match the total_price in the orders table.
select o.order_id, o.total_price as order_price, p.amount as payment_amount from orders o
join payment p
on o.order_id = p.order_id
where o.total_price != p.amount;

-- Retrieve shipments where the delivery was delayed (difference between shipment_date and delivery_date).
select order_id, datediff(delivery_date, shipment_date) as total_shipment_days from shipments;

-- Identify suppliers whose products have an average rating below 3.
select s.supplier_id, s.supplier_name, avg(r.rating) as avg_rating from products p
join reviews r
on p.product_id = r.product_id
join suppliers as s
on p.supplier_id = s.supplier_id
group by  s.supplier_id, s.supplier_name
having avg(r.rating) <3;

-- Fetch the details of customers who have placed orders in multiple categories.
select c.customer_id, concat(c.first_name, ' ', c.last_name) as customer_name from customers c
join orders o 
on c.customer_id = o.customer_id
join order_items oi
on oi.order_id = o.order_id
join products p
on oi.product_id = p.product_id
group by c.customer_id, customer_name
having count(distinct p.category) >1;

-- Identify the month with the highest number of orders placed.
with HighestOrders as (
select month(order_date) as order_month, count(order_id) as total_orders from orders
group by order_month
)

select order_month, total_orders from HighestOrders 
where total_orders = (select max(total_orders) from HighestOrders);

-- List customers and their total spending in each category of products.
select c.customer_id, p.category, sum(oi.quantity*oi.price_at_purchase) as total_spending from customers c
join orders o 
on c.customer_id = o.customer_id
join order_items oi
on oi.order_id = o.order_id
join products p
on oi.product_id = p.product_id
group by c.customer_id, p.category;

-- Retrieve the details of customers who have ordered all products in the "Furniture" category.
select c.customer_id from customers c
join orders o 
on c.customer_id = o.customer_id
join order_items oi
on oi.order_id = o.order_id
join products p
on oi.product_id = p.product_id
where p.category = 'Furniture'
group by c.customer_id
having count(distinct p.product_id) = (select count(*) from products where category = 'Furniture');

-- Identify the products purchased together in the same order (grouped by order_id).
select oi1.order_id, oi1.product_id as product_1, oi2.product_id as product_2 from order_items oi1
join order_items oi2
on oi1.order_id = oi2.order_id
where oi1.product_id < oi2.product_id
order by oi1.order_id;

-- Calculate the total number of products shipped by each carrier.
select s.carrier, count(oi.product_id) as total_products from shipments s
join orders o on s.order_id = o.order_id
join order_items oi on o.order_id = oi.order_id
group by s.carrier;

-- Display the most reviewed product along with its review count.
select p.product_id, p.product_name, count(r.review_id) as total_reviews from products p
join reviews r on p.product_id = r.product_id
group by p.product_id, p.product_name
order by total_reviews desc;

-- Retrieve the order with the maximum quantity of items.
with OrderQuantity as(
select o.order_id, sum(oi.quantity) as quantity from orders o
join order_items oi on o.order_id = oi.order_id 
group by o.order_id
)

select o.order_id, oq.quantity from orders o
join OrderQuantity oq
on o.order_id = oq.order_id
where quantity = (select max(quantity) from OrderQuantity);

-- Identify customers who placed orders but didn’t make any payments.
select distinct c.customer_id, concat(c.first_name, ' ', c.last_name) as customer_name from customers c
join orders o on c.customer_id = o.customer_id
join payment p on o.order_id = p.order_id
where p.order_id is null;

-- Fetch the customer and product details for reviews submitted in the last 7 days.
select r.customer_id, r.product_id, r.review_date from reviews r
where r.review_date >= (
    SELECT MAX(review_date) FROM reviews
) - INTERVAL 7 DAY
order by r.review_date;

-- Calculate the average price of all products sold by each supplier.
select s.supplier_id, s.supplier_name, p.product_name, avg(p.price) as avg_price from products p
join suppliers s 
on p.supplier_id = s.supplier_id
group by s.supplier_id, s.supplier_name, p.product_name;

-- Identify orders with multiple shipments.
SELECT order_id, COUNT(DISTINCT shipment_id) AS shipment_count
FROM shipments
GROUP BY order_id
HAVING COUNT(DISTINCT shipment_id) > 1;

-- Retrieve all orders where the total quantity ordered exceeds 8 items.
select oi.order_id, sum(oi.quantity) as total_quantity from order_items oi
where quantity > 8
group by oi.order_id;

-- List products along with their average rating and total revenue generated.
select r.product_id, avg(r.rating) as avg_rating, sum(oi.quantity*oi.price_at_purchase) as total_revenue from reviews r
join order_items oi
on r.product_id = oi.product_id 
group by r.product_id
order by r.product_id;

-- Display customers and their most purchased product (use aggregate functions).
select c.customer_id, concat(c.first_name, ' ', c.last_name) as customer_name, p.product_name, max(pr.purchase_count) as max_purchase
from customers c 
join
(select o.customer_id, oi.product_id, count(oi.product_id) as purchase_count from orders o
join order_items oi on o.order_id = oi.order_id
group by o.customer_id, oi.product_id) pr
on c.customer_id = pr.customer_id
join products p on pr.product_id = p.product_id
group by c.customer_id, customer_name, p.product_name
having max_purchase = max(pr.purchase_count);

