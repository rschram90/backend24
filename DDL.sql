START TRANSACTION;

Hallo

--
-- Database: `smarthome`
--
CREATE DATABASE IF NOT EXISTS `smarthome`;
USE `smarthome`;

-- --------------------------------------------------------

--
-- Table structure for table `shipmentmethods`
--

CREATE TABLE `shipmentmethods` (
  `ShipmentMethodId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `ShippingCost` decimal(10,2) NOT NULL,
  PRIMARY KEY (`ShipmentMethodId`)
);

-- --------------------------------------------------------

--
-- Table structure for table `paymentmethods`
--

CREATE TABLE `paymentmethods` (
  `PaymentMethodId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  PRIMARY KEY (`PaymentMethodId`)
);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserId` int(11) NOT NULL AUTO_INCREMENT,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(50) NOT NULL,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `LangCode` varchar(2) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `CreatedOn` date NOT NULL,
  `UpdatedOn` date NOT NULL,
  PRIMARY KEY (`UserId`)
);

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `UserId` int(11) NOT NULL,
  `ShipmentMethodId` int(11) NOT NULL,
  `PaymentMethodId` int(11) NOT NULL,
  `TotalPrice` decimal(16,2) NOT NULL,
  `TotalItems` int(11) NOT NULL,
  PRIMARY KEY (`UserId`),
  CONSTRAINT `FK_carts_PaymentMethodId` FOREIGN KEY (`PaymentMethodId`) REFERENCES `paymentmethods` (`PaymentMethodId`) ON UPDATE CASCADE,
  CONSTRAINT `FK_carts_ShipmentMethodId` FOREIGN KEY (`ShipmentMethodId`) REFERENCES `shipmentmethods` (`ShipmentMethodId`) ON UPDATE CASCADE,
  CONSTRAINT `FK_carts_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`UserId`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `OrderId` int(11) NOT NULL AUTO_INCREMENT,
  `UserId` int(11) NOT NULL,
  `ShipmentMethodId` int(11) NOT NULL,
  `PaymentMethodId` int(11) NOT NULL,
  `ShippingCost` decimal(16,2) NOT NULL,
  `TrackingNr` varchar(255),
  `Subtotal` decimal(16,2) NOT NULL,
  `Total` decimal(16,2) NOT NULL,
  `CreatedOn` date NOT NULL,
  `ZipCode` varchar(6) NOT NULL,
  `HouseNo` int(11) NOT NULL,
  `HouseNo_ext` varchar(11) NOT NULL,
  PRIMARY KEY (`OrderId`),
  CONSTRAINT `FK_orders_PaymentMethodId` FOREIGN KEY (`PaymentMethodId`) REFERENCES `paymentmethods` (`PaymentMethodId`) ON UPDATE CASCADE,
  CONSTRAINT `FK_orders_ShipmentMethodId` FOREIGN KEY (`ShipmentMethodId`) REFERENCES `shipmentmethods` (`ShipmentMethodId`) ON UPDATE CASCADE,
  CONSTRAINT `FK_orders_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`UserId`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- --------------------------------------------------------

--
-- Table structure for table `address_order`
--

CREATE TABLE `address_order` (
  `OrderId` int(11) NOT NULL,
  `ZipCode` varchar(6)  NOT NULL,
  `HouseNo` int(11) NOT NULL,
  `AddressType` tinyint(1) NOT NULL,
  `HouseNo_ext` varchar(255)  NOT NULL,
  PRIMARY KEY (`OrderId`,`AddressType`),
  CONSTRAINT `FK_address_order_OrderId` FOREIGN KEY (`OrderId`) REFERENCES `orders` (`OrderId`)
);

-- --------------------------------------------------------

--
-- Table structure for table `adresses`
--

CREATE TABLE `adresses` (
  `UserId` int(11) NOT NULL,
  `IsDefaultAddress` tinyint(1) NOT NULL,
  `Address` varchar(50) NOT NULL,
  `Address_2` varchar(50) NOT NULL,
  `HouseNo` int(11) NOT NULL,
  `HouseNo_ext` varchar(255) NOT NULL,
  `ZipCode` varchar(6) NOT NULL,
  `Country` varchar(2) NOT NULL,
  PRIMARY KEY (`Country`,`ZipCode`,`HouseNo`,`HouseNo_ext`),
  CONSTRAINT `FK_addresses_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`UserId`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `CategoryId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255)  NOT NULL,
  `ParentCategoryId` int(11) DEFAULT NULL,
  PRIMARY KEY (`CategoryId`),
  CONSTRAINT `FK_categories_ParentCategoryId` FOREIGN KEY (`ParentCategoryId`) REFERENCES `categories` (`CategoryId`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- --------------------------------------------------------

--
-- Table structure for table `employeeroles`
--

CREATE TABLE `employeeroles` (
  `RoleId` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  PRIMARY KEY (`RoleId`)
);

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `EmployeeNr` int(11) NOT NULL AUTO_INCREMENT,
  `UserName` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Phone` varchar(15) NOT NULL,
  `CreatedOn` date NOT NULL,
  `IsActive` tinyint(1) NOT NULL,
  PRIMARY KEY (`EmployeeNr`)
);

