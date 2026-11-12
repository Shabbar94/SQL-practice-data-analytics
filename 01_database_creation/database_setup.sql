CREATE DATABASE IF NOT EXISTS inner_join_practice;
USE inner_join_practice;


-- =========================================
-- STEP 2: CREATE TABLES
-- =========================================

DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS customers;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50),
    price DECIMAL(10,2)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    quantity INT,

    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

CREATE TABLE payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    payment_method VARCHAR(30),

    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);


-- =========================================
-- STEP 3: INSERT SAMPLE DATA
-- =========================================

INSERT INTO customers VALUES
(1, 'Ali', 'Karachi'),
(2, 'Ahmed', 'Lahore'),
(3, 'Sara', 'Islamabad'),
(4, 'Usman', 'Karachi');

INSERT INTO products VALUES
(101, 'Laptop', 100000.00),
(102, 'Mouse', 2000.00),
(103, 'Keyboard', 5000.00),
(104, 'Monitor', 30000.00);

INSERT INTO orders VALUES
(1001, 1, 101, 1),
(1002, 2, 102, 2),
(1003, 1, 103, 1),
(1004, 3, 104, 2);

INSERT INTO payments VALUES
(501, 1001, 'Card'),
(502, 1002, 'Cash'),
(503, 1003, 'Bank Transfer');


-- =========================================
-- STEP 4: VIEW THE TABLES
-- =========================================

SELECT * FROM customers;
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM payments;


select
customers.customer_id,
customers.customer_name,
customers.customer_name,
products.product_id,
products.product_name,
products.price,
orders.quantity,
payments.payment_method

from products 
inner join orders 
on products.product_id=orders.product_id
inner join payments on 
orders.order_id=payments.order_id
inner join customers on
customers.customer_id=orders.customer_id;
-- Practice left join --
select 
customers.customer_id,
customers.customer_name,
customers.city,
orders.order_id,
orders.quantity
from customers 
left join orders 
on
customers.customer_id=orders.customer_id
-- filer the customers that have nt placed the order by
where orders.order_id is NULL;
-- filtering the customers who had nt made payment 
select 
customers.customer_id,
customers.customer_name,
customers.city,
orders.order_id,
payments.order_id,
payments.payment_method
from customers
left join orders
on customers.customer_id=orders.customer_id
left join payments 
on orders.order_id=payments.order_id
where payments.payment_method is null;




