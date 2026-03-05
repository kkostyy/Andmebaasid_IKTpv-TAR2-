create table Products (
	ID INT IDENTITY PRIMARY KEY,
	ProductName NVARCHAR(30)not null,
	Manufacturer NVARCHAR(20)not null,
	ProductCount INT DEFAULT 0,
	Price MONEY not null
);

INSERT INTO Products (ProductName, Manufacturer, ProductCount, Price) VALUES
('iPhone 15 Pro','Apple',45,1099.99),
('Galaxy S26 Ultra' ,'Samsung',30,1499.99),
('MX Master 3S','Logitech',120,99.99),
('ThinkPad X1 Carbon','Lenovo',15,1549.00),
('WH-1000XM5','Sony',67,349.99);

SELECT * FROM Products

--Proceduur mis kuvab Product manufacturer ja price 
CREATE PROCEDURE ProductSummary
AS
BEGIN
SELECT ProductName AS Product, Manufacturer, Price	
FROM Products
END;

--Kutse
EXEC ProductSummary

--Proceduur mis lisab
