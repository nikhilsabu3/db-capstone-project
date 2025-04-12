-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema LittleLemonDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `LittleLemonDB` DEFAULT CHARACTER SET utf8 ;
USE `LittleLemonDB` ;

-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Customers` (
  `CustomerID` VARCHAR(45) NOT NULL,
  `CustomerName` VARCHAR(255) NOT NULL,
  `ContactNumber` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(255) NULL,
  PRIMARY KEY (`CustomerID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Country` (
  `CountryCode` VARCHAR(45) NOT NULL,
  `Country` VARCHAR(45) NULL,
  PRIMARY KEY (`CountryCode`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Address` (
  `AddressID` INT NOT NULL AUTO_INCREMENT,
  `Street` VARCHAR(255) NULL,
  `PostCode` VARCHAR(45) NULL,
  `City` VARCHAR(45) NULL,
  `State` VARCHAR(45) NULL,
  `CountryCode` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`AddressID`),
  INDEX `CountryCode_idx` (`CountryCode` ASC) VISIBLE,
  CONSTRAINT `CountryCode`
    FOREIGN KEY (`CountryCode`)
    REFERENCES `LittleLemonDB`.`Country` (`CountryCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Employees` (
  `EmployeeID` INT NOT NULL AUTO_INCREMENT,
  `EmployeeName` VARCHAR(255) NOT NULL,
  `Role` VARCHAR(45) NOT NULL,
  `ContactNumber` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `AnnualSalary` DECIMAL(10,2) NOT NULL,
  `AddressID` INT NOT NULL,
  PRIMARY KEY (`EmployeeID`),
  INDEX `AddressID_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `AddressID2`
    FOREIGN KEY (`AddressID`)
    REFERENCES `LittleLemonDB`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `TableNo` INT NOT NULL,
  `BookingSlot` TIME NOT NULL,
  `CustomerID` VARCHAR(45) NOT NULL,
  `EmployeeID` INT NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  INDEX `EmployeeID_idx` (`EmployeeID` ASC) VISIBLE,
  CONSTRAINT `CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `LittleLemonDB`.`Customers` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `EmployeeID`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `LittleLemonDB`.`Employees` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `MenuItemID` INT NOT NULL AUTO_INCREMENT,
  `CourseName` VARCHAR(45) NOT NULL,
  `StarterName` VARCHAR(45) NOT NULL,
  `DessertName` VARCHAR(45) NULL,
  `DrinkName` VARCHAR(45) NOT NULL,
  `SidesName` VARCHAR(45) NOT NULL,
  `MenuItemPrice` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `MenuItemsID` INT NOT NULL,
  `MenuName` VARCHAR(45) NOT NULL,
  `Cuisine` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `MenuItemsID_idx` (`MenuItemsID` ASC) VISIBLE,
  CONSTRAINT `MenuItemsID`
    FOREIGN KEY (`MenuItemsID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`MenuItemID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` VARCHAR(45) NOT NULL,
  `OrderDate` DATE NOT NULL,
  `BookingID` INT NOT NULL,
  `BillAmount` DECIMAL(10,2) NOT NULL,
  `SaleQuantity` INT NOT NULL,
  `TotalCost` DECIMAL(10,2) NULL,
  `Discount` DECIMAL(10,2) NULL DEFAULT 0,
  `MenuID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `BookingID_idx` (`BookingID` ASC) VISIBLE,
  INDEX `MenuID_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `BookingID`
    FOREIGN KEY (`BookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menus` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Delivery` (
  `DeliveryID` INT NOT NULL AUTO_INCREMENT,
  `DeliveryDate` DATE NOT NULL,
  `DeliveryMode` VARCHAR(45) NULL,
  `DeliveryStatus` VARCHAR(45) NULL,
  `DeliveryCost` DECIMAL(10,2) NULL DEFAULT 0,
  `OrderID` VARCHAR(45) NOT NULL,
  `AddressID` INT NOT NULL,
  PRIMARY KEY (`DeliveryID`),
  INDEX `OrderID_idx` (`OrderID` ASC) VISIBLE,
  INDEX `AddressID_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `OrderID`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `AddressID`
    FOREIGN KEY (`AddressID`)
    REFERENCES `LittleLemonDB`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Customers`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `CustomerName`, `ContactNumber`, `Email`) VALUES ('65-353-0657', 'Giacopo Bramich', '998979676', 'giacopo.bramich@hotmail.com');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `CustomerName`, `ContactNumber`, `Email`) VALUES ('72-055-7985', 'Laney Fadden', '989554432', 'laney.fadden@gmail.com');
INSERT INTO `LittleLemonDB`.`Customers` (`CustomerID`, `CustomerName`, `ContactNumber`, `Email`) VALUES ('90-876-6799', 'Lia Bonar', '789876554', 'lia.bonar@yahoo.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Country`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Country` (`CountryCode`, `Country`) VALUES ('CN', 'China');
INSERT INTO `LittleLemonDB`.`Country` (`CountryCode`, `Country`) VALUES ('KP', 'North Korea');
INSERT INTO `LittleLemonDB`.`Country` (`CountryCode`, `Country`) VALUES ('PE', 'Peru');
INSERT INTO `LittleLemonDB`.`Country` (`CountryCode`, `Country`) VALUES ('US', 'United States of America');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Address` (`AddressID`, `Street`, `PostCode`, `City`, `State`, `CountryCode`) VALUES (1, '', '993-0031', 'Daruoyan', '', 'CN');
INSERT INTO `LittleLemonDB`.`Address` (`AddressID`, `Street`, `PostCode`, `City`, `State`, `CountryCode`) VALUES (2, '', '216282', 'Ongjin', '', 'KP');
INSERT INTO `LittleLemonDB`.`Address` (`AddressID`, `Street`, `PostCode`, `City`, `State`, `CountryCode`) VALUES (3, '', '663246', 'Quince Mil', '', 'PE');
INSERT INTO `LittleLemonDB`.`Address` (`AddressID`, `Street`, `PostCode`, `City`, `State`, `CountryCode`) VALUES (4, '', '724', 'Old Town', 'Chicago', 'US');
INSERT INTO `LittleLemonDB`.`Address` (`AddressID`, `Street`, `PostCode`, `City`, `State`, `CountryCode`) VALUES (5, '', '334', 'Lincoln Park', 'Chicago', 'US');
INSERT INTO `LittleLemonDB`.`Address` (`AddressID`, `Street`, `PostCode`, `City`, `State`, `CountryCode`) VALUES (6, '', '879', 'West Loop', 'Chicago', 'US');
INSERT INTO `LittleLemonDB`.`Address` (`AddressID`, `Street`, `PostCode`, `City`, `State`, `CountryCode`) VALUES (7, '', '132', 'Bay lane', 'Chicago', 'US');
INSERT INTO `LittleLemonDB`.`Address` (`AddressID`, `Street`, `PostCode`, `City`, `State`, `CountryCode`) VALUES (8, '', '989', 'EdgeWater', 'Chicago', 'US');
INSERT INTO `LittleLemonDB`.`Address` (`AddressID`, `Street`, `PostCode`, `City`, `State`, `CountryCode`) VALUES (9, '', '245', 'Lincoln Park', 'Chicago', 'US');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Employees`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `EmployeeName`, `Role`, `ContactNumber`, `Email`, `AnnualSalary`, `AddressID`) VALUES (1, 'Mario Gollini', 'Manager', '351258074', 'Mario.g@littlelemon.com', 70000, 4);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `EmployeeName`, `Role`, `ContactNumber`, `Email`, `AnnualSalary`, `AddressID`) VALUES (2, 'Adrian Gollini', 'Assistant Manager', '351474048', 'Adrian.g@littlelemon.com', 65000, 5);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `EmployeeName`, `Role`, `ContactNumber`, `Email`, `AnnualSalary`, `AddressID`) VALUES (3, 'Giorgos Dioudis', 'Head Chef', '351970582', 'Giorgos.d@littlelemon.com', 50000, 6);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `EmployeeName`, `Role`, `ContactNumber`, `Email`, `AnnualSalary`, `AddressID`) VALUES (4, 'Fatma Kaya', 'Assistant Chef', '351963569', 'Fatma.k@littlelemon.com', 45000, 7);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `EmployeeName`, `Role`, `ContactNumber`, `Email`, `AnnualSalary`, `AddressID`) VALUES (5, 'Elena Salvai', 'Head Waiter', '351074198', 'Elena.s@littlelemon.com', 40000, 8);
INSERT INTO `LittleLemonDB`.`Employees` (`EmployeeID`, `EmployeeName`, `Role`, `ContactNumber`, `Email`, `AnnualSalary`, `AddressID`) VALUES (6, 'John Millar', 'Receptionist', '351584508', 'John.m@littlelemon.com', 35000, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Bookings`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `TableNo`, `BookingSlot`, `CustomerID`, `EmployeeID`) VALUES (1, 3, '18:30:00', '72-055-7985', 3);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `TableNo`, `BookingSlot`, `CustomerID`, `EmployeeID`) VALUES (2, 5, '21:00:00', '65-353-0657', 2);
INSERT INTO `LittleLemonDB`.`Bookings` (`BookingID`, `TableNo`, `BookingSlot`, `CustomerID`, `EmployeeID`) VALUES (3, 2, '19:30:00', '90-876-6799', 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`MenuItems` (`MenuItemID`, `CourseName`, `StarterName`, `DessertName`, `DrinkName`, `SidesName`, `MenuItemPrice`) VALUES (1, 'Greek salad', 'Olives', 'Greek yoghurt', 'Athens White wine', 'Tapas', 54);
INSERT INTO `LittleLemonDB`.`MenuItems` (`MenuItemID`, `CourseName`, `StarterName`, `DessertName`, `DrinkName`, `SidesName`, `MenuItemPrice`) VALUES (2, 'Bean soup', 'Flatbread', 'Ice cream', 'Corfu Red Wine', 'Potato salad', 69);
INSERT INTO `LittleLemonDB`.`MenuItems` (`MenuItemID`, `CourseName`, `StarterName`, `DessertName`, `DrinkName`, `SidesName`, `MenuItemPrice`) VALUES (3, 'Pizza', 'Minestrone', 'Cheesecake', 'Italian Coffee', 'Bruschetta', 34);
INSERT INTO `LittleLemonDB`.`MenuItems` (`MenuItemID`, `CourseName`, `StarterName`, `DessertName`, `DrinkName`, `SidesName`, `MenuItemPrice`) VALUES (4, 'Carbonara', 'Tomato bread', 'Affogato', 'Roma Red wine', 'Focaccia', 55);
INSERT INTO `LittleLemonDB`.`MenuItems` (`MenuItemID`, `CourseName`, `StarterName`, `DessertName`, `DrinkName`, `SidesName`, `MenuItemPrice`) VALUES (5, 'Kabasa', 'Falafel', 'Turkish yoghurt', 'Ankara White Wine', 'Meatballs', 78);
INSERT INTO `LittleLemonDB`.`MenuItems` (`MenuItemID`, `CourseName`, `StarterName`, `DessertName`, `DrinkName`, `SidesName`, `MenuItemPrice`) VALUES (6, 'Shwarma', 'Hummus', 'Baklava', 'Turkish Coffee', 'Fries', 90);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Menus` (`MenuID`, `MenuItemsID`, `MenuName`, `Cuisine`) VALUES (1, 1, 'Greek Heaven Delight', 'Greek');
INSERT INTO `LittleLemonDB`.`Menus` (`MenuID`, `MenuItemsID`, `MenuName`, `Cuisine`) VALUES (2, 4, 'Italian Relief', 'Italian');
INSERT INTO `LittleLemonDB`.`Menus` (`MenuID`, `MenuItemsID`, `MenuName`, `Cuisine`) VALUES (3, 5, 'Turkish Turn', 'Turkish');
INSERT INTO `LittleLemonDB`.`Menus` (`MenuID`, `MenuItemsID`, `MenuName`, `Cuisine`) VALUES (4, 2, 'Zeus Dinner', 'Greek');
INSERT INTO `LittleLemonDB`.`Menus` (`MenuID`, `MenuItemsID`, `MenuName`, `Cuisine`) VALUES (5, 3, 'Pizza For Life', 'Italian');
INSERT INTO `LittleLemonDB`.`Menus` (`MenuID`, `MenuItemsID`, `MenuName`, `Cuisine`) VALUES (6, 6, 'Evening Share', 'Turkish');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `BookingID`, `BillAmount`, `SaleQuantity`, `TotalCost`, `Discount`, `MenuID`) VALUES ('1', '2020-08-05', 2, 353.50, 5, 200.00, 20.00, 4);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `BookingID`, `BillAmount`, `SaleQuantity`, `TotalCost`, `Discount`, `MenuID`) VALUES ('2', '2021-08-17', 3, 211.00, 3, 150.30, 0.00, 2);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `BookingID`, `BillAmount`, `SaleQuantity`, `TotalCost`, `Discount`, `MenuID`) VALUES ('3', '2020-06-15', 1, 188.75, 1, 77.70, 9.5, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Delivery`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Delivery` (`DeliveryID`, `DeliveryDate`, `DeliveryMode`, `DeliveryStatus`, `DeliveryCost`, `OrderID`, `AddressID`) VALUES (1, '2020-03-26', 'Truck', 'Deliver Completed', 61.50, '1', 2);
INSERT INTO `LittleLemonDB`.`Delivery` (`DeliveryID`, `DeliveryDate`, `DeliveryMode`, `DeliveryStatus`, `DeliveryCost`, `OrderID`, `AddressID`) VALUES (2, '2020-07-17', 'Hotel', 'In Progress', 97.00, '2', 1);
INSERT INTO `LittleLemonDB`.`Delivery` (`DeliveryID`, `DeliveryDate`, `DeliveryMode`, `DeliveryStatus`, `DeliveryCost`, `OrderID`, `AddressID`) VALUES (3, '2020-04-24', 'Hotel', 'Preparing to Deliver', 36.30, '3', 3);

COMMIT;

