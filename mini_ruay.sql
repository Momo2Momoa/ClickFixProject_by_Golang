-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 18, 2025 at 09:57 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mini_ruay`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `CusID` int(11) NOT NULL,
  `CusName` varchar(20) NOT NULL,
  `CusAddress` varchar(50) NOT NULL,
  `CusPhone` varchar(10) NOT NULL,
  `CusEmail` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`CusID`, `CusName`, `CusAddress`, `CusPhone`, `CusEmail`) VALUES
(2, 'Stang', 'TH', '0949999999', 'stang@gmail.com'),
(3, 'beam', 'TH', '0920000000', 'beam@gmail.com'),
(4, 'No', 'TH', '0642222222', 'no@gmail.com'),
(5, 'st', 'TH', '0964141462', 'st@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `goods`
--

CREATE TABLE `goods` (
  `GoodID` int(11) NOT NULL,
  `GoodName` varchar(30) NOT NULL,
  `GoodType` int(11) NOT NULL DEFAULT 0,
  `GoodAmount` int(11) NOT NULL,
  `GoodPrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `goods`
--

INSERT INTO `goods` (`GoodID`, `GoodName`, `GoodType`, `GoodAmount`, `GoodPrice`) VALUES
(22, 'pepsi', 6, 100, 12),
(23, 'coke', 6, 100, 12),
(24, 'Soda', 6, 100, 10),
(25, 'รองเท้า nike', 1, 250, 5000),
(26, 'รองเท้า Jodan', 3, 300, 5500),
(27, 'Panda', 3, 100, 1500),
(28, 'ลูกฟุตบอล', 1, 50, 489),
(29, 'ไม้แบตมินตัน', 1, 50, 4770),
(30, 'ตะกร้อ', 1, 50, 359),
(32, 'นม', 7, 100, 15),
(33, 'น้ำเปล่า', 6, 100, 10);

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `ID` int(11) NOT NULL,
  `SalesID` int(11) DEFAULT NULL,
  `CusID` int(11) DEFAULT NULL,
  `GID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `Total` int(11) NOT NULL,
  `SumTotal` int(11) NOT NULL,
  `Datetime` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp(),
  `enter` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`ID`, `SalesID`, `CusID`, `GID`, `Quantity`, `Price`, `Total`, `SumTotal`, `Datetime`, `enter`) VALUES
(248, 1000, NULL, 28, 1, 0, 489, 7489, '2024-03-30 03:31:01', 1),
(249, 1000, NULL, 27, 1, 0, 1500, 7489, '2024-03-30 03:31:02', 1),
(250, 1000, NULL, 26, 1, 0, 5500, 7489, '2024-03-30 03:31:02', 1),
(251, 1001, NULL, 23, 1, 0, 12, 5024, '2024-03-30 03:31:07', 1),
(252, 1001, NULL, 22, 1, 0, 12, 5024, '2024-03-30 03:31:08', 1),
(253, 1001, NULL, 25, 1, 0, 5000, 5024, '2024-03-30 03:31:08', 1),
(254, 1002, NULL, 23, 1, 0, 12, 5022, '2024-03-30 03:31:24', 1),
(255, 1002, NULL, 24, 1, 0, 10, 5022, '2024-03-30 03:31:24', 1),
(256, 1002, NULL, 25, 1, 0, 5000, 5022, '2024-03-30 03:31:25', 1),
(257, 1003, NULL, 25, 1, 0, 5000, 15270, '2024-03-30 03:31:41', 1),
(258, 1003, NULL, 26, 1, 0, 5500, 15270, '2024-03-30 03:31:42', 1),
(259, 1003, NULL, 29, 1, 0, 4770, 15270, '2024-03-30 03:31:42', 1),
(260, 1004, NULL, 27, 1, 0, 1500, 7489, '2024-03-30 05:12:46', 1),
(261, 1004, NULL, 26, 1, 0, 5500, 7489, '2024-03-30 05:12:46', 1),
(262, 1004, NULL, 28, 1, 0, 489, 7489, '2024-03-30 05:12:47', 1),
(263, 1005, NULL, 26, 1, 0, 5500, 10859, '2024-03-30 05:12:52', 1),
(264, 1005, NULL, 25, 1, 0, 5000, 10859, '2024-03-30 08:10:48', 1),
(265, 1005, NULL, 30, 1, 0, 359, 10859, '2024-03-30 08:10:48', 1);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE `invoice` (
  `IID` int(11) NOT NULL,
  `SupID` int(11) NOT NULL,
  `IDate` datetime NOT NULL DEFAULT current_timestamp(),
  `ITotal` int(11) DEFAULT NULL,
  `InvoiceID` int(11) NOT NULL,
  `confirm` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`IID`, `SupID`, `IDate`, `ITotal`, `InvoiceID`, `confirm`) VALUES
(60, 11, '2024-03-25 12:15:22', 72, 1000, 0),
(61, 11, '2024-03-25 12:15:31', 72, 1000, 1),
(62, 11, '2024-03-25 12:23:03', 22024, 1001, 0),
(63, 12, '2024-03-25 12:23:09', 22024, 1001, 1),
(64, 12, '2024-03-25 12:23:20', 52500, 1002, 0),
(65, 12, '2024-03-25 12:23:29', 52500, 1002, 1),
(66, 12, '2024-03-25 16:24:02', 20020, 1003, 0),
(67, 11, '2024-03-25 16:24:30', 20020, 1003, 1),
(74, 12, '2024-03-27 11:21:11', 4500, 1004, 1),
(75, 11, '2024-03-27 13:41:19', 24, 1005, 1),
(76, 11, '2024-03-27 13:42:24', 24, 1006, 1),
(77, 12, '2024-03-27 13:52:02', 11000, 1007, 1),
(78, 11, '2024-03-27 13:54:42', 24, 1008, 1),
(79, 12, '2024-03-27 13:56:42', 11000, 1009, 1),
(80, 11, '2024-03-27 13:58:19', 24, 1010, 1),
(81, 11, '2024-03-27 14:14:24', 15024, 1011, 0),
(82, 12, '2024-03-27 14:14:31', 15024, 1011, 1),
(84, 11, '2024-03-29 15:05:07', 0, 1012, 1),
(85, 11, '2024-03-29 15:26:09', 36, 1013, 1),
(86, 11, '2024-03-31 19:58:05', 11718, 1014, 0),
(87, 12, '2024-03-31 19:58:16', 11718, 1014, 0),
(88, 13, '2024-03-31 19:58:32', 11718, 1014, 1),
(89, 11, '2024-03-31 20:08:35', 12, 1015, 0),
(90, 11, '2024-03-31 20:08:42', 12, 1015, 1),
(91, 11, '2024-03-31 20:09:13', 36, 1016, 1),
(92, 11, '2024-03-31 20:09:32', 24, 1017, 0),
(93, 11, '2024-03-31 20:09:41', 24, 1017, 1),
(94, 11, '2024-03-31 20:10:03', 0, 1018, 1),
(96, 12, '2024-04-01 14:07:57', 15000, 1019, 1);

--
-- Triggers `invoice`
--
DELIMITER $$
CREATE TRIGGER `before_insert_invoice` BEFORE INSERT ON `invoice` FOR EACH ROW BEGIN
    DECLARE lastInvoiceID INT;
    DECLARE confirmID INT;

    -- ค้นหา InvoiceID ล่าสุด
    SELECT MAX(InvoiceID) INTO lastInvoiceID FROM invoice;

    -- ค้นหาค่า confirmID จาก InvoiceID ล่าสุด
	SELECT COALESCE(confirm, 0) INTO confirmID FROM invoice ORDER BY InvoiceID DESC LIMIT 1;


    -- กำหนดค่า InvoiceID ให้เริ่มจาก 1000 ถ้ายังไม่มี InvoiceID ในตาราง
    IF lastInvoiceID IS NULL THEN
        SET NEW.InvoiceID = 1000;
    ELSE
        -- เพิ่มขึ้นเรื่อย ๆ จากค่า InvoiceID ล่าสุด
        SET NEW.InvoiceID = lastInvoiceID + confirmID;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_details`
