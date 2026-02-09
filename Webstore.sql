CREATE DATABASE webstoreGaponenko;
USE webstoreGaponenko;

--tabeli kustutamine
DROP TABLE customers;

--categories tabeli loomine
CREATE TABLE categories (
category_id INT IDENTITY(1,1) PRIMARY KEY,
category_name VARCHAR(30) UNIQUE NOT NULL
);

--categories tabeli täitmine
INSERT INTO categories (category_name)
VALUES 
('T-särk'),
('Mantel'),
('Pusa'),
('Pintsak'),
('Teksad');
SELECT * FROM categories;

--brands tabeli loomine
CREATE TABLE brands(
brand_id INT IDENTITY(1,1) PRIMARY KEY,
brand_name VARCHAR(30) UNIQUE NOT NULL
);

--brands tabeli täitmine
INSERT INTO brands(brand_name)
VALUES 
('Zara'),
('Balenciaga'),
('Alpha Industries'),
('Nike'),
('Asics');
SELECT * FROM brands;

--products tabeli loomine
CREATE TABLE products (
product_id INT IDENTITY(1,1) PRIMARY KEY,
product_name VARCHAR(50) NOT NULL,
brand_id INT NOT NULL,
category_id INT NOT NULL,
model_year INT,
list_price DECIMAL(7,2),
CONSTRAINT fk_products_brand 
FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
CONSTRAINT fk_products_category 
FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

--products tabeli täitmine
INSERT INTO products 
(product_name, brand_id, category_id, model_year, list_price)
VALUES
('Pusa', 4, 3, 2023, 79.99),
('T-särk', 1, 1, 2022, 19.99),
('Mantel', 2, 2, 2024, 899.99);
SELECT * FROM products;

--stores tabeli loomine
CREATE TABLE stores (
store_id INT IDENTITY(1,1) PRIMARY KEY,
store_name VARCHAR(50) NOT NULL,
phone VARCHAR(13),
email VARCHAR(50),
street VARCHAR(50),
city VARCHAR(30),
state VARCHAR(30),
zip_code VARCHAR(5)
);

--stores tabeli täitmine
INSERT INTO stores (store_name, phone, email, street, city, state, zip_code)
VALUES
('Tallinn Store', '+3726001111', 'tallinn@store.ee', 'Narva mnt 7', 'Tallinn', 'Harju', '10117'),
('Berlin Store', '+493012345', 'berlin@store.de', 'Alexanderplatz 1', 'Berlin', 'BE', '10178');
SELECT * FROM stores;

--stocks tabeli loomine
CREATE TABLE stocks (
store_id INT,
product_id INT,
quantity INT NOT NULL,
CONSTRAINT pk_stocks PRIMARY KEY (store_id, product_id),
CONSTRAINT fk_stocks_product 
FOREIGN KEY (product_id) REFERENCES products(product_id)
);

--stocks tabeli täitmine
INSERT INTO stocks (store_id, product_id, quantity)
VALUES
(1, 1, 10),
(1, 2, 25),
(2, 3, 5);
SELECT * FROM stocks;

--customers tabeli loomine
CREATE TABLE customers (
customer_id INT IDENTITY(1,1) PRIMARY KEY,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
phone VARCHAR(13) UNIQUE,
email VARCHAR(50) UNIQUE NOT NULL,
street VARCHAR(50),
city VARCHAR(30),
states VARCHAR(30),
zip_code VARCHAR(5)
);

--customers tabeli täitmine
INSERT INTO customers(first_name, last_name, phone, email, street, city, states, zip_code)
VALUES 
('Mark', 'Johnson', '+15551234567', 'mark.johnson@email.com', '12 Oak Street', 'New York', 'NY', '10001'),
('Anna', 'Petrova', '+3725123456', 'anna.petrova@email.com', '5 Narva mnt', 'Tallinn', 'Harju', '10117'),
('Lucas', 'Meyer', '+4917098765', 'lucas.meyer@email.com', '8 Bahnhofstrasse', 'Berlin', 'BE', '10115'),
('Sofia', 'Garcia', '+3461233445', 'sofia.garcia@email.com', '22 Calle Mayor', 'Madrid', 'MD', '28013'),
('Kevin', 'Brown', '+15557788990', 'kevin.brown@email.com', '45 Pine Avenue', 'Los Angeles', 'CA', '90001');
SELECT * FROM customers;

--staffs tabeli loomine
CREATE TABLE staffs (
staff_id INT IDENTITY(1,1) PRIMARY KEY,
first_name VARCHAR(30) NOT NULL,
last_name VARCHAR(30) NOT NULL,
email VARCHAR(50) UNIQUE NOT NULL,
phone VARCHAR(13) UNIQUE,
active BIT NOT NULL,
store_id INT NOT NULL,
manager_id INT NULL,
CONSTRAINT fk_staffs_store
FOREIGN KEY (store_id) REFERENCES stores(store_id),
CONSTRAINT fk_staffs_manager
FOREIGN KEY (manager_id) REFERENCES staffs(staff_id)
);

--manager_staffs tabeli täitmine
INSERT INTO staffs (first_name, last_name, email, phone, active, store_id, manager_id)
VALUES
('Karl', 'Tamm', 'karl.tamm@store.ee', '+3725111111', 1, 1, NULL),
('Hans', 'Muller', 'hans.muller@store.de', '+49151111111', 1, 2, NULL);

--staffs tabeli täitmine
INSERT INTO staffs (first_name, last_name, email, phone, active, store_id, manager_id)
VALUES
('Maria', 'Ivanova', 'maria.ivanova@store.ee', '+3725222222', 1, 1, 1),
('Lukas', 'Schmidt', 'lukas.schmidt@store.de', '+49152222222', 1, 2, 2);
SELECT * FROM staffs;

--orders tabeli loomine
CREATE TABLE orders (
order_id INT IDENTITY(1,1) PRIMARY KEY,
customer_id INT NOT NULL,
order_status INT NOT NULL,
order_date DATE NOT NULL,
required_date DATE,
shipped_date DATE,
store_id INT NOT NULL,
staff_id INT NOT NULL,
CONSTRAINT fk_orders_customer
FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
CONSTRAINT fk_orders_store
FOREIGN KEY (store_id) REFERENCES stores(store_id),
CONSTRAINT fk_orders_staff
FOREIGN KEY (staff_id) REFERENCES staffs(staff_id)
);

--orders tabeli täitmine
INSERT INTO orders
(customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id)
VALUES
(1, 1, '2025-02-01', '2025-02-05', '2025-02-03', 1, 3),
(2, 2, '2025-02-02', '2025-02-06', NULL, 1, 3),
(3, 1, '2025-02-03', '2025-02-07', '2025-02-05', 2, 4);
SELECT * FROM orders;

--order_items tabeli loomine
CREATE TABLE order_items (
order_id INT NOT NULL,
item_id INT NOT NULL,
product_id INT NOT NULL,
quantity INT NOT NULL,
list_price DECIMAL(7,2) NOT NULL,
discount DECIMAL(4,2) DEFAULT 0,
CONSTRAINT pk_order_items
PRIMARY KEY (order_id, item_id),
CONSTRAINT fk_order_items_order
FOREIGN KEY (order_id) REFERENCES orders(order_id),
CONSTRAINT fk_order_items_product
FOREIGN KEY (product_id) REFERENCES products(product_id),
CONSTRAINT chk_discount
CHECK (discount >= 0 AND discount < 1)
);

--order_items tabeli täitmine
INSERT INTO order_items
(order_id, item_id, product_id, quantity, list_price, discount)
VALUES
(1, 1, 1, 2, 79.99, 0.10),
(1, 2, 2, 1, 19.99, 0.00),
(2, 1, 3, 1, 899.99, 0.15),
(3, 1, 1, 3, 79.99, 0.05);
SELECT * FROM order_items;
