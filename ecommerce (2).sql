Create database ecommerce;
use ecommerce;
CREATE TABLE CUSTOMER (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50),
    email VARCHAR(50),
    phone VARCHAR(15),
    street VARCHAR(50),
    house_no VARCHAR(20),
    city_pincode VARCHAR(20)
);
INSERT INTO CUSTOMER VALUES
(1, 'Asha', 'asha@gmail.com', '9876543210', 'MG Road', '12', '520001'),
(2, 'Ravi', 'ravi@gmail.com', '9123456789', 'Park Street', '45', '500032'),
(3, 'Neha', 'neha@gmail.com', '9988776655', 'Main Road', '22', '600045'),
(4, 'Kiran', 'kiran@gmail.com', '9871234567', 'Lake View', '18', '700012'),
(5, 'Sita', 'sita@gmail.com', '9012345678', 'Hill Street', '9', '400020');
select * from CUSTOMER;
CREATE TABLE ORDERS (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id)
);
INSERT INTO ORDERS VALUES
(101, 1, '2026-04-10', 500.00, 'Delivered'),
(102, 2, '2026-04-11', 800.00, 'Pending'),
(103, 3, '2026-04-12', 1200.00, 'Delivered'),
(104, 4, '2026-04-13', 650.00, 'Shipped'),
(105, 5, '2026-04-14', 900.00, 'Pending');
select * from ORDERS;

CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(50),
    Price DECIMAL(10,2),
    Stock INT
);
INSERT INTO PRODUCT VALUES
(301, 'Shoes', 1200.00, 10),
(302, 'Shirt', 800.00, 20),
(303, 'Watch', 1500.00, 15),
(304, 'Bag', 700.00, 25),
(305, 'Headphones', 2000.00, 12);
select * from Product;

CREATE TABLE CART (
    cart_id INT PRIMARY KEY,
    customer_id INT,
    created_date DATE,
    status VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id)
);
INSERT INTO CART VALUES
(201, 1, '2026-04-01', 'Active'),
(202, 2, '2026-04-02', 'Inactive'),
(203, 3, '2026-04-03', 'Active'),
(204, 4, '2026-04-04', 'Active'),
(205, 5, '2026-04-05', 'Inactive');
select * from CART;

CREATE TABLE PAYMENT (
    payment_id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10,2),
    payment_date DATE,
    method VARCHAR(20),
    status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id)
);
INSERT INTO PAYMENT VALUES
(401, 101, 500.00, '2026-04-10', 'UPI', 'Success'),
(402, 102, 800.00, '2026-04-11', 'Card', 'Pending'),
(403, 103, 1200.00, '2026-04-12', 'Net Banking', 'Success'),
(404, 104, 650.00, '2026-04-13', 'UPI', 'Success'),
(405, 105, 900.00, '2026-04-14', 'Card', 'Pending');
select * from PAYMENT;

