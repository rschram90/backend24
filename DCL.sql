-- --------------------------------------------------------

--
-- Use smarthomebuddie as database
--

USE `smarthomebuddie`;

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
SELECT userwizardhistory.UserId, wizardquestions.Question, wizardansweroptions.WizardAnswerOption
FROM userwizardhistory
INNER JOIN wizardquestions ON userwizardhistory.WizardQuestionId = wizardquestions.QuestionId
INNER JOIN wizardansweroptions ON userwizardhistory.WizardAnswerOptionId = wizardansweroptions.WizardAnswerOptionId
ORDER BY userwizardhistory.UserId, userwizardhistory.WizardQuestionId DESC;

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
GRANT SELECT ON smarthomebuddie.* TO 'application_user'@'%';

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
