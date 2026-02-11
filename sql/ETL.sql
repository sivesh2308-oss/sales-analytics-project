INSERT IGNORE INTO products
SELECT DISTINCT StockCode, Descriptions
FROM raw_sales where stockcode is not null;


INSERT IGNORE INTO customers
SELECT DISTINCT CustomerID, Country
FROM raw_sales
WHERE CustomerID IS NOT NULL;


INSERT ignore INTO orders
SELECT DISTINCT InvoiceNo, InvoiceDate, CustomerID
FROM raw_sales
WHERE CustomerID IS NOT NULL and InvoiceNo not like 'c%';


INSERT INTO order_items (invoice_no, stock_code, quantity, unit_price)
SELECT 
    rs.InvoiceNo,
    rs.StockCode,
    rs.Quantity,
    rs.Price
FROM raw_sales rs
JOIN orders o ON rs.InvoiceNo = o.invoice_no
JOIN products p ON rs.StockCode = p.stock_code
WHERE rs.InvoiceNo NOT LIKE 'C%';
