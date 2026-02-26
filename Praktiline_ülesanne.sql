create database IKTpv25_1_TAR_praktiline_too;
use IKTpv25_1_TAR_praktiline_too;

CREATE TABLE category (
    category_id INT PRIMARY KEY IDENTITY(1,1),
    categoryName VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO category (categoryName) VALUES
('Elektroonika'),
('Rõivad');

CREATE TABLE products (
    products_id INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(100) NOT NULL,
    category_id INT NOT NULL,
    price DECIMAL(10,2) NOT NULL CHECK (Price >= 0),
    CONSTRAINT fk_product_category 
	FOREIGN KEY (category_id) REFERENCES category(category_id)
);

INSERT INTO products (name, category_id, Price) VALUES
('Telefon',1, 299.99),
('Jope',2, 89.99);


CREATE TABLE customer (
    customer_id INT PRIMARY KEY IDENTITY(1,1),
    names VARCHAR(30) NOT NULL,
    contact VARCHAR(30)
);

INSERT INTO customer (names, contact) VALUES
('Jaan Tamm','jaan@gmail.com'),
('Mari Kask','+372 5555 1234');


CREATE TABLE sale (
    sale_id INT PRIMARY KEY IDENTITY(1,1),
    products_id INT  NOT NULL,
    customer_id INT  NOT NULL,
    count_pr INT NOT NULL DEFAULT 1 CHECK (count_pr > 0),
    date_of_sale DATE,
    FOREIGN KEY (products_id) REFERENCES products(products_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
);

INSERT INTO sale (products_id, customer_id, count_pr, date_of_sale) VALUES
(1,1,2,'2024-01-15'),
(2,2,1,'2024-02-20');
