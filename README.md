# Assignment 1 – Sunrise Supermarket Database

**Name:** [SHIMWA RAY VLADAN]
**Student ID:** [20251SEN157]
**DBMS used:** Oracle SQL (Oracle Live SQL / SQL Developer)

---

## 1. Business Scenario

Sunrise Supermarket sells products to customers, who place orders containing one or more items. Management wants to understand:
- **Who their customers are** (identity, location)
- **What they buy** (products, categories, quantities)
- **How sales are trending over time** (order frequency, revenue growth, spending patterns)

To support this, a relational database was designed with four tables:

| Table | Purpose |
|---|---|
| `customers` | Stores customer identity and location details |
| `products` | Stores product catalog with category and price |
| `orders` | Stores each order placed, linked to a customer and a date |
| `order_items` | Stores the line items (product + quantity) within each order |

The database was populated with **5 customers**, **8 products across 4 categories** (Food, Dairy, Drinks, Personal Care — plus Cleaning, 5 total), **15 orders**, and **25 order items** spread across dates in August 2026.

---

## 2. Entity Relationship Overview

```
customers (1) ───< (many) orders (1) ───< (many) order_items >─── (many) products
```

- One customer can place many orders.
- One order can contain many order items.
- One product can appear in many order items.

---

## 3. JOIN Queries

### 3.1 Every order with customer name, city, and order date (INNER JOIN)

```sql
SELECT
    o.order_id,
    c.customer_name,
    c.city,
    o.order_date
FROM orders o
INNER JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY o.order_id;
```

**Explanation:** This query connects the `orders` table to the `customers` table using the shared `customer_id` key, so instead of seeing a raw customer ID next to each order, we see the actual customer's name and city.

**Business interpretation:** This gives management an order log that's readable at a glance — showing exactly who placed each order and where they're from, which is the foundation for any delivery or regional sales analysis.

**Results:**

| ORDER_ID | CUSTOMER_NAME | CITY | ORDER_DATE |
|---|---|---|---|
| 1 | Jean Claude | Kigali | 2026-08-01 |
| 2 | Alice Uwase | Huye | 2026-08-02 |
| 3 | Eric Niyonzima | Kigali | 2026-08-03 |
| 4 | Diane Mukamana | Musanze | 2026-08-05 |
| 5 | Patrick Habimana | Rubavu | 2026-08-06 |
| 6 | Jean Claude | Kigali | 2026-08-08 |
| 7 | Eric Niyonzima | Kigali | 2026-08-10 |
| 8 | Alice Uwase | Huye | 2026-08-12 |
| 9 | Patrick Habimana | Rubavu | 2026-08-15 |
| 10 | Diane Mukamana | Musanze | 2026-08-17 |
| 11 | Jean Claude | Kigali | 2026-08-20 |
| 12 | Alice Uwase | Huye | 2026-08-22 |
| 13 | Eric Niyonzima | Kigali | 2026-08-25 |
| 14 | Patrick Habimana | Rubavu | 2026-08-27 |
| 15 | Diane Mukamana | Musanze | 2026-08-30 |

---

### 3.2 Every order item with product name, category, price, and quantity

```sql
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
```

**Explanation:** This joins `order_items` (which only stores product IDs and quantities) to `products` (which holds names, categories, and prices), producing a full, human-readable line-item breakdown.

**Business interpretation:** This is the level of detail needed to see exactly what's selling — e.g., which categories (Food, Dairy, Drinks, Cleaning, Personal Care) generate the most line items and in what volumes.

**Results:**

