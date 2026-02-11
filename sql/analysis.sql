USE sales_analysis;


-- 1. Total Revenue

SELECT
    SUM(oi.quantity * oi.unit_price) AS total_revenue
FROM order_items oi;


-- 2. Total Orders

SELECT
    COUNT(DISTINCT invoice_no) AS total_orders
FROM orders;


-- 3. Total Customers

SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM customers
WHERE customer_id IS NOT NULL;


-- 4. Average Order Value (AOV)

SELECT
    AVG(order_total) AS avg_order_value
FROM (
    SELECT
        oi.invoice_no,
        SUM(oi.quantity * oi.unit_price) AS order_total
    FROM order_items oi
    GROUP BY oi.invoice_no
) t;


-- 5. Monthly Revenue Trend

SELECT
    DATE_FORMAT(o.invoice_date, '%Y-%m') AS month,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.invoice_no = oi.invoice_no
GROUP BY month
ORDER BY month;


-- 6. Top 10 Customers by Revenue

SELECT
    o.customer_id,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi
    ON o.invoice_no = oi.invoice_no
WHERE o.customer_id IS NOT NULL
GROUP BY o.customer_id
ORDER BY revenue DESC
LIMIT 10;

-- 7. Top 10 Countries by Revenue

SELECT
    c.country,
    SUM(oi.quantity * oi.unit_price) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.invoice_no = oi.invoice_no
GROUP BY c.country
ORDER BY revenue DESC
LIMIT 10;
