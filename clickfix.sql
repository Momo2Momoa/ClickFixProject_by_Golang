-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 18, 2025 at 05:26 PM
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
-- Database: `clickfix`
--

-- --------------------------------------------------------

--
-- Table structure for table `case_custom`
--

CREATE TABLE `case_custom` (
  `case_id` int(11) NOT NULL,
  `case_material` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `case_custom`
--

INSERT INTO `case_custom` (`case_id`, `case_material`) VALUES
(1, '3Dprint'),
(2, 'Acrylic'),
(3, 'Poly_Carbonate'),
(4, 'Aluminium'),
(5, 'Stainless Steel');

-- --------------------------------------------------------

--
-- Table structure for table `keyboard`
--

CREATE TABLE `keyboard` (
  `keyboard_id` int(11) NOT NULL,
  `case_keyboard` int(11) NOT NULL,
  `pcb` int(11) NOT NULL,
  `plate` int(11) NOT NULL,
  `switch` int(11) NOT NULL,
  `stabilizers` int(11) NOT NULL,
  `keycap` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keyboard_view`
--

CREATE TABLE `keyboard_view` (
  `id` int(11) NOT NULL DEFAULT 0,
  `case_custom` varchar(50) NOT NULL,
  `pcb_percent_layout` varchar(50) NOT NULL,
  `pcb_layout` varchar(50) NOT NULL,
  `plate_material` varchar(50) NOT NULL,
  `switch_type` varchar(50) NOT NULL,
  `stab_type` varchar(50) NOT NULL,
  `keycap_profile` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `keycap`
--

CREATE TABLE `keycap` (
  `keycap_id` int(11) NOT NULL,
  `keycap_profile` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keycap`
--

INSERT INTO `keycap` (`keycap_id`, `keycap_profile`) VALUES
(1, 'Cherry'),
(2, 'OEM'),
(3, 'SA'),
(4, 'MDA'),
(5, 'XDA'),
(6, 'DSA');

-- --------------------------------------------------------

--
-- Table structure for table `pcb`
--

CREATE TABLE `pcb` (
  `pcb_id` int(11) NOT NULL,
  `pcb_percent_layout` varchar(50) NOT NULL,
  `pcb_layout` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pcb`
--

INSERT INTO `pcb` (`pcb_id`, `pcb_percent_layout`, `pcb_layout`) VALUES
(1, '100', 'full sized '),
(2, '96', 'compact full sized'),
(3, '80', 'tenkeyless'),
(4, '75', 'compact tenkeyless'),
(5, '65', 'compact'),
(6, '60', 'mini');

-- --------------------------------------------------------

--
-- Table structure for table `plate`
--

CREATE TABLE `plate` (
  `plate_id` int(11) NOT NULL,
  `plate_material` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `plate`
--

INSERT INTO `plate` (`plate_id`, `plate_material`) VALUES
(1, 'Aluminium'),
(2, 'Brass'),
(3, 'Stainless Steel'),
(4, 'Carbon Fiber'),
(5, 'Poly-Carbonate'),
(6, 'Polyoxymethylene'),
(7, 'FR4');

-- --------------------------------------------------------

--
-- Table structure for table `stabilizers`
--

CREATE TABLE `stabilizers` (
  `stab_id` int(11) NOT NULL,
  `stab_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `stabilizers`
--

INSERT INTO `stabilizers` (`stab_id`, `stab_type`) VALUES
(1, 'PCB Mount'),
(2, 'Screw-in Mount'),
(3, 'Plate Mount');

-- --------------------------------------------------------

--
-- Table structure for table `switch`
--

CREATE TABLE `switch` (
  `switch_id` int(11) NOT NULL,
  `switch_type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `switch`
--

INSERT INTO `switch` (`switch_id`, `switch_type`) VALUES
(1, 'Linear'),
(2, 'Tactile'),
(3, 'Clicky');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `role` varchar(255) NOT NULL DEFAULT 'member'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `username`, `password`, `email`, `role`) VALUES
(11, 'stang', 'stang', '$2a$10$UPeW4lIRu51FuW6Hv3addOt7Gi6ozv9lN24WlgagqNs7R8yj35Yw6', 'stang@example.com', 'member');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `case_custom`
--
ALTER TABLE `case_custom`
  ADD PRIMARY KEY (`case_id`);

--
-- Indexes for table `keyboard`
--
ALTER TABLE `keyboard`
  ADD PRIMARY KEY (`keyboard_id`),
  ADD KEY `case_keyboard` (`case_keyboard`,`pcb`,`plate`,`switch`,`stabilizers`,`keycap`),
  ADD KEY `pcb` (`pcb`),
  ADD KEY `plate` (`plate`),
  ADD KEY `switch` (`switch`),
  ADD KEY `stabilizers` (`stabilizers`),
  ADD KEY `keycap` (`keycap`);

--
-- Indexes for table `keycap`
--
ALTER TABLE `keycap`
  ADD PRIMARY KEY (`keycap_id`);

--
-- Indexes for table `pcb`
--
ALTER TABLE `pcb`
  ADD PRIMARY KEY (`pcb_id`);

--
-- Indexes for table `plate`
--
ALTER TABLE `plate`
  ADD PRIMARY KEY (`plate_id`);

--
-- Indexes for table `stabilizers`
--
ALTER TABLE `stabilizers`
  ADD PRIMARY KEY (`stab_id`);

--
-- Indexes for table `switch`
--
ALTER TABLE `switch`
  ADD PRIMARY KEY (`switch_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `keyboard`
--
ALTER TABLE `keyboard`
  MODIFY `keyboard_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `keycap`
--
ALTER TABLE `keycap`
  MODIFY `keycap_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pcb`
--
ALTER TABLE `pcb`
  MODIFY `pcb_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `plate`
--
ALTER TABLE `plate`
  MODIFY `plate_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `stabilizers`
--
ALTER TABLE `stabilizers`
  MODIFY `stab_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `switch`
--
ALTER TABLE `switch`
  MODIFY `switch_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `keyboard`
--
ALTER TABLE `keyboard`
  ADD CONSTRAINT `keyboard_ibfk_1` FOREIGN KEY (`case_keyboard`) REFERENCES `case_custom` (`case_id`),
  ADD CONSTRAINT `keyboard_ibfk_2` FOREIGN KEY (`pcb`) REFERENCES `pcb` (`pcb_id`),
  ADD CONSTRAINT `keyboard_ibfk_3` FOREIGN KEY (`plate`) REFERENCES `plate` (`plate_id`),
  ADD CONSTRAINT `keyboard_ibfk_4` FOREIGN KEY (`switch`) REFERENCES `switch` (`switch_id`),
  ADD CONSTRAINT `keyboard_ibfk_5` FOREIGN KEY (`stabilizers`) REFERENCES `stabilizers` (`stab_id`),
  ADD CONSTRAINT `keyboard_ibfk_6` FOREIGN KEY (`keycap`) REFERENCES `keycap` (`keycap_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