-- --------------------------------------------------------

--
-- Table structure for table `employee_role`
--

CREATE TABLE `employee_role` (
  `EmployeeNr` int(11) NOT NULL,
  `RoleId` int(11) NOT NULL,
  PRIMARY KEY (`EmployeeNr`,`RoleId`),
  CONSTRAINT `FK_employee_role_EmployeeNr` FOREIGN KEY (`EmployeeNr`) REFERENCES `employees` (`EmployeeNr`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_employee_role_RoleId` FOREIGN KEY (`RoleId`) REFERENCES `employeeroles` (`RoleId`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `ProductCode` varchar(10) NOT NULL,
  `Title` varchar(255) NOT NULL,
  `EAN` varchar(255) NOT NULL,
  `CategoryId` int(11) NOT NULL,
  `Stock` int(11) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `CreatedOn` date NOT NULL,
  `CreatedBy` int(11) NOT NULL,
  `UpdatedOn` date NOT NULL,
  `UpdatedBy` int(11) NOT NULL,
  PRIMARY KEY (`ProductCode`),
  CONSTRAINT `FK_products_CategoryId` FOREIGN KEY (`CategoryId`) REFERENCES `categories` (`CategoryId`) ON UPDATE CASCADE,
  CONSTRAINT `FK_products_UpdatedBy` FOREIGN KEY (`UpdatedBy`) REFERENCES `employees` (`EmployeeNr`) ON DELETE NO ACTION ON UPDATE CASCADE
);

-- --------------------------------------------------------

--
-- Table structure for table `order_products`
--

CREATE TABLE `order_products` (
  `OrderNr` int(11) NOT NULL,
  `ProductCode` varchar(10)  NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Price` decimal(16,2) NOT NULL,
  PRIMARY KEY (`OrderNr`,`ProductCode`),
  CONSTRAINT `FK_order_products_OrderNr` FOREIGN KEY (`OrderNr`) REFERENCES `orders` (`OrderNr`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_order_products_ProductCode` FOREIGN KEY (`ProductCode`) REFERENCES `products` (`ProductCode`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- --------------------------------------------------------

--
-- Table structure for table `cart_products`
--

CREATE TABLE `cart_products` (
  `UserNr` int(11) NOT NULL,
  `ProductCode` varchar(10)  NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Price` decimal(16,2) NOT NULL,
  PRIMARY KEY (`UserNr`,`ProductCode`),
  CONSTRAINT `FK_cart_products_UserNr` FOREIGN KEY (`UserNr`) REFERENCES `users` (`UserNr`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_cart_products_ProductCode` FOREIGN KEY (`ProductCode`) REFERENCES `products` (`ProductCode`) ON DELETE CASCADE ON UPDATE CASCADE
);


-- --------------------------------------------------------

--
-- Table structure for table `wizardquestions`
--

CREATE TABLE `wizardquestions` (
  `QuestionId` int(11) NOT NULL AUTO_INCREMENT,
  `Question` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  PRIMARY KEY (`QuestionId`)
);

-- --------------------------------------------------------

--
-- Table structure for table `wizardansweroptions`
--

CREATE TABLE `wizardansweroptions` (
  `WizardAnswerOptionId` int(11) NOT NULL AUTO_INCREMENT,
  `WizardQuestionId` int(11) NOT NULL,
  `WizardAnswerOption` varchar(255) NOT NULL,
  `IsFreeTextOption` tinyint(1) NOT NULL,
  PRIMARY KEY (`WizardAnswerOptionId`),
  CONSTRAINT `FK_wizardansweroptions_WizardQuestionId` FOREIGN KEY (`WizardQuestionId`) REFERENCES `wizardquestions` (`QuestionId`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- --------------------------------------------------------

--
-- Table structure for table `userwizardhistorys`
--

CREATE TABLE `userwizardhistorys` (
  `WizardQuestionId` int(11) NOT NULL,
  `WizardAnswerOptionId` int(11) NOT NULL,
  `UserId` int(11) NOT NULL,
  PRIMARY KEY (`UserId`,`WizardQuestionId`),
  CONSTRAINT `FK_userwizardhistorys_UserId` FOREIGN KEY (`UserId`) REFERENCES `users` (`UserNr`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_userwizardhistorys_WizardAnswerOptionId` FOREIGN KEY (`WizardAnswerOptionId`) REFERENCES `wizardansweroptions` (`WizardAnswerOptionId`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_userwizardhistorys_WizardQuestionId` FOREIGN KEY (`WizardQuestionId`) REFERENCES `wizardquestions` (`QuestionId`) ON DELETE CASCADE ON UPDATE CASCADE
);

-- --------------------------------------------------------

--
-- Create views for smarthomebuddie
--

CREATE VIEW OrderOverview AS
SELECT orders.UserNr, order_products.OrderNr, order_products.ProductCode, products.Title, products.EAN, categories.Name AS CategoryName, order_products.Quantity, order_products.Price AS PricePCS, order_products.Quantity * order_products.Price AS TotalPrice
FROM order_products
INNER JOIN products ON products.ProductCode = order_products.ProductCode
INNER JOIN categories ON products.CategoryId = categories.CategoryId
INNER JOIN orders ON order_products.OrderNr = orders.OrderNr;

CREATE VIEW QuestionOverview AS
SELECT userwizardhistorys.UserId, wizardquestions.Question, wizardansweroptions.WizardAnswerOption
FROM userwizardhistorys
INNER JOIN wizardquestions ON userwizardhistorys.WizardQuestionId = wizardquestions.QuestionId
INNER JOIN wizardansweroptions ON userwizardhistorys.WizardAnswerOptionId = wizardansweroptions.WizardAnswerOptionId
ORDER BY userwizardhistorys.UserId, userwizardhistorys.WizardQuestionId DESC;

-- --------------------------------------------------------

--
-- Create users and grant permissions
--

CREATE USER 'customer'@'%' IDENTIFIED BY 'customerpassword';
GRANT SELECT ON smarthomebuddie.OrderOverview TO 'customer'@'%';
GRANT SELECT ON smarthomebuddie.QuestionOverview TO 'customer'@'%';

CREATE USER 'application_manager'@'%' IDENTIFIED BY 'adminpassword';
GRANT ALL ON smarthomebuddie.* TO 'application_manager'@'%' WITH GRANT OPTION;

CREATE USER 'application_user'@'%' IDENTIFIED BY 'appuserpassword';
GRANT SELECT ON smarthomebuddie.* TO 'application_manager'@'%';

CREATE USER 'user_manager'@'%' IDENTIFIED BY 'usermngrpassword';
GRANT SELECT, INSERT, UPDATE ON smarthomebuddie.users TO 'user_manager'@'%';
GRANT SELECT, INSERT, UPDATE ON smarthomebuddie.adresses TO 'user_manager'@'%';

CREATE USER 'customer_service'@'%' IDENTIFIED BY 'servicepassword';
GRANT SELECT ON smarthomebuddie.OrderOverview TO 'customer_service'@'%';
GRANT SELECT, INSERT, UPDATE ON smarthomebuddie.users TO 'customer_service'@'%';
GRANT SELECT, INSERT, UPDATE ON smarthomebuddie.adresses TO 'customer_service'@'%';
GRANT SELECT, INSERT, UPDATE ON smarthomebuddie.address_order TO 'customer_service'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON smarthomebuddie.orders TO 'customer_service'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON smarthomebuddie.order_products TO 'customer_service'@'%';

CREATE USER 'products_manager'@'%' IDENTIFIED BY 'productspassword';
GRANT SELECT ON smarthomebuddie.OrderOverview TO 'products_manager'@'%';
GRANT SELECT ON smarthomebuddie.QuestionOverview TO 'products_manager'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON smarthomebuddie.products TO 'products_manager'@'%';
GRANT SELECT, INSERT, UPDATE, DELETE ON smarthomebuddie.categories TO 'products_manager'@'%';

FLUSH PRIVILEGES;

COMMIT;

-- --------------------------------------------------------

--
-- Create triggers for smarthomebuddie
--

DELIMITER $$ 
CREATE OR REPLACE TRIGGER OnInsertCartProduct_UpdateCartTotal
AFTER
INSERT ON cart_products FOR EACH ROW BEGIN

DECLARE totalPrice decimal(16, 2);
DECLARE totalItems int(11);

SELECT 
    SUM(price),
    SUM(Quantity) 
INTO 
    totalPrice,
    totalItems
FROM cart_products
WHERE UserNr = NEW.UserNr;
UPDATE carts
SET TotalPrice = totalPrice,
    TotalItems = totalItems;
END $$ 
DELIMITER ;
----------------------------------------------------------------------
DELIMITER $$ 
CREATE OR REPLACE TRIGGER OnUpdateCartProduct_UpdateCartTotal
AFTER
UPDATE ON cart_products FOR EACH ROW BEGIN

DECLARE totalPrice decimal(16, 2);
DECLARE totalItems int(11);

SELECT 
    SUM(price * Quantity),
    SUM(Quantity) 
INTO 
    totalPrice,
    totalItems
FROM cart_products
WHERE UserNr = NEW.UserNr;
UPDATE carts
SET TotalPrice = totalPrice,
    TotalItems = totalItems;
END $$ 
DELIMITER ;
----------------------------------------------------------------------
DELIMITER $$ 
CREATE OR REPLACE TRIGGER OnDeleteCartProduct_UpdateCartTotal
AFTER DELETE ON cart_products FOR EACH ROW BEGIN

DECLARE totalPrice decimal(16, 2);
DECLARE totalItems int(11);

SELECT 
    SUM(price * Quantity),
    SUM(Quantity) 
INTO 
    totalPrice,
    totalItems
FROM cart_products
WHERE UserNr = OLD.UserNr;

IF totalItems = 0 THEN
DELETE FROM carts
WHERE UserNr = OLD.UserNr;

ELSE
UPDATE carts
SET TotalPrice = totalPrice,
    TotalItems = totalItems
WHERE UserNr = OLD.UserNr;
END IF;
END$$ 
DELIMITER ;
----------------------------------------------------------------------
DELIMITER $$
CREATE OR REPLACE TRIGGER OnInsertOrderProduct_CheckStock
BEFORE
INSERT ON order_products FOR EACH ROW BEGIN

DECLARE msg varchar(255);

IF (
    SELECT Stock
    FROM products
    WHERE ProductCode = NEW.ProductCode
) < NEW.Quantity THEN

SELECT CONCAT(
        'Error: There is not enough stock for product with code: ',
        NEW.ProductCode
    ) INTO msg;
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = msg;
END IF;
END$$ 
DELIMITER ;
----------------------------------------------------------------------
DELIMITER $$
CREATE OR REPLACE TRIGGER OnInsertOrderProduct_UpdateStock
AFTER
INSERT ON order_products FOR EACH ROW 

BEGIN
UPDATE products 
SET Stock = STOCK - NEW.Quantity 
WHERE ProductCode = NEW.ProductCode;
END$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Create stored functions for smarthomebuddie
--

DELIMITER $$
CREATE OR REPLACE FUNCTION CreateOrderFromCart(par_UserNr INT) RETURNS INT 

BEGIN
    DECLARE created_order_id int;
    DECLARE msg varchar(255);

    IF (SELECT COUNT(*) FROM carts WHERE UserNr = par_UserNr) = 0 THEN
    SET msg = 'Cart not found';
    SIGNAL SQLSTATE '45000'
    SET MESSAGE_TEXT =  msg;
    ELSE

    INSERT INTO orders (
        UserNr, 
        ShipmentMethodId, 
        PaymentMethodId, 
        ShippingCost, 
        SubTotal, 
        Total, 
        CreatedOn)
    SELECT 
        UserNr, 
        shipmentmethods.ShipmentMethodId, 
        PaymentMethodId, 
        ShippingCost,  
        TotalPrice, 
        TotalPrice + ShippingCost, 
        NOW()
    FROM carts
    INNER JOIN shipmentmethods 
        ON carts.ShipmentMethodId = shipmentmethods.ShipmentMethodId
    WHERE UserNr = par_UserNr;

    SELECT LAST_INSERT_ID() 
    FROM orders 
    INTO created_order_id;

    INSERT INTO order_products
    SELECT 
        created_order_id, 
        cart_products.ProductCode, 
        cart_products.Quantity, 
        cart_products.Price
    FROM cart_products 
    WHERE UserNr = par_UserNr;

    DELETE 
    FROM carts 
    WHERE UserNr = par_UserNr;

    RETURN created_order_id;

    END IF;

END$$
DELIMITER ;
