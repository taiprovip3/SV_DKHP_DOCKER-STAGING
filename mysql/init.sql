-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 24, 2023 at 05:41 PM
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
-- Table structure for table `chuong_trinh_khung`
--

CREATE TABLE `chuong_trinh_khung` (
  `id` bigint(20) NOT NULL,
  `done` bit(1) NOT NULL,
  `ma_mon_hoc` bigint(20) DEFAULT NULL,
  `ma_sinh_vien` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `chuong_trinh_khung`
--

INSERT INTO `chuong_trinh_khung` (`id`, `done`, `ma_mon_hoc`, `ma_sinh_vien`) VALUES
(3, b'1', 1000081, 1),
(6, b'1', 1000082, 1);

-- --------------------------------------------------------

--
-- Table structure for table `cong_no`
--

CREATE TABLE `cong_no` (
  `id` bigint(20) NOT NULL,
  `cong_no` double NOT NULL,
  `da_nop` double NOT NULL,
  `khau_tru` double NOT NULL,
  `mien_giam` float NOT NULL,
  `so_tien` double NOT NULL,
  `trang_thai` varchar(255) DEFAULT NULL,
  `ma_lop_hoc_phan` bigint(20) DEFAULT NULL,
  `ma_mon_hoc` bigint(20) NOT NULL,
  `ma_sinh_vien` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cong_no`
--

INSERT INTO `cong_no` (`id`, `cong_no`, `da_nop`, `khau_tru`, `mien_giam`, `so_tien`, `trang_thai`, `ma_lop_hoc_phan`, `ma_mon_hoc`, `ma_sinh_vien`) VALUES
(1, 0, 4250000, 0, 0, 0, 'DA_NOP', 1, 1000081, 1),
(2, 0, 4250000, 0, 0, 0, 'DA_NOP', 2, 1000082, 1);

-- --------------------------------------------------------

--
-- Table structure for table `diem`
--

CREATE TABLE `diem` (
  `ma_diem` bigint(20) NOT NULL,
  `diem4` float NOT NULL,
  `diemck` float NOT NULL,
  `diem_chu` varchar(255) NOT NULL,
  `diemgk` float NOT NULL,
  `diemlt1` float NOT NULL,
  `diemlt2` float NOT NULL,
  `diemlt3` float NOT NULL,
  `diemth1` float NOT NULL,
  `diemth2` float NOT NULL,
  `diemth3` float NOT NULL,
  `diem_tong_ket` float NOT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `pass` bit(1) NOT NULL,
  `xep_loai` varchar(255) DEFAULT NULL,
  `ma_lop_hoc_phan` bigint(20) DEFAULT NULL,
  `ma_sinh_vien` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `diem`
--

INSERT INTO `diem` (`ma_diem`, `diem4`, `diemck`, `diem_chu`, `diemgk`, `diemlt1`, `diemlt2`, `diemlt3`, `diemth1`, `diemth2`, `diemth3`, `diem_tong_ket`, `ghi_chu`, `pass`, `xep_loai`, `ma_lop_hoc_phan`, `ma_sinh_vien`) VALUES
(2, 2.6, 7.2, 'B', 5, 6, 7, 8, 0, 0, 0, 6.5, 'Đạt', b'1', 'TRUNG_BINH_KHA', 1, 1),
(4, 1.86667, 5.5, 'C', 5, 6, 7, 7, 6, 4, 4, 4.66667, 'Đạt', b'1', 'YEU', 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `giao_vien`
--

CREATE TABLE `giao_vien` (
  `ma_giao_vien` bigint(20) NOT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `gioi_tinh` varchar(255) DEFAULT NULL,
  `loai_giao_vien` varchar(255) DEFAULT NULL,
  `ngay_sinh` date DEFAULT NULL,
  `sdt` varchar(255) DEFAULT NULL,
  `ten_giao_vien` varchar(255) DEFAULT NULL,
  `ma_tai_khoan` bigint(20) DEFAULT NULL,
  `avatar` varchar(255) NOT NULL DEFAULT 'https://smilemedia.vn/wp-content/uploads/2022/09/cach-chup-hinh-the-dep.jpeg'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `giao_vien`
--

INSERT INTO `giao_vien` (`ma_giao_vien`, `dia_chi`, `gioi_tinh`, `loai_giao_vien`, `ngay_sinh`, `sdt`, `ten_giao_vien`, `ma_tai_khoan`, `avatar`) VALUES
(1, '163 Bùi Quan Là', 'NU', 'GIAO_VIEN_BO_MON', '2018-01-01', '0338188506', 'Giáo Viên A', 1, 'https://smilemedia.vn/wp-content/uploads/2022/09/cach-chup-hinh-the-dep.jpeg');

-- --------------------------------------------------------

--
-- Table structure for table `hoc_ky`
--

CREATE TABLE `hoc_ky` (
  `ma_hoc_ky` bigint(20) NOT NULL,
  `so_tin_chi` int(11) NOT NULL,
  `ten_hoc_ky` varchar(255) DEFAULT NULL,
  `ma_nganh` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hoc_ky`
--

INSERT INTO `hoc_ky` (`ma_hoc_ky`, `so_tin_chi`, `ten_hoc_ky`, `ma_nganh`) VALUES
(1, 17, 'Học kỳ 1', 2),
(2, 23, 'Học kỳ 2', 2),
(3, 27, 'Học kỳ 3', 2),
(4, 28, 'Học kỳ 4', 2),
(5, 21, 'Học kỳ 5', 2),
(6, 17, 'Học kỳ 6', 2),
(7, 15, 'Học kỳ 7', 2),
(8, 10, 'Học kỳ 8', 2);

-- --------------------------------------------------------

--
-- Table structure for table `khoa`
--

CREATE TABLE `khoa` (
  `ma_khoa` bigint(20) NOT NULL,
  `ten_khoa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `khoa`
--

INSERT INTO `khoa` (`ma_khoa`, `ten_khoa`) VALUES
(1, 'Khoa Công Nghệ Thông Tin'),
(2, 'Khoa Công Nghệ Cơ Khí'),
(3, 'Khoa Công Nghệ Điện'),
(4, 'Koa Công Nghệ Điện Tử'),
(5, 'Khoa Công Nghệ Động Lực'),
(6, 'Khoa Công Nghệ Nhiệt Lạnh'),
(7, 'Khoa Công Nghệ May - Thời Trang'),
(8, 'Khoa Công Nghệ Hóa Học'),
(9, 'Khoa Kế Toán - Kiểm Toán'),
(10, 'Khoa Khoa Học Cơ Bản'),
(11, 'Khoa Lý Luận Chính Trị'),
(12, 'Khoa Ngoại Ngữ'),
(13, 'Khoa Quản Trị Kinh Doanh'),
(14, 'Khoa Tài Chính - Ngân Hàng'),
(15, 'Khoa Thương Mại - Du Lịch'),
(16, 'Khoa Kỹ Thuật Xây Dựng'),
(17, 'Khoa Luật');

-- --------------------------------------------------------

--
-- Table structure for table `khoa_hoc`
--

CREATE TABLE `khoa_hoc` (
  `ma_khoa_hoc` bigint(20) NOT NULL,
  `alias` varchar(255) DEFAULT NULL,
  `nam_bat_dau` int(11) NOT NULL,
  `nam_ket_thuc` int(11) NOT NULL,
  `ten_khoa_hoc` varchar(255) DEFAULT NULL,
  `ma_hoc_ky` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `khoa_hoc`
--

INSERT INTO `khoa_hoc` (`ma_khoa_hoc`, `alias`, `nam_bat_dau`, `nam_ket_thuc`, `ten_khoa_hoc`, `ma_hoc_ky`) VALUES
(1, 'Học kỳ 1', 2019, 2020, 'HOC_KY_I', 1),
(2, 'Học kỳ 2', 2019, 2020, 'HOC_KY_II', 2),
(3, 'Học kỳ 3', 2019, 2020, 'HOC_KY_III', NULL),
(4, 'Học kỳ 1', 2020, 2021, 'HOC_KY_I', 3),
(5, 'Học kỳ 2', 2020, 2021, 'HOC_KY_II', 4),
(6, 'Học kỳ 3', 2020, 2021, 'HOC_KY_III', NULL),
(7, 'Học kỳ 1', 2021, 2022, 'HOC_KY_I', 5),
(8, 'Học kỳ 2', 2021, 2022, 'HOC_KY_II', 6),
(9, 'Học kỳ 3', 2021, 2022, 'HOC_KY_III', NULL),
(10, 'Học kỳ 1', 2022, 2023, 'HOC_KY_I', 7),
(11, 'Học kỳ 2', 2022, 2023, 'HOC_KY_II', 8),
(12, 'Học kỳ 3', 2022, 2023, 'HOC_KY_III', NULL),
(13, 'Học kỳ 1', 2023, 2024, 'HOC_KY_I', 1);

-- --------------------------------------------------------

--
-- Table structure for table `lop_hoc_danh_nghia`
--

CREATE TABLE `lop_hoc_danh_nghia` (
  `ma_lop` bigint(20) NOT NULL,
  `so_luong` int(11) NOT NULL,
  `ten_lop` varchar(255) DEFAULT NULL,
  `ma_giao_vien` bigint(20) NOT NULL,
  `ma_khoa_hoc` bigint(20) NOT NULL,
  `ma_nganh` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lop_hoc_danh_nghia`
--

INSERT INTO `lop_hoc_danh_nghia` (`ma_lop`, `so_luong`, `ten_lop`, `ma_giao_vien`, `ma_khoa_hoc`, `ma_nganh`) VALUES
(1, 50, 'DHKTPM11ATT', 1, 1, 2),
(2, 31, 'DHKTPM1ATT', 1, 1, 1),
(3, 32, 'DHKTPM2ATT', 1, 1, 1),
(4, 31, 'DHKTPM1ATT', 1, 1, 1),
(5, 32, 'DHKTPM2ATT', 1, 1, 1),
(6, 31, 'DHKTPM1ATT', 1, 1, 1),
(7, 32, 'DHKTPM2ATT', 1, 1, 1),
(8, 31, 'DHKTPM1ATT', 1, 1, 1),
(9, 32, 'DHKTPM2ATT', 1, 1, 1),
(10, 31, 'DHKTPM1ATT', 1, 1, 1),
(11, 32, 'DHKTPM2ATT', 1, 1, 1),
(12, 31, 'DHKTPM1ATT', 1, 1, 1),
(13, 32, 'DHKTPM2ATT', 1, 1, 1),
(14, 31, 'DHKTPM1ATT', 1, 1, 1),
(15, 32, 'DHKTPM2ATT', 1, 1, 1),
(16, 31, 'DHKTPM1ATT', 1, 1, 1),
(17, 32, 'DHKTPM2ATT', 1, 1, 1),
(18, 31, 'DHKTPM1ATT', 1, 1, 1),
(19, 32, 'DHKTPM2ATT', 1, 1, 1),
(20, 31, 'DHKTPM1ATT', 1, 1, 1),
(21, 32, 'DHKTPM2ATT', 1, 1, 1),
(22, 31, 'DHKTPM1ATT', 1, 1, 1),
(23, 32, 'DHKTPM2ATT', 1, 1, 1),
(24, 31, 'DHKTPM1ATT', 1, 1, 1),
(25, 32, 'DHKTPM2ATT', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `lop_hoc_phan`
--

CREATE TABLE `lop_hoc_phan` (
  `ma_lop_hoc_phan` bigint(20) NOT NULL,
  `han_nop_hoc_phi` date DEFAULT NULL,
  `loai_hoc` varchar(255) DEFAULT NULL,
  `ngay_bat_dau` date DEFAULT NULL,
  `ngay_ket_thuc` date DEFAULT NULL,
  `so_luong` int(11) NOT NULL,
  `so_luong_max` int(11) NOT NULL,
  `ten_lop_hoc_phan` varchar(255) DEFAULT NULL,
  `trang_thai` varchar(255) DEFAULT NULL,
  `ma_giao_vien` bigint(20) DEFAULT NULL,
  `ma_khoa_hoc` bigint(20) DEFAULT NULL,
  `ma_mon_hoc` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lop_hoc_phan`
--

INSERT INTO `lop_hoc_phan` (`ma_lop_hoc_phan`, `han_nop_hoc_phi`, `loai_hoc`, `ngay_bat_dau`, `ngay_ket_thuc`, `so_luong`, `so_luong_max`, `ten_lop_hoc_phan`, `trang_thai`, `ma_giao_vien`, `ma_khoa_hoc`, `ma_mon_hoc`) VALUES
(1, '2023-02-12', 'HOC_MOI', '2023-02-12', '2023-03-31', 0, 23, 'DHKTPM15CTT', 'DA_KHOA', 1, 11, 1000081),
(2, '2023-03-12', 'HOC_MOI', '2023-03-12', '2023-03-31', 1, 55, 'DHKTPM15ATT', 'CHAP_NHAN_MO_LOP', 1, 11, 1000082),
(3, '2023-03-01', 'HOC_MOI', '1899-11-01', '2023-03-30', 3, 44, 'DHKTPM15ATT', 'DANG_CHO_SINH_VIEN_DANG_KY', 1, 11, 1000080),
(4, '2023-04-01', 'HOC_MOI', '2023-04-01', '2023-04-30', 0, 32, 'DHKTPM16', 'DANG_CHO_SINH_VIEN_DANG_KY', 1, 1, 1000001),
(5, '2023-04-01', 'HOC_MOI', '2023-04-01', '2023-04-30', 0, 33, 'DHKTPM16S', 'DANG_CHO_SINH_VIEN_DANG_KY', 1, 1, 1000001),
(6, '2023-04-05', 'HOC_MOI', '2023-04-05', '2023-04-30', 30, 44, 'DHKTPM12B', 'DANG_CHO_SINH_VIEN_DANG_KY', 1, 11, 1000080),
(7, '2023-04-25', 'HOC_MOI', '2023-04-25', '2023-04-30', 0, 22, 'DHKTPM1ATT', 'DANG_CHO_SINH_VIEN_DANG_KY', 1, 13, 1000001);

-- --------------------------------------------------------

--
-- Table structure for table `mon_hoc`
--

CREATE TABLE `mon_hoc` (
  `ma_mon_hoc` bigint(20) NOT NULL,
  `hoc_phi` double NOT NULL,
  `loai_mon` varchar(255) DEFAULT NULL,
  `ma_mon_yeu_cau` bigint(20) NOT NULL,
  `nhom_mon` int(11) NOT NULL,
  `so_tietlt` int(11) NOT NULL,
  `so_tietth` int(11) NOT NULL,
  `so_tin_chi` int(11) NOT NULL,
  `ten_mon_hoc` varchar(255) DEFAULT NULL,
  `ma_hoc_ky` bigint(20) NOT NULL,
  `ma_nganh` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mon_hoc`
--

INSERT INTO `mon_hoc` (`ma_mon_hoc`, `hoc_phi`, `loai_mon`, `ma_mon_yeu_cau`, `nhom_mon`, `so_tietlt`, `so_tietth`, `so_tin_chi`, `ten_mon_hoc`, `ma_hoc_ky`, `ma_nganh`) VALUES
(1000001, 1700000, 'BAT_BUOC', 0, 0, 30, 0, 2, 'Nhập môn tin học', 1, 2),
(1000002, 3400000, 'SUPER_BAT_BUOC', 0, 0, 60, 0, 4, 'Giáo dục quốc phòng và an ninh 1', 1, 2),
(1000003, 1700000, 'SUPER_BAT_BUOC', 0, 0, 0, 60, 2, 'Giáo dục thể chất 1', 1, 2),
(1000004, 1700000, 'BAT_BUOC', 0, 0, 30, 0, 2, 'Toán cao cấp 1', 1, 2),
(1000005, 1700000, 'BAT_BUOC', 0, 0, 0, 60, 2, 'Nhập môn lập trình', 1, 2),
(1000006, 2550000, 'BAT_BUOC', 0, 0, 45, 0, 3, 'Triết học Mác - Lênin', 1, 2),
(1000007, 1700000, 'BAT_BUOC', 0, 0, 30, 0, 2, 'Kinh tế chính trị Mác-Lênin', 1, 2),
(1000008, 2550000, 'BAT_BUOC', 0, 0, 30, 0, 3, 'Anh văn 1', 2, 2),
(1000009, 2550000, 'BAT_BUOC', 1000005, 0, 30, 30, 3, 'Kỹ thuật lập trình', 2, 2),
(1000010, 1700000, 'BAT_BUOC', 0, 0, 30, 0, 2, 'Kỹ năng làm việc nhóm', 2, 2),
(1000011, 1700000, 'BAT_BUOC', 0, 0, 30, 0, 2, 'Toán cao cấp 2', 2, 2),
(1000012, 3400000, 'SUPER_BAT_BUOC', 0, 0, 30, 60, 4, 'Giáo dục Quốc phòng và An ninh 2', 2, 2),
(1000013, 1700000, 'SUPER_BAT_BUOC', 0, 0, 0, 60, 2, 'Giáo dục thể chất 2', 2, 2),
(1000014, 3400000, 'BAT_BUOC', 0, 0, 45, 30, 4, 'Hệ thống máy tính', 2, 2),
(1000015, 2550000, 'TU_CHON', 0, 1, 45, 0, 3, 'Tâm lý học đại cương', 2, 2),
(1000016, 2550000, 'TU_CHON', 0, 1, 45, 0, 3, 'Tiếng Việt thực hành', 2, 2),
(1000017, 2550000, 'TU_CHON', 0, 1, 45, 0, 3, 'Âm nhạc – Nhạc lý và Guitar căn bản', 2, 2),
(1000018, 2550000, 'TU_CHON', 0, 1, 45, 0, 3, 'Xã hội học', 2, 2),
(1000019, 2550000, 'TU_CHON', 0, 1, 45, 0, 3, 'Cơ sở văn hóa Việt Nam', 2, 2),
(1000020, 2550000, 'TU_CHON', 0, 1, 45, 0, 3, 'Hội họa', 2, 2),
(1000021, 3400000, 'BAT_BUOC', 1000008, 0, 60, 0, 4, 'Anh văn 2', 3, 2),
(1000022, 2550000, 'BAT_BUOC', 0, 0, 45, 0, 3, 'Cấu trúc rời rạc', 3, 2),
(1000023, 3400000, 'BAT_BUOC', 1000005, 0, 45, 30, 4, 'Cấu trúc dữ liệu và giải thuật', 3, 2),
(1000024, 3400000, 'BAT_BUOC', 1000001, 0, 45, 30, 4, 'Hệ cơ sở dữ liệu', 3, 2),
(1000025, 2550000, 'BAT_BUOC', 0, 0, 45, 0, 3, 'Mạng máy tính', 3, 2),
(1000026, 2550000, 'BAT_BUOC', 1000005, 0, 30, 30, 3, 'Lập trình hướng đối tượng', 3, 2),
(1000027, 2550000, 'BAT_BUOC', 0, 0, 45, 0, 3, 'Sự phát triển của lịch sử và công nghệ', 3, 2),
(1000028, 2550000, 'TU_CHON', 0, 1, 45, 0, 3, 'Phương pháp tính', 3, 2),
(1000029, 2550000, 'TU_CHON', 0, 1, 45, 0, 3, 'Vật lý đại cương', 3, 2),
(1000030, 2550000, 'TU_CHON', 0, 1, 45, 0, 3, 'Toán ứng dụng', 3, 2),
(1000031, 2550000, 'TU_CHON', 0, 1, 45, 0, 3, 'Hàm phức và phép biến đổi Laplace', 3, 2),
(1000032, 2550000, 'TU_CHON', 0, 1, 45, 0, 3, 'Logic học', 3, 2),
(1000033, 3400000, 'BAT_BUOC', 1000021, 0, 60, 0, 4, 'Anh văn 3', 4, 2),
(1000034, 2550000, 'BAT_BUOC', 1000022, 0, 45, 0, 3, 'Lý thuyết đồ thị', 4, 2),
(1000035, 2550000, 'BAT_BUOC', 0, 0, 30, 30, 3, 'Hệ Thống và Công nghệ Web', 4, 2),
(1000036, 1700000, 'BAT_BUOC', 0, 0, 30, 0, 2, 'Phương pháp luận nghiên cứu khoa học', 4, 2),
(1000037, 2550000, 'BAT_BUOC', 1000024, 0, 30, 30, 3, 'Phân tích thiết kế hệ thống', 4, 2),
(1000038, 2550000, 'BAT_BUOC', 1000009, 0, 30, 30, 3, 'Thống kê máy tính và ứng dụng', 4, 2),
(1000039, 2550000, 'TU_CHON', 1000024, 1, 30, 30, 3, 'Hệ quản trị cơ sở dữ liệu', 4, 2),
(1000040, 2550000, 'TU_CHON', 1000014, 1, 45, 0, 3, 'Tương tác người máy', 4, 2),
(1000041, 2550000, 'TU_CHON', 0, 1, 30, 30, 3, 'Thương mại điện tử', 4, 2),
(1000042, 3400000, 'TU_CHON', 1000005, 2, 45, 30, 4, 'Lập trình hướng sự kiện với công nghệ Java', 4, 2),
(1000043, 3400000, 'TU_CHON', 1000005, 2, 45, 30, 4, 'Lập Trình Hướng Sự Kiện với Công Nghệ .NET', 4, 2),
(1000044, 3400000, 'TU_CHON', 1000005, 2, 45, 30, 4, 'Lập trình GUI với Qt Framework', 4, 2),
(1000045, 2550000, 'TU_CHON', 0, 3, 45, 0, 3, 'Quản trị học', 4, 2),
(1000046, 2550000, 'TU_CHON', 0, 3, 45, 0, 3, 'Kỹ năng xây dựng kế hoạch', 4, 2),
(1000047, 2550000, 'TU_CHON', 0, 3, 45, 0, 3, 'Giao tiếp kinh doanh', 4, 2),
(1000048, 2550000, 'TU_CHON', 0, 3, 45, 0, 3, 'Quản trị doanh nghiệp', 4, 2),
(1000049, 2550000, 'TU_CHON', 0, 3, 45, 0, 3, 'Kế toán cơ bản', 4, 2),
(1000050, 2550000, 'TU_CHON', 0, 3, 45, 0, 3, 'Môi trường và con người', 4, 2),
(1000051, 2550000, 'BAT_BUOC', 1000033, 0, 45, 0, 3, 'Anh văn 4', 5, 2),
(1000052, 2550000, 'BAT_BUOC', 1000014, 0, 45, 0, 3, 'Nhập môn an toàn thông tin', 5, 2),
(1000053, 2550000, 'BAT_BUOC', 1000026, 0, 45, 0, 3, 'Công nghệ phần mềm', 5, 2),
(1000054, 2550000, 'BAT_BUOC', 0, 0, 45, 0, 3, 'Những vấn đề xã hội và đạo đức nghề nghiệp', 5, 2),
(1000055, 2550000, 'BAT_BUOC', 0, 0, 30, 30, 3, 'Phát triển ứng dụng', 5, 2),
(1000056, 2550000, 'TU_CHON', 1000042, 1, 30, 30, 3, 'Lập trình phân tán với công nghệ Java', 5, 2),
(1000057, 2550000, 'TU_CHON', 1000043, 1, 30, 30, 3, 'Lập trình Phân Tán Công Nghệ .NET', 5, 2),
(1000058, 2550000, 'TU_CHON', 1000044, 1, 30, 30, 3, 'Lập trình mạng với Qt Framework', 5, 2),
(1000059, 2550000, 'TU_CHON', 1000009, 2, 30, 30, 3, 'Lập trình phân tích dữ liệu 1', 5, 2),
(1000060, 2550000, 'TU_CHON', 1000024, 2, 30, 30, 3, 'Khai thác dữ liệu và ứng dụng', 5, 2),
(1000061, 2550000, 'TU_CHON', 0, 2, 30, 30, 3, 'Kỹ thuật điện tử', 5, 2),
(1000062, 3400000, 'BAT_BUOC', 0, 0, 45, 30, 4, 'Lập trình thiết bị di động', 6, 2),
(1000063, 1700000, 'BAT_BUOC', 0, 0, 30, 0, 2, 'Pháp luật đại cương', 6, 2),
(1000064, 2550000, 'BAT_BUOC', 1000053, 0, 30, 30, 3, 'Đảm bảo chất lượng và Kiểm thử phần mềm', 6, 2),
(1000065, 1700000, 'BAT_BUOC', 0, 0, 30, 0, 2, 'Chủ nghĩa xã hội khoa học', 6, 2),
(1000066, 3400000, 'TU_CHON', 1000035, 1, 45, 30, 4, 'Lập trình WWW (Java)', 6, 2),
(1000067, 3400000, 'TU_CHON', 0, 1, 30, 60, 4, 'Lập trình IoTs', 6, 2),
(1000068, 3400000, 'TU_CHON', 1000035, 1, 45, 30, 4, 'Lập trình WWW (.NET)', 6, 2),
(1000069, 3400000, 'TU_CHON', 1000058, 1, 45, 30, 4, 'Phát triển ứng dụng Web với Qt Engine', 6, 2),
(1000070, 1700000, 'BAT_BUOC', 0, 0, 30, 0, 2, 'Tư tưởng Hồ Chí Minh', 7, 2),
(1000071, 1700000, 'BAT_BUOC', 1000037, 0, 30, 0, 2, 'Kiến trúc và Thiết kế phần mềm', 7, 2),
(1000072, 2550000, 'BAT_BUOC', 0, 0, 30, 30, 3, 'Công nghệ mới trong phát triển ứng dụng CNTT', 7, 2),
(1000073, 2550000, 'TU_CHON', 1000034, 1, 45, 0, 3, 'Automat & ngôn ngữ hình thức', 7, 2),
(1000074, 2550000, 'TU_CHON', 0, 1, 30, 30, 3, 'Tiếp thị điện tử', 7, 2),
(1000075, 2550000, 'TU_CHON', 1000038, 1, 30, 30, 3, 'Lập trình phân tích dữ liệu 2', 7, 2),
(1000076, 2550000, 'TU_CHON', 1000024, 1, 30, 30, 3, 'Nhập môn dữ liệu lớn', 7, 2),
(1000077, 2550000, 'TU_CHON', 1000062, 1, 30, 30, 3, 'Lập trình thiết bị di động nâng cao', 7, 2),
(1000078, 2550000, 'TU_CHON', 0, 1, 30, 30, 3, 'Quản lý dự án CNTT', 7, 2),
(1000079, 2550000, 'TU_CHON', 0, 1, 30, 30, 3, 'Kiến trúc hướng dịch vụ và Điện toán đám mây', 7, 2),
(1000080, 850000, 'SUPER_BAT_BUOC', 0, 0, 0, 0, 1, 'Chứng chỉ TOEIC 450', 8, 2),
(1000081, 4250000, 'BAT_BUOC', 0, 0, 0, 150, 5, 'Thực tập doanh nghiệp', 8, 2),
(1000082, 4250000, 'BAT_BUOC', 0, 0, 0, 150, 5, 'Khóa luận tốt nghiệp', 8, 2);

-- --------------------------------------------------------

--
-- Table structure for table `nganh`
--

CREATE TABLE `nganh` (
  `ma_nganh` bigint(20) NOT NULL,
  `ten_nganh` varchar(255) DEFAULT NULL,
  `ma_khoa` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nganh`
--

INSERT INTO `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`) VALUES
(1, 'Công nghệ thông tin', 1),
(2, 'Kỹ thuật phần mềm', 1),
(3, 'Khoa học máy tính', 1),
(4, 'Công nghệ kỹ thuật cơ khí', 2),
(5, 'Công nghệ Chế tạo máy', 2),
(6, 'Kỹ thuật điện', 3),
(7, 'Điều khiển tự động', 3),
(8, 'Công nghệ kỹ thuật điện tử', 4),
(9, 'Năng lượng tái tạo', 4),
(10, 'Điện tử công nghiệp', 4),
(11, 'Công nghệ kỹ thuật ô tô', 5),
(12, 'Công nghệ Kỹ thuật nhiệt', 6),
(13, 'Công nghệ May', 7),
(14, 'Thiết kế thời trang', 7),
(15, 'Công nghệ Hữu cơ', 8),
(16, 'Công nghệ Vô cơ-Vật liệu', 8),
(17, 'Công nghệ Hóa dầu', 8),
(18, 'Kỹ thuật Hóa phân tích', 8),
(19, 'Kế toán', 9),
(20, 'Kiểm toán', 9),
(21, 'Khoa học dữ liệu', 10),
(22, 'Lý luận chính trị', 11),
(23, 'Ngôn Ngữ Anh', 12),
(24, 'Quản trị kinh doanh', 13),
(25, 'Quản trị cung ứng và logistic', 13),
(26, 'Quản trị nhân sự', 13),
(27, 'Quản trị marketing', 13),
(28, 'Tài chính – Ngân hàng', 14),
(29, 'Tài chính doanh nghiệp', 14),
(30, 'Kinh doanh quốc tế', 15),
(31, 'Thương mại điện tử', 15),
(32, 'Quản trị dịch vụ du lịch và lữ hành', 15),
(33, 'Quản trị khách sạn', 15),
(34, 'Quản trị nhà hàng và dịch vụ ăn uống', 15),
(35, 'Kỹ thuật xây dựng', 16),
(36, 'Kỹ thuật xây dựng công trình giao thông', 16),
(37, 'Luật kinh tế', 17),
(38, 'Luật quốc tế', 17);

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

-- --------------------------------------------------------

--
-- Table structure for table `permission`
--

CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL,
  `permission` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `permission`
--

INSERT INTO `permission` (`id`, `permission`) VALUES
(1, 'member.read'),
(2, 'member.write'),
(3, '*'),
(4, 'employee.read'),
(5, 'employee.write'),
(6, 'teacher.read'),
(7, 'teacher.write');

-- --------------------------------------------------------

--
-- Table structure for table `phieu_thu`
--

CREATE TABLE `phieu_thu` (
  `ma_phieu_thu` bigint(20) NOT NULL,
  `don_vi_thu` varchar(255) DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `ngay_thu` date DEFAULT NULL,
  `so_tien` double NOT NULL,
  `trang_thai` varchar(255) DEFAULT NULL,
  `ma_sinh_vien` bigint(20) NOT NULL,
  `ma_giao_dich` varchar(255) DEFAULT NULL,
  `loai_phieu_thu` varchar(255) NOT NULL DEFAULT 'OUT' COMMENT 'IN: là nạp vào ví. OUT: là thanh toán học phí'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `phieu_thu`
--

INSERT INTO `phieu_thu` (`ma_phieu_thu`, `don_vi_thu`, `ghi_chu`, `ngay_thu`, `so_tien`, `trang_thai`, `ma_sinh_vien`, `ma_giao_dich`, `loai_phieu_thu`) VALUES
(1, 'Ngân hàng Agribank', 'Giao dich truc tiep tai QGD GoVap', '2023-02-04', 15300000, 'DANG_CHO_XU_LY', 1, 'znUfmIVh', 'OUT'),
(2, 'PAYPAL - WALLET', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 0 ₫', '2023-03-05', 4250000, 'DA_XU_LY', 1, 'NSvb1geq', 'OUT'),
(15, 'SỐ DƯ VÍ', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 12.450.000 ₫. Số tiến đã thanh toán thành công: 850.000 ₫. Số tiền thanh toán dư còn lại: 11.600.000 ₫', '2023-03-25', 850000, 'DA_XU_LY', 1, 'km1wA95q', 'IN'),
(16, '\'PAYPAL - WALLET\'', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 50.000 ₫. Số tiến đã thanh toán thành công: 50.000 ₫. Số tiền dư thanh toán còn lại: 11.650.000 ₫', '2023-03-26', 50000, 'DA_XU_LY', 1, 'EperQQpK', 'IN'),
(17, '\'PAYPAL - WALLET\'', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 50.000 ₫. Số tiến đã thanh toán thành công: 50.000 ₫. Số tiền dư thanh toán còn lại: 11.700.000 ₫', '2023-03-26', 50000, 'DA_XU_LY', 1, 'tAPsTH0j', 'IN'),
(18, '\'PAYPAL - WALLET\'', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 50.000 ₫. Số tiến đã thanh toán thành công: 50.000 ₫. Số tiền dư thanh toán còn lại: 11.750.000 ₫', '2023-03-26', 50000, 'DA_XU_LY', 1, '1b8M39Ap', 'IN'),
(19, '\'PAYPAL - WALLET\'', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 500.000 ₫. Số tiến đã thanh toán thành công: 500.000 ₫. Số tiền dư thanh toán còn lại: 12.250.000 ₫', '2023-03-28', 500000, 'DA_XU_LY', 1, 'vxx5lT26', 'IN'),
(20, NULL, 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.226.550 ₫', '2023-04-01', 23450, 'DA_XU_LY', 1, 'ZlUaDWXP', 'OUT'),
(21, NULL, 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.203.100 ₫', '2023-04-01', 23450, 'DA_XU_LY', 1, 'iBy5Bftn', 'OUT'),
(22, NULL, 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.179.650 ₫', '2023-04-02', 23450, 'DA_XU_LY', 1, 'Vd3jiQPP', 'OUT'),
(23, NULL, 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.156.200 ₫', '2023-04-02', 23450, 'DA_XU_LY', 1, 'lMFP434j', 'OUT'),
(24, NULL, 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.132.750 ₫', '2023-04-02', 23450, 'DA_XU_LY', 1, 'NE2ZMJX6', 'OUT'),
(25, 'PAYPAL - WALLET', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.156.200 ₫', '2023-04-02', 23450, 'DA_XU_LY', 1, '0tYr3oi3', 'IN'),
(26, 'PAYPAL - WALLET', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.179.650 ₫', '2023-04-02', 23450, 'DA_XU_LY', 1, '0tYr3oi3', 'IN'),
(27, 'PAYPAL - WALLET', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.203.100 ₫', '2023-04-02', 23450, 'DA_XU_LY', 1, '0tYr3oi3', 'IN'),
(28, 'PAYPAL - WALLET', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.226.550 ₫', '2023-04-02', 23450, 'DA_XU_LY', 1, '0tYr3oi3', 'IN'),
(29, 'STUDENT - WALLET', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 28.760.550 ₫', '2023-04-09', 4250000, 'DA_XU_LY', 1, 'Gr48LnkU', 'OUT'),
(30, 'STUDENT - WALLET', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 24.510.550 ₫', '2023-04-09', 4250000, 'DA_XU_LY', 1, 'LJNLEdnM', 'OUT'),
(31, 'PAYPAL - WALLET', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 49.949 ₫. Số tiến đã thanh toán thành công: 49.949 ₫. Số tiền dư thanh toán còn lại: 24.560.499 ₫', '2023-04-15', 49948.5, 'DA_XU_LY', 1, 'E8ohiFLJ', 'IN'),
(32, 'PAYPAL - WALLET', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 49.949 ₫. Số tiến đã thanh toán thành công: 49.949 ₫. Số tiền dư thanh toán còn lại: 24.610.447 ₫', '2023-04-15', 49948.5, 'DA_XU_LY', 1, 'G4Ib1daZ', 'IN');

-- --------------------------------------------------------

--
-- Table structure for table `role`
--

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'MEMBER'),
(2, 'ADMIN'),
(3, 'EMPLOYEE'),
(4, 'TEACHER');

-- --------------------------------------------------------

--
-- Table structure for table `role_permission_map`
--

CREATE TABLE `role_permission_map` (
  `id_role` bigint(20) NOT NULL,
  `id_permission` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `role_permission_map`
--

INSERT INTO `role_permission_map` (`id_role`, `id_permission`) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 4),
(3, 5),
(4, 6),
(4, 7);

-- --------------------------------------------------------

--
-- Table structure for table `sinh_vien`
--

CREATE TABLE `sinh_vien` (
  `ma_sinh_vien` bigint(20) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `cccd` varchar(255) DEFAULT NULL,
  `bac_dao_tao` varchar(255) DEFAULT NULL,
  `co_so` varchar(255) DEFAULT NULL,
  `loai_hinh_dao_tao` varchar(255) DEFAULT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `gioi_tinh` varchar(255) DEFAULT NULL,
  `ho_ten` varchar(255) DEFAULT NULL,
  `ngay_sinh` date DEFAULT NULL,
  `ngay_vao_truong` date DEFAULT NULL,
  `noi_sinh` varchar(255) DEFAULT NULL,
  `sdt` varchar(255) DEFAULT NULL,
  `so_du` double NOT NULL,
  `tot_nghiep` bit(1) NOT NULL,
  `ma_lop_danh_nghia` bigint(20) NOT NULL,
  `ma_tai_khoan` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sinh_vien`
--

INSERT INTO `sinh_vien` (`ma_sinh_vien`, `avatar`, `cccd`, `bac_dao_tao`, `co_so`, `loai_hinh_dao_tao`, `dia_chi`, `gioi_tinh`, `ho_ten`, `ngay_sinh`, `ngay_vao_truong`, `noi_sinh`, `sdt`, `so_du`, `tot_nghiep`, `ma_lop_danh_nghia`, `ma_tai_khoan`) VALUES
(1, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg', '079201030774', 'DAI_HOC', 'HA_NOI', 'CHAT_LUONG_CAO', '60/122 KP8 Phường TCH Quận 12 HCM', 'NAM', 'Học Sinh A', '2020-01-01', '2019-01-01', 'HỒ CHÍ MINH', '0338188506', 24610447, b'0', 1, 4),
(2, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg', '079201030774', 'DAI_HOC', 'HA_NOI', 'CHAT_LUONG_CAO', '60/122 KP8 Phường TCH Quận 12 HCM', 'NAM', 'Học Sinh B', '2020-01-01', '2019-01-01', 'HỒ CHÍ MINH', '0338188506', 24610447, b'0', 1, 5),
(3, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg', '079201030774', 'DAI_HOC', 'HA_NOI', 'CHAT_LUONG_CAO', '60/122 KP8 Phường TCH Quận 12 HCM', 'NAM', 'Học Sinh C', '2020-01-01', '2019-01-01', 'HỒ CHÍ MINH', '0338188506', 24610447, b'0', 1, 6),
(4, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg', '079201030774', 'DAI_HOC', 'HA_NOI', 'CHAT_LUONG_CAO', '60/122 KP8 Phường TCH Quận 12 HCM', 'NAM', 'Học Sinh D', '2020-01-01', '2019-01-01', 'HỒ CHÍ MINH', '0338188506', 24610447, b'0', 1, 7),
(5, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg', '079201030774', 'DAI_HOC', 'HA_NOI', 'CHAT_LUONG_CAO', '60/122 KP8 Phường TCH Quận 12 HCM', 'NAM', 'Học Sinh E', '2020-01-01', '2019-01-01', 'HỒ CHÍ MINH', '0338188506', 24610447, b'0', 1, 8),
(6, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg', '079201030774', 'DAI_HOC', 'HA_NOI', 'CHAT_LUONG_CAO', '60/122 KP8 Phường TCH Quận 12 HCM', 'NAM', 'Học Sinh F', '2020-01-01', '2019-01-01', 'HỒ CHÍ MINH', '0338188506', 24610447, b'0', 1, 9),
(7, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg', '079201030774', 'DAI_HOC', 'HA_NOI', 'CHAT_LUONG_CAO', '60/122 KP8 Phường TCH Quận 12 HCM', 'NAM', 'Học Sinh G', '2020-01-01', '2019-01-01', 'HỒ CHÍ MINH', '0338188506', 24610447, b'0', 1, 10),
(8, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg', '079201030774', 'DAI_HOC', 'HA_NOI', 'CHAT_LUONG_CAO', '60/122 KP8 Phường TCH Quận 12 HCM', 'NAM', 'Học Sinh H', '2020-01-01', '2019-01-01', 'HỒ CHÍ MINH', '0338188506', 24610447, b'0', 1, 11),
(9, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg', '079201030774', 'DAI_HOC', 'HA_NOI', 'CHAT_LUONG_CAO', '60/122 KP8 Phường TCH Quận 12 HCM', 'NAM', 'Học Sinh I', '2020-01-01', '2019-01-01', 'HỒ CHÍ MINH', '0338188506', 24610447, b'0', 1, 12),
(10, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg', '079201030774', 'DAI_HOC', 'HA_NOI', 'CHAT_LUONG_CAO', '60/122 KP8 Phường TCH Quận 12 HCM', 'NAM', 'Học Sinh J', '2020-01-01', '2019-01-01', 'HỒ CHÍ MINH', '0338188506', 24610447, b'0', 1, 13),
(11, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg', '079201030774', 'DAI_HOC', 'HA_NOI', 'CHAT_LUONG_CAO', '60/122 KP8 Phường TCH Quận 12 HCM', 'NAM', 'Học Sinh K', '2020-01-01', '2019-01-01', 'HỒ CHÍ MINH', '0338188506', 24610447, b'0', 1, 14);

-- --------------------------------------------------------

--
-- Table structure for table `sinh_vien_lop_hoc_phan`
--

CREATE TABLE `sinh_vien_lop_hoc_phan` (
  `id` bigint(20) NOT NULL,
  `da_thu_hoc_phi` bit(1) NOT NULL,
  `ngay_dang_ky` date DEFAULT NULL,
  `ma_lop_hoc_phan` bigint(20) NOT NULL COMMENT 'Field có này được dùng cho hàm lọc lớp học phần trùng lịch',
  `ma_sinh_vien` bigint(20) NOT NULL,
  `ma_thoi_khoa_bieu` bigint(20) NOT NULL,
  `ma_thoi_khoa_bieu_con` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sinh_vien_lop_hoc_phan`
--

INSERT INTO `sinh_vien_lop_hoc_phan` (`id`, `da_thu_hoc_phi`, `ngay_dang_ky`, `ma_lop_hoc_phan`, `ma_sinh_vien`, `ma_thoi_khoa_bieu`, `ma_thoi_khoa_bieu_con`) VALUES
(3, b'1', '2023-03-12', 2, 1, 6, 4),
(7, b'1', '2023-03-12', 1, 1, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tai_khoan`
--

CREATE TABLE `tai_khoan` (
  `id` bigint(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `id_user` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tai_khoan`
--

INSERT INTO `tai_khoan` (`id`, `email`, `type`, `id_user`) VALUES
(1, NULL, 'GIAO_VIEN', 1),
(2, NULL, 'NHAN_VIEN', 2),
(3, 'taiproduaxe@gmail.com', 'ADMIN', 3),
(4, 'taiproduaxe@gmail.com', 'SINH_VIEN', 4),
(5, 'nhito1odraemon@gmail.com', 'SINH_VIEN', 5),
(6, 'phantanduy1234567@gmail.com', 'SINH_VIEN', 6),
(7, 'phantantri1234567@gmail.com', 'SINH_VIEN', 7),
(8, 'nguyenvan8@gmail.com', 'SINH_VIEN', 8),
(9, 'nguyenvan9@gmail.com', 'SINH_VIEN', 9),
(10, 'nguyenvan10@gmail.com', 'SINH_VIEN', 10),
(11, 'nguyenvan11@gmail.com', 'SINH_VIEN', 11),
(12, 'nguyenvan12@gmail.com', 'SINH_VIEN', 12),
(13, 'nguyenvan13@gmail.com', 'SINH_VIEN', 13),
(14, 'nguyenvan14@gmail.com', 'SINH_VIEN', 14);

-- --------------------------------------------------------

--
-- Table structure for table `thanh_toan_giao_dich`
--

CREATE TABLE `thanh_toan_giao_dich` (
  `ma_giao_dich` varchar(255) NOT NULL,
  `balance` double NOT NULL,
  `expired_time` datetime DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `status` bit(1) NOT NULL,
  `un_debt_ids` varchar(255) DEFAULT NULL,
  `ma_sinh_vien` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `thanh_toan_giao_dich`
--

INSERT INTO `thanh_toan_giao_dich` (`ma_giao_dich`, `balance`, `expired_time`, `ghi_chu`, `status`, `un_debt_ids`, `ma_sinh_vien`) VALUES
('02Ywivl5', 256000000, '2023-03-25 22:40:02', '', b'0', 'Array', 1),
('0aKjahwP', 256000000, '2023-03-25 22:39:50', '', b'0', 'Array', 1),
('0blvHhlX', 0, '2023-04-09 00:22:27', '', b'0', '1', 1),
('0dq4zfIB', 200000, '2023-03-26 14:49:45', '', b'0', 'Array', 1),
('0e0Y9F7P', 0, '2023-04-15 11:56:54', '', b'0', 'Array', 1),
('0tYr3oi3', 23450, '2023-04-09 09:50:51', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.226.550 ₫', b'0', 'Array', 1),
('15CyF2xg', 500000, '2023-03-26 14:35:34', '', b'0', 'Array', 1),
('1b8M39Ap', 50000, '2023-03-26 15:33:07', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 50.000 ₫. Số tiến đã thanh toán thành công: 50.000 ₫. Số tiền dư thanh toán còn lại: 11.750.000 ₫', b'1', 'Array', 1),
('1OhJJLU4', 4250000, '2023-03-05 10:26:16', '', b'0', '1', 1),
('3CGkOmkK', 850000, '2023-03-26 11:29:29', '', b'0', '27', 1),
('3KPwstnm', 0, '2023-04-01 22:39:19', '', b'0', 'Array', 1),
('5vjRPFPX', 500000, '2023-03-26 10:39:53', '', b'0', 'Array', 1),
('6mnpFmW4', 0, '2023-04-15 11:54:13', '', b'0', 'Array', 1),
('8vN6Bbut', 50000, '2023-03-26 10:35:19', '', b'0', 'Array', 1),
('9AfwpN22', 0, '2023-04-01 23:13:05', '', b'0', 'Array', 1),
('9D4HGJd4', 0, '2023-04-09 00:27:45', '', b'0', '1', 1),
('AoAK8Stw', 0, '2023-04-09 10:14:21', '', b'0', 'Array', 1),
('av1GhOOD', 0, '2023-04-09 00:24:53', '', b'0', '1', 1),
('awHwoGtw', 0, '2023-04-09 00:28:19', '', b'0', '1', 1),
('BuLE6Bb7', 200000, '2023-03-26 15:03:14', '', b'0', 'Array', 1),
('C15BLpfB', 0, '2023-04-02 09:01:09', '', b'0', 'Array', 1),
('CJLBPhmE', 0, '2023-04-01 22:40:29', '', b'0', 'Array', 1),
('cLaqkt63', 850000, '2023-03-26 11:29:00', '', b'0', '27', 1),
('CxY5zLco', 0, '2023-04-01 23:12:11', '', b'0', 'Array', 1),
('D82nKueS', 0, '2023-04-01 23:14:12', '', b'0', 'Array', 1),
('dE16BWRh', 0, '2023-04-01 23:17:55', '', b'0', 'Array', 1),
('drp4t0F1', 200000, '2023-03-26 14:55:33', '', b'0', 'Array', 1),
('e1Lbdd47', 0, '2023-04-02 08:22:26', '', b'0', 'Array', 1),
('E8ohiFLJ', 49948.5, '2023-04-15 11:57:38', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 49.949 ₫. Số tiến đã thanh toán thành công: 49.949 ₫. Số tiền dư thanh toán còn lại: 24.560.499 ₫', b'1', 'Array', 1),
('EagoJ5P4', 0, '2023-04-01 22:46:44', '', b'0', 'Array', 1),
('EperQQpK', 50000, '2023-03-26 15:26:19', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 50.000 ₫. Số tiến đã thanh toán thành công: 50.000 ₫. Số tiền dư thanh toán còn lại: 11.650.000 ₫', b'1', 'Array', 1),
('ERQIzVaL', 0, '2023-04-01 22:45:59', '', b'0', 'Array', 1),
('EUBEPyVa', 0, '2023-04-09 00:26:26', '', b'0', '1', 1),
('EyvoHogQ', 0, '2023-04-01 22:53:20', '', b'0', 'Array', 1),
('fOVX7FvY', 200000, '2023-03-26 14:46:54', '', b'0', 'Array', 1),
('FTwnc5P6', 200000, '2023-03-26 15:01:46', '', b'0', 'Array', 1),
('G4Ib1daZ', 49948.5, '2023-04-15 12:11:19', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 49.949 ₫. Số tiến đã thanh toán thành công: 49.949 ₫. Số tiền dư thanh toán còn lại: 24.610.447 ₫', b'1', 'Array', 1),
('GH8ZhWvp', 200000, '2023-03-26 14:51:30', '', b'0', 'Array', 1),
('gIv6uBEf', 200000, '2023-03-26 14:59:55', '', b'0', 'Array', 1),
('gPeE4gW9', 500000, '2023-04-02 19:25:34', '', b'0', 'Array', 1),
('Gr48LnkU', 4250000, '2023-04-09 00:30:03', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 28.760.550 ₫', b'1', '1', 1),
('gvfNJcFe', 0, '2023-04-01 22:37:15', '', b'0', 'Array', 1),
('gvmbq2io', 200000, '2023-03-26 14:55:41', '', b'0', 'Array', 1),
('Hh5M8VN2', 0, '2023-04-01 22:44:24', '', b'0', 'Array', 1),
('HN01CROR', 200000, '2023-03-26 15:05:04', '', b'0', 'Array', 1),
('Hx51pu1P', 0, '2023-04-01 23:00:48', '', b'0', 'Array', 1),
('i76NDGgL', 25600000, '2023-03-25 22:36:58', '', b'0', 'Array', 1),
('iBy5Bftn', 23450, '2023-04-01 23:56:38', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.203.100 ₫', b'1', '1', 1),
('isI22gPX', 0, '2023-04-09 10:15:08', '', b'0', '1', 1),
('JnqTQg3F', 0, '2023-04-01 23:52:30', '', b'0', 'Array', 1),
('KFCQV4KF', 0, '2023-04-01 23:49:44', '', b'0', 'Array', 1),
('ki6qZsJG', 0, '2023-04-09 00:23:37', '', b'0', '1', 1),
('km1wA95q', 850000, '2023-03-25 12:13:33', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 12.450.000 ₫. Số tiến đã thanh toán thành công: 850.000 ₫. Số tiền thanh toán dư còn lại: 11.600.000 ₫', b'1', '26', 1),
('KP2np9BE', 0, '2023-04-01 22:57:01', '', b'0', 'Array', 1),
('kxnmPorw', 200000, '2023-03-26 14:51:02', '', b'0', 'Array', 1),
('lASxcHYr', 200000, '2023-03-26 14:59:43', '', b'0', 'Array', 1),
('lgSpoWuG', 500000, '2023-03-26 11:24:13', '', b'0', 'Array', 1),
('LJNLEdnM', 4250000, '2023-04-09 00:20:48', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 24.510.550 ₫', b'1', '1', 1),
('LKVPGDf8', 0, '2023-04-02 09:02:00', '', b'0', 'Array', 1),
('llCknOhp', 0, '2023-04-09 10:02:52', '', b'0', 'Array', 1),
('llrmg44i', 200000, '2023-03-26 14:53:35', '', b'0', 'Array', 1),
('lmClucMq', 0, '2023-04-01 23:44:34', '', b'0', 'Array', 1),
('lMFP434j', 23450, '2023-04-02 09:07:36', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.156.200 ₫', b'1', '1', 1),
('lmQV9rYv', 256000000, '2023-03-25 22:39:23', '', b'0', 'Array', 1),
('LxguS2V5', 500000, '2023-04-09 17:29:06', '', b'0', 'Array', 1),
('NE2ZMJX6', 23450, '2023-04-02 09:08:57', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.132.750 ₫', b'1', '1', 1),
('NSvb1geq', 4250000, '2023-03-05 10:37:37', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 0 ₫', b'1', '1', 1),
('nZE4mzti', 0, '2023-04-01 22:42:00', '', b'0', 'Array', 1),
('o1YXk30b', 500000, '2023-03-25 21:29:45', '', b'0', 'Array', 1),
('OR34ZN8T', 200000, '2023-03-26 14:58:14', '', b'0', 'Array', 1),
('Oz03fdmB', 200000, '2023-03-26 14:58:53', '', b'0', 'Array', 1),
('PQNZicK1', 0, '2023-04-15 11:55:55', '', b'0', 'Array', 1),
('pS1yg8O1', 2566000000, '2023-03-25 22:40:27', '', b'0', 'Array', 1),
('QdCJYh5z', 50000, '2023-03-26 10:39:36', '', b'0', 'Array', 1),
('qlwqELku', 850000, '2023-03-26 10:53:56', '', b'0', '27', 1),
('qSaAkSQR', 0, '2023-04-15 11:46:11', '', b'0', 'Array', 1),
('QxwszJyV', 850000, '2023-03-26 14:23:13', '', b'0', '27', 1),
('RtOWV9in', 200000, '2023-03-26 14:50:56', '', b'0', 'Array', 1),
('S2uEPytI', 256000000, '2023-03-25 22:39:39', '', b'0', 'Array', 1),
('SAFFSisu', 200000, '2023-03-26 14:48:55', '', b'0', '1,2', 1),
('siPt4mjt', 0, '2023-04-09 00:23:27', '', b'0', '1', 1),
('SydUIMie', 0, '2023-04-01 22:47:30', '', b'0', 'Array', 1),
('sYps8YDf', 0, '2023-04-01 22:42:39', '', b'0', 'Array', 1),
('tAPsTH0j', 50000, '2023-03-26 15:30:17', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 50.000 ₫. Số tiến đã thanh toán thành công: 50.000 ₫. Số tiền dư thanh toán còn lại: 11.700.000 ₫', b'1', 'Array', 1),
('Vd3jiQPP', 23450, '2023-04-02 08:22:44', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.179.650 ₫', b'1', '1', 1),
('vlFD3JjK', 0, '2023-04-01 23:17:52', '', b'0', 'Array', 1),
('vMYpOi63', 200000, '2023-03-26 14:54:22', '', b'0', 'Array', 1),
('VpL9Rr0D', 200000, '2023-03-26 14:58:25', '', b'0', 'Array', 1),
('vxx5lT26', 500000, '2023-03-28 20:48:08', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 500.000 ₫. Số tiến đã thanh toán thành công: 500.000 ₫. Số tiền dư thanh toán còn lại: 12.250.000 ₫', b'1', 'Array', 1),
('wEBTEe3d', 0, '2023-04-01 23:51:04', '', b'0', 'Array', 1),
('wKSn5ghV', 0, '2023-04-02 09:11:50', '', b'0', 'Array', 1),
('XDbv6DOj', 0, '2023-04-02 09:06:52', '', b'0', 'Array', 1),
('XjujA9Qt', 0, '2023-04-15 11:52:01', '', b'0', 'Array', 1),
('xXCUNm0a', 0, '2023-04-01 23:04:16', '', b'0', 'Array', 1),
('Y3Kmwt5X', 0, '2023-04-09 10:04:53', '', b'0', 'Array', 1),
('YeIUhK1I', 200000, '2023-03-26 14:54:11', '', b'0', 'Array', 1),
('zjDp1W3A', 256000000, '2023-03-25 22:40:13', '', b'0', 'Array', 1),
('ZlUaDWXP', 23450, '2023-04-01 23:55:39', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.226.550 ₫', b'1', '1', 1),
('znL5J7tk', 0, '2023-04-01 23:46:39', '', b'0', 'Array', 1),
('znUfmIVh', 1700000, '2023-02-04 09:56:48', '', b'0', NULL, 1),
('ZRczboRF', 4250000, '2023-04-09 00:29:14', 'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 33.010.550 ₫', b'1', '1', 1);

-- --------------------------------------------------------

--
-- Table structure for table `thoi_khoa_bieu`
--

CREATE TABLE `thoi_khoa_bieu` (
  `ma_thoi_khoa_bieu` bigint(20) NOT NULL,
  `den_tiet_hoc` varchar(255) DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `loai_buoi_hoc` varchar(255) DEFAULT NULL,
  `ngay_bat_dau` date DEFAULT NULL,
  `ngay_ket_thuc` date DEFAULT NULL,
  `nhom_hoc` int(11) NOT NULL,
  `phong_hoc` varchar(255) DEFAULT NULL,
  `thi` bit(1) NOT NULL,
  `thu_hoc` varchar(255) DEFAULT NULL,
  `tu_tiet_hoc` varchar(255) DEFAULT NULL,
  `ma_lop_hoc_phan` bigint(20) NOT NULL,
  `so_luong_da_dang_ky` int(11) NOT NULL,
  `ma_giao_vien` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `thoi_khoa_bieu`
--

INSERT INTO `thoi_khoa_bieu` (`ma_thoi_khoa_bieu`, `den_tiet_hoc`, `ghi_chu`, `loai_buoi_hoc`, `ngay_bat_dau`, `ngay_ket_thuc`, `nhom_hoc`, `phong_hoc`, `thi`, `thu_hoc`, `tu_tiet_hoc`, `ma_lop_hoc_phan`, `so_luong_da_dang_ky`, `ma_giao_vien`) VALUES
(1, 'T3', 'LÝ THUYẾT NHÓM 1', 'LT', '2023-02-12', '2023-03-31', 1, 'B1.01', b'0', 'T2', 'T1', 1, 1, 1),
(2, 'T6', 'LÝ THUYẾT NHÓM 2', 'LT', '2023-02-12', '2023-02-28', 2, 'B1.02', b'0', 'T2', 'T4', 1, 0, 1),
(6, 'T15', 'HỌc lý thuyet buooi dau nho di hoc day du nha cac em', 'LT', '2023-03-20', '2023-03-31', 0, 'A1.01', b'0', 'T2', 'T13', 2, 2, 1),
(7, 'T9', 'DI HOC LY THUYET NHO PHOTO DE CUONG NHA', 'LT', '2023-03-21', '2023-03-31', 0, 'V5.01', b'0', 'T2', 'T7', 3, 5, 1),
(8, 'T15', 'Thứ 2- T1-> T5. Dự đoán là lịch này sẽ trùng với nhiều lịch khác vì', 'LT', '2023-04-01', '2023-04-30', 0, 'V2.01', b'0', 'T3', 'T13', 4, 0, 1),
(9, 'T12', 'Lớp này dành cho DH12 T10-12 T5', 'LT', '2023-04-05', '2023-04-30', 0, 'V5.03', b'0', 'T5', 'T10', 6, 0, 1),
(10, 'T5', '', 'LT', '2023-04-25', '2023-04-30', 0, 'H6.02', b'0', 'T2', 'T1', 7, 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `thoi_khoa_bieu_con`
--

CREATE TABLE `thoi_khoa_bieu_con` (
  `ma_thoi_khoa_bieu_con` bigint(20) NOT NULL,
  `so_luong_da_dang_ky` int(11) NOT NULL,
  `ma_thoi_khoa_bieu` bigint(20) NOT NULL,
  `ma_giao_vien` bigint(20) NOT NULL,
  `den_tiet_hoc` varchar(255) DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `loai_buoi_hoc` varchar(255) DEFAULT NULL,
  `ngay_bat_dau` date DEFAULT NULL,
  `ngay_ket_thuc` date DEFAULT NULL,
  `nhom_hoc` int(11) NOT NULL,
  `phong_hoc` varchar(255) DEFAULT NULL,
  `thi` bit(1) NOT NULL,
  `thu_hoc` varchar(255) DEFAULT NULL,
  `tu_tiet_hoc` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `thoi_khoa_bieu_con`
--

INSERT INTO `thoi_khoa_bieu_con` (`ma_thoi_khoa_bieu_con`, `so_luong_da_dang_ky`, `ma_thoi_khoa_bieu`, `ma_giao_vien`, `den_tiet_hoc`, `ghi_chu`, `loai_buoi_hoc`, `ngay_bat_dau`, `ngay_ket_thuc`, `nhom_hoc`, `phong_hoc`, `thi`, `thu_hoc`, `tu_tiet_hoc`) VALUES
(1, 7, 1, 1, 'T3', 'HOC THUC HANH NHA CAC BAN NHO DEM LAPTOP', 'TH', '2023-02-12', '2023-02-28', 1, 'H6.01', b'0', 'T5', 'T1'),
(2, 0, 1, 1, 'T3', 'HOC THUC HANH CAC BAN NHOM 2 NHO DEM LAPTOP NHA', 'TH', '2023-02-12', '2023-02-28', 2, 'H6.02', b'0', 'T5', 'T1'),
(3, 0, 6, 1, 'T6', 'HOC THUC HANH NHA NHOM 1', 'TH', '2023-03-20', '2023-03-31', 1, 'H8.01', b'0', 'T3', 'T4'),
(4, 2, 6, 1, 'T15', 'NHO MANG LAPTOP NHA NHÓM 2', 'TH', '2023-02-20', '2023-03-31', 2, 'H8.02', b'0', 'T3', 'T13'),
(5, 0, 8, 1, 'T5', 'T1-5 CN HỌC THỰC HÀNH NHA CÁC EM NHỚ MANG THEO LAPTOP CÁ NHÂN!', 'TH', '2023-04-01', '2023-04-30', 0, 'H3.01 (Phòng H3 TH 1)', b'0', 'CN', 'T1'),
(6, 2, 9, 1, 'T5', 'T1-5 T7 HỌC THỰC HÀNH NHA CÁC EM NHỚ MANG THEO LAPTOP CÁ NHÂN!', 'TH', '2023-04-05', '2023-04-30', 1, 'H4.01 (Phòng H4 TH 1)', b'0', 'T7', 'T1'),
(7, 19, 9, 1, 'T5', 'T1-5 T6 N2 HỌC THỰC HÀNH NHA CÁC EM NHỚ MANG THEO LAPTOP CÁ NHÂN!', 'TH', '2023-04-05', '2023-04-30', 2, 'H4.01 (Phòng H4 TH 1)', b'0', 'T6', 'T1'),
(8, 0, 10, 1, 'T5', 'Nhóm 1 nha', 'TH', '2023-04-25', '2023-04-30', 1, 'H6.01 (Phòng TH 1)', b'0', 'T3', 'T1'),
(9, 0, 10, 1, 'T12', 'Nhóm 2 nha', 'TH', '2023-04-25', '2023-04-30', 2, 'H6.01 (Phòng TH 2)', b'0', 'T3', 'T7');

-- --------------------------------------------------------

--
-- Table structure for table `thong_bao`
--

CREATE TABLE `thong_bao` (
  `id` bigint(20) NOT NULL,
  `create_at` datetime DEFAULT NULL,
  `is_read` bit(1) NOT NULL,
  `linking` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `ma_sinh_vien` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `thong_bao`
--

INSERT INTO `thong_bao` (`id`, `create_at`, `is_read`, `linking`, `message`, `title`, `ma_sinh_vien`) VALUES
(1, NULL, b'0', 'aaa', 'aa', 'aaaa', 1);

-- --------------------------------------------------------

--
-- Table structure for table `thong_bao_khoa`
--

CREATE TABLE `thong_bao_khoa` (
  `ma_thong_bao` bigint(20) NOT NULL,
  `ngay_xuat_ban` date DEFAULT NULL,
  `noi_dung` text DEFAULT NULL,
  `tieu_de` varchar(255) DEFAULT NULL,
  `ma_khoa` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `thong_bao_khoa`
--

INSERT INTO `thong_bao_khoa` (`ma_thong_bao`, `ngay_xuat_ban`, `noi_dung`, `tieu_de`, `ma_khoa`) VALUES
(1, '2021-01-01', 'Gửi tới các em sinh viên hệ CLC / Đại trà. Cũng đã sắp đến tết cận kề, nhà nhà đã mang không khí nôn nao của lễ hội tết truyền thống. Nhằm mục đích hỗ trợ cho việc các sinh viên có thể bắt xe trở về quê ăn tết thuận tiện với gia đình tốt nhất. Nhà trường quyết định sẽ tổ chức các buổi học cận kề ngày nghĩ tết thành lịch học online (có thể). Một vài trường hợp môn học bắt buộc học offline như thực hành sẽ vẫn tiếp tục.', 'THÔNG BÁO LỊCH NGHĨ TẾT DƯƠNG LỊCH CHO TOÀN BỘ SINH VIÊN TRƯỜNG ĐẠI HỌC CÔNG NGHIỆP IV (IUH)', 1);

-- --------------------------------------------------------

--
-- Table structure for table `token`
--

CREATE TABLE `token` (
  `id` bigint(20) NOT NULL,
  `token` text DEFAULT NULL,
  `token_exp_date` datetime DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `token`
--

INSERT INTO `token` (`id`, `token`, `token_exp_date`, `created_by`) VALUES
(1, 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzdjEiLCJleHAiOjE2ODIzMjUyMDQsImlhdCI6MTY4MjMwNzIwNH0.xmSJHPSuB8UyrOpxbvZr8NrxbEmBoEtmcBcPeW4OqGOCdQmfWjq7d9I0coVd2XmlvS5ChaefcaFABnr62IBAUQ', '2023-02-04 14:46:52', 4),
(2, 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJndjEiLCJleHAiOjE2ODIyNzcwMzAsImlhdCI6MTY4MjI1OTAzMH0.dwqcEZG5ui-oNTdAiGkOR_ESkNMPDbDQ6AjuKS2DqwJOhR4OB22RfpeCg0ZmMJF8zr4qjqZLUHqzax5LkTcPzg', '2023-02-04 20:15:46', 1),
(3, 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJudjIiLCJleHAiOjE2ODIzMzA1MzYsImlhdCI6MTY4MjMxMjUzNn0.1qNpBaU36lnAXWrMt5lUPwnu9R8Fp52aXy1sm2Yy0aIRJQXsZ8tNcqh7mnNEOaFNAe7AtrkJclLANa8Xa0fBPA', '2023-02-05 01:08:03', 2),
(4, 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzYSIsImV4cCI6MTY4MTUwNTU5MCwiaWF0IjoxNjgxNDg3NTkwfQ.jalt9_rCs1v0vKueIzSjDviMNHbze3HvtL15AOJJxPNF0nFJ3gILyLS4JwoRN4BhTknWRNjAIaSaqfd8nSqvpg', '2023-04-15 03:53:10', 3);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `password`, `username`) VALUES
(1, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'gv1'),
(2, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'nv1'),
(3, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sa'),
(4, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sv1'),
(5, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sv2'),
(6, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sv3'),
(7, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sv4'),
(8, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sv5'),
(9, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sv6'),
(10, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sv7'),
(11, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sv8'),
(12, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sv9'),
(13, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sv10'),
(14, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sv11');

-- --------------------------------------------------------

--
-- Table structure for table `user_role_map`
--

CREATE TABLE `user_role_map` (
  `id_user` bigint(20) NOT NULL,
  `id_role` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_role_map`
--

INSERT INTO `user_role_map` (`id_user`, `id_role`) VALUES
(1, 4),
(2, 3),
(3, 2),
(4, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chuong_trinh_khung`
--
ALTER TABLE `chuong_trinh_khung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKg03funaw6lm3b5tsmkl24weei` (`ma_mon_hoc`),
  ADD KEY `FK3wm9ly0g4i8nn5dhn51ue1n0j` (`ma_sinh_vien`);

--
-- Indexes for table `cong_no`
--
ALTER TABLE `cong_no`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKkxl1i4597wqhq1lcsxe80k9pi` (`ma_lop_hoc_phan`),
  ADD KEY `FKqgvb2b1v3buwnf79biq25v41p` (`ma_mon_hoc`),
  ADD KEY `FKg8i8ji845ka67ejnoid4oqr2u` (`ma_sinh_vien`);

--
-- Indexes for table `diem`
--
ALTER TABLE `diem`
  ADD PRIMARY KEY (`ma_diem`),
  ADD KEY `FKa4mk5ny0xtsxf1vgaxo8g49yu` (`ma_lop_hoc_phan`),
  ADD KEY `FK8fjjyfymvjg93mbsth73q4r85` (`ma_sinh_vien`);

--
-- Indexes for table `giao_vien`
--
ALTER TABLE `giao_vien`
  ADD PRIMARY KEY (`ma_giao_vien`),
  ADD KEY `FKjpuvgu4m7k7qg5ry8enpiwla8` (`ma_tai_khoan`);

--
-- Indexes for table `hoc_ky`
--
ALTER TABLE `hoc_ky`
  ADD PRIMARY KEY (`ma_hoc_ky`),
  ADD KEY `FKrhv21in81gd0q877baj66o2jv` (`ma_nganh`);

--
-- Indexes for table `khoa`
--
ALTER TABLE `khoa`
  ADD PRIMARY KEY (`ma_khoa`);

--
-- Indexes for table `khoa_hoc`
--
ALTER TABLE `khoa_hoc`
  ADD PRIMARY KEY (`ma_khoa_hoc`),
  ADD KEY `FKeio267xmxe9dcrit7q7xxjno5` (`ma_hoc_ky`);

--
-- Indexes for table `lop_hoc_danh_nghia`
--
ALTER TABLE `lop_hoc_danh_nghia`
  ADD PRIMARY KEY (`ma_lop`),
  ADD KEY `FK4pvx3xu9tg0cebd4842x3va41` (`ma_giao_vien`),
  ADD KEY `FKig93cv30e8b0m5gidp8kw1n7k` (`ma_khoa_hoc`),
  ADD KEY `FKk1tyuwrp94i4hi8rg5trbecbn` (`ma_nganh`);

--
-- Indexes for table `lop_hoc_phan`
--
ALTER TABLE `lop_hoc_phan`
  ADD PRIMARY KEY (`ma_lop_hoc_phan`),
  ADD KEY `FK3ry1unxhxp6x73pthyt762uup` (`ma_giao_vien`),
  ADD KEY `FKk6be4r8ym9mph9tn7h3s209cn` (`ma_khoa_hoc`),
  ADD KEY `FKsin0ppsx8ftjbqkngy4ohy1pi` (`ma_mon_hoc`);

--
-- Indexes for table `mon_hoc`
--
ALTER TABLE `mon_hoc`
  ADD PRIMARY KEY (`ma_mon_hoc`),
  ADD KEY `FKi6b1jns4haog4p4nuqly59pid` (`ma_hoc_ky`),
  ADD KEY `FK3tdld0m297q7li7fqto6rm1u5` (`ma_nganh`);

--
-- Indexes for table `nganh`
--
ALTER TABLE `nganh`
  ADD PRIMARY KEY (`ma_nganh`),
  ADD KEY `FKeljm0njcqiwey0kgb6k487rk3` (`ma_khoa`);

--
-- Indexes for table `nhan_vien`
--
ALTER TABLE `nhan_vien`
  ADD PRIMARY KEY (`ma_nhan_vien`),
  ADD KEY `FKdpk3u6xuawsiksnkklx1pfeyw` (`ma_tai_khoan`);

--
-- Indexes for table `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `phieu_thu`
--
ALTER TABLE `phieu_thu`
  ADD PRIMARY KEY (`ma_phieu_thu`),
  ADD KEY `FKq5fea4js9jw4ndu38fdl8p35c` (`ma_sinh_vien`),
  ADD KEY `FK7toy90p9ejciwkoisey01vlhr` (`ma_giao_dich`);

--
-- Indexes for table `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `role_permission_map`
--
ALTER TABLE `role_permission_map`
  ADD PRIMARY KEY (`id_role`,`id_permission`),
  ADD UNIQUE KEY `UK_m1k6evof73n1rreqnn427d5v1` (`id_permission`);

--
-- Indexes for table `sinh_vien`
--
ALTER TABLE `sinh_vien`
  ADD PRIMARY KEY (`ma_sinh_vien`),
  ADD KEY `FKce2axufilntg2wuss16ioqrew` (`ma_lop_danh_nghia`),
  ADD KEY `FKql4r5wwkkx1ha86mdbrnokajj` (`ma_tai_khoan`);

--
-- Indexes for table `sinh_vien_lop_hoc_phan`
--
ALTER TABLE `sinh_vien_lop_hoc_phan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK6rrjsxx10j1lge1dskhcw92ad` (`ma_lop_hoc_phan`),
  ADD KEY `FKmd0chdv7c7i5bwqt0xxqcm8e` (`ma_sinh_vien`),
  ADD KEY `FK7dxegu5yiurf47k1yrgn5a8n2` (`ma_thoi_khoa_bieu`),
  ADD KEY `FKt446j3gsdfn36isyny7glolnm` (`ma_thoi_khoa_bieu_con`);

--
-- Indexes for table `tai_khoan`
--
ALTER TABLE `tai_khoan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKg9gtme1qx7benvoa9lrhef0ot` (`id_user`);

--
-- Indexes for table `thanh_toan_giao_dich`
--
ALTER TABLE `thanh_toan_giao_dich`
  ADD PRIMARY KEY (`ma_giao_dich`),
  ADD KEY `FKf5vbis6scdfd897fgftenakab` (`ma_sinh_vien`);

--
-- Indexes for table `thoi_khoa_bieu`
--
ALTER TABLE `thoi_khoa_bieu`
  ADD PRIMARY KEY (`ma_thoi_khoa_bieu`),
  ADD KEY `FKg4dn0u4fmgtqbncb33box445j` (`ma_lop_hoc_phan`),
  ADD KEY `FKutiwe9oyux8ww29coan5mu0t` (`ma_giao_vien`);

--
-- Indexes for table `thoi_khoa_bieu_con`
--
ALTER TABLE `thoi_khoa_bieu_con`
  ADD PRIMARY KEY (`ma_thoi_khoa_bieu_con`),
  ADD KEY `FKnpdt0cxyu9jimfw4ir2l2h1w4` (`ma_thoi_khoa_bieu`),
  ADD KEY `FKq9mk804kal4b8ur4g5yi2gtda` (`ma_giao_vien`);

--
-- Indexes for table `thong_bao`
--
ALTER TABLE `thong_bao`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKc9wew8egsdia4kif8ikm62g44` (`ma_sinh_vien`);

--
-- Indexes for table `thong_bao_khoa`
--
ALTER TABLE `thong_bao_khoa`
  ADD PRIMARY KEY (`ma_thong_bao`),
  ADD KEY `FKbqgh4gmlh31n757e70nnh6pww` (`ma_khoa`);

--
-- Indexes for table `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKq5g30l3l475dgnvd85fe254ln` (`created_by`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_role_map`
--
ALTER TABLE `user_role_map`
  ADD PRIMARY KEY (`id_user`,`id_role`),
  ADD KEY `FKj1ggj17aib8c49ppm5pxj42o7` (`id_role`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chuong_trinh_khung`
--
ALTER TABLE `chuong_trinh_khung`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `cong_no`
--
ALTER TABLE `cong_no`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `diem`
--
ALTER TABLE `diem`
  MODIFY `ma_diem` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `giao_vien`
--
ALTER TABLE `giao_vien`
  MODIFY `ma_giao_vien` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hoc_ky`
--
ALTER TABLE `hoc_ky`
  MODIFY `ma_hoc_ky` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `khoa`
--
ALTER TABLE `khoa`
  MODIFY `ma_khoa` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `khoa_hoc`
--
ALTER TABLE `khoa_hoc`
  MODIFY `ma_khoa_hoc` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=90;

--
-- AUTO_INCREMENT for table `lop_hoc_danh_nghia`
--
ALTER TABLE `lop_hoc_danh_nghia`
  MODIFY `ma_lop` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `lop_hoc_phan`
--
ALTER TABLE `lop_hoc_phan`
  MODIFY `ma_lop_hoc_phan` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `nganh`
--
ALTER TABLE `nganh`
  MODIFY `ma_nganh` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `nhan_vien`
--
ALTER TABLE `nhan_vien`
  MODIFY `ma_nhan_vien` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `permission`
--
ALTER TABLE `permission`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `phieu_thu`
--
ALTER TABLE `phieu_thu`
  MODIFY `ma_phieu_thu` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `role`
--
ALTER TABLE `role`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sinh_vien`
--
ALTER TABLE `sinh_vien`
  MODIFY `ma_sinh_vien` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `sinh_vien_lop_hoc_phan`
--
ALTER TABLE `sinh_vien_lop_hoc_phan`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `tai_khoan`
--
ALTER TABLE `tai_khoan`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `thoi_khoa_bieu`
--
ALTER TABLE `thoi_khoa_bieu`
  MODIFY `ma_thoi_khoa_bieu` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `thoi_khoa_bieu_con`
--
ALTER TABLE `thoi_khoa_bieu_con`
  MODIFY `ma_thoi_khoa_bieu_con` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `thong_bao`
--
ALTER TABLE `thong_bao`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `thong_bao_khoa`
--
ALTER TABLE `thong_bao_khoa`
  MODIFY `ma_thong_bao` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `token`
--
ALTER TABLE `token`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chuong_trinh_khung`
--
ALTER TABLE `chuong_trinh_khung`
  ADD CONSTRAINT `FK3wm9ly0g4i8nn5dhn51ue1n0j` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`),
  ADD CONSTRAINT `FKg03funaw6lm3b5tsmkl24weei` FOREIGN KEY (`ma_mon_hoc`) REFERENCES `mon_hoc` (`ma_mon_hoc`);

--
-- Constraints for table `cong_no`
--
ALTER TABLE `cong_no`
  ADD CONSTRAINT `FKg8i8ji845ka67ejnoid4oqr2u` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`),
  ADD CONSTRAINT `FKkxl1i4597wqhq1lcsxe80k9pi` FOREIGN KEY (`ma_lop_hoc_phan`) REFERENCES `lop_hoc_phan` (`ma_lop_hoc_phan`),
  ADD CONSTRAINT `FKqgvb2b1v3buwnf79biq25v41p` FOREIGN KEY (`ma_mon_hoc`) REFERENCES `mon_hoc` (`ma_mon_hoc`);

--
-- Constraints for table `diem`
--
ALTER TABLE `diem`
  ADD CONSTRAINT `FK8fjjyfymvjg93mbsth73q4r85` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`),
  ADD CONSTRAINT `FKa4mk5ny0xtsxf1vgaxo8g49yu` FOREIGN KEY (`ma_lop_hoc_phan`) REFERENCES `lop_hoc_phan` (`ma_lop_hoc_phan`);

--
-- Constraints for table `giao_vien`
--
ALTER TABLE `giao_vien`
  ADD CONSTRAINT `FKjpuvgu4m7k7qg5ry8enpiwla8` FOREIGN KEY (`ma_tai_khoan`) REFERENCES `tai_khoan` (`id`);

--
-- Constraints for table `hoc_ky`
--
ALTER TABLE `hoc_ky`
  ADD CONSTRAINT `FKrhv21in81gd0q877baj66o2jv` FOREIGN KEY (`ma_nganh`) REFERENCES `nganh` (`ma_nganh`);

--
-- Constraints for table `khoa_hoc`
--
ALTER TABLE `khoa_hoc`
  ADD CONSTRAINT `FKeio267xmxe9dcrit7q7xxjno5` FOREIGN KEY (`ma_hoc_ky`) REFERENCES `hoc_ky` (`ma_hoc_ky`);

--
-- Constraints for table `lop_hoc_danh_nghia`
--
ALTER TABLE `lop_hoc_danh_nghia`
  ADD CONSTRAINT `FK4pvx3xu9tg0cebd4842x3va41` FOREIGN KEY (`ma_giao_vien`) REFERENCES `giao_vien` (`ma_giao_vien`),
  ADD CONSTRAINT `FKig93cv30e8b0m5gidp8kw1n7k` FOREIGN KEY (`ma_khoa_hoc`) REFERENCES `khoa_hoc` (`ma_khoa_hoc`),
  ADD CONSTRAINT `FKk1tyuwrp94i4hi8rg5trbecbn` FOREIGN KEY (`ma_nganh`) REFERENCES `nganh` (`ma_nganh`);

--
-- Constraints for table `lop_hoc_phan`
--
ALTER TABLE `lop_hoc_phan`
  ADD CONSTRAINT `FK3ry1unxhxp6x73pthyt762uup` FOREIGN KEY (`ma_giao_vien`) REFERENCES `giao_vien` (`ma_giao_vien`),
  ADD CONSTRAINT `FKk6be4r8ym9mph9tn7h3s209cn` FOREIGN KEY (`ma_khoa_hoc`) REFERENCES `khoa_hoc` (`ma_khoa_hoc`),
  ADD CONSTRAINT `FKsin0ppsx8ftjbqkngy4ohy1pi` FOREIGN KEY (`ma_mon_hoc`) REFERENCES `mon_hoc` (`ma_mon_hoc`);

--
-- Constraints for table `mon_hoc`
--
ALTER TABLE `mon_hoc`
  ADD CONSTRAINT `FK3tdld0m297q7li7fqto6rm1u5` FOREIGN KEY (`ma_nganh`) REFERENCES `nganh` (`ma_nganh`),
  ADD CONSTRAINT `FKi6b1jns4haog4p4nuqly59pid` FOREIGN KEY (`ma_hoc_ky`) REFERENCES `hoc_ky` (`ma_hoc_ky`);

--
-- Constraints for table `nganh`
--
ALTER TABLE `nganh`
  ADD CONSTRAINT `FKeljm0njcqiwey0kgb6k487rk3` FOREIGN KEY (`ma_khoa`) REFERENCES `khoa` (`ma_khoa`);

--
-- Constraints for table `nhan_vien`
--
ALTER TABLE `nhan_vien`
  ADD CONSTRAINT `FKdpk3u6xuawsiksnkklx1pfeyw` FOREIGN KEY (`ma_tai_khoan`) REFERENCES `tai_khoan` (`id`);

--
-- Constraints for table `phieu_thu`
--
ALTER TABLE `phieu_thu`
  ADD CONSTRAINT `FK7toy90p9ejciwkoisey01vlhr` FOREIGN KEY (`ma_giao_dich`) REFERENCES `thanh_toan_giao_dich` (`ma_giao_dich`),
  ADD CONSTRAINT `FKq5fea4js9jw4ndu38fdl8p35c` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`);

--
-- Constraints for table `role_permission_map`
--
ALTER TABLE `role_permission_map`
  ADD CONSTRAINT `FKg10nq04sem65ifn7fku658bkx` FOREIGN KEY (`id_permission`) REFERENCES `permission` (`id`),
  ADD CONSTRAINT `FKsd5nu56rs6a7vret5p2f8v7ua` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`);

--
-- Constraints for table `sinh_vien`
--
ALTER TABLE `sinh_vien`
  ADD CONSTRAINT `FKce2axufilntg2wuss16ioqrew` FOREIGN KEY (`ma_lop_danh_nghia`) REFERENCES `lop_hoc_danh_nghia` (`ma_lop`),
  ADD CONSTRAINT `FKql4r5wwkkx1ha86mdbrnokajj` FOREIGN KEY (`ma_tai_khoan`) REFERENCES `tai_khoan` (`id`);

--
-- Constraints for table `sinh_vien_lop_hoc_phan`
--
ALTER TABLE `sinh_vien_lop_hoc_phan`
  ADD CONSTRAINT `FK6rrjsxx10j1lge1dskhcw92ad` FOREIGN KEY (`ma_lop_hoc_phan`) REFERENCES `lop_hoc_phan` (`ma_lop_hoc_phan`),
  ADD CONSTRAINT `FK7dxegu5yiurf47k1yrgn5a8n2` FOREIGN KEY (`ma_thoi_khoa_bieu`) REFERENCES `thoi_khoa_bieu` (`ma_thoi_khoa_bieu`),
  ADD CONSTRAINT `FKmd0chdv7c7i5bwqt0xxqcm8e` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`),
  ADD CONSTRAINT `FKt446j3gsdfn36isyny7glolnm` FOREIGN KEY (`ma_thoi_khoa_bieu_con`) REFERENCES `thoi_khoa_bieu_con` (`ma_thoi_khoa_bieu_con`);

--
-- Constraints for table `tai_khoan`
--
ALTER TABLE `tai_khoan`
  ADD CONSTRAINT `FKg9gtme1qx7benvoa9lrhef0ot` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Constraints for table `thanh_toan_giao_dich`
--
ALTER TABLE `thanh_toan_giao_dich`
  ADD CONSTRAINT `FKf5vbis6scdfd897fgftenakab` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`);

--
-- Constraints for table `thoi_khoa_bieu`
--
ALTER TABLE `thoi_khoa_bieu`
  ADD CONSTRAINT `FKg4dn0u4fmgtqbncb33box445j` FOREIGN KEY (`ma_lop_hoc_phan`) REFERENCES `lop_hoc_phan` (`ma_lop_hoc_phan`),
  ADD CONSTRAINT `FKutiwe9oyux8ww29coan5mu0t` FOREIGN KEY (`ma_giao_vien`) REFERENCES `giao_vien` (`ma_giao_vien`);

--
-- Constraints for table `thoi_khoa_bieu_con`
--
ALTER TABLE `thoi_khoa_bieu_con`
  ADD CONSTRAINT `FKnpdt0cxyu9jimfw4ir2l2h1w4` FOREIGN KEY (`ma_thoi_khoa_bieu`) REFERENCES `thoi_khoa_bieu` (`ma_thoi_khoa_bieu`),
  ADD CONSTRAINT `FKq9mk804kal4b8ur4g5yi2gtda` FOREIGN KEY (`ma_giao_vien`) REFERENCES `giao_vien` (`ma_giao_vien`);

--
-- Constraints for table `thong_bao`
--
ALTER TABLE `thong_bao`
  ADD CONSTRAINT `FKc9wew8egsdia4kif8ikm62g44` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`);

--
-- Constraints for table `thong_bao_khoa`
--
ALTER TABLE `thong_bao_khoa`
  ADD CONSTRAINT `FKbqgh4gmlh31n757e70nnh6pww` FOREIGN KEY (`ma_khoa`) REFERENCES `khoa` (`ma_khoa`);

--
-- Constraints for table `token`
--
ALTER TABLE `token`
  ADD CONSTRAINT `FKq5g30l3l475dgnvd85fe254ln` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`);

--
-- Constraints for table `user_role_map`
--
ALTER TABLE `user_role_map`
  ADD CONSTRAINT `FKj1ggj17aib8c49ppm5pxj42o7` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`),
  ADD CONSTRAINT `FKyjdp00usiuj07xumj63fh0du` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