CREATE TABLE DELIVERY (
    delivery_id INT PRIMARY KEY,
    order_id INT,
    delivery_date DATE,
    address VARCHAR(100),
    status VARCHAR(20),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id)
);
INSERT INTO DELIVERY VALUES
(501, 101, '2026-04-12', 'MG Road, 12', 'Delivered'),
(502, 102, '2026-04-13', 'Park Street, 45', 'Pending'),
(503, 103, '2026-04-14', 'Main Road, 22', 'Delivered'),
(504, 104, '2026-04-15', 'Lake View, 18', 'Shipped'),
(505, 105, '2026-04-16', 'Hill Street, 9', 'Pending');
select * from DELIVERY;
CREATE TABLE ORDER_ITEM (
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES ORDERS(order_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);
INSERT INTO ORDER_ITEM VALUES
(601, 101, 301, 1, 1200.00),
(602, 102, 302, 2, 800.00),
(603, 103, 303, 1, 1500.00),
(604, 104, 304, 1, 700.00),
(605, 105, 305, 1, 2000.00);
select * from ORDER_ITEM;

CREATE TABLE CART_PRODUCT (
    cart_id INT,
    product_id INT,
    PRIMARY KEY (cart_id, product_id),
    FOREIGN KEY (cart_id) REFERENCES CART(cart_id),
    FOREIGN KEY (product_id) REFERENCES PRODUCT(product_id)
);
INSERT INTO CART_PRODUCT VALUES
(201, 301),
(202, 302),
(203, 303),
(204, 304),
(205, 305);
select * from CART_PRODUCT;
-- 1. Customers who placed orders
SELECT name 
FROM CUSTOMER 
WHERE customer_id IN (SELECT customer_id FROM ORDERS);
-- 2. Products with price above average
SELECT Product_id
FROM PRODUCT 
WHERE price > (SELECT AVG(price) FROM PRODUCT);
-- 3. Orders with amount greater than average
SELECT order_id 
FROM ORDERS 
WHERE total_amount > (SELECT AVG(total_amount) FROM ORDERS);
-- 4. Customers who made payments
SELECT name 
FROM CUSTOMER 
WHERE customer_id IN (
    SELECT customer_id 
    FROM ORDERS 
    WHERE order_id IN (SELECT order_id FROM PAYMENT)
);
-- 5. Products that are in orders
SELECT Product_Name 
FROM PRODUCT 
WHERE product_id IN (SELECT product_id FROM ORDER_ITEM);
2. CORRELATED QUERIES
-- 1. Orders having more than 1 item
SELECT order_id 
FROM ORDERS o
WHERE (
    SELECT COUNT(*) 
    FROM ORDER_ITEM oi 
    WHERE oi.order_id = o.order_id
) >1;
-- 2. Customers who placed at least one order
SELECT name 
FROM CUSTOMER c
WHERE EXISTS (
    SELECT * FROM ORDERS o 
    WHERE o.customer_id = c.customer_id
);
-- 3. Products ordered more than once
SELECT Product_name 
FROM PRODUCT p
WHERE (
    SELECT COUNT(*) 
    FROM ORDER_ITEM oi 
    WHERE oi.product_id = p.product_id
) > 1;
-- 4. Orders that have payments
SELECT order_id 
FROM ORDERS o
WHERE EXISTS (
    SELECT * FROM PAYMENT p 
    WHERE p.order_id = o.order_id
);
-- 5. Customers whose order amount is above their average
SELECT name 
FROM CUSTOMER c
WHERE EXISTS (
    SELECT * FROM ORDERS o 
    WHERE o.customer_id = c.customer_id 
    AND total_amount > (
        SELECT AVG(total_amount) 
        FROM ORDERS 
        WHERE customer_id = c.customer_id
    )
);
3. AGGREGATE FUNCTIONS
-- 1. Total number of orders
SELECT COUNT(*) FROM ORDERS;
-- 2. Average product price
SELECT AVG(price) FROM PRODUCT;
-- 3. Maximum order amount
SELECT MAX(total_amount) FROM ORDERS;
-- 4. Total payment amount
SELECT SUM(amount) FROM PAYMENT;
-- 5. Number of products per order
SELECT order_id, COUNT(product_id)
FROM ORDER_ITEM
GROUP BY order_id;
4.  JOINS
-- 1. Customer and their orders
SELECT c.name, o.order_id
FROM CUSTOMER c
JOIN ORDERS o ON c.customer_id = o.customer_id;
-- 2. Orders with payment details
SELECT o.order_id, p.amount
FROM ORDERS o
JOIN PAYMENT p ON o.order_id = p.order_id;
-- 3. Orders with product names
SELECT o.order_id, pr.Product_Name
FROM ORDER_ITEM oi
JOIN ORDERS o ON oi.order_id = o.order_id
JOIN PRODUCT pr ON oi.product_id = pr.product_id;
-- 4. Cart with products
SELECT c.cart_id, p.Product_Name
FROM CART_PRODUCT cp
JOIN CART c ON cp.cart_id = c.cart_id
JOIN PRODUCT p ON cp.product_id = p.product_id;
-- 5. Orders with delivery info
SELECT o.order_id, d.delivery_date
FROM ORDERS o
JOIN DELIVERY d ON o.order_id = d.order_id;
11. Creation of views using the tables.
-- 1. Customer Orders View
CREATE VIEW Customer_Orders AS
SELECT c.name, o.order_id, o.total_amount
FROM CUSTOMER c
JOIN ORDERS o ON c.customer_id = o.customer_id;
select * from Customer_Orders;
-- 2. Product View
CREATE VIEW Product_List AS
SELECT Product_Name, price FROM PRODUCT;
select * from Product_List;

-- 3. Order Details View
CREATE VIEW Order_Details AS
SELECT order_id, total_amount, status FROM ORDERS;
select * from Order_Details;

-- 4. Payment View
CREATE VIEW Payment_Info AS
SELECT payment_id, amount, method FROM PAYMENT;
select * from Order_Details;

-- 5. Delivery View
CREATE VIEW Delivery_Status AS
SELECT delivery_id, status FROM DELIVERY;
select * from Delivery_Status;