| ORDER_ITEM_ID | PRODUCT_NAME | CATEGORY | PRICE | QUANTITY |
|---|---|---|---|---|
| 1 | Rice 5kg | Food | 6500 | 2 |
| 2 | Milk 1L | Dairy | 1500 | 1 |
| 3 | Bread | Food | 1200 | 3 |
| 4 | Orange Juice | Drinks | 2500 | 2 |
| 5 | Yogurt | Dairy | 1000 | 2 |
| 6 | Soda 500ml | Drinks | 1000 | 4 |
| 7 | Laundry Soap | Cleaning | 1800 | 2 |
| 8 | Toothpaste | Personal Care | 2200 | 1 |
| 9 | Rice 5kg | Food | 6500 | 1 |
| 10 | Orange Juice | Drinks | 2500 | 2 |
| 11 | Milk 1L | Dairy | 1500 | 3 |
| 12 | Soda 500ml | Drinks | 1000 | 2 |
| 13 | Bread | Food | 1200 | 2 |
| 14 | Laundry Soap | Cleaning | 1800 | 1 |
| 15 | Yogurt | Dairy | 1000 | 3 |
| 16 | Orange Juice | Drinks | 2500 | 1 |
| 17 | Toothpaste | Personal Care | 2200 | 2 |
| 18 | Soda 500ml | Drinks | 1000 | 3 |
| 19 | Rice 5kg | Food | 6500 | 2 |
| 20 | Milk 1L | Dairy | 1500 | 2 |
| 21 | Orange Juice | Drinks | 2500 | 3 |
| 22 | Laundry Soap | Cleaning | 1800 | 2 |
| 23 | Rice 5kg | Food | 6500 | 1 |
| 24 | Yogurt | Dairy | 1000 | 2 |
| 25 | Toothpaste | Personal Care | 2200 | 3 |

---

### 3.3 All customers and their orders, including customers with no orders (LEFT JOIN)

```sql
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
```

**Explanation:** A `LEFT JOIN` keeps every row from `customers`, even if there's no matching row in `orders`. Any customer without an order would show `NULL` in the `order_id` and `order_date` columns instead of being dropped from the results.

**Business interpretation:** This lets management identify inactive customers — people who are registered but have never ordered — so they can be targeted with re-engagement campaigns or promotions. In this dataset, all 5 customers have placed at least one order, so no `NULL` rows appear.

**Results:**

| CUSTOMER_ID | CUSTOMER_NAME | CITY | ORDER_ID | ORDER_DATE |
|---|---|---|---|---|
| 1 | Jean Claude | Kigali | 1 | 2026-08-01 |
| 1 | Jean Claude | Kigali | 6 | 2026-08-08 |
| 1 | Jean Claude | Kigali | 11 | 2026-08-20 |
| 2 | Alice Uwase | Huye | 2 | 2026-08-02 |
| 2 | Alice Uwase | Huye | 8 | 2026-08-12 |
| 2 | Alice Uwase | Huye | 12 | 2026-08-22 |
| 3 | Eric Niyonzima | Kigali | 3 | 2026-08-03 |
| 3 | Eric Niyonzima | Kigali | 7 | 2026-08-10 |
| 3 | Eric Niyonzima | Kigali | 13 | 2026-08-25 |
| 4 | Diane Mukamana | Musanze | 4 | 2026-08-05 |
| 4 | Diane Mukamana | Musanze | 10 | 2026-08-17 |
| 4 | Diane Mukamana | Musanze | 15 | 2026-08-30 |
| 5 | Patrick Habimana | Rubavu | 5 | 2026-08-06 |
| 5 | Patrick Habimana | Rubavu | 9 | 2026-08-15 |
| 5 | Patrick Habimana | Rubavu | 14 | 2026-08-27 |

*(No customer shows a `NULL` order, since every customer in this dataset has placed at least one order.)*

---

## 4. CTE Query

### 4.1 Customers with above-average total spend

```sql
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
```

**Explanation:** The CTE `customer_totals` first computes each customer's total spend by joining all four tables and multiplying `quantity * price` for every line item, then summing per customer. The outer query then filters that CTE result down to only customers whose `total_spend` is above the average of all customers' totals (calculated with a scalar subquery).

