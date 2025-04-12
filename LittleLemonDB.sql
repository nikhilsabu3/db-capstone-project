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
  `AnnualSalary` DECIMAL NOT NULL,
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
-- Table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Orders` (
  `OrderID` VARCHAR(45) NOT NULL,
  `OrderDate` DATE NOT NULL,
  `BookingID` INT NOT NULL,
  `BillAmount` DECIMAL NOT NULL,
  `SaleQuantity` INT NOT NULL,
  `TotalCost` DECIMAL NULL,
  `Discount` DECIMAL NULL DEFAULT 0,
  PRIMARY KEY (`OrderID`),
  INDEX `BookingID_idx` (`BookingID` ASC) VISIBLE,
  CONSTRAINT `BookingID`
    FOREIGN KEY (`BookingID`)
    REFERENCES `LittleLemonDB`.`Bookings` (`BookingID`)
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
  `DeliveryCost` DECIMAL NULL DEFAULT 0,
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


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`Menus` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `Cuisine` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`MenuItems` (
  `ItemID` INT NOT NULL AUTO_INCREMENT,
  `ItemName` VARCHAR(45) NOT NULL,
  `Course` VARCHAR(45) NOT NULL,
  `ItemPrice` DECIMAL NOT NULL,
  `MenuID` INT NOT NULL,
  PRIMARY KEY (`ItemID`),
  INDEX `MenuID_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `LittleLemonDB`.`Menus` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LittleLemonDB`.`OrderDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LittleLemonDB`.`OrderDetails` (
  `OrderDetailsID` INT NOT NULL AUTO_INCREMENT,
  `OrderID` VARCHAR(45) NOT NULL,
  `OrderLineNo` INT NOT NULL,
  `ItemID` INT NOT NULL,
  PRIMARY KEY (`OrderDetailsID`),
  INDEX `OrderID_idx` (`OrderID` ASC) VISIBLE,
  INDEX `ItemID_idx` (`ItemID` ASC) VISIBLE,
  CONSTRAINT `OrderID2`
    FOREIGN KEY (`OrderID`)
    REFERENCES `LittleLemonDB`.`Orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ItemID`
    FOREIGN KEY (`ItemID`)
    REFERENCES `LittleLemonDB`.`MenuItems` (`ItemID`)
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
-- Data for table `LittleLemonDB`.`Orders`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `BookingID`, `BillAmount`, `SaleQuantity`, `TotalCost`, `Discount`) VALUES ('1', '25/08/2020', 2, 353, 1, 200, 20);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `BookingID`, `BillAmount`, `SaleQuantity`, `TotalCost`, `Discount`) VALUES ('2', '17/08/2021', 3, 113, 3, 51, 0);
INSERT INTO `LittleLemonDB`.`Orders` (`OrderID`, `OrderDate`, `BookingID`, `BillAmount`, `SaleQuantity`, `TotalCost`, `Discount`) VALUES ('3', '15/06/2020', 1, 188, 2, 43, 9);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Delivery`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Delivery` (`DeliveryID`, `DeliveryDate`, `DeliveryMode`, `DeliveryStatus`, `DeliveryCost`, `OrderID`, `AddressID`) VALUES (1, '26/03/2020', 'Truck', 'Deliver Completed', 61, '1', 2);
INSERT INTO `LittleLemonDB`.`Delivery` (`DeliveryID`, `DeliveryDate`, `DeliveryMode`, `DeliveryStatus`, `DeliveryCost`, `OrderID`, `AddressID`) VALUES (2, '17/07/2020', 'Hotel', 'In Progress', 97, '2', 1);
INSERT INTO `LittleLemonDB`.`Delivery` (`DeliveryID`, `DeliveryDate`, `DeliveryMode`, `DeliveryStatus`, `DeliveryCost`, `OrderID`, `AddressID`) VALUES (3, '24/04/2020', 'Hotel', 'Preparing to Deliver', 36, '3', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`Menus`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`Menus` (`MenuID`, `Cuisine`) VALUES (1, 'Greek');
INSERT INTO `LittleLemonDB`.`Menus` (`MenuID`, `Cuisine`) VALUES (2, 'Italian');
INSERT INTO `LittleLemonDB`.`Menus` (`MenuID`, `Cuisine`) VALUES (3, 'Turkish');

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`MenuItems`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (1, 'Olives', 'Starters', 5, 1);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (2, 'Flatbread', 'Starters', 5, 1);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (3, 'Minestrone', 'Starters', 8, 2);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (4, 'Tomato bread', 'Starters', 8, 2);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (5, 'Falafel', 'Starters', 7, 3);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (6, 'Hummus', 'Starters', 5, 3);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (7, 'Greek salad', 'Main Courses', 15, 1);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (8, 'Bean soup', 'Main Courses', 12, 2);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (9, 'Pizza', 'Main Courses', 15, 3);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (10, 'Greek yoghurt', 'Desserts', 7, 1);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (11, 'Ice cream', 'Desserts', 6, 2);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (12, 'Cheesecake', 'Desserts', 5, 3);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (13, 'Athens White wine', 'Drinks', 25, 1);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (14, 'Corfu Red Wine', 'Drinks', 30, 2);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (15, 'Turkish Coffee', 'Drinks', 10, 3);
INSERT INTO `LittleLemonDB`.`MenuItems` (`ItemID`, `ItemName`, `Course`, `ItemPrice`, `MenuID`) VALUES (16, 'Kabasa', 'Main Courses', 17, 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `LittleLemonDB`.`OrderDetails`
-- -----------------------------------------------------
START TRANSACTION;
USE `LittleLemonDB`;
INSERT INTO `LittleLemonDB`.`OrderDetails` (`OrderDetailsID`, `OrderID`, `OrderLineNo`, `ItemID`) VALUES (1, '1', 1, 4);
INSERT INTO `LittleLemonDB`.`OrderDetails` (`OrderDetailsID`, `OrderID`, `OrderLineNo`, `ItemID`) VALUES (2, '1', 2, 8);
INSERT INTO `LittleLemonDB`.`OrderDetails` (`OrderDetailsID`, `OrderID`, `OrderLineNo`, `ItemID`) VALUES (3, '1', 3, 11);
INSERT INTO `LittleLemonDB`.`OrderDetails` (`OrderDetailsID`, `OrderID`, `OrderLineNo`, `ItemID`) VALUES (4, '2', 1, 2);
INSERT INTO `LittleLemonDB`.`OrderDetails` (`OrderDetailsID`, `OrderID`, `OrderLineNo`, `ItemID`) VALUES (5, '2', 2, 7);
INSERT INTO `LittleLemonDB`.`OrderDetails` (`OrderDetailsID`, `OrderID`, `OrderLineNo`, `ItemID`) VALUES (6, '3', 1, 5);
INSERT INTO `LittleLemonDB`.`OrderDetails` (`OrderDetailsID`, `OrderID`, `OrderLineNo`, `ItemID`) VALUES (7, '3', 2, 9);
INSERT INTO `LittleLemonDB`.`OrderDetails` (`OrderDetailsID`, `OrderID`, `OrderLineNo`, `ItemID`) VALUES (8, '3', 3, 12);
INSERT INTO `LittleLemonDB`.`OrderDetails` (`OrderDetailsID`, `OrderID`, `OrderLineNo`, `ItemID`) VALUES (9, '3', 4, 16);

COMMIT;

