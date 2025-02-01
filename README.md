# Store Management System

## Overview
The **Store Management System** is a comprehensive database management project developed using **MySQL**. The system is designed to manage all essential aspects of a retail store, including customer details, orders, product catalogs, payment transactions, shipments, and supplier information. By creating relational tables, this project helps in streamlining store operations and maintaining an organized database that can handle a large volume of transactions.

This repository contains SQL queries and a set of tables for managing:
- **Customers**: Store customer information
- **Orders**: Track customer orders and their total cost
- **Products**: Manage product inventory, details, and pricing
- **Payments**: Handle payment information and transaction statuses
- **Shipments**: Track order deliveries and shipment statuses
- **Reviews**: Allow customers to leave feedback and ratings on products
- **Suppliers**: Manage the contact details and product supply chain

## Database Schema
The system is built around multiple interrelated tables to capture essential information. Here is a breakdown of each table:

### 1. **customers**
This table stores the personal details of each customer. Each customer is uniquely identified by a `customer_id`. Fields include:
- `customer_id`: A unique identifier for each customer
- `first_name`, `last_name`: The customer's first and last name
- `address`: The address of the customer
- `email`: Contact email for the customer
- `phone_number`: Customer's contact phone number

### 2. **order_items**
This table records the details of products within an order. Each row corresponds to one product in a specific order, and multiple order items can exist for one order.
- `order_item_id`: Unique identifier for the order item
- `order_id`: A reference to the `orders` table, linking to a specific order
- `product_id`: A reference to the `products` table, indicating the product purchased
- `quantity`: The number of units of the product ordered
- `price_at_purchase`: The price at which the product was purchased at the time of order

### 3. **orders**
This table holds the order-level information for each customer purchase. It stores details like order date and total cost.
- `order_id`: A unique identifier for each order
- `order_date`: The date the order was placed
- `customer_id`: A reference to the `customers` table, indicating who placed the order
- `total_price`: The total price of the order (calculated based on order items)

### 4. **payment**
This table tracks payment information for each order. It stores how each order was paid, including the payment method and status.
- `payment_id`: A unique identifier for each payment transaction
- `order_id`: A reference to the `orders` table, indicating which order the payment belongs to
- `payment_method`: Describes the method of payment (e.g., credit card, PayPal, etc.)
- `amount`: The total payment amount for the order
- `transaction_status`: Status of the payment (e.g., successful, failed, pending)

### 5. **products**
This table contains details about the products available for sale in the store, including the price and category.
- `product_id`: Unique identifier for each product
- `product_name`: Name of the product
- `category`: The product category (e.g., electronics, furniture, clothing)
- `price`: Price of the product
- `supplier_id`: A reference to the `suppliers` table, indicating the supplier of the product

### 6. **reviews**
This table allows customers to leave reviews for products. It includes ratings and textual feedback.
- `review_id`: Unique identifier for each review
- `product_id`: A reference to the `products` table, indicating which product the review is for
- `customer_id`: A reference to the `customers` table, indicating which customer left the review
- `rating`: Rating given by the customer (e.g., 1 to 5 stars)
- `review_text`: The written review or feedback
- `review_date`: The date the review was submitted

### 7. **shipments**
This table tracks shipment information for each order, including carrier details and delivery status.
- `shipment_id`: Unique identifier for each shipment
- `order_id`: A reference to the `orders` table, linking to a specific order
- `shipment_date`: The date the order was shipped
- `carrier`: The carrier responsible for the shipment (e.g., FedEx, UPS)
- `tracking_number`: Tracking number provided by the carrier
- `delivery_date`: The expected or actual delivery date of the order
- `shipment_status`: The current status of the shipment (e.g., pending, delivered)

### 8. **suppliers**
This table stores information about the suppliers who provide products to the store.
- `supplier_id`: Unique identifier for each supplier
- `supplier_name`: The name of the supplier
- `contact_name`: Name of the contact person at the supplier
- `address`: The physical address of the supplier
- `phone_number`: Contact phone number for the supplier
- `email`: Contact email for the supplier

---

This project includes a set of SQL queries categorized into three levels: Basic, Intermediate, and Advanced. These questions help in understanding database interactions and improving SQL skills.

---

## Future Enhancements
The following improvements can be made in the future to enhance this system:
- **Stored Procedures and Triggers**: Automate operations like updating stock or sending email alerts on certain conditions (e.g., order placed or payment failed).
- **API Integration**: Develop an API for integration with external applications like a front-end interface or mobile app.
- **Query Optimization**: Work on improving query performance with indexing, partitioning, and optimization techniques.
- **Data Analytics**: Build reports and dashboards for better insights on store performance, customer behavior, and product trends.

## Author
Developed by **Jahanvi**

