-- Andmebaasi loomine ja valimine
CREATE DATABASE webstoreGaponenko;
USE webstoreGaponenko;

-- Vana tabeli kustutamine (vajadusel)
DROP TABLE customers;

-- TABEL: categories
-- Salvestab rõivakategooriad
CREATE TABLE categories (
    category_id int IDENTITY(1,1) PRIMARY KEY,
    category_name varchar(30) UNIQUE NOT NULL
);

-- Kategooriate lisamine
INSERT INTO categories (category_name) VALUES
('T-särk'),
('Mantel'),
('Pusa'),
('Pintsak'),
('Teksad');

SELECT * FROM categories;

-- TABEL: brands
-- Salvestab brändide nimed
CREATE TABLE brands (
    brand_id int IDENTITY(1,1) PRIMARY KEY,
    brand_name varchar(30) UNIQUE NOT NULL
);

-- Brändide lisamine
INSERT INTO brands (brand_name) VALUES
('Zara'),
('Balenciaga'),
('Alpha Industries'),
('Nike'),
('Asics');

SELECT * FROM brands;

-- TABEL: products
-- Salvestab tooted koos brändi, kategooria, aasta ja hinnaga
CREATE TABLE products (
    product_id int IDENTITY(1,1) PRIMARY KEY,
    product_name varchar(50) NOT NULL,
    brand_id int NOT NULL,
    category_id int NOT NULL,
    model_year int,
    list_price decimal(7,2),
    CONSTRAINT fk_products_brand FOREIGN KEY (brand_id) REFERENCES brands(brand_id),
    CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Toodete lisamine
INSERT INTO products (product_name, brand_id, category_id, model_year, list_price) VALUES
('Pusa', 4, 3, 2023, 79.99),
('T-särk', 1, 1, 2022, 19.99),
('Mantel', 2, 2, 2024, 899.99);

SELECT * FROM products;

-- TABEL: stores
-- Salvestab poodide andmed: nimi, kontakt, aadress
CREATE TABLE stores (
    store_id int IDENTITY(1,1) PRIMARY KEY,
    store_name varchar(50) NOT NULL,
    phone varchar(13),
    email varchar(50),
    street varchar(50),
    city varchar(30),
    state varchar(30),
    zip_code varchar(5)
);

-- Poodide lisamine
INSERT INTO stores (store_name, phone, email, street, city, state, zip_code) VALUES
('Tallinn Store', '+3726001111', 'tallinn@store.ee', 'Narva mnt 7', 'Tallinn', 'Harju', '10117'),
('Berlin Store', '+493012345', 'berlin@store.de', 'Alexanderplatz 1', 'Berlin', 'BE', '10178');

SELECT * FROM stores;

-- TABEL: stocks
-- Salvestab toodete laoseis poodide kaupa (liitprimaarvõti)
CREATE TABLE stocks (
    store_id int,
    product_id int,
    quantity int NOT NULL,
    CONSTRAINT pk_stocks PRIMARY KEY (store_id, product_id),
    CONSTRAINT fk_stocks_product FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Laoandmete lisamine
INSERT INTO stocks (store_id, product_id, quantity) VALUES
(1, 1, 10),
(1, 2, 25),
(2, 3, 5);

SELECT * FROM stocks;

-- TABEL: customers
-- Salvestab klientide isikuandmed ja aadress
CREATE TABLE customers (
    customer_id int IDENTITY(1,1) PRIMARY KEY,
    first_name varchar(30) NOT NULL,
    last_name varchar(30) NOT NULL,
    phone varchar(13) UNIQUE,
    email varchar(50) UNIQUE NOT NULL,
    street varchar(50),
    city varchar(30),
    states varchar(30),
    zip_code varchar(5)
);

-- Klientide lisamine
INSERT INTO customers (first_name, last_name, phone, email, street, city, states, zip_code) VALUES
('Mark', 'Johnson', '+15551234567', 'mark.johnson@email.com', '12 Oak Street', 'New York', 'NY', '10001'),
('Anna', 'Petrova', '+3725123456', 'anna.petrova@email.com', '5 Narva mnt', 'Tallinn', 'Harju', '10117'),
('Lucas', 'Meyer', '+4917098765', 'lucas.meyer@email.com', '8 Bahnhofstrasse', 'Berlin', 'BE', '10115'),
('Sofia', 'Garcia', '+3461233445', 'sofia.garcia@email.com', '22 Calle Mayor', 'Madrid', 'MD', '28013'),
('Kevin', 'Brown', '+15557788990', 'kevin.brown@email.com', '45 Pine Avenue', 'Los Angeles', 'CA', '90001');

SELECT * FROM customers;

-- TABEL: staffs
-- Salvestab töötajate andmed koos poe ja juhi viitega
-- manager_id viitab samale tabelile (enesviide)
CREATE TABLE staffs (
    staff_id int IDENTITY(1,1) PRIMARY KEY,
    first_name varchar(30) NOT NULL,
    last_name varchar(30) NOT NULL,
    email varchar(50) UNIQUE NOT NULL,
    phone varchar(13) UNIQUE,
    active bit NOT NULL, -- 1 = aktiivne, 0 = mitteaktiivne
    store_id int NOT NULL,
    manager_id int NULL, -- NULL kui töötaja on ise juht
    CONSTRAINT fk_staffs_store FOREIGN KEY (store_id) REFERENCES stores(store_id),
    CONSTRAINT fk_staffs_manager FOREIGN KEY (manager_id) REFERENCES staffs(staff_id)
);

-- Juhtide lisamine (manager_id = NULL)
INSERT INTO staffs (first_name, last_name, email, phone, active, store_id, manager_id) VALUES
('Karl', 'Tamm', 'karl.tamm@store.ee', '+3725111111', 1, 1, NULL),
('Hans', 'Muller', 'hans.muller@store.de', '+49151111111', 1, 2, NULL);

-- Töötajate lisamine (viitavad juhtidele)
INSERT INTO staffs (first_name, last_name, email, phone, active, store_id, manager_id) VALUES
('Maria', 'Ivanova', 'maria.ivanova@store.ee', '+3725222222', 1, 1, 1),
('Lukas', 'Schmidt', 'lukas.schmidt@store.de', '+49152222222', 1, 2, 2);

SELECT * FROM staffs;

-- TABEL: orders
-- Salvestab tellimused koos kliendi, poe ja töötaja viitega
CREATE TABLE orders (
    order_id int IDENTITY(1,1) PRIMARY KEY,
    customer_id int NOT NULL,
    order_status int NOT NULL, -- 1=uus, 2=töötlemisel jne
    order_date date NOT NULL,
    required_date date,
    shipped_date date, -- NULL kui pole veel saadetud
    store_id int NOT NULL,
    staff_id int NOT NULL,
    CONSTRAINT fk_orders_customer FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    CONSTRAINT fk_orders_store FOREIGN KEY (store_id) REFERENCES stores(store_id),
    CONSTRAINT fk_orders_staff FOREIGN KEY (staff_id) REFERENCES staffs(staff_id)
);

-- Tellimuste lisamine
INSERT INTO orders (customer_id, order_status, order_date, required_date, shipped_date, store_id, staff_id) VALUES
(1, 1, '2025-02-01', '2025-02-05', '2025-02-03', 1, 3),
(2, 2, '2025-02-02', '2025-02-06', NULL, 1, 3),
(3, 1, '2025-02-03', '2025-02-07', '2025-02-05', 2, 4);

SELECT * FROM orders;

-- TABEL: order_items
-- Salvestab tellimuse read: toode, kogus, hind, allahindlus
-- Liitprimaarvõti: order_id + item_id
CREATE TABLE order_items (
    order_id int NOT NULL,
    item_id int NOT NULL,
    product_id int NOT NULL,
    quantity int NOT NULL,
    list_price decimal(7,2) NOT NULL,
    discount decimal(4,2) DEFAULT 0, -- allahindlus 0.00–0.99
    CONSTRAINT pk_order_items PRIMARY KEY (order_id, item_id),
    CONSTRAINT fk_order_items_order FOREIGN KEY (order_id) REFERENCES orders(order_id),
    CONSTRAINT fk_order_items_product FOREIGN KEY (product_id) REFERENCES products(product_id),
    CONSTRAINT chk_discount CHECK(discount >= 0 AND discount < 1)
);

-- Tellimuse ridade lisamine
INSERT INTO order_items (order_id, item_id, product_id, quantity, list_price, discount) VALUES
(1, 1, 1, 2, 79.99, 0.10),
(1, 2, 2, 1, 19.99, 0.00),
(2, 1, 3, 1, 899.99, 0.15),
(3, 1, 1, 3, 79.99, 0.05);

SELECT * FROM order_items;
