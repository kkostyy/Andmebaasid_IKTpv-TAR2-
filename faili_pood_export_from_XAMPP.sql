-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Loomise aeg: Veebr 16, 2026 kell 03:45 PL
-- Serveri versioon: 10.4.32-MariaDB
-- PHP versioon: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Andmebaas: `faili pood`
--

DELIMITER $$
--
-- Toimingud
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteCustomerByID` (IN `id` INT)   BEGIN
SELECT * FROM customers;
DELETE FROM customers WHERE customer_id = id;
SELECT * FROM customers;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetLateOrders` (IN `data` DATE)   BEGIN
SELECT * FROM orders WHERE shipped_date < data;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `IncreaseStockByTenPercent` ()   BEGIN
SELECT * FROM stocks;
UPDATE stocks SET quantity = quantity * 1.1;
SELECT * FROM stocks;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `kustutaBrand` (IN `brand_id` INT)   BEGIN
    DELETE FROM brands
    WHERE brand_id = brand_id;

    SELECT * FROM brands;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaBrand` (IN `brand_name` VARCHAR(30))   BEGIN
	INSERT INTO brands(brand_name) VALUES (brand_name);
	SELECT * from brands;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lisaProduct` (IN `product_name` VARCHAR(50), IN `brand_id` INT, IN `category_id` INT, IN `model_year` INT, IN `list_price` DECIMAL(7))   BEGIN
    INSERT INTO products(product_name, brand_id, category_id, model_year, list_price)
    VALUES (product_name, brand_id, category_id, model_year, list_price);

    SELECT * FROM products;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ordersByCustomer` (IN `customer_id` INT)   BEGIN
    SELECT order_id,
           order_date,
           order_status,
           store_name,
           first_name + ' ' + last_name AS staff_name
    FROM orders o
    JOIN stores s ON store_id = store_id
    JOIN staffs st ON staff_id = staff_id
    WHERE customer_id = customer_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `otsiCustomerCity` (IN `city` VARCHAR(30))   BEGIN
    SELECT * 
    FROM customers
    WHERE city = city;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `otsing1taht` (IN `taht` CHAR(1))   BEGIN
	DECLARE today Timestamp DEFAULT CURRENT_DATE;
	SELECT * FROM brands
    WHERE brand_name LIKE CONCAT(taht,'%');
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `uuendaBrand` (IN `brand_id` INT, IN `new_brand_name` VARCHAR(30))   BEGIN
    UPDATE brands
    SET brand_name = new_brand_name
    WHERE brand_id = brand_id;

    SELECT * FROM brands;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `brands`
--

CREATE TABLE `brands` (
  `brand_id` int(11) NOT NULL,
  `brand_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `brands`
--

INSERT INTO `brands` (`brand_id`, `brand_name`) VALUES
(3, 'Alpha Industries'),
(5, 'Asics'),
(2, 'Balenciaga'),
(4, 'Nike'),
(8, 'test'),
(1, 'Zara');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `category_name` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `categories`
--

INSERT INTO `categories` (`category_id`, `category_name`) VALUES
(1, 'Kindad'),
(2, 'T-särk'),
(3, 'Mantel'),
(4, 'Pusa'),
(5, 'Pintsak'),
(6, 'Teksad');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `email` varchar(50) NOT NULL,
  `street` varchar(50) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `states` varchar(30) DEFAULT NULL,
  `zip_code` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `phone`, `email`, `street`, `city`, `states`, `zip_code`) VALUES
(1, 'Mark', 'Johnson', '+15551234567', 'mark.johnson@email.com', '12 Oak Street', 'New York', 'NY', '10001'),
(2, 'Anna', 'Petrova', '+3725123456', 'anna.petrova@email.com', '5 Narva mnt', 'Tallinn', 'Harju', '10117'),
(3, 'Lucas', 'Meyer', '+4917098765', 'lucas.meyer@email.com', '8 Bahnhofstrasse', 'Berlin', 'BE', '10115'),
(4, 'Sofia', 'Garcia', '+3461233445', 'sofia.garcia@email.com', '22 Calle Mayor', 'Madrid', 'MD', '28013'),
(5, 'Kevin', 'Brown', '+15557788990', 'kevin.brown@email.com', '45 Pine Avenue', 'Los Angeles', 'CA', '90001');

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `order_status` int(11) NOT NULL,
  `order_date` date NOT NULL,
  `required_date` date DEFAULT NULL,
  `shipped_date` date DEFAULT NULL,
  `store_id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `order_status`, `order_date`, `required_date`, `shipped_date`, `store_id`, `staff_id`) VALUES
(1, 1, 1, '2025-02-01', '2025-02-05', '2025-02-03', 1, 3),
(2, 2, 2, '2025-02-02', '2025-02-06', NULL, 1, 3),
(3, 3, 1, '2025-02-03', '2025-02-07', '2025-02-05', 2, 4);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `order_items`
--

CREATE TABLE `order_items` (
  `order_id` int(11) NOT NULL,
  `item_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `list_price` decimal(7,2) NOT NULL,
  `discount` decimal(4,2) DEFAULT 0.00
) ;

--
-- Andmete tõmmistamine tabelile `order_items`
--

