-- TABEL: Products
-- Salvestab toodete andmed: nimi, tootja, kogus, hind
CREATE TABLE Products (
    ID int IDENTITY PRIMARY KEY,
    ProductName nvarchar(30) NOT NULL,
    Manufacturer nvarchar(20) NOT NULL,
    ProductCount int DEFAULT 0, -- laoseis, vaikimisi 0
    Price money NOT NULL
);

-- Toodete lisamine
INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price) VALUES
('iPhone 15 Pro', 'Apple', 45, 1099.99),
('Galaxy S26 Ultra', 'Samsung', 30, 1499.99),
('MX Master 3S', 'Logitech', 120, 99.99),
('ThinkPad X1 Carbon', 'Lenovo', 15, 1549.00),
('WH-1000XM5', 'Sony', 67, 349.99);

SELECT * FROM Products;

-- PROTSEDUUR: ProductSummary
-- Kuvab iga toote nime, tootja ja hinna
CREATE PROCEDURE ProductSummary
AS
BEGIN
    SELECT ProductName AS Product, Manufacturer, Price
    FROM Products;
END;

-- Kutse
EXEC ProductSummary;
