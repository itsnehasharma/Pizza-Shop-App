-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               10.3.12-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for pizzaparty
CREATE DATABASE IF NOT EXISTS `pizzaparty` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `pizzaparty`;

-- Dumping structure for table pizzaparty.car
CREATE TABLE IF NOT EXISTS `car` (
  `Model` varchar(50) NOT NULL,
  `Make` varchar(50) NOT NULL,
  PRIMARY KEY (`Model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table pizzaparty.car: ~12 rows (approximately)
/*!40000 ALTER TABLE `car` DISABLE KEYS */;
REPLACE INTO `car` (`Model`, `Make`) VALUES
	('Accord', 'Honda'),
	('Civic', 'Honda'),
	('Cruze', 'Chevrolet'),
	('Fit', 'Honda'),
	('Focus', 'Ford'),
	('Forte', 'Kia'),
	('Fusion', 'Ford'),
	('Impala', 'Chevrolet'),
	('Malibu', 'Chevrolet'),
	('Maxima', 'Nissan'),
	('RAV4', 'Toyota'),
	('Sentra', 'Nissan');
/*!40000 ALTER TABLE `car` ENABLE KEYS */;

-- Dumping structure for table pizzaparty.crusts
CREATE TABLE IF NOT EXISTS `crusts` (
  `Crust_Style` varchar(50) NOT NULL,
  `Size` int(11) NOT NULL,
  `Restaurant_Name` varchar(50) NOT NULL,
  `Price` double DEFAULT NULL,
  PRIMARY KEY (`Crust_Style`,`Size`,`Restaurant_Name`),
  KEY `FK_crusts_restaurant` (`Restaurant_Name`),
  CONSTRAINT `FK_crusts_restaurant` FOREIGN KEY (`Restaurant_Name`) REFERENCES `restaurant` (`Restaurant_Name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table pizzaparty.crusts: ~34 rows (approximately)
/*!40000 ALTER TABLE `crusts` DISABLE KEYS */;
REPLACE INTO `crusts` (`Crust_Style`, `Size`, `Restaurant_Name`, `Price`) VALUES
	('Brooklyn Style', 14, 'Dominos Pizza', 4),
	('Brooklyn Style', 16, 'Dominos Pizza', 6),
	('Classic Dough', 11, 'Blaze Pizza', 0),
	('Crunchy Thin Crust', 10, 'Dominos Pizza', 0),
	('Crunchy Thin Crust', 12, 'Dominos Pizza', 2),
	('Crunchy Thin Crust', 14, 'Dominos Pizza', 4),
	('Gluten Free', 10, 'Dominos Pizza', 2),
	('Gluten-Free', 8, 'Papa Johns', 0),
	('Gluten-Free Dough', 11, 'Blaze Pizza', 1),
	('Hand Tossed', 10, 'Dominos Pizza', 0),
	('Hand Tossed', 12, 'Dominos Pizza', 2),
	('Hand Tossed', 14, 'Dominos Pizza', 4),
	('Hand Tossed  Pizza', 12, 'Pizza Hut', 0),
	('Hand Tossed  Pizza', 14, 'Pizza Hut', 2),
	('Handmade Pan', 12, 'Dominos Pizza', 4),
	('High-Rise Dough', 11, 'Blaze Pizza', 2),
	('Original Pan Pizza', 12, 'Pizza Hut', 1),
	('Original Pan Pizza', 14, 'Pizza Hut', 3),
	('Original Stuffed Crust', 12, 'Pizza Hut', 0),
	('Original Stuffed Crust', 14, 'Pizza Hut', 4),
	('Pan', 12, 'Papa Johns', 4),
	('Regular', 8, 'Piesanos Stone Fired Pizza', 0),
	('Regular', 10, 'Papa Johns', 1),
	('Regular', 12, 'Papa Johns', 3),
	('Regular', 12, 'Piesanos Stone Fired Pizza', 5),
	('Regular', 14, 'Papa Johns', 5),
	('Regular', 16, 'Papa Johns', 7),
	('Regular', 16, 'Piesanos Stone Fired Pizza', 10),
	('Regular', 24, 'Piesanos Stone Fired Pizza', 26),
	('Thin Crust', 14, 'Papa Johns', 5),
	('Thin N Crispy', 12, 'Pizza Hut', 0),
	('Thin N Crispy', 14, 'Pizza Hut', 2),
	('Ultimate Cheesy Crust', 12, 'Pizza Hut', 0),
	('Ultimate Cheesy Crust', 14, 'Pizza Hut', 2);
/*!40000 ALTER TABLE `crusts` ENABLE KEYS */;

-- Dumping structure for table pizzaparty.customer
CREATE TABLE IF NOT EXISTS `customer` (
  `Customer_Name` varchar(50) NOT NULL,
  `Address` text NOT NULL,
  `Phone_Number` bigint(20) NOT NULL,
  PRIMARY KEY (`Customer_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table pizzaparty.customer: ~7 rows (approximately)
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
REPLACE INTO `customer` (`Customer_Name`, `Address`, `Phone_Number`) VALUES
	('Corrie', '1551 E Main Street', 1511551),
	('Eva', '4200 NW 5th Avenue', 6783254),
	('Jenny', '22 N 2nd Place', 8675309),
	('Joseph', '1551 E Main Street', 5155115),
	('Stephen', '4848 W 48th Terrace', 8884444),
	('Steve', '1553 NW University Avenue', 3682323),
	('Vikki', '342 S Spring Way', 3333342);
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;

-- Dumping structure for table pizzaparty.driver
CREATE TABLE IF NOT EXISTS `driver` (
  `Car_Number` varchar(10) NOT NULL,
  `Driver_Name` varchar(50) NOT NULL,
  `Model` varchar(50) NOT NULL,
  `Restaurant_Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Car_Number`),
  KEY `FK_driver_car` (`Model`),
  KEY `FK_driver_restaurant` (`Restaurant_Name`),
  CONSTRAINT `FK_driver_car` FOREIGN KEY (`Model`) REFERENCES `car` (`Model`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_driver_restaurant` FOREIGN KEY (`Restaurant_Name`) REFERENCES `restaurant` (`Restaurant_Name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table pizzaparty.driver: ~10 rows (approximately)
/*!40000 ALTER TABLE `driver` DISABLE KEYS */;
REPLACE INTO `driver` (`Car_Number`, `Driver_Name`, `Model`, `Restaurant_Name`) VALUES
	('ABSP42', 'Bruce', 'Civic', 'Pizza Hut'),
	('ADBY44', 'Linda', 'Impala', 'Blaze Pizza'),
	('ADSP94', 'Isabel', 'Malibu', 'Piesanos Stone Fired Pizza'),
	('AHBF84', 'Bill', 'Fusion', 'Dominos Pizza'),
	('AHCF27', 'Charlie', 'Fit', 'Dominos Pizza'),
	('APVS71', 'Tony', 'Impala', 'Pizza Hut'),
	('ARTP69', 'Travers', 'Accord', 'Papa Johns'),
	('AXBP83', 'Steve', 'Fusion', 'Papa Johns'),
	('AXST75', 'Graham', 'Impala', 'Piesanos Stone Fired Pizza'),
	('BDCH33', 'Nathan', 'Civic', 'Blaze Pizza');
/*!40000 ALTER TABLE `driver` ENABLE KEYS */;

-- Dumping structure for table pizzaparty.flavor
CREATE TABLE IF NOT EXISTS `flavor` (
  `Flavor_Name` varchar(50) NOT NULL,
  `Restaurant_Name` varchar(50) NOT NULL,
  `Price` double DEFAULT NULL,
  PRIMARY KEY (`Flavor_Name`,`Restaurant_Name`),
  KEY `FK_flavor_restaurant` (`Restaurant_Name`),
  CONSTRAINT `FK_flavor_restaurant` FOREIGN KEY (`Restaurant_Name`) REFERENCES `restaurant` (`Restaurant_Name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table pizzaparty.flavor: ~16 rows (approximately)
/*!40000 ALTER TABLE `flavor` DISABLE KEYS */;
REPLACE INTO `flavor` (`Flavor_Name`, `Restaurant_Name`, `Price`) VALUES
	('Art Lover', 'Blaze Pizza', 8.25),
	('Cheese Pizza', 'Papa Johns', 7),
	('Cheese Pizza', 'Pizza Hut', 9.49),
	('Delux', 'Piesanos Stone Fired Pizza', 9.39),
	('ExtravaganZZa', 'Dominos Pizza', 11.99),
	('Fiery Buffalo Chicken', 'Papa Johns', 11),
	('Greek Veggie', 'Piesanos Stone Fired Pizza', 9.39),
	('Honolulu Hawaiian', 'Dominos Pizza', 11.99),
	('Meat Lovers Pizza', 'Pizza Hut', 13.49),
	('Pacific Veggie', 'Dominos Pizza', 11.99),
	('Pepperoni Pizza', 'Pizza Hut', 10.74),
	('Philly Cheese Steak', 'Dominos Pizza', 11.99),
	('Piesanos Supreme', 'Piesanos Stone Fired Pizza', 9.39),
	('Red Vine', 'Blaze Pizza', 8.25),
	('Simple Pie', 'Blaze Pizza', 5.25),
	('Zesty Italian Trio', 'Papa Johns', 12);
/*!40000 ALTER TABLE `flavor` ENABLE KEYS */;

-- Dumping structure for table pizzaparty.flavor_toppings
CREATE TABLE IF NOT EXISTS `flavor_toppings` (
  `Flavor_Name` varchar(50) NOT NULL,
  `Restaurant_Name` varchar(50) NOT NULL,
  `Topping_Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Flavor_Name`,`Restaurant_Name`,`Topping_Name`),
  KEY `FK_flavor_toppings_toppings` (`Topping_Name`),
  CONSTRAINT `FK_flavor_toppings_flavor` FOREIGN KEY (`Flavor_Name`, `Restaurant_Name`) REFERENCES `flavor` (`Flavor_Name`, `Restaurant_Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_flavor_toppings_toppings` FOREIGN KEY (`Topping_Name`) REFERENCES `toppings` (`Topping_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table pizzaparty.flavor_toppings: ~66 rows (approximately)
/*!40000 ALTER TABLE `flavor_toppings` DISABLE KEYS */;
REPLACE INTO `flavor_toppings` (`Flavor_Name`, `Restaurant_Name`, `Topping_Name`) VALUES
	('Art Lover', 'Blaze Pizza', 'Artichokes'),
	('Art Lover', 'Blaze Pizza', 'Garlic'),
	('Art Lover', 'Blaze Pizza', 'Mozzarella'),
	('Art Lover', 'Blaze Pizza', 'Ricotta'),
	('Cheese Pizza', 'Papa Johns', 'Mozzarella'),
	('Cheese Pizza', 'Pizza Hut', 'Mozzarella'),
	('Delux', 'Piesanos Stone Fired Pizza', 'Black Olives'),
	('Delux', 'Piesanos Stone Fired Pizza', 'Meatball'),
	('Delux', 'Piesanos Stone Fired Pizza', 'Mushroom'),
	('Delux', 'Piesanos Stone Fired Pizza', 'Onion'),
	('Delux', 'Piesanos Stone Fired Pizza', 'Pepperoni'),
	('ExtravaganZZa', 'Dominos Pizza', 'Beef'),
	('ExtravaganZZa', 'Dominos Pizza', 'Black Olives'),
	('ExtravaganZZa', 'Dominos Pizza', 'Ham'),
	('ExtravaganZZa', 'Dominos Pizza', 'Italian Sausage'),
	('ExtravaganZZa', 'Dominos Pizza', 'Mushroom'),
	('ExtravaganZZa', 'Dominos Pizza', 'Onion'),
	('ExtravaganZZa', 'Dominos Pizza', 'Pepper'),
	('ExtravaganZZa', 'Dominos Pizza', 'Pepperoni'),
	('Fiery Buffalo Chicken', 'Papa Johns', 'Bacon'),
	('Fiery Buffalo Chicken', 'Papa Johns', 'Chicken'),
	('Fiery Buffalo Chicken', 'Papa Johns', 'Onion'),
	('Greek Veggie', 'Piesanos Stone Fired Pizza', 'Diced Tomatoes'),
	('Greek Veggie', 'Piesanos Stone Fired Pizza', 'Feta'),
	('Greek Veggie', 'Piesanos Stone Fired Pizza', 'Garlic'),
	('Greek Veggie', 'Piesanos Stone Fired Pizza', 'Mozzarella'),
	('Greek Veggie', 'Piesanos Stone Fired Pizza', 'Spinach'),
	('Honolulu Hawaiian', 'Dominos Pizza', 'Bacon'),
	('Honolulu Hawaiian', 'Dominos Pizza', 'Ham'),
	('Honolulu Hawaiian', 'Dominos Pizza', 'Pineapple'),
	('Honolulu Hawaiian', 'Dominos Pizza', 'Provolone'),
	('Meat Lovers Pizza', 'Pizza Hut', 'Bacon'),
	('Meat Lovers Pizza', 'Pizza Hut', 'Beef'),
	('Meat Lovers Pizza', 'Pizza Hut', 'Ham'),
	('Meat Lovers Pizza', 'Pizza Hut', 'Italian Sausage'),
	('Meat Lovers Pizza', 'Pizza Hut', 'Pepperoni'),
	('Meat Lovers Pizza', 'Pizza Hut', 'Pork'),
	('Pacific Veggie', 'Dominos Pizza', 'Black Olives'),
	('Pacific Veggie', 'Dominos Pizza', 'Diced Tomatoes'),
	('Pacific Veggie', 'Dominos Pizza', 'Feta'),
	('Pacific Veggie', 'Dominos Pizza', 'Mushroom'),
	('Pacific Veggie', 'Dominos Pizza', 'Onion'),
	('Pacific Veggie', 'Dominos Pizza', 'Pepper'),
	('Pacific Veggie', 'Dominos Pizza', 'Provolone'),
	('Pacific Veggie', 'Dominos Pizza', 'Spinach'),
	('Pepperoni Pizza', 'Pizza Hut', 'Pepperoni'),
	('Philly Cheese Steak', 'Dominos Pizza', 'Mushroom'),
	('Philly Cheese Steak', 'Dominos Pizza', 'Onion'),
	('Philly Cheese Steak', 'Dominos Pizza', 'Pepper'),
	('Philly Cheese Steak', 'Dominos Pizza', 'Philly Steak'),
	('Philly Cheese Steak', 'Dominos Pizza', 'Provolone'),
	('Piesanos Supreme', 'Piesanos Stone Fired Pizza', 'Italian Sausage'),
	('Piesanos Supreme', 'Piesanos Stone Fired Pizza', 'Mushroom'),
	('Piesanos Supreme', 'Piesanos Stone Fired Pizza', 'Onion'),
	('Piesanos Supreme', 'Piesanos Stone Fired Pizza', 'Pepper'),
	('Piesanos Supreme', 'Piesanos Stone Fired Pizza', 'Pepperoni'),
	('Red Vine', 'Blaze Pizza', 'Basil'),
	('Red Vine', 'Blaze Pizza', 'Diced Tomatoes'),
	('Red Vine', 'Blaze Pizza', 'Mozzarella'),
	('Red Vine', 'Blaze Pizza', 'Parmesan Asiago'),
	('Simple Pie', 'Blaze Pizza', 'Mozzarella'),
	('Simple Pie', 'Blaze Pizza', 'Parmesan Asiago'),
	('Zesty Italian Trio', 'Papa Johns', 'Banana Peppers'),
	('Zesty Italian Trio', 'Papa Johns', 'Italian Sausage'),
	('Zesty Italian Trio', 'Papa Johns', 'Pepperoni'),
	('Zesty Italian Trio', 'Papa Johns', 'Salami');
/*!40000 ALTER TABLE `flavor_toppings` ENABLE KEYS */;

-- Dumping structure for table pizzaparty.orders
CREATE TABLE IF NOT EXISTS `orders` (
  `Order_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Customer_Name` varchar(50) NOT NULL,
  `Restaurant_Name` varchar(50) NOT NULL,
  `Is_Delivery` varchar(3) NOT NULL,
  `Car_Number` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`Order_ID`),
  KEY `FK_order_customer` (`Customer_Name`),
  KEY `FK_order_restaurant` (`Restaurant_Name`),
  KEY `FK_order_driver` (`Car_Number`),
  CONSTRAINT `FK_order_customer` FOREIGN KEY (`Customer_Name`) REFERENCES `customer` (`Customer_Name`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_order_driver` FOREIGN KEY (`Car_Number`) REFERENCES `driver` (`Car_Number`) ON DELETE SET NULL ON UPDATE SET NULL,
  CONSTRAINT `FK_order_restaurant` FOREIGN KEY (`Restaurant_Name`) REFERENCES `restaurant` (`Restaurant_Name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=latin1;

-- Dumping data for table pizzaparty.orders: ~24 rows (approximately)
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
REPLACE INTO `orders` (`Order_ID`, `Customer_Name`, `Restaurant_Name`, `Is_Delivery`, `Car_Number`) VALUES
	(1, 'Jenny', 'Blaze Pizza', 'No', NULL),
	(2, 'Corrie', 'Papa Johns', 'Yes', 'AXBP83'),
	(3, 'Corrie', 'Dominos Pizza', 'Yes', 'AHBF84'),
	(4, 'Joseph', 'Papa Johns', 'No', NULL),
	(5, 'Stephen', 'Piesanos Stone Fired Pizza', 'Yes', 'AXST75'),
	(6, 'Joseph', 'Dominos Pizza', 'Yes', 'AHBF84'),
	(7, 'Jenny', 'Papa Johns', 'Yes', 'ARTP69'),
	(8, 'Stephen', 'Dominos Pizza', 'Yes', 'AHCF27'),
	(9, 'Jenny', 'Dominos Pizza', 'Yes', 'AHBF84'),
	(10, 'Jenny', 'Dominos Pizza', 'No', NULL),
	(11, 'Jenny', 'Papa Johns', 'No', NULL),
	(12, 'Jenny', 'Dominos Pizza', 'Yes', 'AHCF27'),
	(13, 'Joseph', 'Dominos Pizza', 'Yes', 'AHBF84'),
	(14, 'Corrie', 'Piesanos Stone Fired Pizza', 'No', NULL),
	(15, 'Stephen', 'Dominos Pizza', 'Yes', 'AHBF84'),
	(16, 'Joseph', 'Dominos Pizza', 'Yes', 'AHBF84'),
	(17, 'Joseph', 'Papa Johns', 'Yes', 'ARTP69'),
	(18, 'Corrie', 'Dominos Pizza', 'Yes', 'AHBF84'),
	(19, 'Corrie', 'Dominos Pizza', 'Yes', 'AHCF27'),
	(20, 'Joseph', 'Papa Johns', 'Yes', 'ARTP69'),
	(29, 'Eva', 'Pizza Hut', 'Yes', 'ABSP42'),
	(30, 'Corrie', 'Piesanos Stone Fired Pizza', 'No', NULL),
	(31, 'Corrie', 'Blaze Pizza', 'No', NULL),
	(32, 'Eva', 'Blaze Pizza', 'Yes', 'BDCH33'),
	(33, 'Steve', 'Piesanos Stone Fired Pizza', 'No', NULL),
	(34, 'Corrie', 'Papa Johns', 'No', NULL);
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;

-- Dumping structure for table pizzaparty.order_pizza
CREATE TABLE IF NOT EXISTS `order_pizza` (
  `Order_ID` bigint(20) NOT NULL,
  `Pizza_ID` bigint(20) NOT NULL,
  PRIMARY KEY (`Order_ID`,`Pizza_ID`),
  KEY `FK_order_pizza_pizza` (`Pizza_ID`),
  CONSTRAINT `FK_order_pizza_order` FOREIGN KEY (`Order_ID`) REFERENCES `orders` (`Order_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_order_pizza_pizza` FOREIGN KEY (`Pizza_ID`) REFERENCES `pizza` (`Pizza_ID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table pizzaparty.order_pizza: ~54 rows (approximately)
/*!40000 ALTER TABLE `order_pizza` DISABLE KEYS */;
REPLACE INTO `order_pizza` (`Order_ID`, `Pizza_ID`) VALUES
	(1, 1),
	(1, 2),
	(1, 3),
	(2, 4),
	(2, 5),
	(3, 6),
	(3, 7),
	(4, 8),
	(4, 9),
	(5, 10),
	(6, 11),
	(6, 12),
	(6, 13),
	(6, 14),
	(7, 15),
	(8, 16),
	(8, 17),
	(8, 18),
	(9, 19),
	(9, 20),
	(9, 21),
	(10, 22),
	(10, 23),
	(11, 24),
	(11, 25),
	(11, 26),
	(11, 27),
	(12, 28),
	(13, 29),
	(13, 30),
	(14, 31),
	(15, 32),
	(16, 33),
	(16, 34),
	(17, 35),
	(17, 36),
	(17, 37),
	(18, 38),
	(18, 39),
	(19, 40),
	(19, 41),
	(19, 42),
	(19, 43),
	(19, 44),
	(20, 45),
	(29, 54),
	(29, 55),
	(29, 56),
	(30, 57),
	(30, 58),
	(31, 59),
	(32, 60),
	(33, 61),
	(33, 62),
	(34, 63),
	(34, 64);
/*!40000 ALTER TABLE `order_pizza` ENABLE KEYS */;

-- Dumping structure for table pizzaparty.pizza
CREATE TABLE IF NOT EXISTS `pizza` (
  `Pizza_ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `Flavor_Name` varchar(50) NOT NULL,
  `Crust_Style` varchar(50) NOT NULL,
  `Size` int(11) NOT NULL,
  `Restaurant_Name` varchar(50) NOT NULL,
  `Sauce_Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Pizza_ID`),
  KEY `FK_pizza_flavor` (`Flavor_Name`),
  KEY `FK_pizza_crusts` (`Crust_Style`,`Size`),
  KEY `FK_pizza_sauce` (`Restaurant_Name`,`Sauce_Name`),
  KEY `FK_pizza_sauce2` (`Sauce_Name`),
  CONSTRAINT `FK_pizza_crusts` FOREIGN KEY (`Crust_Style`, `Size`) REFERENCES `crusts` (`Crust_Style`, `Size`),
  CONSTRAINT `FK_pizza_flavor` FOREIGN KEY (`Flavor_Name`) REFERENCES `flavor` (`Flavor_Name`),
  CONSTRAINT `FK_pizza_restaurant` FOREIGN KEY (`Restaurant_Name`) REFERENCES `restaurant` (`Restaurant_Name`),
  CONSTRAINT `FK_pizza_sauce2` FOREIGN KEY (`Sauce_Name`) REFERENCES `sauce` (`Sauce_Name`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=latin1;

-- Dumping data for table pizzaparty.pizza: ~54 rows (approximately)
/*!40000 ALTER TABLE `pizza` DISABLE KEYS */;
REPLACE INTO `pizza` (`Pizza_ID`, `Flavor_Name`, `Crust_Style`, `Size`, `Restaurant_Name`, `Sauce_Name`) VALUES
	(1, 'Art Lover', 'Gluten-Free Dough', 11, 'Blaze Pizza', 'Red Sauce'),
	(2, 'Red Vine', 'Gluten-Free Dough', 11, 'Blaze Pizza', 'Garlic Pesto Sauce'),
	(3, 'Art Lover', 'Classic Dough', 11, 'Blaze Pizza', 'Red Sauce Dollops'),
	(4, 'Fiery Buffalo Chicken', 'Pan', 12, 'Papa Johns', 'BBQ'),
	(5, 'Zesty Italian Trio', 'Gluten-Free', 8, 'Papa Johns', 'Buffalo'),
	(6, 'ExtravaganZZa', 'Brooklyn Style', 14, 'Dominos Pizza', 'Garlic Parmesan White Sauce'),
	(7, 'ExtravaganZZa', 'Brooklyn Style', 14, 'Dominos Pizza', 'Alfredo Sauce'),
	(8, 'Zesty Italian Trio', 'Pan', 12, 'Papa Johns', 'Original'),
	(9, 'Fiery Buffalo Chicken', 'Regular', 10, 'Papa Johns', 'Buffalo'),
	(10, 'Delux', 'Regular', 8, 'Piesanos Stone Fired Pizza', 'Buffalo Sauce'),
	(11, 'Pacific Veggie', 'Crunchy Thin Crust', 10, 'Dominos Pizza', 'BBQ Sauce'),
	(12, 'Pacific Veggie', 'Crunchy Thin Crust', 10, 'Dominos Pizza', 'BBQ Sauce'),
	(13, 'Honolulu Hawaiian', 'Brooklyn Style', 16, 'Dominos Pizza', 'Alfredo Sauce'),
	(14, 'ExtravaganZZa', 'Brooklyn Style', 14, 'Dominos Pizza', 'Garlic Parmesan White Sauce'),
	(15, 'Cheese Pizza', 'Regular', 10, 'Papa Johns', 'Buffalo'),
	(16, 'Pacific Veggie', 'Crunchy Thin Crust', 10, 'Dominos Pizza', 'Garlic Parmesan White Sauce'),
	(17, 'Honolulu Hawaiian', 'Brooklyn Style', 14, 'Dominos Pizza', 'Garlic Parmesan White Sauce'),
	(18, 'Honolulu Hawaiian', 'Brooklyn Style', 16, 'Dominos Pizza', 'BBQ Sauce'),
	(19, 'ExtravaganZZa', 'Brooklyn Style', 16, 'Dominos Pizza', 'BBQ Sauce'),
	(20, 'Pacific Veggie', 'Brooklyn Style', 14, 'Dominos Pizza', 'Garlic Parmesan White Sauce'),
	(21, 'ExtravaganZZa', 'Brooklyn Style', 16, 'Dominos Pizza', 'BBQ Sauce'),
	(22, 'Pacific Veggie', 'Brooklyn Style', 14, 'Dominos Pizza', 'Hearty Marinara Sauce'),
	(23, 'Honolulu Hawaiian', 'Brooklyn Style', 14, 'Dominos Pizza', 'BBQ Sauce'),
	(24, 'Fiery Buffalo Chicken', 'Pan', 12, 'Papa Johns', 'BBQ'),
	(25, 'Zesty Italian Trio', 'Pan', 12, 'Papa Johns', 'BBQ'),
	(26, 'Fiery Buffalo Chicken', 'Gluten-Free', 8, 'Papa Johns', 'Buffalo'),
	(27, 'Fiery Buffalo Chicken', 'Gluten-Free', 8, 'Papa Johns', 'BBQ'),
	(28, 'ExtravaganZZa', 'Brooklyn Style', 16, 'Dominos Pizza', 'Garlic Parmesan White Sauce'),
	(29, 'Honolulu Hawaiian', 'Brooklyn Style', 14, 'Dominos Pizza', 'Hearty Marinara Sauce'),
	(30, 'Honolulu Hawaiian', 'Crunchy Thin Crust', 10, 'Dominos Pizza', 'Alfredo Sauce'),
	(31, 'Delux', 'Regular', 16, 'Piesanos Stone Fired Pizza', 'Pesto Sauce'),
	(32, 'Pacific Veggie', 'Brooklyn Style', 16, 'Dominos Pizza', 'Hearty Marinara Sauce'),
	(33, 'Honolulu Hawaiian', 'Brooklyn Style', 16, 'Dominos Pizza', 'BBQ Sauce'),
	(34, 'Honolulu Hawaiian', 'Brooklyn Style', 16, 'Dominos Pizza', 'BBQ Sauce'),
	(35, 'Cheese Pizza', 'Pan', 12, 'Papa Johns', 'BBQ'),
	(36, 'Fiery Buffalo Chicken', 'Pan', 12, 'Papa Johns', 'Buffalo'),
	(37, 'Fiery Buffalo Chicken', 'Regular', 10, 'Papa Johns', 'Buffalo'),
	(38, 'Honolulu Hawaiian', 'Brooklyn Style', 16, 'Dominos Pizza', 'Alfredo Sauce'),
	(39, 'Honolulu Hawaiian', 'Brooklyn Style', 16, 'Dominos Pizza', 'BBQ Sauce'),
	(40, 'Honolulu Hawaiian', 'Brooklyn Style', 14, 'Dominos Pizza', 'Garlic Parmesan White Sauce'),
	(41, 'Honolulu Hawaiian', 'Brooklyn Style', 16, 'Dominos Pizza', 'BBQ Sauce'),
	(42, 'Pacific Veggie', 'Brooklyn Style', 14, 'Dominos Pizza', 'BBQ Sauce'),
	(43, 'Pacific Veggie', 'Brooklyn Style', 14, 'Dominos Pizza', 'Alfredo Sauce'),
	(44, 'ExtravaganZZa', 'Brooklyn Style', 16, 'Dominos Pizza', 'Garlic Parmesan White Sauce'),
	(45, 'Fiery Buffalo Chicken', 'Regular', 10, 'Papa Johns', 'Original'),
	(54, 'Cheese Pizza', 'Ultimate Cheesy Crust', 14, 'Pizza Hut', 'Classic Marinara'),
	(55, 'Meat Lovers Pizza', 'Hand Tossed  Pizza', 14, 'Pizza Hut', 'Creamy Garlic Parmesan'),
	(56, 'Pepperoni Pizza', 'Original Stuffed Crust', 14, 'Pizza Hut', 'Classic Marinara'),
	(57, 'Delux', 'Regular', 12, 'Piesanos Stone Fired Pizza', 'Classic Pizza Sauce'),
	(58, 'Piesanos Supreme', 'Regular', 8, 'Piesanos Stone Fired Pizza', 'Buffalo Sauce'),
	(59, 'Art Lover', 'Classic Dough', 11, 'Blaze Pizza', 'Garlic Pesto Sauce'),
	(60, 'Simple Pie', 'Gluten-Free Dough', 11, 'Blaze Pizza', 'Spicy Red Sauce'),
	(61, 'Greek Veggie', 'Regular', 16, 'Piesanos Stone Fired Pizza', 'Roma Tomato Sauce'),
	(62, 'Delux', 'Regular', 24, 'Piesanos Stone Fired Pizza', 'Pesto Sauce'),
	(63, 'Fiery Buffalo Chicken', 'Pan', 12, 'Papa Johns', 'Original'),
	(64, 'Zesty Italian Trio', 'Regular', 16, 'Papa Johns', 'BBQ');
/*!40000 ALTER TABLE `pizza` ENABLE KEYS */;

-- Dumping structure for table pizzaparty.restaurant
CREATE TABLE IF NOT EXISTS `restaurant` (
  `Restaurant_Name` varchar(50) NOT NULL,
  `Address` text NOT NULL,
  `Phone_Number` bigint(20) NOT NULL,
  PRIMARY KEY (`Restaurant_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table pizzaparty.restaurant: ~5 rows (approximately)
/*!40000 ALTER TABLE `restaurant` DISABLE KEYS */;
REPLACE INTO `restaurant` (`Restaurant_Name`, `Address`, `Phone_Number`) VALUES
	('Blaze Pizza', '3617 Archer RD', 4585208),
	('Dominos Pizza', '3581 SW Archer RD', 5055557),
	('Papa Johns', '3605 SW Archer Road', 3367272),
	('Piesanos Stone Fired Pizza', '1250 W University Avenue', 3752337),
	('Pizza Hut', '7331 NW 4th BLVD', 3320032);
/*!40000 ALTER TABLE `restaurant` ENABLE KEYS */;

-- Dumping structure for table pizzaparty.sauce
CREATE TABLE IF NOT EXISTS `sauce` (
  `Sauce_Name` varchar(50) NOT NULL,
  `Restaurant_Name` varchar(50) NOT NULL,
  PRIMARY KEY (`Sauce_Name`,`Restaurant_Name`),
  KEY `FK_sauce_restaurant` (`Restaurant_Name`),
  CONSTRAINT `FK_sauce_restaurant` FOREIGN KEY (`Restaurant_Name`) REFERENCES `restaurant` (`Restaurant_Name`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table pizzaparty.sauce: ~23 rows (approximately)
/*!40000 ALTER TABLE `sauce` DISABLE KEYS */;
REPLACE INTO `sauce` (`Sauce_Name`, `Restaurant_Name`) VALUES
	('Alfredo Sauce', 'Dominos Pizza'),
	('Barbeque', 'Pizza hut'),
	('BBQ', 'Papa Johns'),
	('BBQ Sauce', 'Dominos Pizza'),
	('BBQ Sauce', 'Piesanos Stone Fired Pizza'),
	('Buffalo', 'Papa Johns'),
	('Buffalo', 'Pizza hut'),
	('Buffalo Sauce', 'Piesanos Stone Fired Pizza'),
	('Classic Marinara', 'Pizza hut'),
	('Classic Pizza Sauce', 'Piesanos Stone Fired Pizza'),
	('Creamy Garlic Parmesan', 'Pizza hut'),
	('Garlic Parmesan White Sauce', 'Dominos Pizza'),
	('Garlic Pesto Sauce', 'Blaze Pizza'),
	('Hearty Marinara Sauce', 'Dominos Pizza'),
	('Original', 'Papa Johns'),
	('Pesto Sauce', 'Piesanos Stone Fired Pizza'),
	('Ranch', 'Papa Johns'),
	('Red Sauce', 'Blaze Pizza'),
	('Red Sauce Dollops', 'Blaze Pizza'),
	('Robust Inspired Tomato Sauce', 'Dominos Pizza'),
	('Roma Tomato Sauce', 'Piesanos Stone Fired Pizza'),
	('Spicy Red Sauce', 'Blaze Pizza'),
	('White Cream Sauce', 'Blaze Pizza');
/*!40000 ALTER TABLE `sauce` ENABLE KEYS */;

-- Dumping structure for table pizzaparty.toppings
CREATE TABLE IF NOT EXISTS `toppings` (
  `Topping_Name` varchar(50) NOT NULL,
  `Food_Group` varchar(50) NOT NULL,
  `Calories` int(11) DEFAULT NULL,
  PRIMARY KEY (`Topping_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Dumping data for table pizzaparty.toppings: ~33 rows (approximately)
/*!40000 ALTER TABLE `toppings` DISABLE KEYS */;
REPLACE INTO `toppings` (`Topping_Name`, `Food_Group`, `Calories`) VALUES
	('Artichokes', 'Vegetable', 20),
	('Arugula', 'Vegetable', 10),
	('Bacon', 'Meat', 325),
	('Banana Peppers', 'Vegetable', 20),
	('Basil', 'Herb', 0),
	('Beef', 'Meat', 275),
	('Black Olives', 'Vegetable', 50),
	('Canadian Bacon', 'Meat', 125),
	('Cheddar', 'Cheese', 50),
	('Chicken', 'Meat', 175),
	('Diced Tomatoes', 'Vegetable', 40),
	('Feta', 'Cheese', 50),
	('Garlic', 'Seasoning', 20),
	('Gorgonzola', 'Cheese', 50),
	('Ham', 'Meat', 225),
	('Hot Sauce', 'Sauce', 15),
	('Italian Sausage', 'Meat', 175),
	('Jalapeno', 'Vegetable', 20),
	('Meatball', 'Meat', 300),
	('Mozzarella', 'Cheese', 40),
	('Mushroom', 'Vegetable', 15),
	('Onion', 'Vegetable', 30),
	('Ovalini Mozzarella', 'Cheese', 50),
	('Parmesan Asiago', 'Cheese', 50),
	('Pepper', 'Vegetable', 40),
	('Pepperoni', 'Meat', 250),
	('Philly Steak', 'Meat', 375),
	('Pineapple', 'Fruit', 50),
	('Pork', 'Meat', 200),
	('Provolone', 'Cheese', 50),
	('Ricotta', 'Cheese', 50),
	('Roasted Red Peppers', 'Vegetable', 30),
	('Salami', 'Meat', 245),
	('Spinach', 'Vegetable', 10);
/*!40000 ALTER TABLE `toppings` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
