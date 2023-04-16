-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th1 29, 2023 lúc 10:12 AM
-- Phiên bản máy phục vụ: 10.4.27-MariaDB
-- Phiên bản PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `sv_dkhp`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `chuong_trinh_khung`
--

CREATE TABLE `chuong_trinh_khung` (
  `id` bigint(20) NOT NULL,
  `done` bit(1) NOT NULL,
  `ma_mon_hoc` bigint(20) DEFAULT NULL,
  `ma_sinh_vien` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `cong_no`
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
-- Đang đổ dữ liệu cho bảng `cong_no`
--

INSERT INTO `cong_no` (`id`, `cong_no`, `da_nop`, `khau_tru`, `mien_giam`, `so_tien`, `trang_thai`, `ma_lop_hoc_phan`, `ma_mon_hoc`, `ma_sinh_vien`) VALUES
(1, 0, 0, 0, 0, 0, 'CHUA_NOP', 1, 1000001, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `diem`
--

CREATE TABLE `diem` (
  `ma_diem` bigint(20) NOT NULL,
  `diem4` float NOT NULL,
  `diemck` float NOT NULL,
  `diem_chu` float NOT NULL,
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

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `giao_vien`
--

CREATE TABLE `giao_vien` (
  `ma_giao_vien` bigint(20) NOT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `gioi_tinh` varchar(255) DEFAULT NULL,
  `loai_giao_vien` varchar(255) DEFAULT NULL,
  `ngay_sinh` date DEFAULT NULL,
  `sdt` varchar(255) DEFAULT NULL,
  `ten_giao_vien` varchar(255) DEFAULT NULL,
  `ma_tai_khoan` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `giao_vien`
--

INSERT INTO `giao_vien` (`ma_giao_vien`, `dia_chi`, `gioi_tinh`, `loai_giao_vien`, `ngay_sinh`, `sdt`, `ten_giao_vien`, `ma_tai_khoan`) VALUES
(1, '163 Bùi Quan Là', 'NU', 'GIAO_VIEN_BO_MON', '2018-01-01', '0338188506', 'Giáo Viên A', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `hoc_ky`
--

CREATE TABLE `hoc_ky` (
  `ma_hoc_ky` bigint(20) NOT NULL,
  `so_tin_chi` int(11) NOT NULL,
  `ten_hoc_ky` varchar(255) DEFAULT NULL,
  `ma_nganh` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `hoc_ky`
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
-- Cấu trúc bảng cho bảng `khoa`
--

CREATE TABLE `khoa` (
  `ma_khoa` bigint(20) NOT NULL,
  `ten_khoa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `khoa`
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
-- Cấu trúc bảng cho bảng `khoa_hoc`
--

CREATE TABLE `khoa_hoc` (
  `ma_khoa_hoc` bigint(20) NOT NULL,
  `nam_bat_dau` int(11) NOT NULL,
  `nam_ket_thuc` int(11) NOT NULL,
  `ten_khoa_hoc` varchar(255) DEFAULT NULL,
  `ma_hoc_ky` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `khoa_hoc`
--

INSERT INTO `khoa_hoc` (`ma_khoa_hoc`, `nam_bat_dau`, `nam_ket_thuc`, `ten_khoa_hoc`, `ma_hoc_ky`) VALUES
(1, 2019, 2020, 'HOC_KY_I', 1),
(2, 2019, 2020, 'HOC_KY_II', 2),
(3, 2020, 2021, 'HOC_KY_I', 3),
(4, 2020, 2021, 'HOC_KY_II', 4),
(5, 2021, 2022, 'HOC_KY_I', 5),
(6, 2021, 2022, 'HOC_KY_II', 6),
(7, 2022, 2023, 'HOC_KY_I', 7),
(8, 2022, 2023, 'HOC_KY_II', 8);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lop_hoc_danh_nghia`
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
-- Đang đổ dữ liệu cho bảng `lop_hoc_danh_nghia`
--

INSERT INTO `lop_hoc_danh_nghia` (`ma_lop`, `so_luong`, `ten_lop`, `ma_giao_vien`, `ma_khoa_hoc`, `ma_nganh`) VALUES
(1, 50, 'DHKTPM11ATT', 1, 1, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `lop_hoc_phan`
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
-- Đang đổ dữ liệu cho bảng `lop_hoc_phan`
--

INSERT INTO `lop_hoc_phan` (`ma_lop_hoc_phan`, `han_nop_hoc_phi`, `loai_hoc`, `ngay_bat_dau`, `ngay_ket_thuc`, `so_luong`, `so_luong_max`, `ten_lop_hoc_phan`, `trang_thai`, `ma_giao_vien`, `ma_khoa_hoc`, `ma_mon_hoc`) VALUES
(1, '2023-02-13', 'HOC_MOI', '2023-02-11', '2023-02-28', 1, 30, 'DHKTPM1ATT', 'DANG_CHO_SINH_VIEN_DANG_KY', 1, 1, 1000001);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `mon_hoc`
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
-- Đang đổ dữ liệu cho bảng `mon_hoc`
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
(1000080, 0, 'SUPER_BAT_BUOC', 0, 0, 0, 0, 0, 'Chứng chỉ TOEIC 450', 8, 2),
(1000081, 4250000, 'BAT_BUOC', 0, 0, 0, 150, 5, 'Thực tập doanh nghiệp', 8, 2),
(1000082, 4250000, 'BAT_BUOC', 0, 0, 0, 150, 5, 'Khóa luận tốt nghiệp', 8, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `nganh`
--

CREATE TABLE `nganh` (
  `ma_nganh` bigint(20) NOT NULL,
  `ten_nganh` varchar(255) DEFAULT NULL,
  `ma_khoa` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `nganh`
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
-- Cấu trúc bảng cho bảng `nhan_vien`
--

CREATE TABLE `nhan_vien` (
  `ma_nhan_vien` bigint(20) NOT NULL,
  `chuc_vu` varchar(255) DEFAULT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `sdt` varchar(255) DEFAULT NULL,
  `ten_nhan_vien` varchar(255) DEFAULT NULL,
  `ma_tai_khoan` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `nhan_vien`
--

INSERT INTO `nhan_vien` (`ma_nhan_vien`, `chuc_vu`, `dia_chi`, `sdt`, `ten_nhan_vien`, `ma_tai_khoan`) VALUES
(1, 'THO_DIEN', '60/122 To 10 KP8 Phuong TCH Q12 TP.HCM', '0338188506', 'Nhân Viên A', 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `permission`
--

CREATE TABLE `permission` (
  `id` bigint(20) NOT NULL,
  `permission` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `permission`
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
-- Cấu trúc bảng cho bảng `phieu_thu`
--

CREATE TABLE `phieu_thu` (
  `ma_phieu_thu` bigint(20) NOT NULL,
  `don_vi_thu` varchar(255) DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `ngay_thu` date DEFAULT NULL,
  `so_tien` double NOT NULL,
  `trang_thai` varchar(255) DEFAULT NULL,
  `ma_sinh_vien` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `phieu_thu`
--

INSERT INTO `phieu_thu` (`ma_phieu_thu`, `don_vi_thu`, `ghi_chu`, `ngay_thu`, `so_tien`, `trang_thai`, `ma_sinh_vien`) VALUES
(1, 'Ngân hàng Agribank', 'Giao dich truc tiep tai QGD GoVap', '2023-01-28', 15300000, 'DANG_CHO_XU_LY', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role`
--

CREATE TABLE `role` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'MEMBER'),
(2, 'ADMIN'),
(3, 'EMPLOYEE'),
(4, 'TEACHER');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `role_permission_map`
--

CREATE TABLE `role_permission_map` (
  `id_role` bigint(20) NOT NULL,
  `id_permission` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `role_permission_map`
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
-- Cấu trúc bảng cho bảng `sinh_vien`
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
-- Đang đổ dữ liệu cho bảng `sinh_vien`
--

INSERT INTO `sinh_vien` (`ma_sinh_vien`, `avatar`, `cccd`, `bac_dao_tao`, `co_so`, `loai_hinh_dao_tao`, `dia_chi`, `gioi_tinh`, `ho_ten`, `ngay_sinh`, `ngay_vao_truong`, `noi_sinh`, `sdt`, `so_du`, `tot_nghiep`, `ma_lop_danh_nghia`, `ma_tai_khoan`) VALUES
(1, 'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg', '079201030774', NULL, NULL, NULL, '60/122 KP8 Phường TCH Quận 12 HCM', 'NAM', 'Học Sinh A', '2020-01-01', '2019-01-01', 'HỒ CHÍ MINH', '0338188506', 0, b'0', 1, 4);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `sinh_vien_lop_hoc_phan`
--

CREATE TABLE `sinh_vien_lop_hoc_phan` (
  `id` bigint(20) NOT NULL,
  `da_thu_hoc_phi` bit(1) NOT NULL,
  `ngay_dang_ky` date DEFAULT NULL,
  `ma_lop_hoc_phan` bigint(20) NOT NULL,
  `ma_sinh_vien` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `sinh_vien_lop_hoc_phan`
--

INSERT INTO `sinh_vien_lop_hoc_phan` (`id`, `da_thu_hoc_phi`, `ngay_dang_ky`, `ma_lop_hoc_phan`, `ma_sinh_vien`) VALUES
(1, b'0', '2023-01-28', 1, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `tai_khoan`
--

CREATE TABLE `tai_khoan` (
  `id` bigint(20) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `id_user` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `tai_khoan`
--

INSERT INTO `tai_khoan` (`id`, `email`, `type`, `id_user`) VALUES
(1, NULL, 'GIAO_VIEN', 1),
(2, NULL, 'NHAN_VIEN', 2),
(3, 'taito1doraemon@gmail.com', 'ADMIN', 3),
(4, NULL, 'SINH_VIEN', 4);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thanh_toan_giao_dich`
--

CREATE TABLE `thanh_toan_giao_dich` (
  `ma_giao_dich` bigint(20) NOT NULL,
  `expired_time` datetime DEFAULT NULL,
  `ma_sinh_vien` bigint(20) NOT NULL,
  `balance` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `thanh_toan_giao_dich`
--

INSERT INTO `thanh_toan_giao_dich` (`ma_giao_dich`, `expired_time`, `ma_sinh_vien`, `balance`) VALUES
(1, '2023-01-29 16:19:13', 1, 1700000);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thoi_khoa_bieu`
--

CREATE TABLE `thoi_khoa_bieu` (
  `ma_thoi_khoa_bieu` bigint(20) NOT NULL,
  `chung_with_ma_thoi_khoa_bieu` bigint(20) NOT NULL,
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
  `ma_lop_hoc_phan` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `thoi_khoa_bieu`
--

INSERT INTO `thoi_khoa_bieu` (`ma_thoi_khoa_bieu`, `chung_with_ma_thoi_khoa_bieu`, `den_tiet_hoc`, `ghi_chu`, `loai_buoi_hoc`, `ngay_bat_dau`, `ngay_ket_thuc`, `nhom_hoc`, `phong_hoc`, `thi`, `thu_hoc`, `tu_tiet_hoc`, `ma_lop_hoc_phan`) VALUES
(1, 0, 'T3', '', 'LT', '2023-02-01', '2023-02-28', 1, 'B1.01', b'0', 'T2', 'T1', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `thong_bao_khoa`
--

CREATE TABLE `thong_bao_khoa` (
  `ma_thong_bao` bigint(20) NOT NULL,
  `ngay_xuat_ban` date DEFAULT NULL,
  `noi_dung` text DEFAULT NULL,
  `tieu_de` varchar(255) DEFAULT NULL,
  `ma_khoa` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `thong_bao_khoa`
--

INSERT INTO `thong_bao_khoa` (`ma_thong_bao`, `ngay_xuat_ban`, `noi_dung`, `tieu_de`, `ma_khoa`) VALUES
(1, '2021-01-01', 'Gửi tới các em sinh viên hệ CLC / Đại trà. Cũng đã sắp đến tết cận kề, nhà nhà đã mang không khí nôn nao của lễ hội tết truyền thống. Nhằm mục đích hỗ trợ cho việc các sinh viên có thể bắt xe trở về quê ăn tết thuận tiện với gia đình tốt nhất. Nhà trường quyết định sẽ tổ chức các buổi học cận kề ngày nghĩ tết thành lịch học online (có thể). Một vài trường hợp môn học bắt buộc học offline như thực hành sẽ vẫn tiếp tục.', 'THÔNG BÁO LỊCH NGHĨ TẾT DƯƠNG LỊCH CHO TOÀN BỘ SINH VIÊN TRƯỜNG ĐẠI HỌC CÔNG NGHIỆP IV (IUH)', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `token`
--

CREATE TABLE `token` (
  `id` bigint(20) NOT NULL,
  `token` text DEFAULT NULL,
  `token_exp_date` datetime DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `token`
--

INSERT INTO `token` (`id`, `token`, `token_exp_date`, `created_by`) VALUES
(1, 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJudjEiLCJleHAiOjE2NzQ5MzI2ODcsImlhdCI6MTY3NDkxNDY4N30.S4jdZnZKHfFs83D-bfegDFqXWMbrsK1ojfxIAoLyELogUqwVlFl_EDkEfGmd90bJ7ygilXsQyJQbQXzzh_PhDg', '2023-01-29 02:01:43', 2),
(2, 'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzdjEiLCJleHAiOjE2NzQ5OTc4NjMsImlhdCI6MTY3NDk3OTg2M30.sv2OXeKhKw6bV2hUxlLlQoc-WJOiIwySDX70UCDSev8KtjU5Srq_QtovPqHaF9_WLFQ5euVgPPbHXX1_iptgdg', '2023-01-29 02:05:12', 4);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user`
--

CREATE TABLE `user` (
  `id` bigint(20) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user`
--

INSERT INTO `user` (`id`, `password`, `username`) VALUES
(1, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'gv1'),
(2, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'nv1'),
(3, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sa'),
(4, '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6', 'sv1');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `user_role_map`
--

CREATE TABLE `user_role_map` (
  `id_user` bigint(20) NOT NULL,
  `id_role` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `user_role_map`
--

INSERT INTO `user_role_map` (`id_user`, `id_role`) VALUES
(1, 4),
(2, 3),
(3, 2),
(4, 1);

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `chuong_trinh_khung`
--
ALTER TABLE `chuong_trinh_khung`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKg03funaw6lm3b5tsmkl24weei` (`ma_mon_hoc`),
  ADD KEY `FK3wm9ly0g4i8nn5dhn51ue1n0j` (`ma_sinh_vien`);

--
-- Chỉ mục cho bảng `cong_no`
--
ALTER TABLE `cong_no`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKkxl1i4597wqhq1lcsxe80k9pi` (`ma_lop_hoc_phan`),
  ADD KEY `FKqgvb2b1v3buwnf79biq25v41p` (`ma_mon_hoc`),
  ADD KEY `FKg8i8ji845ka67ejnoid4oqr2u` (`ma_sinh_vien`);

--
-- Chỉ mục cho bảng `diem`
--
ALTER TABLE `diem`
  ADD PRIMARY KEY (`ma_diem`),
  ADD KEY `FKa4mk5ny0xtsxf1vgaxo8g49yu` (`ma_lop_hoc_phan`),
  ADD KEY `FK8fjjyfymvjg93mbsth73q4r85` (`ma_sinh_vien`);

--
-- Chỉ mục cho bảng `giao_vien`
--
ALTER TABLE `giao_vien`
  ADD PRIMARY KEY (`ma_giao_vien`),
  ADD KEY `FKjpuvgu4m7k7qg5ry8enpiwla8` (`ma_tai_khoan`);

--
-- Chỉ mục cho bảng `hoc_ky`
--
ALTER TABLE `hoc_ky`
  ADD PRIMARY KEY (`ma_hoc_ky`),
  ADD KEY `FKrhv21in81gd0q877baj66o2jv` (`ma_nganh`);

--
-- Chỉ mục cho bảng `khoa`
--
ALTER TABLE `khoa`
  ADD PRIMARY KEY (`ma_khoa`);

--
-- Chỉ mục cho bảng `khoa_hoc`
--
ALTER TABLE `khoa_hoc`
  ADD PRIMARY KEY (`ma_khoa_hoc`),
  ADD KEY `FKeio267xmxe9dcrit7q7xxjno5` (`ma_hoc_ky`);

--
-- Chỉ mục cho bảng `lop_hoc_danh_nghia`
--
ALTER TABLE `lop_hoc_danh_nghia`
  ADD PRIMARY KEY (`ma_lop`),
  ADD KEY `FK4pvx3xu9tg0cebd4842x3va41` (`ma_giao_vien`),
  ADD KEY `FKig93cv30e8b0m5gidp8kw1n7k` (`ma_khoa_hoc`),
  ADD KEY `FKk1tyuwrp94i4hi8rg5trbecbn` (`ma_nganh`);

--
-- Chỉ mục cho bảng `lop_hoc_phan`
--
ALTER TABLE `lop_hoc_phan`
  ADD PRIMARY KEY (`ma_lop_hoc_phan`),
  ADD KEY `FK3ry1unxhxp6x73pthyt762uup` (`ma_giao_vien`),
  ADD KEY `FKk6be4r8ym9mph9tn7h3s209cn` (`ma_khoa_hoc`),
  ADD KEY `FKsin0ppsx8ftjbqkngy4ohy1pi` (`ma_mon_hoc`);

--
-- Chỉ mục cho bảng `mon_hoc`
--
ALTER TABLE `mon_hoc`
  ADD PRIMARY KEY (`ma_mon_hoc`),
  ADD KEY `FKi6b1jns4haog4p4nuqly59pid` (`ma_hoc_ky`),
  ADD KEY `FK3tdld0m297q7li7fqto6rm1u5` (`ma_nganh`);

--
-- Chỉ mục cho bảng `nganh`
--
ALTER TABLE `nganh`
  ADD PRIMARY KEY (`ma_nganh`),
  ADD KEY `FKeljm0njcqiwey0kgb6k487rk3` (`ma_khoa`);

--
-- Chỉ mục cho bảng `nhan_vien`
--
ALTER TABLE `nhan_vien`
  ADD PRIMARY KEY (`ma_nhan_vien`),
  ADD KEY `FKdpk3u6xuawsiksnkklx1pfeyw` (`ma_tai_khoan`);

--
-- Chỉ mục cho bảng `permission`
--
ALTER TABLE `permission`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `phieu_thu`
--
ALTER TABLE `phieu_thu`
  ADD PRIMARY KEY (`ma_phieu_thu`),
  ADD KEY `FKq5fea4js9jw4ndu38fdl8p35c` (`ma_sinh_vien`);

--
-- Chỉ mục cho bảng `role`
--
ALTER TABLE `role`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `role_permission_map`
--
ALTER TABLE `role_permission_map`
  ADD PRIMARY KEY (`id_role`,`id_permission`),
  ADD UNIQUE KEY `UK_m1k6evof73n1rreqnn427d5v1` (`id_permission`);

--
-- Chỉ mục cho bảng `sinh_vien`
--
ALTER TABLE `sinh_vien`
  ADD PRIMARY KEY (`ma_sinh_vien`),
  ADD KEY `FKce2axufilntg2wuss16ioqrew` (`ma_lop_danh_nghia`),
  ADD KEY `FKql4r5wwkkx1ha86mdbrnokajj` (`ma_tai_khoan`);

--
-- Chỉ mục cho bảng `sinh_vien_lop_hoc_phan`
--
ALTER TABLE `sinh_vien_lop_hoc_phan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK6rrjsxx10j1lge1dskhcw92ad` (`ma_lop_hoc_phan`),
  ADD KEY `FKmd0chdv7c7i5bwqt0xxqcm8e` (`ma_sinh_vien`);

--
-- Chỉ mục cho bảng `tai_khoan`
--
ALTER TABLE `tai_khoan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKg9gtme1qx7benvoa9lrhef0ot` (`id_user`);

--
-- Chỉ mục cho bảng `thanh_toan_giao_dich`
--
ALTER TABLE `thanh_toan_giao_dich`
  ADD PRIMARY KEY (`ma_giao_dich`),
  ADD KEY `FKf5vbis6scdfd897fgftenakab` (`ma_sinh_vien`);

--
-- Chỉ mục cho bảng `thoi_khoa_bieu`
--
ALTER TABLE `thoi_khoa_bieu`
  ADD PRIMARY KEY (`ma_thoi_khoa_bieu`),
  ADD KEY `FKg4dn0u4fmgtqbncb33box445j` (`ma_lop_hoc_phan`);

--
-- Chỉ mục cho bảng `thong_bao_khoa`
--
ALTER TABLE `thong_bao_khoa`
  ADD PRIMARY KEY (`ma_thong_bao`),
  ADD KEY `FKbqgh4gmlh31n757e70nnh6pww` (`ma_khoa`);

--
-- Chỉ mục cho bảng `token`
--
ALTER TABLE `token`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FKq5g30l3l475dgnvd85fe254ln` (`created_by`);

--
-- Chỉ mục cho bảng `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `user_role_map`
--
ALTER TABLE `user_role_map`
  ADD PRIMARY KEY (`id_user`,`id_role`),
  ADD KEY `FKj1ggj17aib8c49ppm5pxj42o7` (`id_role`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `chuong_trinh_khung`
--
ALTER TABLE `chuong_trinh_khung`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `cong_no`
--
ALTER TABLE `cong_no`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `diem`
--
ALTER TABLE `diem`
  MODIFY `ma_diem` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT cho bảng `giao_vien`
--
ALTER TABLE `giao_vien`
  MODIFY `ma_giao_vien` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `hoc_ky`
--
ALTER TABLE `hoc_ky`
  MODIFY `ma_hoc_ky` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `khoa`
--
ALTER TABLE `khoa`
  MODIFY `ma_khoa` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT cho bảng `khoa_hoc`
--
ALTER TABLE `khoa_hoc`
  MODIFY `ma_khoa_hoc` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT cho bảng `lop_hoc_danh_nghia`
--
ALTER TABLE `lop_hoc_danh_nghia`
  MODIFY `ma_lop` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `lop_hoc_phan`
--
ALTER TABLE `lop_hoc_phan`
  MODIFY `ma_lop_hoc_phan` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `nganh`
--
ALTER TABLE `nganh`
  MODIFY `ma_nganh` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT cho bảng `nhan_vien`
--
ALTER TABLE `nhan_vien`
  MODIFY `ma_nhan_vien` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `permission`
--
ALTER TABLE `permission`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT cho bảng `phieu_thu`
--
ALTER TABLE `phieu_thu`
  MODIFY `ma_phieu_thu` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `role`
--
ALTER TABLE `role`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `sinh_vien`
--
ALTER TABLE `sinh_vien`
  MODIFY `ma_sinh_vien` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `sinh_vien_lop_hoc_phan`
--
ALTER TABLE `sinh_vien_lop_hoc_phan`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `tai_khoan`
--
ALTER TABLE `tai_khoan`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT cho bảng `thanh_toan_giao_dich`
--
ALTER TABLE `thanh_toan_giao_dich`
  MODIFY `ma_giao_dich` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `thoi_khoa_bieu`
--
ALTER TABLE `thoi_khoa_bieu`
  MODIFY `ma_thoi_khoa_bieu` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `thong_bao_khoa`
--
ALTER TABLE `thong_bao_khoa`
  MODIFY `ma_thong_bao` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `token`
--
ALTER TABLE `token`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT cho bảng `user`
--
ALTER TABLE `user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `chuong_trinh_khung`
--
ALTER TABLE `chuong_trinh_khung`
  ADD CONSTRAINT `FK3wm9ly0g4i8nn5dhn51ue1n0j` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`),
  ADD CONSTRAINT `FKg03funaw6lm3b5tsmkl24weei` FOREIGN KEY (`ma_mon_hoc`) REFERENCES `mon_hoc` (`ma_mon_hoc`);

--
-- Các ràng buộc cho bảng `cong_no`
--
ALTER TABLE `cong_no`
  ADD CONSTRAINT `FKg8i8ji845ka67ejnoid4oqr2u` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`),
  ADD CONSTRAINT `FKkxl1i4597wqhq1lcsxe80k9pi` FOREIGN KEY (`ma_lop_hoc_phan`) REFERENCES `lop_hoc_phan` (`ma_lop_hoc_phan`),
  ADD CONSTRAINT `FKqgvb2b1v3buwnf79biq25v41p` FOREIGN KEY (`ma_mon_hoc`) REFERENCES `mon_hoc` (`ma_mon_hoc`);

--
-- Các ràng buộc cho bảng `diem`
--
ALTER TABLE `diem`
  ADD CONSTRAINT `FK8fjjyfymvjg93mbsth73q4r85` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`),
  ADD CONSTRAINT `FKa4mk5ny0xtsxf1vgaxo8g49yu` FOREIGN KEY (`ma_lop_hoc_phan`) REFERENCES `lop_hoc_phan` (`ma_lop_hoc_phan`);

--
-- Các ràng buộc cho bảng `giao_vien`
--
ALTER TABLE `giao_vien`
  ADD CONSTRAINT `FKjpuvgu4m7k7qg5ry8enpiwla8` FOREIGN KEY (`ma_tai_khoan`) REFERENCES `tai_khoan` (`id`);

--
-- Các ràng buộc cho bảng `hoc_ky`
--
ALTER TABLE `hoc_ky`
  ADD CONSTRAINT `FKrhv21in81gd0q877baj66o2jv` FOREIGN KEY (`ma_nganh`) REFERENCES `nganh` (`ma_nganh`);

--
-- Các ràng buộc cho bảng `khoa_hoc`
--
ALTER TABLE `khoa_hoc`
  ADD CONSTRAINT `FKeio267xmxe9dcrit7q7xxjno5` FOREIGN KEY (`ma_hoc_ky`) REFERENCES `hoc_ky` (`ma_hoc_ky`);

--
-- Các ràng buộc cho bảng `lop_hoc_danh_nghia`
--
ALTER TABLE `lop_hoc_danh_nghia`
  ADD CONSTRAINT `FK4pvx3xu9tg0cebd4842x3va41` FOREIGN KEY (`ma_giao_vien`) REFERENCES `giao_vien` (`ma_giao_vien`),
  ADD CONSTRAINT `FKig93cv30e8b0m5gidp8kw1n7k` FOREIGN KEY (`ma_khoa_hoc`) REFERENCES `khoa_hoc` (`ma_khoa_hoc`),
  ADD CONSTRAINT `FKk1tyuwrp94i4hi8rg5trbecbn` FOREIGN KEY (`ma_nganh`) REFERENCES `nganh` (`ma_nganh`);

--
-- Các ràng buộc cho bảng `lop_hoc_phan`
--
ALTER TABLE `lop_hoc_phan`
  ADD CONSTRAINT `FK3ry1unxhxp6x73pthyt762uup` FOREIGN KEY (`ma_giao_vien`) REFERENCES `giao_vien` (`ma_giao_vien`),
  ADD CONSTRAINT `FKk6be4r8ym9mph9tn7h3s209cn` FOREIGN KEY (`ma_khoa_hoc`) REFERENCES `khoa_hoc` (`ma_khoa_hoc`),
  ADD CONSTRAINT `FKsin0ppsx8ftjbqkngy4ohy1pi` FOREIGN KEY (`ma_mon_hoc`) REFERENCES `mon_hoc` (`ma_mon_hoc`);

--
-- Các ràng buộc cho bảng `mon_hoc`
--
ALTER TABLE `mon_hoc`
  ADD CONSTRAINT `FK3tdld0m297q7li7fqto6rm1u5` FOREIGN KEY (`ma_nganh`) REFERENCES `nganh` (`ma_nganh`),
  ADD CONSTRAINT `FKi6b1jns4haog4p4nuqly59pid` FOREIGN KEY (`ma_hoc_ky`) REFERENCES `hoc_ky` (`ma_hoc_ky`);

--
-- Các ràng buộc cho bảng `nganh`
--
ALTER TABLE `nganh`
  ADD CONSTRAINT `FKeljm0njcqiwey0kgb6k487rk3` FOREIGN KEY (`ma_khoa`) REFERENCES `khoa` (`ma_khoa`);

--
-- Các ràng buộc cho bảng `nhan_vien`
--
ALTER TABLE `nhan_vien`
  ADD CONSTRAINT `FKdpk3u6xuawsiksnkklx1pfeyw` FOREIGN KEY (`ma_tai_khoan`) REFERENCES `tai_khoan` (`id`);

--
-- Các ràng buộc cho bảng `phieu_thu`
--
ALTER TABLE `phieu_thu`
  ADD CONSTRAINT `FKq5fea4js9jw4ndu38fdl8p35c` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`);

--
-- Các ràng buộc cho bảng `role_permission_map`
--
ALTER TABLE `role_permission_map`
  ADD CONSTRAINT `FKg10nq04sem65ifn7fku658bkx` FOREIGN KEY (`id_permission`) REFERENCES `permission` (`id`),
  ADD CONSTRAINT `FKsd5nu56rs6a7vret5p2f8v7ua` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`);

--
-- Các ràng buộc cho bảng `sinh_vien`
--
ALTER TABLE `sinh_vien`
  ADD CONSTRAINT `FKce2axufilntg2wuss16ioqrew` FOREIGN KEY (`ma_lop_danh_nghia`) REFERENCES `lop_hoc_danh_nghia` (`ma_lop`),
  ADD CONSTRAINT `FKql4r5wwkkx1ha86mdbrnokajj` FOREIGN KEY (`ma_tai_khoan`) REFERENCES `tai_khoan` (`id`);

--
-- Các ràng buộc cho bảng `sinh_vien_lop_hoc_phan`
--
ALTER TABLE `sinh_vien_lop_hoc_phan`
  ADD CONSTRAINT `FK6rrjsxx10j1lge1dskhcw92ad` FOREIGN KEY (`ma_lop_hoc_phan`) REFERENCES `lop_hoc_phan` (`ma_lop_hoc_phan`),
  ADD CONSTRAINT `FKmd0chdv7c7i5bwqt0xxqcm8e` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`);

--
-- Các ràng buộc cho bảng `tai_khoan`
--
ALTER TABLE `tai_khoan`
  ADD CONSTRAINT `FKg9gtme1qx7benvoa9lrhef0ot` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

--
-- Các ràng buộc cho bảng `thanh_toan_giao_dich`
--
ALTER TABLE `thanh_toan_giao_dich`
  ADD CONSTRAINT `FKf5vbis6scdfd897fgftenakab` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`);

--
-- Các ràng buộc cho bảng `thoi_khoa_bieu`
--
ALTER TABLE `thoi_khoa_bieu`
  ADD CONSTRAINT `FKg4dn0u4fmgtqbncb33box445j` FOREIGN KEY (`ma_lop_hoc_phan`) REFERENCES `lop_hoc_phan` (`ma_lop_hoc_phan`);

--
-- Các ràng buộc cho bảng `thong_bao_khoa`
--
ALTER TABLE `thong_bao_khoa`
  ADD CONSTRAINT `FKbqgh4gmlh31n757e70nnh6pww` FOREIGN KEY (`ma_khoa`) REFERENCES `khoa` (`ma_khoa`);

--
-- Các ràng buộc cho bảng `token`
--
ALTER TABLE `token`
  ADD CONSTRAINT `FKq5g30l3l475dgnvd85fe254ln` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`);

--
-- Các ràng buộc cho bảng `user_role_map`
--
ALTER TABLE `user_role_map`
  ADD CONSTRAINT `FKj1ggj17aib8c49ppm5pxj42o7` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`),
  ADD CONSTRAINT `FKyjdp00usiuj07xumj63fh0du` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
