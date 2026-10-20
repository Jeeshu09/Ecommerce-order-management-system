# Ecommerce Order Management System

## Project Overview
The Ecommerce Order Management System is a database project developed using SQL to manage customers, products, orders, shopping carts, payments, and deliveries. It demonstrates database design and the use of SQL queries to retrieve, organize, and analyze e-commerce data.

## Technologies Used
- SQL
- Relational Database Management System (RDBMS)

## Database Tables
The project includes the following tables:

1. **CUSTOMER** – Stores customer details and addresses.
2. **ORDERS** – Stores order dates, amounts, and statuses.
3. **PRODUCT** – Stores product names, prices, and stock quantities.
4. **CART** – Maintains customer shopping carts.
5. **PAYMENT** – Stores payment amounts, methods, and statuses.
6. **DELIVERY** – Maintains delivery information and statuses.
7. **ORDER_ITEM** – Connects orders with products and quantities.
8. **CART_PRODUCT** – Establishes the relationship between shopping carts and products.

## Key Features
- Creates relational database tables using SQL.
- Inserts sample customer, product, order, payment, and delivery data.
- Uses primary keys and foreign keys to establish relationships between tables.
- Performs subqueries and correlated queries.
- Uses aggregate functions such as COUNT, AVG, MAX, and SUM.
- Retrieves related information using JOIN operations.
- Creates database views to simplify data retrieval.

## SQL Concepts Demonstrated
- Database and table creation
- Data insertion and retrieval
- Primary and foreign key constraints
- Subqueries and correlated subqueries
- Aggregate functions and GROUP BY
- INNER JOIN operations
- Views using CREATE VIEW

## How to Run the Project
1. Install or open a SQL database environment, such as MySQL.
2. Open the `ecommerce (2).sql` file in your SQL editor.
3. Execute the script to create the database, tables, and sample records.
4. Run the SELECT queries to view the stored data and explore the results.

## Project Objective
The objective of this project is to understand relational database design and apply SQL concepts to a practical e-commerce order management scenario.
