-- =========================================================
-- Sunrise Supermarket - Assignment 1
-- Database: Oracle SQL
-- =========================================================

-- =========================
-- 1. TABLE CREATION
-- =========================

CREATE TABLE customers (
  customer_id NUMBER PRIMARY KEY,
  customer_name VARCHAR2(100),
  email VARCHAR2(100),
  city VARCHAR2(50)
);

CREATE TABLE products (
  product_id NUMBER PRIMARY KEY,
  product_name VARCHAR2(100),
  category VARCHAR2(50),
  price NUMBER(10,2)
);

CREATE TABLE orders (
  order_id NUMBER PRIMARY KEY,
  customer_id NUMBER REFERENCES customers(customer_id),
  order_date DATE
);

CREATE TABLE order_items (
  order_item_id NUMBER PRIMARY KEY,
  order_id NUMBER REFERENCES orders(order_id),
  product_id NUMBER REFERENCES products(product_id),
  quantity NUMBER
);

-- =========================
-- 2. DATA POPULATION
-- =========================

-- Customers (5)
INSERT INTO customers (customer_id, customer_name, email, city) VALUES (1, 'Jean Claude', 'jean@gmail.com', 'Kigali');
INSERT INTO customers (customer_id, customer_name, email, city) VALUES (2, 'Alice Uwase', 'alice@gmail.com', 'Huye');
INSERT INTO customers (customer_id, customer_name, email, city) VALUES (3, 'Eric Niyonzima', 'eric@gmail.com', 'Kigali');
INSERT INTO customers (customer_id, customer_name, email, city) VALUES (4, 'Diane Mukamana', 'diane@gmail.com', 'Musanze');
INSERT INTO customers (customer_id, customer_name, email, city) VALUES (5, 'Patrick Habimana', 'patrick@gmail.com', 'Rubavu');

-- Products (8, across 4 categories)
INSERT INTO products (product_id, product_name, category, price) VALUES (1, 'Rice 5kg', 'Food', 6500);
INSERT INTO products (product_id, product_name, category, price) VALUES (2, 'Bread', 'Food', 1200);
INSERT INTO products (product_id, product_name, category, price) VALUES (3, 'Milk 1L', 'Dairy', 1500);
INSERT INTO products (product_id, product_name, category, price) VALUES (4, 'Yogurt', 'Dairy', 1000);
INSERT INTO products (product_id, product_name, category, price) VALUES (5, 'Orange Juice', 'Drinks', 2500);
INSERT INTO products (product_id, product_name, category, price) VALUES (6, 'Soda 500ml', 'Drinks', 1000);
INSERT INTO products (product_id, product_name, category, price) VALUES (7, 'Laundry Soap', 'Cleaning', 1800);
INSERT INTO products (product_id, product_name, category, price) VALUES (8, 'Toothpaste', 'Personal Care', 2200);

-- Orders (15)
INSERT INTO orders (order_id, customer_id, order_date) VALUES (1, 1, DATE '2026-08-01');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (2, 2, DATE '2026-08-02');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (3, 3, DATE '2026-08-03');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (4, 4, DATE '2026-08-05');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (5, 5, DATE '2026-08-06');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (6, 1, DATE '2026-08-08');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (7, 3, DATE '2026-08-10');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (8, 2, DATE '2026-08-12');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (9, 5, DATE '2026-08-15');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (10, 4, DATE '2026-08-17');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (11, 1, DATE '2026-08-20');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (12, 2, DATE '2026-08-22');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (13, 3, DATE '2026-08-25');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (14, 5, DATE '2026-08-27');
INSERT INTO orders (order_id, customer_id, order_date) VALUES (15, 4, DATE '2026-08-30');

-- Order items (25)
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (1, 1, 1, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (2, 1, 3, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (3, 2, 2, 3);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (4, 2, 5, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (5, 3, 4, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (6, 3, 6, 4);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (7, 4, 7, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (8, 4, 8, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (9, 5, 1, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (10, 5, 5, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (11, 6, 3, 3);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (12, 6, 6, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (13, 7, 2, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (14, 7, 7, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (15, 8, 4, 3);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (16, 8, 5, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (17, 9, 8, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (18, 9, 6, 3);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (19, 10, 1, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (20, 10, 3, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (21, 11, 5, 3);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (22, 12, 7, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (23, 13, 1, 1);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (24, 14, 4, 2);
INSERT INTO order_items (order_item_id, order_id, product_id, quantity) VALUES (25, 15, 8, 3);

COMMIT;

-- =========================
-- 3. JOIN QUERIES
-- =========================

-- 3.1 Every order with customer name, city, order date (INNER JOIN)
SELECT
    o.order_id,
    c.customer_name,
    c.city,
    o.order_date
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY o.order_id;

-- 3.2 Every order item with product name, category, price, quantity
SELECT
    oi.order_item_id,
    p.product_name,
    p.category,
    p.price,
    oi.quantity
FROM order_items oi
INNER JOIN products p
    ON oi.product_id = p.product_id
ORDER BY oi.order_item_id;

-- 3.3 All customers and their orders, including customers with no orders (LEFT JOIN)
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date
FROM customers c
LEFT JOIN orders o
    ON c.customer_id = o.customer_id
ORDER BY c.customer_id, o.order_date;

-- =========================
-- 4. CTE QUERY
-- =========================

-- 4.1 Customers whose total spend is above the average total spend
WITH customer_totals AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * p.price) AS total_spend
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    JOIN products p
        ON oi.product_id = p.product_id
    GROUP BY
        c.customer_id,
        c.customer_name
)
SELECT
    customer_id,
    customer_name,
    total_spend
FROM customer_totals
WHERE total_spend > (
    SELECT AVG(total_spend)
    FROM customer_totals
)
ORDER BY total_spend DESC;

-- =========================
-- 5. WINDOW FUNCTION QUERIES
-- =========================

-- 5.1 Rank customers by total amount spent, highest first
SELECT
    c.customer_id,
    c.customer_name,
    SUM(oi.quantity * p.price) AS total_spend,
    RANK() OVER (ORDER BY SUM(oi.quantity * p.price) DESC) AS spend_rank
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY c.customer_id, c.customer_name
ORDER BY spend_rank;

-- 5.2 Number each customer's orders in the order placed
SELECT
    o.customer_id,
    o.order_id,
    o.order_date,
    ROW_NUMBER() OVER (
        PARTITION BY o.customer_id
        ORDER BY o.order_date
    ) AS order_sequence
FROM orders o
ORDER BY o.customer_id, order_sequence;

-- 5.3 Running total of revenue over time, ordered by order date
SELECT
    o.order_id,
    o.order_date,
    SUM(oi.quantity * p.price) AS order_revenue,
    SUM(SUM(oi.quantity * p.price)) OVER (
        ORDER BY o.order_date, o.order_id
    ) AS running_total_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON oi.product_id = p.product_id
GROUP BY o.order_id, o.order_date
ORDER BY o.order_date, o.order_id;

-- 5.4 Days between current and previous order, for customers with more than one order
SELECT
    customer_id,
    order_id,
    order_date,
    prev_order_date,
    order_date - prev_order_date AS days_since_last_order
FROM (
    SELECT
        o.customer_id,
        o.order_id,
        o.order_date,
        LAG(o.order_date) OVER (
            PARTITION BY o.customer_id
            ORDER BY o.order_date
        ) AS prev_order_date,
        COUNT(*) OVER (PARTITION BY o.customer_id) AS order_count
    FROM orders o
) t
WHERE order_count > 1
  AND prev_order_date IS NOT NULL
ORDER BY customer_id, order_date;
