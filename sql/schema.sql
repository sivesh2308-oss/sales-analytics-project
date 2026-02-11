CREATE TABLE products (
    stock_code VARCHAR(20) PRIMARY KEY,
    description TEXT
);

CREATE TABLE customers (
    customer_id VARCHAR(20) PRIMARY KEY,
    country VARCHAR(100)
);

CREATE TABLE orders (
    invoice_no VARCHAR(20) PRIMARY KEY,
    invoice_date DATE,
    customer_id VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE order_items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    invoice_no VARCHAR(20),
    stock_code VARCHAR(20),
    quantity INT,
    unit_price DECIMAL(10,2),
    FOREIGN KEY (invoice_no) REFERENCES orders(invoice_no),
    FOREIGN KEY (stock_code) REFERENCES products(stock_code)
);