**Business interpretation:** This flags "high-value" customers — the ones spending more than the typical customer — who management may want to prioritize for loyalty programs or personalized offers.

**Results:**

Average total spend across all 5 customers = **22,440** (112,200 ÷ 5).

| CUSTOMER_ID | CUSTOMER_NAME | TOTAL_SPEND |
|---|---|---|
| 1 | Jean Claude | 28500 |
| 4 | Diane Mukamana | 28400 |

Only Jean Claude and Diane Mukamana spend above the 22,440 average; the other three customers (Patrick Habimana – 20,900, Alice Uwase – 17,700, Eric Niyonzima – 16,700) fall below it.

---

## 5. Window Function Queries

### 5.1 Rank customers by total amount spent, highest first

```sql
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
```

**Explanation:** `RANK() OVER (ORDER BY ... DESC)` assigns rank 1 to the highest total spender. Unlike `ROW_NUMBER()`, `RANK()` gives tied values the same rank and skips the next rank number(s) accordingly.

**Business interpretation:** A straightforward leaderboard of customers by lifetime value, useful for identifying VIP customers at a glance.

**Results:**

| CUSTOMER_ID | CUSTOMER_NAME | TOTAL_SPEND | SPEND_RANK |
|---|---|---|---|
| 1 | Jean Claude | 28500 | 1 |
| 4 | Diane Mukamana | 28400 | 2 |
| 5 | Patrick Habimana | 20900 | 3 |
| 2 | Alice Uwase | 17700 | 4 |
| 3 | Eric Niyonzima | 16700 | 5 |

---

### 5.2 Number each customer's orders in the order placed

```sql
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
```

**Explanation:** `PARTITION BY customer_id` restarts the numbering for each customer, and `ORDER BY order_date` numbers their orders chronologically (their 1st order, 2nd order, and so on).

**Business interpretation:** This helps track each customer's purchase journey and repeat-buying behavior — e.g., distinguishing a customer's first order (possibly influenced by a promotion) from later, repeat orders.

**Results:**

| CUSTOMER_ID | ORDER_ID | ORDER_DATE | ORDER_SEQUENCE |
|---|---|---|---|
| 1 | 1 | 2026-08-01 | 1 |
| 1 | 6 | 2026-08-08 | 2 |
| 1 | 11 | 2026-08-20 | 3 |
| 2 | 2 | 2026-08-02 | 1 |
| 2 | 8 | 2026-08-12 | 2 |
| 2 | 12 | 2026-08-22 | 3 |
| 3 | 3 | 2026-08-03 | 1 |
| 3 | 7 | 2026-08-10 | 2 |
| 3 | 13 | 2026-08-25 | 3 |
| 4 | 4 | 2026-08-05 | 1 |
| 4 | 10 | 2026-08-17 | 2 |
| 4 | 15 | 2026-08-30 | 3 |
| 5 | 5 | 2026-08-06 | 1 |
| 5 | 9 | 2026-08-15 | 2 |
| 5 | 14 | 2026-08-27 | 3 |

---

### 5.3 Running total of revenue over time, ordered by order date

```sql
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
```

**Explanation:** The inner `SUM(oi.quantity * p.price)` (with `GROUP BY`) calculates each order's total revenue. The outer `SUM(...) OVER (ORDER BY order_date, order_id)` is a window function that adds each order's revenue to a cumulative running total as we move forward in time.

**Business interpretation:** This shows management how total revenue accumulates over the month, making it easy to spot growth trends, slow periods, or the impact of specific high-value orders on overall sales momentum.

**Results:**

