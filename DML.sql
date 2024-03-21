-- --------------------------------------------------------

--
-- DML Smarthomebuddie
--

-- --------------------------------------------------------

INSERT INTO `users` (`UserNr`, `Email`, `Password`, `FirstName`, `LastName`, `LangCode`, `Phone`, `CreatedOn`, `UpdatedOn`) VALUES
(1, 'rachidschram@gmail.com', 'test12', 'Rachid', 'Schram', 'NL', '0612345678', '2023-03-14', '2023-03-14'),
(2, 'wessel@vloet.nl', 'test12', 'Wessel', 'Vloet', 'NL', '0612345679', '2023-03-16', '2023-03-16'),
(3, 'pietvanaalst@gmail.com', 'piet12', 'Piet', 'van Aalst', 'NL', '0612345690', '2023-03-16', '2023-03-16'),
(4, 'fredfranken@gmail.com', 'kaasfred12', 'Fred', 'Franken', 'NL', '0612345691', '2023-03-17', '2023-03-17'),
(5, 'pietdoorn@gmail.com', 'doorntje12', 'Piet', 'van Doorn', 'NL', '0612345692', '2023-03-18', '2023-03-18');

INSERT INTO `adresses` (`UserNr`, `IsDefaultAddress`, `Address`, `Address_2`, `HouseNo`, `HouseNo_ext`, `ZipCode`, `Country`) VALUES
(1, 1, 'IJsselstraat ', '', 66, '', '5463NL', 'NL'),
(2, 1, 'Gondyastraat ', '', 5, '', '7812BE', 'NL'),
(3, 1, 'Begoniatsraat ', '', 18, '', '6532NE', 'NL'),
(4, 1, 'Klaverstraat ', '', 22, '', '6123HA', 'NL'),
(5, 1, 'Kloosterstraat ', '', 26, '', '4324HS', 'NL');

INSERT INTO `employeeroles` (`RoleId`, `Name`, `Description`) VALUES
(1, 'Eigenaar', 'Eigenaar van SmarthomeBuddie'),
(2, 'Klantenservice', 'Klantenservice medewerker van SmarthomeBuddie');


INSERT INTO `employees` (`EmployeeNr`, `UserName`, `Password`, `Email`, `Phone`, `CreatedOn`, `IsActive`) VALUES
(1, 'Rachid', 'test12', 'rachidschram@gmail.com', '0612345678', '2023-03-14', 1),
(2, 'Wessel', 'test12', 'wessel@vloet.nl', '0612345678', '2023-03-16', 1);

INSERT INTO `employee_role` (`EmployeeNr`, `RoleId`) VALUES
(1, 1),
(2, 2);

INSERT INTO `paymentmethods` (`PaymentMethodId`, `Name`, `Description`) VALUES
(1, 'iDeal', 'iDeal betalingsmogelijkheid in Nederland'),
(2, 'Klarna', 'Betaal 30 dagen later'),
(3, 'Apple Pay', 'Betaal gemakkelijk via Apple Pay');
(4, 'Google Pay', 'Betaal gemakkelijk met Google Pay');
(5, 'MasterCard', 'Betaal met EuroCard Mastercard');

INSERT INTO `shipmentmethods` (`ShipmentMethodId`, `Name`, `Description`, `ShippingCost`) VALUES
(1, 'PostNL', 'PostNL bezorgservice in Nederland', '4.75'),
(2, 'DHL', 'DHL bezorgservice in Nederland', '7.25'),
(3, 'BudBee', 'BudBee bezorgservice in Nederland', '1.50');

INSERT INTO `categories` (`CategoryId`, `Name`, `ParentCategoryId`) VALUES
(1, 'Smart lampen', 1),
(2, 'Slimme spots', 1),
(3, 'Slimme verlichtingsaccessoires', 1);

INSERT INTO `products` (`ProductCode`, `Title`, `EAN`, `CategoryId`, `Stock`, `Description`, `CreatedOn`, `CreatedBy`, `UpdatedOn`, `UpdatedBy`) VALUES
('117474503', 'Philips Hue Filament Lichtbron E27 Globe', '8718699688882', 1, 3, 'Deze lamp valt in de kleurreeks White. White-lampen geven dimbaar, warmwit licht.', '2023-03-14', 1, '2023-03-14', 1),
('117474504', 'HappyLEDS® Hexagon LED Lights App', '8720299578623', 2, 5, 'Een ruimte vol sfeer en gezelligheid? Met de HappyLEDS® Hexagon LED panelen voel jij je helemaal thuis!', '2023-03-15', 2, '2023-03-15', 2),
('117474508', 'Philips Hue bewegingssensor', '8719514342125', 3, 4, 'Gebruik de Philips Hue bewegingssensor om je slimme Hue lampen te activeren zodra er iets beweegt in de kamer.', '2023-03-17', 1, '2023-03-17', 1);

INSERT INTO `carts` (`UserNr`, `ShipmentMethodId`, `PaymentMethodId`, `TotalPrice`, `TotalItems`) VALUES
(1, 1, 1, '40.00', 2),
(3, 3, 2, '45.00', 2);

INSERT INTO `cart_products` (`UserNr`, `ProductCode`, `Quantity`, `Price`) VALUES
(1, '117474503', 2, '40.00'),
(3, '117474504', 1, '45.00');

INSERT INTO `orders` (`OrderNr`, `UserNr`, `ShipmentMethodId`, `PaymentMethodId`, `ShippingCost`, `TrackingNr`, `Subtotal`, `Total`, `CreatedOn`, `ZipCode`, `HouseNo`, `HouseNo_ext`) VALUES
(1, 1, 1, 1, '2.00', 'SM27382', '20.00', '22.00', '2023-03-14', '5463NL', 66, ''),
(2, 3, 3, 2, '1.50', 'SM27383', '43.00', '45.00', '2023-03-16', '6532NE', 18, '');

INSERT INTO `order_products` (`OrderNr`, `ProductCode`, `Quantity`, `Price`) VALUES
(1, '117474503', 2, '40.00'),
(2, '117474504', 1, '45.00');

INSERT INTO `address_order` (`OrderNr`, `ZipCode`, `HouseNo`, `AddressType`, `HouseNo_ext`) VALUES 
('1', '5463NL', '66', '1', ''),
('2', '6532NE', '18', '1', '');

INSERT INTO `wizardquestions` (`QuestionId`, `Question`, `Description`) VALUES
(1, 'Ben je tevreden over de kwaliteit van de website?', 'We proberen het gebruiksgemak te verbeteren');

INSERT INTO `wizardansweroptions` (`WizardAnswerOptionId`, `WizardQuestionId`, `WizardAnswerOption`, `IsFreeTextOption`) VALUES
(1, 1, 'Ja', 0),
(2, 1, 'Nee', 1);

INSERT INTO `userwizardhistory` (`WizardQuestionId`, `WizardAnswerOptionId`, `UserId`) VALUES
(1, 1, 1);