--

CREATE TABLE `invoice_details` (
  `IDID` int(11) NOT NULL,
  `Inv_ID` int(50) NOT NULL,
  `Good_ID` int(50) NOT NULL,
  `Quantity` int(50) NOT NULL,
  `Amount` double NOT NULL,
  `Status` int(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `invoice_details`
--

INSERT INTO `invoice_details` (`IDID`, `Inv_ID`, `Good_ID`, `Quantity`, `Amount`, `Status`) VALUES
(85, 1000, 23, 2, 24, 0),
(86, 1000, 22, 4, 48, 0),
(87, 1001, 23, 2, 24, 0),
(88, 1001, 26, 4, 22000, 0),
(89, 1002, 26, 5, 27500, 0),
(90, 1002, 25, 5, 25000, 0),
(91, 1003, 25, 4, 20000, 0),
(92, 1003, 22, 4, 48, 0),
(99, 1004, 27, 3, 4500, 0),
(100, 1005, 23, 2, 24, 0),
(101, 1006, 23, 2, 24, 0),
(102, 1007, 26, 2, 11000, 0),
(103, 1008, 23, 2, 24, 0),
(104, 1009, 26, 2, 11000, 0),
(105, 1010, 23, 2, 24, 0),
(106, 1011, 23, 2, 24, 0),
(107, 1011, 25, 3, 15000, 0),
(109, 1012, 23, 0, 0, 0),
(110, 1013, 22, 3, 36, 0),
(111, 1014, 23, 0, 0, 0),
(112, 1014, 26, 2, 11000, 0),
(113, 1014, 30, 2, 718, 0),
(114, 1015, 23, 0, 0, 0),
(115, 1015, 23, 1, 12, 0),
(116, 1016, 23, 3, 36, 0),
(117, 1017, 23, 2, 24, 0),
(118, 1017, 24, 0, 0, 0),
(119, 1018, 23, 0, 0, 0),
(121, 1019, 25, 3, 15000, 0);

--
-- Triggers `invoice_details`
--
DELIMITER $$
CREATE TRIGGER `before_insert_invoice_details` BEFORE INSERT ON `invoice_details` FOR EACH ROW BEGIN
    DECLARE lastInvoiceID INT;

    -- ค้นหา InvoiceID ล่าสุด
    SELECT MAX(InvoiceID) INTO lastInvoiceID FROM invoice;

    -- กำหนดค่า Inv_ID ให้เริ่มจาก 1000 ถ้ายังไม่มี InvoiceID ในตาราง
    IF lastInvoiceID IS NULL THEN
        SET NEW.Inv_ID = 1000;
    ELSE
        -- กำหนดค่า Inv_ID ให้เท่ากับ InvoiceID ล่าสุด
        SET NEW.Inv_ID = lastInvoiceID;
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `calculate_ITotal` AFTER INSERT ON `invoice_details` FOR EACH ROW BEGIN
    -- คำนวณยอดรวมของค่า Amount ที่มี Inv_ID และ InvoiceID ตรงกัน
    UPDATE invoice i
    SET i.ITotal = (
        SELECT SUM(amount)
        FROM invoice_details
        WHERE Inv_ID = NEW.Inv_ID
          AND Inv_ID = i.InvoiceID
    )
    WHERE i.InvoiceID = NEW.Inv_ID;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `delete_invoice_details_trigger` AFTER DELETE ON `invoice_details` FOR EACH ROW BEGIN
    IF NOT EXISTS (SELECT * FROM invoice_details WHERE Inv_ID = OLD.Inv_ID) THEN
        DELETE FROM invoice WHERE InvoiceID = OLD.Inv_ID;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `invoice_year_month`
-- (See below for the actual view)
--
CREATE TABLE `invoice_year_month` (
`formatted_date` varchar(7)
,`ITotal` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `receipt`
--

CREATE TABLE `receipt` (
  `ID` int(11) NOT NULL,
  `Datetime` datetime NOT NULL,
  `Cust` varchar(50) NOT NULL,
  `Total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `receipt_details`
--

CREATE TABLE `receipt_details` (
  `ID` int(11) NOT NULL,
  `Rec_ID` int(11) NOT NULL,
  `Good_ID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Amount` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `suppliers`
--

CREATE TABLE `suppliers` (
  `SupID` int(11) NOT NULL,
  `SupName` varchar(20) NOT NULL,
  `SupAddress` varchar(50) NOT NULL,
  `SupPhone` varchar(10) NOT NULL,
  `SupEmail` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `suppliers`
--

INSERT INTO `suppliers` (`SupID`, `SupName`, `SupAddress`, `SupPhone`, `SupEmail`) VALUES
(11, 'JOJO', 'TH', '0964141462', 'jo@gmail.com'),
(12, 'SupShoes', 'TH', '0920000000', 'ss@gmail.com'),
(13, 'SupSportGears', 'TH', '0923333333', 'ssg@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `supplier_good`
--

CREATE TABLE `supplier_good` (
  `SGID` int(11) NOT NULL,
  `Sup_ID` int(11) NOT NULL,
  `Good_ID` int(11) NOT NULL,
  `SGPrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `supplier_good`
--

INSERT INTO `supplier_good` (`SGID`, `Sup_ID`, `Good_ID`, `SGPrice`) VALUES
(1, 11, 23, 0),
(2, 11, 22, 0),
(3, 12, 26, 0),
(4, 12, 25, 0),
(5, 11, 24, 0),
(6, 12, 27, 0),
(7, 13, 30, 0),
(8, 13, 28, 0),
(9, 13, 29, 0),
(17, 11, 32, 0),
(18, 11, 32, 0),
(19, 11, 33, 0),
(20, 12, 32, 0),
(21, 13, 25, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tempsales`
--

CREATE TABLE `tempsales` (
  `ID` int(11) NOT NULL,
  `SalesID` int(11) DEFAULT NULL,
  `CusID` int(11) DEFAULT NULL,
  `GID` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Price` int(11) NOT NULL,
  `Total` int(11) DEFAULT 0,
  `SumTotal` int(11) NOT NULL DEFAULT 0,
  `Datetime` datetime NOT NULL DEFAULT current_timestamp(),
  `enter` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Triggers `tempsales`
--
DELIMITER $$
CREATE TRIGGER `before_insert_tempsales` BEFORE INSERT ON `tempsales` FOR EACH ROW BEGIN
    DECLARE lastSalesID INT;
    DECLARE EnterID INT;

    -- ค้นหา SalseID ล่าสุด
    SELECT MAX(SalesID) INTO lastSalesID FROM history;
    
    SELECT COALESCE(enter, 0) INTO EnterID from history order by history.ID DESC LIMIT 1;

    -- กำหนดค่า SalseID ให้เริ่มจาก 1000 ถ้ายังไม่มี SalseID ในตาราง
    IF lastSalesID IS NULL THEN
        SET NEW.SalesID = 1000;
    ELSE
        -- กำหนดค่า SalesID ให้เท่ากับ SalesID ล่าสุด
        SET NEW.SalesID = lastSalesID + EnterID;
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `type`
--

CREATE TABLE `type` (
  `TypeID` int(11) NOT NULL,
  `TypeName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `type`
--

INSERT INTO `type` (`TypeID`, `TypeName`) VALUES
(1, 'Sport Gears เครื่องกีฬา'),
(2, 'Shirts เสื้อ'),
(3, ' Shoes รองเท้า'),
(4, 'Books หนังสือ'),
(5, ' Bicycles จักรยาน'),
(6, ' Foods อาหาร'),
(7, ' Diary นมเนย'),
(8, ' Health อาหารสุขภาพ'),
(9, ' Drugs ยา'),
(10, ' Bags กระเป๋า'),
(11, ' Stationaries ครื่องเขียน'),
(12, ' OTOP โอท็อป'),
(13, ' Gardening เครื่องสวน'),
(14, ' Electric Appliances เครื่องไฟฟ้า');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `Name` varchar(30) NOT NULL,
  `UserName` varchar(30) NOT NULL,
  `Password` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserID`, `Name`, `UserName`, `Password`) VALUES
(1, 'stang', 'admin', 'admin');

-- --------------------------------------------------------

--
-- Stand-in structure for view `veiw_supplier_good`
-- (See below for the actual view)
--
CREATE TABLE `veiw_supplier_good` (
`SGID` int(11)
,`SupName` varchar(20)
,`GoodName` varchar(30)
,`GoodPrice` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_history`
-- (See below for the actual view)
--
CREATE TABLE `view_history` (
`GoodName` varchar(30)
,`Quantity` decimal(32,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_invoice_details`
-- (See below for the actual view)
--
CREATE TABLE `view_invoice_details` (
`Inv_ID` int(50)
,`SupName` varchar(20)
,`GoodName` varchar(30)
,`Quantity` int(50)
,`Amount` double
,`Status` int(1)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_invoice_details2`
-- (See below for the actual view)
--
CREATE TABLE `view_invoice_details2` (
`Inv_ID` int(50)
,`SupName` varchar(20)
,`GoodName` varchar(30)
,`Quantity` int(50)
,`Amount` double
,`confirm` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_invoice_details3`
-- (See below for the actual view)
--
CREATE TABLE `view_invoice_details3` (
`Inv_ID` int(50)
,`SupName` varchar(20)
,`GoodName` varchar(30)
,`Quantity` int(50)
,`Amount` double
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_print_invoice_details`
-- (See below for the actual view)
--
CREATE TABLE `view_print_invoice_details` (
`Inv_ID` int(50)
,`IDate` datetime
,`SupName` varchar(20)
,`GoodName` varchar(30)
,`GoodPrice` int(11)
,`Quantity` int(50)
,`Amount` double
,`ITotal` int(11)
,`confirm` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_print_receive`
-- (See below for the actual view)
--
CREATE TABLE `view_print_receive` (
`ID` int(11)
,`salesID` int(11)
,`Datetime` datetime
,`GoodName` varchar(30)
,`Quantity` int(11)
,`GoodPrice` int(11)
,`Total` int(11)
,`SumTotal` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_report_invoice`
-- (See below for the actual view)
--
CREATE TABLE `view_report_invoice` (
`GoodName` varchar(30)
,`Quantity` decimal(65,0)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_supplier_good`
-- (See below for the actual view)
--
CREATE TABLE `view_supplier_good` (
`SGID` int(11)
,`SupName` varchar(20)
,`GoodName` varchar(30)
,`GoodPrice` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `view_tempsales`
-- (See below for the actual view)
--
CREATE TABLE `view_tempsales` (
`ID` int(11)
,`SalesID` int(11)
,`GoodName` varchar(30)
,`Quantity` int(11)
,`GoodPrice` int(11)
,`Total` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `warehouse`
-- (See below for the actual view)
--
CREATE TABLE `warehouse` (
`GoodID` int(11)
,`GoodName` varchar(30)
,`TypeName` varchar(50)
,`GoodAmount` int(11)
,`GoodPrice` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `invoice_year_month`
--
DROP TABLE IF EXISTS `invoice_year_month`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `invoice_year_month`  AS SELECT date_format(`invoice`.`IDate`,'%Y-%m') AS `formatted_date`, `invoice`.`ITotal` AS `ITotal` FROM `invoice` ;

-- --------------------------------------------------------

--
-- Structure for view `veiw_supplier_good`
--
DROP TABLE IF EXISTS `veiw_supplier_good`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `veiw_supplier_good`  AS SELECT `supplier_good`.`SGID` AS `SGID`, `suppliers`.`SupName` AS `SupName`, `goods`.`GoodName` AS `GoodName`, `goods`.`GoodPrice` AS `GoodPrice` FROM ((`supplier_good` join `suppliers` on(`supplier_good`.`Sup_ID` = `suppliers`.`SupID`)) join `goods` on(`supplier_good`.`Good_ID` = `goods`.`GoodID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `view_history`
--
DROP TABLE IF EXISTS `view_history`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_history`  AS SELECT `goods`.`GoodName` AS `GoodName`, sum(`history`.`Quantity`) AS `Quantity` FROM (`goods` join `history` on(`goods`.`GoodID` = `history`.`GID`)) GROUP BY `goods`.`GoodID` ;

-- --------------------------------------------------------

--
-- Structure for view `view_invoice_details`
--
DROP TABLE IF EXISTS `view_invoice_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_invoice_details`  AS SELECT `invoice_details`.`Inv_ID` AS `Inv_ID`, `suppliers`.`SupName` AS `SupName`, `goods`.`GoodName` AS `GoodName`, `invoice_details`.`Quantity` AS `Quantity`, `invoice_details`.`Amount` AS `Amount`, `invoice_details`.`Status` AS `Status` FROM (((`invoice_details` join `supplier_good` on(`invoice_details`.`Good_ID` = `supplier_good`.`Good_ID`)) join `suppliers` on(`supplier_good`.`Sup_ID` = `suppliers`.`SupID`)) join `goods` on(`supplier_good`.`Good_ID` = `goods`.`GoodID`)) ORDER BY `invoice_details`.`Inv_ID` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `view_invoice_details2`
--
DROP TABLE IF EXISTS `view_invoice_details2`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_invoice_details2`  AS SELECT `invoice_details`.`Inv_ID` AS `Inv_ID`, `suppliers`.`SupName` AS `SupName`, `goods`.`GoodName` AS `GoodName`, `invoice_details`.`Quantity` AS `Quantity`, `invoice_details`.`Amount` AS `Amount`, `invoice`.`confirm` AS `confirm` FROM (((`invoice_details` join `goods` on(`invoice_details`.`Good_ID` = `goods`.`GoodID`)) join `invoice` on(`invoice_details`.`Inv_ID` = `invoice`.`InvoiceID`)) join `suppliers` on(`invoice`.`SupID` = `suppliers`.`SupID`)) ORDER BY `invoice_details`.`Inv_ID` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `view_invoice_details3`
--
DROP TABLE IF EXISTS `view_invoice_details3`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_invoice_details3`  AS SELECT `invoice_details`.`Inv_ID` AS `Inv_ID`, `suppliers`.`SupName` AS `SupName`, `goods`.`GoodName` AS `GoodName`, `invoice_details`.`Quantity` AS `Quantity`, `invoice_details`.`Amount` AS `Amount` FROM (((`invoice_details` join `supplier_good` on(`invoice_details`.`Good_ID` = `supplier_good`.`Good_ID`)) join `suppliers` on(`supplier_good`.`Sup_ID` = `suppliers`.`SupID`)) join `goods` on(`supplier_good`.`Good_ID` = `goods`.`GoodID`)) ORDER BY `invoice_details`.`Inv_ID` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `view_print_invoice_details`
--
DROP TABLE IF EXISTS `view_print_invoice_details`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_print_invoice_details`  AS SELECT `invoice_details`.`Inv_ID` AS `Inv_ID`, `invoice`.`IDate` AS `IDate`, `suppliers`.`SupName` AS `SupName`, `goods`.`GoodName` AS `GoodName`, `goods`.`GoodPrice` AS `GoodPrice`, `invoice_details`.`Quantity` AS `Quantity`, `invoice_details`.`Amount` AS `Amount`, `invoice`.`ITotal` AS `ITotal`, `invoice`.`confirm` AS `confirm` FROM ((((`invoice_details` join `invoice` on(`invoice_details`.`Inv_ID` = `invoice`.`InvoiceID`)) join `supplier_good` on(`invoice_details`.`Good_ID` = `supplier_good`.`Good_ID`)) join `suppliers` on(`supplier_good`.`Sup_ID` = `suppliers`.`SupID`)) join `goods` on(`supplier_good`.`Good_ID` = `goods`.`GoodID`)) ORDER BY `invoice_details`.`Inv_ID` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `view_print_receive`
--
DROP TABLE IF EXISTS `view_print_receive`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_print_receive`  AS SELECT `tempsales`.`ID` AS `ID`, `tempsales`.`SalesID` AS `salesID`, `tempsales`.`Datetime` AS `Datetime`, `goods`.`GoodName` AS `GoodName`, `tempsales`.`Quantity` AS `Quantity`, `goods`.`GoodPrice` AS `GoodPrice`, `tempsales`.`Total` AS `Total`, `tempsales`.`SumTotal` AS `SumTotal` FROM (`tempsales` join `goods` on(`tempsales`.`GID` = `goods`.`GoodID`)) ORDER BY `tempsales`.`ID` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `view_report_invoice`
--
DROP TABLE IF EXISTS `view_report_invoice`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_report_invoice`  AS SELECT `goods`.`GoodName` AS `GoodName`, sum(`invoice_details`.`Quantity`) AS `Quantity` FROM (`goods` join `invoice_details` on(`goods`.`GoodID` = `invoice_details`.`Good_ID`)) GROUP BY `goods`.`GoodID` ;

-- --------------------------------------------------------

--
-- Structure for view `view_supplier_good`
--
DROP TABLE IF EXISTS `view_supplier_good`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_supplier_good`  AS SELECT `supplier_good`.`SGID` AS `SGID`, `suppliers`.`SupName` AS `SupName`, `goods`.`GoodName` AS `GoodName`, `goods`.`GoodPrice` AS `GoodPrice` FROM ((`supplier_good` join `suppliers` on(`supplier_good`.`Sup_ID` = `suppliers`.`SupID`)) join `goods` on(`supplier_good`.`Good_ID` = `goods`.`GoodID`)) ORDER BY `supplier_good`.`SGID` ASC ;

-- --------------------------------------------------------

--
-- Structure for view `view_tempsales`
--
DROP TABLE IF EXISTS `view_tempsales`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `view_tempsales`  AS SELECT `tempsales`.`ID` AS `ID`, `tempsales`.`SalesID` AS `SalesID`, `goods`.`GoodName` AS `GoodName`, `tempsales`.`Quantity` AS `Quantity`, `goods`.`GoodPrice` AS `GoodPrice`, `tempsales`.`Total` AS `Total` FROM (`tempsales` join `goods` on(`tempsales`.`GID` = `goods`.`GoodID`)) ;

-- --------------------------------------------------------

--
-- Structure for view `warehouse`
--
DROP TABLE IF EXISTS `warehouse`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `warehouse`  AS SELECT `goods`.`GoodID` AS `GoodID`, `goods`.`GoodName` AS `GoodName`, `type`.`TypeName` AS `TypeName`, `goods`.`GoodAmount` AS `GoodAmount`, `goods`.`GoodPrice` AS `GoodPrice` FROM (`goods` join `type` on(`goods`.`GoodType` = `type`.`TypeID`)) ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`CusID`);

--
-- Indexes for table `goods`
--
ALTER TABLE `goods`
  ADD PRIMARY KEY (`GoodID`),
  ADD KEY `GoodType` (`GoodType`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `GID` (`GID`);

--
-- Indexes for table `invoice`
--
ALTER TABLE `invoice`
  ADD PRIMARY KEY (`IID`),
  ADD KEY `SupID` (`SupID`),
  ADD KEY `InvoiceID` (`InvoiceID`);

--
-- Indexes for table `invoice_details`
--
ALTER TABLE `invoice_details`
  ADD PRIMARY KEY (`IDID`),
  ADD KEY `Inv_ID` (`Inv_ID`),
  ADD KEY `Good_ID` (`Good_ID`);

--
-- Indexes for table `receipt`
--
ALTER TABLE `receipt`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `receipt_details`
--
ALTER TABLE `receipt_details`
  ADD PRIMARY KEY (`ID`) USING BTREE,
  ADD KEY `Good_ID` (`Good_ID`),
  ADD KEY `Rec_ID` (`Rec_ID`) USING BTREE;

--
-- Indexes for table `suppliers`
--
ALTER TABLE `suppliers`
  ADD PRIMARY KEY (`SupID`);

--
-- Indexes for table `supplier_good`
--
ALTER TABLE `supplier_good`
  ADD PRIMARY KEY (`SGID`),
  ADD KEY `Sup_ID` (`Sup_ID`),
  ADD KEY `Good_ID` (`Good_ID`),
  ADD KEY `SGPrice` (`SGPrice`);

--
-- Indexes for table `tempsales`
--
ALTER TABLE `tempsales`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `CusID` (`CusID`),
  ADD KEY `GID` (`GID`);

--
-- Indexes for table `type`
--
ALTER TABLE `type`
  ADD PRIMARY KEY (`TypeID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `CusID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `goods`
--
ALTER TABLE `goods`
  MODIFY `GoodID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=269;

--
-- AUTO_INCREMENT for table `invoice`
--
ALTER TABLE `invoice`
  MODIFY `IID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=97;

--
-- AUTO_INCREMENT for table `invoice_details`
--
ALTER TABLE `invoice_details`
  MODIFY `IDID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=122;

--
-- AUTO_INCREMENT for table `receipt`
--
ALTER TABLE `receipt`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `receipt_details`
--
ALTER TABLE `receipt_details`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `suppliers`
--
ALTER TABLE `suppliers`
  MODIFY `SupID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `supplier_good`
--
ALTER TABLE `supplier_good`
  MODIFY `SGID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `tempsales`
--
ALTER TABLE `tempsales`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=280;

--
-- AUTO_INCREMENT for table `type`
--
ALTER TABLE `type`
  MODIFY `TypeID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `goods`
--
ALTER TABLE `goods`
  ADD CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`GoodType`) REFERENCES `type` (`TypeID`);

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`GID`) REFERENCES `goods` (`GoodID`);

--
-- Constraints for table `invoice`
--
ALTER TABLE `invoice`
  ADD CONSTRAINT `invoice_ibfk_1` FOREIGN KEY (`SupID`) REFERENCES `suppliers` (`SupID`);

--
-- Constraints for table `invoice_details`
--
ALTER TABLE `invoice_details`
  ADD CONSTRAINT `invoice_details_ibfk_2` FOREIGN KEY (`Good_ID`) REFERENCES `goods` (`GoodID`),
  ADD CONSTRAINT `invoice_details_ibfk_3` FOREIGN KEY (`Inv_ID`) REFERENCES `invoice` (`InvoiceID`);

--
-- Constraints for table `receipt_details`
--
ALTER TABLE `receipt_details`
  ADD CONSTRAINT `receipt_details_ibfk_1` FOREIGN KEY (`Good_ID`) REFERENCES `goods` (`GoodID`),
  ADD CONSTRAINT `receipt_details_ibfk_2` FOREIGN KEY (`Rec_ID`) REFERENCES `receipt` (`ID`);

--
-- Constraints for table `supplier_good`
--
ALTER TABLE `supplier_good`
  ADD CONSTRAINT `supplier_good_ibfk_1` FOREIGN KEY (`Sup_ID`) REFERENCES `suppliers` (`SupID`),
  ADD CONSTRAINT `supplier_good_ibfk_2` FOREIGN KEY (`Good_ID`) REFERENCES `goods` (`GoodID`);

--
-- Constraints for table `tempsales`
--
ALTER TABLE `tempsales`
  ADD CONSTRAINT `tempsales_ibfk_1` FOREIGN KEY (`GID`) REFERENCES `goods` (`GoodID`),
  ADD CONSTRAINT `tempsales_ibfk_2` FOREIGN KEY (`CusID`) REFERENCES `customer` (`CusID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