| ORDER_ID | ORDER_DATE | ORDER_REVENUE | RUNNING_TOTAL_REVENUE |
|---|---|---|---|
| 1 | 2026-08-01 | 14500 | 14500 |
| 2 | 2026-08-02 | 8600 | 23100 |
| 3 | 2026-08-03 | 6000 | 29100 |
| 4 | 2026-08-05 | 5800 | 34900 |
| 5 | 2026-08-06 | 11500 | 46400 |
| 6 | 2026-08-08 | 6500 | 52900 |
| 7 | 2026-08-10 | 4200 | 57100 |
| 8 | 2026-08-12 | 5500 | 62600 |
| 9 | 2026-08-15 | 7400 | 70000 |
| 10 | 2026-08-17 | 16000 | 86000 |
| 11 | 2026-08-20 | 7500 | 93500 |
| 12 | 2026-08-22 | 3600 | 97100 |
| 13 | 2026-08-25 | 6500 | 103600 |
| 14 | 2026-08-27 | 2000 | 105600 |
| 15 | 2026-08-30 | 6600 | 112200 |

Total revenue for the month reaches **112,200**, growing steadily with a notable jump on Aug 17 (Order 10, 16,000) driven by a large Rice 5kg purchase.

---

### 5.4 Days between current and previous order (customers with more than one order)

```sql
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
```

**Explanation:** `LAG(order_date)` looks back one row within each customer's partition (sorted by date) to retrieve their previous order's date. Subtracting the two dates gives the number of days between consecutive orders. The `COUNT(*) OVER (PARTITION BY customer_id)` filters the result to customers with more than one order, and excluding `NULL` `prev_order_date` removes each customer's very first order (which has no prior order to compare against).

**Business interpretation:** This reveals each customer's typical reorder frequency — how many days pass between their visits — which management can use to plan restocking cycles, predict future orders, or trigger reminder promotions when a customer is "due" for another order.

**Results:**

| CUSTOMER_ID | ORDER_ID | ORDER_DATE | PREV_ORDER_DATE | DAYS_SINCE_LAST_ORDER |
|---|---|---|---|---|
| 1 | 6 | 2026-08-08 | 2026-08-01 | 7 |
| 1 | 11 | 2026-08-20 | 2026-08-08 | 12 |
| 2 | 8 | 2026-08-12 | 2026-08-02 | 10 |
| 2 | 12 | 2026-08-22 | 2026-08-12 | 10 |
| 3 | 7 | 2026-08-10 | 2026-08-03 | 7 |
| 3 | 13 | 2026-08-25 | 2026-08-10 | 15 |
| 4 | 10 | 2026-08-17 | 2026-08-05 | 12 |
| 4 | 15 | 2026-08-30 | 2026-08-17 | 13 |
| 5 | 9 | 2026-08-15 | 2026-08-06 | 9 |
| 5 | 14 | 2026-08-27 | 2026-08-15 | 12 |

Each customer's very first order (order 1, 2, 3, 4, or 5) is excluded, since there's no prior order to compare it to. Reorder gaps range from 7 to 15 days across customers.

---


---

## 7. How to Run

1. **Requirements:** Oracle Database (tested on Oracle Live SQL / Oracle SQL Developer). The script uses standard Oracle syntax (`NUMBER`, `VARCHAR2`, `DATE 'YYYY-MM-DD'` literals, `RANK()`, `ROW_NUMBER()`, `LAG()`).
2. Open the file [`sunrise_supermarket.sql`](./sunrise_supermarket.sql) in your Oracle SQL client.
3. Run the script **top to bottom in order**:
   - Section 1 creates the four tables (`customers`, `products`, `orders`, `order_items`).
   - Section 2 inserts all sample data (5 customers, 8 products, 15 orders, 25 order items) and commits.
   - Section 3 contains the three JOIN queries.
   - Section 4 contains the CTE query.
   - Section 5 contains the four window-function queries.
4. Each query can also be run individually/on its own once the schema and data are loaded, if you only want to re-check one result.
5. If you need to reset and re-run the whole script, drop the tables first in reverse dependency order:
   ```sql
   DROP TABLE order_items;
   DROP TABLE orders;
   DROP TABLE products;
   DROP TABLE customers;
   ```
