-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 24, 2023 at 04:59 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `sv_dkhp`
--

-- --------------------------------------------------------

--
-- Table structure for table `nhan_vien`
--

CREATE TABLE `nhan_vien` (
  `ma_nhan_vien` bigint(20) NOT NULL,
  `chuc_vu` varchar(255) DEFAULT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `sdt` varchar(255) DEFAULT NULL,
  `ten_nhan_vien` varchar(255) DEFAULT NULL,
  `ma_tai_khoan` bigint(20) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `gioi_tinh` varchar(255) DEFAULT NULL,
  `last_backup` datetime DEFAULT NULL,
  `nam_sinh` int(11) NOT NULL,
  `ngay_vao_lam` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nhan_vien`
--

INSERT INTO `nhan_vien` (`ma_nhan_vien`, `chuc_vu`, `dia_chi`, `sdt`, `ten_nhan_vien`, `ma_tai_khoan`, `avatar`, `gioi_tinh`, `last_backup`, `nam_sinh`, `ngay_vao_lam`) VALUES
(1, 'THO_DIEN', '60/122 To 10 KP8 Phuong TCH Q12 TP.HCM, Đường Huỳnh Thị Hai', '0338188506', 'Nhân Viên A', 2, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1672644566/sv-iuh-avatar-pattern_oyubmc.jpg', 'NAM', NULL, 2001, '2023-04-01');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `nhan_vien`
--
ALTER TABLE `nhan_vien`
  ADD PRIMARY KEY (`ma_nhan_vien`),
  ADD KEY `FKdpk3u6xuawsiksnkklx1pfeyw` (`ma_tai_khoan`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `nhan_vien`
--
ALTER TABLE `nhan_vien`
  MODIFY `ma_nhan_vien` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `nhan_vien`
--
ALTER TABLE `nhan_vien`
  ADD CONSTRAINT `FKdpk3u6xuawsiksnkklx1pfeyw` FOREIGN KEY (`ma_tai_khoan`) REFERENCES `tai_khoan` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