INSERT INTO `order_items` (`order_id`, `item_id`, `product_id`, `quantity`, `list_price`, `discount`) VALUES
(1, 1, 1, 2, 79.99, 0.10),
(1, 2, 2, 1, 19.99, 0.00),
(2, 1, 3, 1, 899.99, 0.15),
(3, 1, 1, 3, 79.99, 0.05);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(50) NOT NULL,
  `brand_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL,
  `model_year` int(11) DEFAULT NULL,
  `list_price` decimal(7,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `products`
--

INSERT INTO `products` (`product_id`, `product_name`, `brand_id`, `category_id`, `model_year`, `list_price`) VALUES
(1, 'Pusa', 4, 3, 2023, 79.99),
(2, 'T-särk', 1, 1, 2022, 19.99),
(3, 'Mantel', 2, 2, 2024, 899.99);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `staffs`
--

CREATE TABLE `staffs` (
  `staff_id` int(11) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `active` bit(1) NOT NULL,
  `store_id` int(11) NOT NULL,
  `manager_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `staffs`
--

INSERT INTO `staffs` (`staff_id`, `first_name`, `last_name`, `email`, `phone`, `active`, `store_id`, `manager_id`) VALUES
(1, 'Karl', 'Tamm', 'karl.tamm@store.ee', '+3725111111', b'1', 1, NULL),
(2, 'Hans', 'Muller', 'hans.muller@store.de', '+49151111111', b'1', 2, NULL),
(3, 'Maria', 'Ivanova', 'maria.ivanova@store.ee', '+3725222222', b'1', 1, 1),
(4, 'Lukas', 'Schmidt', 'lukas.schmidt@store.de', '+49152222222', b'1', 2, 2);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `stocks`
--

CREATE TABLE `stocks` (
  `store_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `stocks`
--

INSERT INTO `stocks` (`store_id`, `product_id`, `quantity`) VALUES
(1, 1, 11),
(1, 2, 28),
(2, 3, 6);

-- --------------------------------------------------------

--
-- Tabeli struktuur tabelile `stores`
--

CREATE TABLE `stores` (
  `store_id` int(11) NOT NULL,
  `store_name` varchar(50) NOT NULL,
  `phone` varchar(13) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `street` varchar(50) DEFAULT NULL,
  `city` varchar(30) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  `zip_code` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Andmete tõmmistamine tabelile `stores`
--

INSERT INTO `stores` (`store_id`, `store_name`, `phone`, `email`, `street`, `city`, `state`, `zip_code`) VALUES
(1, 'Tallinn Store', '+3726001111', 'tallinn@store.ee', 'Narva mnt 7', 'Tallinn', 'Harju', '10117'),
(2, 'Berlin Store', '+493012345', 'berlin@store.de', 'Alexanderplatz 1', 'Berlin', 'BE', '10178');

--
-- Indeksid tõmmistatud tabelitele
--

--
-- Indeksid tabelile `brands`
--
ALTER TABLE `brands`
  ADD PRIMARY KEY (`brand_id`),
  ADD UNIQUE KEY `brand_name` (`brand_name`);

--
-- Indeksid tabelile `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indeksid tabelile `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indeksid tabelile `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `fk_orders_customer` (`customer_id`),
  ADD KEY `fk_orders_store` (`store_id`),
  ADD KEY `fk_orders_staff` (`staff_id`);

--
-- Indeksid tabelile `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_id`,`item_id`),
  ADD KEY `fk_order_items_product` (`product_id`);

--
-- Indeksid tabelile `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `fk_products_brand` (`brand_id`),
  ADD KEY `fk_products_category` (`category_id`);

--
-- Indeksid tabelile `staffs`
--
ALTER TABLE `staffs`
  ADD PRIMARY KEY (`staff_id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`),
  ADD KEY `fk_staffs_store` (`store_id`),
  ADD KEY `fk_staffs_manager` (`manager_id`);

--
-- Indeksid tabelile `stocks`
--
ALTER TABLE `stocks`
  ADD PRIMARY KEY (`store_id`,`product_id`),
  ADD KEY `fk_stocks_product` (`product_id`);

--
-- Indeksid tabelile `stores`
--
ALTER TABLE `stores`
  ADD PRIMARY KEY (`store_id`);

--
-- AUTO_INCREMENT tõmmistatud tabelitele
--

--
-- AUTO_INCREMENT tabelile `brands`
--
ALTER TABLE `brands`
  MODIFY `brand_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT tabelile `categories`
--
ALTER TABLE `categories`
  MODIFY `category_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT tabelile `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT tabelile `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `products`
--
ALTER TABLE `products`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT tabelile `staffs`
--
ALTER TABLE `staffs`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT tabelile `stores`
--
ALTER TABLE `stores`
  MODIFY `store_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Tõmmistatud tabelite piirangud
--

--
-- Piirangud tabelile `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_customer` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `fk_orders_staff` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`staff_id`),
  ADD CONSTRAINT `fk_orders_store` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`);

--
-- Piirangud tabelile `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `fk_order_items_order` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `fk_order_items_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Piirangud tabelile `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `fk_products_brand` FOREIGN KEY (`brand_id`) REFERENCES `brands` (`brand_id`),
  ADD CONSTRAINT `fk_products_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`category_id`);

--
-- Piirangud tabelile `staffs`
--
ALTER TABLE `staffs`
  ADD CONSTRAINT `fk_staffs_manager` FOREIGN KEY (`manager_id`) REFERENCES `staffs` (`staff_id`),
  ADD CONSTRAINT `fk_staffs_store` FOREIGN KEY (`store_id`) REFERENCES `stores` (`store_id`);

--
-- Piirangud tabelile `stocks`
--
ALTER TABLE `stocks`
  ADD CONSTRAINT `fk_stocks_product` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
