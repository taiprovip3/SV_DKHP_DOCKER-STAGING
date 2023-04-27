/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: chuong_trinh_khung
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `chuong_trinh_khung` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `done` bit(1) NOT NULL,
  `ma_mon_hoc` bigint(20) DEFAULT NULL,
  `ma_sinh_vien` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKg03funaw6lm3b5tsmkl24weei` (`ma_mon_hoc`),
  KEY `FK3wm9ly0g4i8nn5dhn51ue1n0j` (`ma_sinh_vien`),
  CONSTRAINT `FK3wm9ly0g4i8nn5dhn51ue1n0j` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`),
  CONSTRAINT `FKg03funaw6lm3b5tsmkl24weei` FOREIGN KEY (`ma_mon_hoc`) REFERENCES `mon_hoc` (`ma_mon_hoc`)
) ENGINE = InnoDB AUTO_INCREMENT = 7 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: cong_no
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `cong_no` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cong_no` double NOT NULL,
  `da_nop` double NOT NULL,
  `khau_tru` double NOT NULL,
  `mien_giam` float NOT NULL,
  `so_tien` double NOT NULL,
  `trang_thai` varchar(255) DEFAULT NULL,
  `ma_lop_hoc_phan` bigint(20) DEFAULT NULL,
  `ma_mon_hoc` bigint(20) NOT NULL,
  `ma_sinh_vien` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKkxl1i4597wqhq1lcsxe80k9pi` (`ma_lop_hoc_phan`),
  KEY `FKqgvb2b1v3buwnf79biq25v41p` (`ma_mon_hoc`),
  KEY `FKg8i8ji845ka67ejnoid4oqr2u` (`ma_sinh_vien`),
  CONSTRAINT `FKg8i8ji845ka67ejnoid4oqr2u` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`),
  CONSTRAINT `FKkxl1i4597wqhq1lcsxe80k9pi` FOREIGN KEY (`ma_lop_hoc_phan`) REFERENCES `lop_hoc_phan` (`ma_lop_hoc_phan`),
  CONSTRAINT `FKqgvb2b1v3buwnf79biq25v41p` FOREIGN KEY (`ma_mon_hoc`) REFERENCES `mon_hoc` (`ma_mon_hoc`)
) ENGINE = InnoDB AUTO_INCREMENT = 53 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: diem
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `diem` (
  `ma_diem` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `ma_sinh_vien` bigint(20) NOT NULL,
  PRIMARY KEY (`ma_diem`),
  KEY `FKa4mk5ny0xtsxf1vgaxo8g49yu` (`ma_lop_hoc_phan`),
  KEY `FK8fjjyfymvjg93mbsth73q4r85` (`ma_sinh_vien`),
  CONSTRAINT `FK8fjjyfymvjg93mbsth73q4r85` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`),
  CONSTRAINT `FKa4mk5ny0xtsxf1vgaxo8g49yu` FOREIGN KEY (`ma_lop_hoc_phan`) REFERENCES `lop_hoc_phan` (`ma_lop_hoc_phan`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: giao_vien
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `giao_vien` (
  `ma_giao_vien` bigint(20) NOT NULL AUTO_INCREMENT,
  `dia_chi` varchar(255) DEFAULT NULL,
  `gioi_tinh` varchar(255) DEFAULT NULL,
  `loai_giao_vien` varchar(255) DEFAULT NULL,
  `ngay_sinh` date DEFAULT NULL,
  `sdt` varchar(255) DEFAULT NULL,
  `ten_giao_vien` varchar(255) DEFAULT NULL,
  `ma_tai_khoan` bigint(20) DEFAULT NULL,
  `avatar` varchar(255) NOT NULL DEFAULT 'https://smilemedia.vn/wp-content/uploads/2022/09/cach-chup-hinh-the-dep.jpeg',
  PRIMARY KEY (`ma_giao_vien`),
  KEY `FKjpuvgu4m7k7qg5ry8enpiwla8` (`ma_tai_khoan`),
  CONSTRAINT `FKjpuvgu4m7k7qg5ry8enpiwla8` FOREIGN KEY (`ma_tai_khoan`) REFERENCES `tai_khoan` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: hoc_ky
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `hoc_ky` (
  `ma_hoc_ky` bigint(20) NOT NULL AUTO_INCREMENT,
  `so_tin_chi` int(11) NOT NULL,
  `ten_hoc_ky` varchar(255) DEFAULT NULL,
  `ma_nganh` bigint(20) NOT NULL,
  PRIMARY KEY (`ma_hoc_ky`),
  KEY `FKrhv21in81gd0q877baj66o2jv` (`ma_nganh`),
  CONSTRAINT `FKrhv21in81gd0q877baj66o2jv` FOREIGN KEY (`ma_nganh`) REFERENCES `nganh` (`ma_nganh`)
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: khoa
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `khoa` (
  `ma_khoa` bigint(20) NOT NULL AUTO_INCREMENT,
  `ten_khoa` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ma_khoa`)
) ENGINE = InnoDB AUTO_INCREMENT = 18 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: khoa_hoc
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `khoa_hoc` (
  `ma_khoa_hoc` bigint(20) NOT NULL AUTO_INCREMENT,
  `alias` varchar(255) DEFAULT NULL,
  `nam_bat_dau` int(11) NOT NULL,
  `nam_ket_thuc` int(11) NOT NULL,
  `ten_khoa_hoc` varchar(255) DEFAULT NULL,
  `ma_hoc_ky` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ma_khoa_hoc`),
  KEY `FKeio267xmxe9dcrit7q7xxjno5` (`ma_hoc_ky`),
  CONSTRAINT `FKeio267xmxe9dcrit7q7xxjno5` FOREIGN KEY (`ma_hoc_ky`) REFERENCES `hoc_ky` (`ma_hoc_ky`)
) ENGINE = InnoDB AUTO_INCREMENT = 90 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: lop_hoc_danh_nghia
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `lop_hoc_danh_nghia` (
  `ma_lop` bigint(20) NOT NULL AUTO_INCREMENT,
  `so_luong` int(11) NOT NULL,
  `ten_lop` varchar(255) DEFAULT NULL,
  `ma_giao_vien` bigint(20) NOT NULL,
  `ma_khoa_hoc` bigint(20) NOT NULL,
  `ma_nganh` bigint(20) NOT NULL,
  PRIMARY KEY (`ma_lop`),
  KEY `FK4pvx3xu9tg0cebd4842x3va41` (`ma_giao_vien`),
  KEY `FKig93cv30e8b0m5gidp8kw1n7k` (`ma_khoa_hoc`),
  KEY `FKk1tyuwrp94i4hi8rg5trbecbn` (`ma_nganh`),
  CONSTRAINT `FK4pvx3xu9tg0cebd4842x3va41` FOREIGN KEY (`ma_giao_vien`) REFERENCES `giao_vien` (`ma_giao_vien`),
  CONSTRAINT `FKig93cv30e8b0m5gidp8kw1n7k` FOREIGN KEY (`ma_khoa_hoc`) REFERENCES `khoa_hoc` (`ma_khoa_hoc`),
  CONSTRAINT `FKk1tyuwrp94i4hi8rg5trbecbn` FOREIGN KEY (`ma_nganh`) REFERENCES `nganh` (`ma_nganh`)
) ENGINE = InnoDB AUTO_INCREMENT = 26 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: lop_hoc_phan
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `lop_hoc_phan` (
  `ma_lop_hoc_phan` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `ma_mon_hoc` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ma_lop_hoc_phan`),
  KEY `FK3ry1unxhxp6x73pthyt762uup` (`ma_giao_vien`),
  KEY `FKk6be4r8ym9mph9tn7h3s209cn` (`ma_khoa_hoc`),
  KEY `FKsin0ppsx8ftjbqkngy4ohy1pi` (`ma_mon_hoc`),
  CONSTRAINT `FK3ry1unxhxp6x73pthyt762uup` FOREIGN KEY (`ma_giao_vien`) REFERENCES `giao_vien` (`ma_giao_vien`),
  CONSTRAINT `FKk6be4r8ym9mph9tn7h3s209cn` FOREIGN KEY (`ma_khoa_hoc`) REFERENCES `khoa_hoc` (`ma_khoa_hoc`),
  CONSTRAINT `FKsin0ppsx8ftjbqkngy4ohy1pi` FOREIGN KEY (`ma_mon_hoc`) REFERENCES `mon_hoc` (`ma_mon_hoc`)
) ENGINE = InnoDB AUTO_INCREMENT = 9 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: mon_hoc
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `mon_hoc` (
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
  `ma_nganh` bigint(20) NOT NULL,
  PRIMARY KEY (`ma_mon_hoc`),
  KEY `FKi6b1jns4haog4p4nuqly59pid` (`ma_hoc_ky`),
  KEY `FK3tdld0m297q7li7fqto6rm1u5` (`ma_nganh`),
  CONSTRAINT `FK3tdld0m297q7li7fqto6rm1u5` FOREIGN KEY (`ma_nganh`) REFERENCES `nganh` (`ma_nganh`),
  CONSTRAINT `FKi6b1jns4haog4p4nuqly59pid` FOREIGN KEY (`ma_hoc_ky`) REFERENCES `hoc_ky` (`ma_hoc_ky`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: nganh
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `nganh` (
  `ma_nganh` bigint(20) NOT NULL AUTO_INCREMENT,
  `ten_nganh` varchar(255) DEFAULT NULL,
  `ma_khoa` bigint(20) NOT NULL,
  PRIMARY KEY (`ma_nganh`),
  KEY `FKeljm0njcqiwey0kgb6k487rk3` (`ma_khoa`),
  CONSTRAINT `FKeljm0njcqiwey0kgb6k487rk3` FOREIGN KEY (`ma_khoa`) REFERENCES `khoa` (`ma_khoa`)
) ENGINE = InnoDB AUTO_INCREMENT = 39 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: nhan_vien
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `nhan_vien` (
  `ma_nhan_vien` bigint(20) NOT NULL AUTO_INCREMENT,
  `chuc_vu` varchar(255) DEFAULT NULL,
  `dia_chi` varchar(255) DEFAULT NULL,
  `sdt` varchar(255) DEFAULT NULL,
  `ten_nhan_vien` varchar(255) DEFAULT NULL,
  `ma_tai_khoan` bigint(20) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `gioi_tinh` varchar(255) DEFAULT NULL,
  `last_backup` datetime DEFAULT NULL,
  `nam_sinh` int(11) NOT NULL,
  `ngay_vao_lam` date NOT NULL,
  PRIMARY KEY (`ma_nhan_vien`),
  KEY `FKdpk3u6xuawsiksnkklx1pfeyw` (`ma_tai_khoan`),
  CONSTRAINT `FKdpk3u6xuawsiksnkklx1pfeyw` FOREIGN KEY (`ma_tai_khoan`) REFERENCES `tai_khoan` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 21052004 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: permission
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `permission` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `permission` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 8 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: phieu_thu
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `phieu_thu` (
  `ma_phieu_thu` bigint(20) NOT NULL AUTO_INCREMENT,
  `don_vi_thu` varchar(255) DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `ngay_thu` date DEFAULT NULL,
  `so_tien` double NOT NULL,
  `trang_thai` varchar(255) DEFAULT NULL,
  `ma_sinh_vien` bigint(20) NOT NULL,
  `ma_giao_dich` varchar(255) DEFAULT NULL,
  `loai_phieu_thu` varchar(255) NOT NULL DEFAULT 'OUT' COMMENT 'IN: là nạp vào ví. OUT: là thanh toán học phí',
  PRIMARY KEY (`ma_phieu_thu`),
  KEY `FKq5fea4js9jw4ndu38fdl8p35c` (`ma_sinh_vien`),
  KEY `FK7toy90p9ejciwkoisey01vlhr` (`ma_giao_dich`),
  CONSTRAINT `FK7toy90p9ejciwkoisey01vlhr` FOREIGN KEY (`ma_giao_dich`) REFERENCES `thanh_toan_giao_dich` (`ma_giao_dich`),
  CONSTRAINT `FKq5fea4js9jw4ndu38fdl8p35c` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`)
) ENGINE = InnoDB AUTO_INCREMENT = 33 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: role
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: role_permission_map
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `role_permission_map` (
  `id_role` bigint(20) NOT NULL,
  `id_permission` bigint(20) NOT NULL,
  PRIMARY KEY (`id_role`, `id_permission`),
  UNIQUE KEY `UK_m1k6evof73n1rreqnn427d5v1` (`id_permission`),
  CONSTRAINT `FKg10nq04sem65ifn7fku658bkx` FOREIGN KEY (`id_permission`) REFERENCES `permission` (`id`),
  CONSTRAINT `FKsd5nu56rs6a7vret5p2f8v7ua` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: sinh_vien
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `sinh_vien` (
  `ma_sinh_vien` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `ma_tai_khoan` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`ma_sinh_vien`),
  KEY `FKce2axufilntg2wuss16ioqrew` (`ma_lop_danh_nghia`),
  KEY `FKql4r5wwkkx1ha86mdbrnokajj` (`ma_tai_khoan`),
  CONSTRAINT `FKce2axufilntg2wuss16ioqrew` FOREIGN KEY (`ma_lop_danh_nghia`) REFERENCES `lop_hoc_danh_nghia` (`ma_lop`),
  CONSTRAINT `FKql4r5wwkkx1ha86mdbrnokajj` FOREIGN KEY (`ma_tai_khoan`) REFERENCES `tai_khoan` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 19524792 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: sinh_vien_lop_hoc_phan
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `sinh_vien_lop_hoc_phan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `da_thu_hoc_phi` bit(1) NOT NULL,
  `ngay_dang_ky` date DEFAULT NULL,
  `ma_lop_hoc_phan` bigint(20) NOT NULL COMMENT 'Field có này được dùng cho hàm lọc lớp học phần trùng lịch',
  `ma_sinh_vien` bigint(20) NOT NULL,
  `ma_thoi_khoa_bieu` bigint(20) NOT NULL,
  `ma_thoi_khoa_bieu_con` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK6rrjsxx10j1lge1dskhcw92ad` (`ma_lop_hoc_phan`),
  KEY `FKmd0chdv7c7i5bwqt0xxqcm8e` (`ma_sinh_vien`),
  KEY `FK7dxegu5yiurf47k1yrgn5a8n2` (`ma_thoi_khoa_bieu`),
  KEY `FKt446j3gsdfn36isyny7glolnm` (`ma_thoi_khoa_bieu_con`),
  CONSTRAINT `FK6rrjsxx10j1lge1dskhcw92ad` FOREIGN KEY (`ma_lop_hoc_phan`) REFERENCES `lop_hoc_phan` (`ma_lop_hoc_phan`),
  CONSTRAINT `FK7dxegu5yiurf47k1yrgn5a8n2` FOREIGN KEY (`ma_thoi_khoa_bieu`) REFERENCES `thoi_khoa_bieu` (`ma_thoi_khoa_bieu`),
  CONSTRAINT `FKmd0chdv7c7i5bwqt0xxqcm8e` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`),
  CONSTRAINT `FKt446j3gsdfn36isyny7glolnm` FOREIGN KEY (`ma_thoi_khoa_bieu_con`) REFERENCES `thoi_khoa_bieu_con` (`ma_thoi_khoa_bieu_con`)
) ENGINE = InnoDB AUTO_INCREMENT = 52 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: tai_khoan
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `tai_khoan` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `id_user` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKg9gtme1qx7benvoa9lrhef0ot` (`id_user`),
  CONSTRAINT `FKg9gtme1qx7benvoa9lrhef0ot` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 15 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: thanh_toan_giao_dich
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `thanh_toan_giao_dich` (
  `ma_giao_dich` varchar(255) NOT NULL,
  `balance` double NOT NULL,
  `expired_time` datetime DEFAULT NULL,
  `ghi_chu` varchar(255) DEFAULT NULL,
  `status` bit(1) NOT NULL,
  `un_debt_ids` varchar(255) DEFAULT NULL,
  `ma_sinh_vien` bigint(20) NOT NULL,
  PRIMARY KEY (`ma_giao_dich`),
  KEY `FKf5vbis6scdfd897fgftenakab` (`ma_sinh_vien`),
  CONSTRAINT `FKf5vbis6scdfd897fgftenakab` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: thoi_khoa_bieu
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `thoi_khoa_bieu` (
  `ma_thoi_khoa_bieu` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `ma_giao_vien` bigint(20) NOT NULL,
  PRIMARY KEY (`ma_thoi_khoa_bieu`),
  KEY `FKg4dn0u4fmgtqbncb33box445j` (`ma_lop_hoc_phan`),
  KEY `FKutiwe9oyux8ww29coan5mu0t` (`ma_giao_vien`),
  CONSTRAINT `FKg4dn0u4fmgtqbncb33box445j` FOREIGN KEY (`ma_lop_hoc_phan`) REFERENCES `lop_hoc_phan` (`ma_lop_hoc_phan`),
  CONSTRAINT `FKutiwe9oyux8ww29coan5mu0t` FOREIGN KEY (`ma_giao_vien`) REFERENCES `giao_vien` (`ma_giao_vien`)
) ENGINE = InnoDB AUTO_INCREMENT = 11 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: thoi_khoa_bieu_con
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `thoi_khoa_bieu_con` (
  `ma_thoi_khoa_bieu_con` bigint(20) NOT NULL AUTO_INCREMENT,
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
  `tu_tiet_hoc` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ma_thoi_khoa_bieu_con`),
  KEY `FKnpdt0cxyu9jimfw4ir2l2h1w4` (`ma_thoi_khoa_bieu`),
  KEY `FKq9mk804kal4b8ur4g5yi2gtda` (`ma_giao_vien`),
  CONSTRAINT `FKnpdt0cxyu9jimfw4ir2l2h1w4` FOREIGN KEY (`ma_thoi_khoa_bieu`) REFERENCES `thoi_khoa_bieu` (`ma_thoi_khoa_bieu`),
  CONSTRAINT `FKq9mk804kal4b8ur4g5yi2gtda` FOREIGN KEY (`ma_giao_vien`) REFERENCES `giao_vien` (`ma_giao_vien`)
) ENGINE = InnoDB AUTO_INCREMENT = 10 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: thong_bao
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `thong_bao` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `create_at` datetime DEFAULT NULL,
  `is_read` bit(1) NOT NULL,
  `linking` varchar(255) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `ma_sinh_vien` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKc9wew8egsdia4kif8ikm62g44` (`ma_sinh_vien`),
  CONSTRAINT `FKc9wew8egsdia4kif8ikm62g44` FOREIGN KEY (`ma_sinh_vien`) REFERENCES `sinh_vien` (`ma_sinh_vien`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: thong_bao_khoa
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `thong_bao_khoa` (
  `ma_thong_bao` bigint(20) NOT NULL AUTO_INCREMENT,
  `ngay_xuat_ban` date DEFAULT NULL,
  `noi_dung` text DEFAULT NULL,
  `tieu_de` varchar(255) DEFAULT NULL,
  `ma_khoa` bigint(20) NOT NULL,
  PRIMARY KEY (`ma_thong_bao`),
  KEY `FKbqgh4gmlh31n757e70nnh6pww` (`ma_khoa`),
  CONSTRAINT `FKbqgh4gmlh31n757e70nnh6pww` FOREIGN KEY (`ma_khoa`) REFERENCES `khoa` (`ma_khoa`)
) ENGINE = InnoDB AUTO_INCREMENT = 2 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: token
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `token` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `token` text DEFAULT NULL,
  `token_exp_date` datetime DEFAULT NULL,
  `created_by` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKq5g30l3l475dgnvd85fe254ln` (`created_by`),
  CONSTRAINT `FKq5g30l3l475dgnvd85fe254ln` FOREIGN KEY (`created_by`) REFERENCES `user` (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 5 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: user
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE = InnoDB AUTO_INCREMENT = 15 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: user_role_map
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `user_role_map` (
  `id_user` bigint(20) NOT NULL,
  `id_role` bigint(20) NOT NULL,
  PRIMARY KEY (`id_user`, `id_role`),
  KEY `FKj1ggj17aib8c49ppm5pxj42o7` (`id_role`),
  CONSTRAINT `FKj1ggj17aib8c49ppm5pxj42o7` FOREIGN KEY (`id_role`) REFERENCES `role` (`id`),
  CONSTRAINT `FKyjdp00usiuj07xumj63fh0du` FOREIGN KEY (`id_user`) REFERENCES `user` (`id`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: chuong_trinh_khung
# ------------------------------------------------------------

INSERT INTO
  `chuong_trinh_khung` (`id`, `done`, `ma_mon_hoc`, `ma_sinh_vien`)
VALUES
  (3, b'1', 1000081, 19524791);
INSERT INTO
  `chuong_trinh_khung` (`id`, `done`, `ma_mon_hoc`, `ma_sinh_vien`)
VALUES
  (6, b'1', 1000082, 19524791);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: cong_no
# ------------------------------------------------------------

INSERT INTO
  `cong_no` (
    `id`,
    `cong_no`,
    `da_nop`,
    `khau_tru`,
    `mien_giam`,
    `so_tien`,
    `trang_thai`,
    `ma_lop_hoc_phan`,
    `ma_mon_hoc`,
    `ma_sinh_vien`
  )
VALUES
  (1, 0, 4250000, 0, 0, 0, 'DA_NOP', 1, 1000081, 19524791);
INSERT INTO
  `cong_no` (
    `id`,
    `cong_no`,
    `da_nop`,
    `khau_tru`,
    `mien_giam`,
    `so_tien`,
    `trang_thai`,
    `ma_lop_hoc_phan`,
    `ma_mon_hoc`,
    `ma_sinh_vien`
  )
VALUES
  (2, 0, 4250000, 0, 0, 0, 'DA_NOP', 2, 1000082, 19524791);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: diem
# ------------------------------------------------------------

INSERT INTO
  `diem` (
    `ma_diem`,
    `diem4`,
    `diemck`,
    `diem_chu`,
    `diemgk`,
    `diemlt1`,
    `diemlt2`,
    `diemlt3`,
    `diemth1`,
    `diemth2`,
    `diemth3`,
    `diem_tong_ket`,
    `ghi_chu`,
    `pass`,
    `xep_loai`,
    `ma_lop_hoc_phan`,
    `ma_sinh_vien`
  )
VALUES
  (
    2,
    2.6,
    7.2,
    'B',
    5,
    6,
    7,
    8,
    0,
    0,
    0,
    6.5,
    'Đạt',
    b'1',
    'TRUNG_BINH_KHA',
    1,
    19524791
  );
INSERT INTO
  `diem` (
    `ma_diem`,
    `diem4`,
    `diemck`,
    `diem_chu`,
    `diemgk`,
    `diemlt1`,
    `diemlt2`,
    `diemlt3`,
    `diemth1`,
    `diemth2`,
    `diemth3`,
    `diem_tong_ket`,
    `ghi_chu`,
    `pass`,
    `xep_loai`,
    `ma_lop_hoc_phan`,
    `ma_sinh_vien`
  )
VALUES
  (
    4,
    1.86667,
    5.5,
    'C',
    5,
    6,
    7,
    7,
    6,
    4,
    4,
    4.66667,
    'Đạt',
    b'1',
    'YEU',
    2,
    19524791
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: giao_vien
# ------------------------------------------------------------

INSERT INTO
  `giao_vien` (
    `ma_giao_vien`,
    `dia_chi`,
    `gioi_tinh`,
    `loai_giao_vien`,
    `ngay_sinh`,
    `sdt`,
    `ten_giao_vien`,
    `ma_tai_khoan`,
    `avatar`
  )
VALUES
  (
    1,
    '163 Bùi Quan Là',
    'NU',
    'GIAO_VIEN_BO_MON',
    '1992-04-22',
    '0338188506',
    'Lê Thị Thanh Tuyết',
    1,
    'https://smilemedia.vn/wp-content/uploads/2022/09/cach-chup-hinh-the-dep.jpeg'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: hoc_ky
# ------------------------------------------------------------

INSERT INTO
  `hoc_ky` (`ma_hoc_ky`, `so_tin_chi`, `ten_hoc_ky`, `ma_nganh`)
VALUES
  (1, 17, 'Học kỳ 1', 2);
INSERT INTO
  `hoc_ky` (`ma_hoc_ky`, `so_tin_chi`, `ten_hoc_ky`, `ma_nganh`)
VALUES
  (2, 23, 'Học kỳ 2', 2);
INSERT INTO
  `hoc_ky` (`ma_hoc_ky`, `so_tin_chi`, `ten_hoc_ky`, `ma_nganh`)
VALUES
  (3, 27, 'Học kỳ 3', 2);
INSERT INTO
  `hoc_ky` (`ma_hoc_ky`, `so_tin_chi`, `ten_hoc_ky`, `ma_nganh`)
VALUES
  (4, 28, 'Học kỳ 4', 2);
INSERT INTO
  `hoc_ky` (`ma_hoc_ky`, `so_tin_chi`, `ten_hoc_ky`, `ma_nganh`)
VALUES
  (5, 21, 'Học kỳ 5', 2);
INSERT INTO
  `hoc_ky` (`ma_hoc_ky`, `so_tin_chi`, `ten_hoc_ky`, `ma_nganh`)
VALUES
  (6, 17, 'Học kỳ 6', 2);
INSERT INTO
  `hoc_ky` (`ma_hoc_ky`, `so_tin_chi`, `ten_hoc_ky`, `ma_nganh`)
VALUES
  (7, 15, 'Học kỳ 7', 2);
INSERT INTO
  `hoc_ky` (`ma_hoc_ky`, `so_tin_chi`, `ten_hoc_ky`, `ma_nganh`)
VALUES
  (8, 10, 'Học kỳ 8', 2);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: khoa
# ------------------------------------------------------------

INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (1, 'Khoa Công Nghệ Thông Tin');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (2, 'Khoa Công Nghệ Cơ Khí');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (3, 'Khoa Công Nghệ Điện');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (4, 'Koa Công Nghệ Điện Tử');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (5, 'Khoa Công Nghệ Động Lực');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (6, 'Khoa Công Nghệ Nhiệt Lạnh');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (7, 'Khoa Công Nghệ May - Thời Trang');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (8, 'Khoa Công Nghệ Hóa Học');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (9, 'Khoa Kế Toán - Kiểm Toán');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (10, 'Khoa Khoa Học Cơ Bản');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (11, 'Khoa Lý Luận Chính Trị');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (12, 'Khoa Ngoại Ngữ');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (13, 'Khoa Quản Trị Kinh Doanh');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (14, 'Khoa Tài Chính - Ngân Hàng');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (15, 'Khoa Thương Mại - Du Lịch');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (16, 'Khoa Kỹ Thuật Xây Dựng');
INSERT INTO
  `khoa` (`ma_khoa`, `ten_khoa`)
VALUES
  (17, 'Khoa Luật');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: khoa_hoc
# ------------------------------------------------------------

INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (1, 'Học kỳ 1', 2019, 2020, 'HOC_KY_I', 1);
INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (2, 'Học kỳ 2', 2019, 2020, 'HOC_KY_II', 2);
INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (3, 'Học kỳ 3', 2019, 2020, 'HOC_KY_III', NULL);
INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (4, 'Học kỳ 1', 2020, 2021, 'HOC_KY_I', 3);
INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (5, 'Học kỳ 2', 2020, 2021, 'HOC_KY_II', 4);
INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (6, 'Học kỳ 3', 2020, 2021, 'HOC_KY_III', NULL);
INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (7, 'Học kỳ 1', 2021, 2022, 'HOC_KY_I', 5);
INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (8, 'Học kỳ 2', 2021, 2022, 'HOC_KY_II', 6);
INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (9, 'Học kỳ 3', 2021, 2022, 'HOC_KY_III', NULL);
INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (10, 'Học kỳ 1', 2022, 2023, 'HOC_KY_I', 7);
INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (11, 'Học kỳ 2', 2022, 2023, 'HOC_KY_II', 8);
INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (12, 'Học kỳ 3', 2022, 2023, 'HOC_KY_III', NULL);
INSERT INTO
  `khoa_hoc` (
    `ma_khoa_hoc`,
    `alias`,
    `nam_bat_dau`,
    `nam_ket_thuc`,
    `ten_khoa_hoc`,
    `ma_hoc_ky`
  )
VALUES
  (13, 'Học kỳ 1', 2023, 2024, 'HOC_KY_I', 1);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: lop_hoc_danh_nghia
# ------------------------------------------------------------

INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (1, 50, 'DHKTPM11ATT', 1, 1, 2);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (2, 31, 'DHKTPM1ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (3, 32, 'DHKTPM2ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (4, 31, 'DHKTPM1ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (5, 32, 'DHKTPM2ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (6, 31, 'DHKTPM1ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (7, 32, 'DHKTPM2ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (8, 31, 'DHKTPM1ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (9, 32, 'DHKTPM2ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (10, 31, 'DHKTPM1ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (11, 32, 'DHKTPM2ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (12, 31, 'DHKTPM1ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (13, 32, 'DHKTPM2ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (14, 31, 'DHKTPM1ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (15, 32, 'DHKTPM2ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (16, 31, 'DHKTPM1ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (17, 32, 'DHKTPM2ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (18, 31, 'DHKTPM1ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (19, 32, 'DHKTPM2ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (20, 31, 'DHKTPM1ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (21, 32, 'DHKTPM2ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (22, 31, 'DHKTPM1ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (23, 32, 'DHKTPM2ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (24, 31, 'DHKTPM1ATT', 1, 1, 1);
INSERT INTO
  `lop_hoc_danh_nghia` (
    `ma_lop`,
    `so_luong`,
    `ten_lop`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_nganh`
  )
VALUES
  (25, 32, 'DHKTPM2ATT', 1, 1, 1);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: lop_hoc_phan
# ------------------------------------------------------------

INSERT INTO
  `lop_hoc_phan` (
    `ma_lop_hoc_phan`,
    `han_nop_hoc_phi`,
    `loai_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `so_luong`,
    `so_luong_max`,
    `ten_lop_hoc_phan`,
    `trang_thai`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_mon_hoc`
  )
VALUES
  (
    1,
    '2023-02-12',
    'HOC_MOI',
    '2023-02-12',
    '2023-03-31',
    0,
    23,
    'DHKTPM15CTT',
    'DA_KHOA',
    1,
    11,
    1000081
  );
INSERT INTO
  `lop_hoc_phan` (
    `ma_lop_hoc_phan`,
    `han_nop_hoc_phi`,
    `loai_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `so_luong`,
    `so_luong_max`,
    `ten_lop_hoc_phan`,
    `trang_thai`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_mon_hoc`
  )
VALUES
  (
    2,
    '2023-03-12',
    'HOC_MOI',
    '2023-03-12',
    '2023-03-31',
    1,
    55,
    'DHKTPM15ATT',
    'CHAP_NHAN_MO_LOP',
    1,
    11,
    1000082
  );
INSERT INTO
  `lop_hoc_phan` (
    `ma_lop_hoc_phan`,
    `han_nop_hoc_phi`,
    `loai_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `so_luong`,
    `so_luong_max`,
    `ten_lop_hoc_phan`,
    `trang_thai`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_mon_hoc`
  )
VALUES
  (
    3,
    '2023-03-01',
    'HOC_MOI',
    '1899-11-01',
    '2023-03-30',
    3,
    44,
    'DHKTPM15ATT',
    'DANG_CHO_SINH_VIEN_DANG_KY',
    1,
    11,
    1000080
  );
INSERT INTO
  `lop_hoc_phan` (
    `ma_lop_hoc_phan`,
    `han_nop_hoc_phi`,
    `loai_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `so_luong`,
    `so_luong_max`,
    `ten_lop_hoc_phan`,
    `trang_thai`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_mon_hoc`
  )
VALUES
  (
    4,
    '2023-04-01',
    'HOC_MOI',
    '2023-04-01',
    '2023-04-30',
    0,
    32,
    'DHKTPM16',
    'DANG_CHO_SINH_VIEN_DANG_KY',
    1,
    1,
    1000001
  );
INSERT INTO
  `lop_hoc_phan` (
    `ma_lop_hoc_phan`,
    `han_nop_hoc_phi`,
    `loai_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `so_luong`,
    `so_luong_max`,
    `ten_lop_hoc_phan`,
    `trang_thai`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_mon_hoc`
  )
VALUES
  (
    5,
    '2023-04-01',
    'HOC_MOI',
    '2023-04-01',
    '2023-04-30',
    0,
    33,
    'DHKTPM16S',
    'DANG_CHO_SINH_VIEN_DANG_KY',
    1,
    1,
    1000001
  );
INSERT INTO
  `lop_hoc_phan` (
    `ma_lop_hoc_phan`,
    `han_nop_hoc_phi`,
    `loai_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `so_luong`,
    `so_luong_max`,
    `ten_lop_hoc_phan`,
    `trang_thai`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_mon_hoc`
  )
VALUES
  (
    6,
    '2023-04-05',
    'HOC_MOI',
    '2023-04-05',
    '2023-04-30',
    30,
    44,
    'DHKTPM12B',
    'DANG_CHO_SINH_VIEN_DANG_KY',
    1,
    11,
    1000080
  );
INSERT INTO
  `lop_hoc_phan` (
    `ma_lop_hoc_phan`,
    `han_nop_hoc_phi`,
    `loai_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `so_luong`,
    `so_luong_max`,
    `ten_lop_hoc_phan`,
    `trang_thai`,
    `ma_giao_vien`,
    `ma_khoa_hoc`,
    `ma_mon_hoc`
  )
VALUES
  (
    7,
    '2023-04-25',
    'HOC_MOI',
    '2023-04-25',
    '2023-04-30',
    0,
    22,
    'DHKTPM1ATT',
    'DANG_CHO_SINH_VIEN_DANG_KY',
    1,
    13,
    1000001
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: mon_hoc
# ------------------------------------------------------------

INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000001,
    1700000,
    'BAT_BUOC',
    0,
    0,
    30,
    0,
    2,
    'Nhập môn tin học',
    1,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000002,
    3400000,
    'SUPER_BAT_BUOC',
    0,
    0,
    60,
    0,
    4,
    'Giáo dục quốc phòng và an ninh 1',
    1,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000003,
    1700000,
    'SUPER_BAT_BUOC',
    0,
    0,
    0,
    60,
    2,
    'Giáo dục thể chất 1',
    1,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000004,
    1700000,
    'BAT_BUOC',
    0,
    0,
    30,
    0,
    2,
    'Toán cao cấp 1',
    1,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000005,
    1700000,
    'BAT_BUOC',
    0,
    0,
    0,
    60,
    2,
    'Nhập môn lập trình',
    1,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000006,
    2550000,
    'BAT_BUOC',
    0,
    0,
    45,
    0,
    3,
    'Triết học Mác - Lênin',
    1,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000007,
    1700000,
    'BAT_BUOC',
    0,
    0,
    30,
    0,
    2,
    'Kinh tế chính trị Mác-Lênin',
    1,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000008,
    2550000,
    'BAT_BUOC',
    0,
    0,
    30,
    0,
    3,
    'Anh văn 1',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000009,
    2550000,
    'BAT_BUOC',
    1000005,
    0,
    30,
    30,
    3,
    'Kỹ thuật lập trình',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000010,
    1700000,
    'BAT_BUOC',
    0,
    0,
    30,
    0,
    2,
    'Kỹ năng làm việc nhóm',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000011,
    1700000,
    'BAT_BUOC',
    0,
    0,
    30,
    0,
    2,
    'Toán cao cấp 2',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000012,
    3400000,
    'SUPER_BAT_BUOC',
    0,
    0,
    30,
    60,
    4,
    'Giáo dục Quốc phòng và An ninh 2',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000013,
    1700000,
    'SUPER_BAT_BUOC',
    0,
    0,
    0,
    60,
    2,
    'Giáo dục thể chất 2',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000014,
    3400000,
    'BAT_BUOC',
    0,
    0,
    45,
    30,
    4,
    'Hệ thống máy tính',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000015,
    2550000,
    'TU_CHON',
    0,
    1,
    45,
    0,
    3,
    'Tâm lý học đại cương',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000016,
    2550000,
    'TU_CHON',
    0,
    1,
    45,
    0,
    3,
    'Tiếng Việt thực hành',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000017,
    2550000,
    'TU_CHON',
    0,
    1,
    45,
    0,
    3,
    'Âm nhạc – Nhạc lý và Guitar căn bản',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000018,
    2550000,
    'TU_CHON',
    0,
    1,
    45,
    0,
    3,
    'Xã hội học',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000019,
    2550000,
    'TU_CHON',
    0,
    1,
    45,
    0,
    3,
    'Cơ sở văn hóa Việt Nam',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000020,
    2550000,
    'TU_CHON',
    0,
    1,
    45,
    0,
    3,
    'Hội họa',
    2,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000021,
    3400000,
    'BAT_BUOC',
    1000008,
    0,
    60,
    0,
    4,
    'Anh văn 2',
    3,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000022,
    2550000,
    'BAT_BUOC',
    0,
    0,
    45,
    0,
    3,
    'Cấu trúc rời rạc',
    3,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000023,
    3400000,
    'BAT_BUOC',
    1000005,
    0,
    45,
    30,
    4,
    'Cấu trúc dữ liệu và giải thuật',
    3,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000024,
    3400000,
    'BAT_BUOC',
    1000001,
    0,
    45,
    30,
    4,
    'Hệ cơ sở dữ liệu',
    3,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000025,
    2550000,
    'BAT_BUOC',
    0,
    0,
    45,
    0,
    3,
    'Mạng máy tính',
    3,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000026,
    2550000,
    'BAT_BUOC',
    1000005,
    0,
    30,
    30,
    3,
    'Lập trình hướng đối tượng',
    3,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000027,
    2550000,
    'BAT_BUOC',
    0,
    0,
    45,
    0,
    3,
    'Sự phát triển của lịch sử và công nghệ',
    3,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000028,
    2550000,
    'TU_CHON',
    0,
    1,
    45,
    0,
    3,
    'Phương pháp tính',
    3,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000029,
    2550000,
    'TU_CHON',
    0,
    1,
    45,
    0,
    3,
    'Vật lý đại cương',
    3,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000030,
    2550000,
    'TU_CHON',
    0,
    1,
    45,
    0,
    3,
    'Toán ứng dụng',
    3,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000031,
    2550000,
    'TU_CHON',
    0,
    1,
    45,
    0,
    3,
    'Hàm phức và phép biến đổi Laplace',
    3,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000032,
    2550000,
    'TU_CHON',
    0,
    1,
    45,
    0,
    3,
    'Logic học',
    3,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000033,
    3400000,
    'BAT_BUOC',
    1000021,
    0,
    60,
    0,
    4,
    'Anh văn 3',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000034,
    2550000,
    'BAT_BUOC',
    1000022,
    0,
    45,
    0,
    3,
    'Lý thuyết đồ thị',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000035,
    2550000,
    'BAT_BUOC',
    0,
    0,
    30,
    30,
    3,
    'Hệ Thống và Công nghệ Web',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000036,
    1700000,
    'BAT_BUOC',
    0,
    0,
    30,
    0,
    2,
    'Phương pháp luận nghiên cứu khoa học',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000037,
    2550000,
    'BAT_BUOC',
    1000024,
    0,
    30,
    30,
    3,
    'Phân tích thiết kế hệ thống',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000038,
    2550000,
    'BAT_BUOC',
    1000009,
    0,
    30,
    30,
    3,
    'Thống kê máy tính và ứng dụng',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000039,
    2550000,
    'TU_CHON',
    1000024,
    1,
    30,
    30,
    3,
    'Hệ quản trị cơ sở dữ liệu',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000040,
    2550000,
    'TU_CHON',
    1000014,
    1,
    45,
    0,
    3,
    'Tương tác người máy',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000041,
    2550000,
    'TU_CHON',
    0,
    1,
    30,
    30,
    3,
    'Thương mại điện tử',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000042,
    3400000,
    'TU_CHON',
    1000005,
    2,
    45,
    30,
    4,
    'Lập trình hướng sự kiện với công nghệ Java',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000043,
    3400000,
    'TU_CHON',
    1000005,
    2,
    45,
    30,
    4,
    'Lập Trình Hướng Sự Kiện với Công Nghệ .NET',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000044,
    3400000,
    'TU_CHON',
    1000005,
    2,
    45,
    30,
    4,
    'Lập trình GUI với Qt Framework',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000045,
    2550000,
    'TU_CHON',
    0,
    3,
    45,
    0,
    3,
    'Quản trị học',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000046,
    2550000,
    'TU_CHON',
    0,
    3,
    45,
    0,
    3,
    'Kỹ năng xây dựng kế hoạch',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000047,
    2550000,
    'TU_CHON',
    0,
    3,
    45,
    0,
    3,
    'Giao tiếp kinh doanh',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000048,
    2550000,
    'TU_CHON',
    0,
    3,
    45,
    0,
    3,
    'Quản trị doanh nghiệp',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000049,
    2550000,
    'TU_CHON',
    0,
    3,
    45,
    0,
    3,
    'Kế toán cơ bản',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000050,
    2550000,
    'TU_CHON',
    0,
    3,
    45,
    0,
    3,
    'Môi trường và con người',
    4,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000051,
    2550000,
    'BAT_BUOC',
    1000033,
    0,
    45,
    0,
    3,
    'Anh văn 4',
    5,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000052,
    2550000,
    'BAT_BUOC',
    1000014,
    0,
    45,
    0,
    3,
    'Nhập môn an toàn thông tin',
    5,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000053,
    2550000,
    'BAT_BUOC',
    1000026,
    0,
    45,
    0,
    3,
    'Công nghệ phần mềm',
    5,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000054,
    2550000,
    'BAT_BUOC',
    0,
    0,
    45,
    0,
    3,
    'Những vấn đề xã hội và đạo đức nghề nghiệp',
    5,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000055,
    2550000,
    'BAT_BUOC',
    0,
    0,
    30,
    30,
    3,
    'Phát triển ứng dụng',
    5,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000056,
    2550000,
    'TU_CHON',
    1000042,
    1,
    30,
    30,
    3,
    'Lập trình phân tán với công nghệ Java',
    5,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000057,
    2550000,
    'TU_CHON',
    1000043,
    1,
    30,
    30,
    3,
    'Lập trình Phân Tán Công Nghệ .NET',
    5,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000058,
    2550000,
    'TU_CHON',
    1000044,
    1,
    30,
    30,
    3,
    'Lập trình mạng với Qt Framework',
    5,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000059,
    2550000,
    'TU_CHON',
    1000009,
    2,
    30,
    30,
    3,
    'Lập trình phân tích dữ liệu 1',
    5,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000060,
    2550000,
    'TU_CHON',
    1000024,
    2,
    30,
    30,
    3,
    'Khai thác dữ liệu và ứng dụng',
    5,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000061,
    2550000,
    'TU_CHON',
    0,
    2,
    30,
    30,
    3,
    'Kỹ thuật điện tử',
    5,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000062,
    3400000,
    'BAT_BUOC',
    0,
    0,
    45,
    30,
    4,
    'Lập trình thiết bị di động',
    6,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000063,
    1700000,
    'BAT_BUOC',
    0,
    0,
    30,
    0,
    2,
    'Pháp luật đại cương',
    6,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000064,
    2550000,
    'BAT_BUOC',
    1000053,
    0,
    30,
    30,
    3,
    'Đảm bảo chất lượng và Kiểm thử phần mềm',
    6,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000065,
    1700000,
    'BAT_BUOC',
    0,
    0,
    30,
    0,
    2,
    'Chủ nghĩa xã hội khoa học',
    6,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000066,
    3400000,
    'TU_CHON',
    1000035,
    1,
    45,
    30,
    4,
    'Lập trình WWW (Java)',
    6,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000067,
    3400000,
    'TU_CHON',
    0,
    1,
    30,
    60,
    4,
    'Lập trình IoTs',
    6,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000068,
    3400000,
    'TU_CHON',
    1000035,
    1,
    45,
    30,
    4,
    'Lập trình WWW (.NET)',
    6,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000069,
    3400000,
    'TU_CHON',
    1000058,
    1,
    45,
    30,
    4,
    'Phát triển ứng dụng Web với Qt Engine',
    6,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000070,
    1700000,
    'BAT_BUOC',
    0,
    0,
    30,
    0,
    2,
    'Tư tưởng Hồ Chí Minh',
    7,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000071,
    1700000,
    'BAT_BUOC',
    1000037,
    0,
    30,
    0,
    2,
    'Kiến trúc và Thiết kế phần mềm',
    7,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000072,
    2550000,
    'BAT_BUOC',
    0,
    0,
    30,
    30,
    3,
    'Công nghệ mới trong phát triển ứng dụng CNTT',
    7,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000073,
    2550000,
    'TU_CHON',
    1000034,
    1,
    45,
    0,
    3,
    'Automat & ngôn ngữ hình thức',
    7,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000074,
    2550000,
    'TU_CHON',
    0,
    1,
    30,
    30,
    3,
    'Tiếp thị điện tử',
    7,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000075,
    2550000,
    'TU_CHON',
    1000038,
    1,
    30,
    30,
    3,
    'Lập trình phân tích dữ liệu 2',
    7,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000076,
    2550000,
    'TU_CHON',
    1000024,
    1,
    30,
    30,
    3,
    'Nhập môn dữ liệu lớn',
    7,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000077,
    2550000,
    'TU_CHON',
    1000062,
    1,
    30,
    30,
    3,
    'Lập trình thiết bị di động nâng cao',
    7,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000078,
    2550000,
    'TU_CHON',
    0,
    1,
    30,
    30,
    3,
    'Quản lý dự án CNTT',
    7,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000079,
    2550000,
    'TU_CHON',
    0,
    1,
    30,
    30,
    3,
    'Kiến trúc hướng dịch vụ và Điện toán đám mây',
    7,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000080,
    850000,
    'SUPER_BAT_BUOC',
    0,
    0,
    0,
    0,
    1,
    'Chứng chỉ TOEIC 450',
    8,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000081,
    4250000,
    'BAT_BUOC',
    0,
    0,
    0,
    150,
    5,
    'Thực tập doanh nghiệp',
    8,
    2
  );
INSERT INTO
  `mon_hoc` (
    `ma_mon_hoc`,
    `hoc_phi`,
    `loai_mon`,
    `ma_mon_yeu_cau`,
    `nhom_mon`,
    `so_tietlt`,
    `so_tietth`,
    `so_tin_chi`,
    `ten_mon_hoc`,
    `ma_hoc_ky`,
    `ma_nganh`
  )
VALUES
  (
    1000082,
    4250000,
    'BAT_BUOC',
    0,
    0,
    0,
    150,
    5,
    'Khóa luận tốt nghiệp',
    8,
    2
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: nganh
# ------------------------------------------------------------

INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (1, 'Công nghệ thông tin', 1);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (2, 'Kỹ thuật phần mềm', 1);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (3, 'Khoa học máy tính', 1);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (4, 'Công nghệ kỹ thuật cơ khí', 2);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (5, 'Công nghệ Chế tạo máy', 2);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (6, 'Kỹ thuật điện', 3);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (7, 'Điều khiển tự động', 3);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (8, 'Công nghệ kỹ thuật điện tử', 4);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (9, 'Năng lượng tái tạo', 4);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (10, 'Điện tử công nghiệp', 4);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (11, 'Công nghệ kỹ thuật ô tô', 5);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (12, 'Công nghệ Kỹ thuật nhiệt', 6);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (13, 'Công nghệ May', 7);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (14, 'Thiết kế thời trang', 7);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (15, 'Công nghệ Hữu cơ', 8);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (16, 'Công nghệ Vô cơ-Vật liệu', 8);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (17, 'Công nghệ Hóa dầu', 8);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (18, 'Kỹ thuật Hóa phân tích', 8);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (19, 'Kế toán', 9);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (20, 'Kiểm toán', 9);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (21, 'Khoa học dữ liệu', 10);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (22, 'Lý luận chính trị', 11);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (23, 'Ngôn Ngữ Anh', 12);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (24, 'Quản trị kinh doanh', 13);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (25, 'Quản trị cung ứng và logistic', 13);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (26, 'Quản trị nhân sự', 13);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (27, 'Quản trị marketing', 13);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (28, 'Tài chính – Ngân hàng', 14);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (29, 'Tài chính doanh nghiệp', 14);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (30, 'Kinh doanh quốc tế', 15);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (31, 'Thương mại điện tử', 15);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (32, 'Quản trị dịch vụ du lịch và lữ hành', 15);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (33, 'Quản trị khách sạn', 15);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (34, 'Quản trị nhà hàng và dịch vụ ăn uống', 15);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (35, 'Kỹ thuật xây dựng', 16);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (36, 'Kỹ thuật xây dựng công trình giao thông', 16);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (37, 'Luật kinh tế', 17);
INSERT INTO
  `nganh` (`ma_nganh`, `ten_nganh`, `ma_khoa`)
VALUES
  (38, 'Luật quốc tế', 17);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: nhan_vien
# ------------------------------------------------------------

INSERT INTO
  `nhan_vien` (
    `ma_nhan_vien`,
    `chuc_vu`,
    `dia_chi`,
    `sdt`,
    `ten_nhan_vien`,
    `ma_tai_khoan`,
    `avatar`,
    `gioi_tinh`,
    `last_backup`,
    `nam_sinh`,
    `ngay_vao_lam`
  )
VALUES
  (
    21052002,
    'THU_THU',
    '60/122 To 10 KP8 Phuong TCH Q12 TP.HCM, Đường Huỳnh Thị Hai',
    '0338188506',
    'Lê Văn Tùng',
    2,
    'https://res.cloudinary.com/dopzctbyo/image/upload/v1672644566/sv-iuh-avatar-pattern_oyubmc.jpg',
    'NAM',
    NULL,
    2001,
    '2005-04-28'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: permission
# ------------------------------------------------------------

INSERT INTO
  `permission` (`id`, `permission`)
VALUES
  (1, 'member.read');
INSERT INTO
  `permission` (`id`, `permission`)
VALUES
  (2, 'member.write');
INSERT INTO
  `permission` (`id`, `permission`)
VALUES
  (3, '*');
INSERT INTO
  `permission` (`id`, `permission`)
VALUES
  (4, 'employee.read');
INSERT INTO
  `permission` (`id`, `permission`)
VALUES
  (5, 'employee.write');
INSERT INTO
  `permission` (`id`, `permission`)
VALUES
  (6, 'teacher.read');
INSERT INTO
  `permission` (`id`, `permission`)
VALUES
  (7, 'teacher.write');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: phieu_thu
# ------------------------------------------------------------

INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    1,
    'Ngân hàng Agribank',
    'Giao dich truc tiep tai QGD GoVap',
    '2023-02-04',
    15300000,
    'DANG_CHO_XU_LY',
    19524791,
    'znUfmIVh',
    'OUT'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    2,
    'PAYPAL - WALLET',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 0 ₫',
    '2023-03-05',
    4250000,
    'DA_XU_LY',
    19524791,
    'NSvb1geq',
    'OUT'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    15,
    'SỐ DƯ VÍ',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 12.450.000 ₫. Số tiến đã thanh toán thành công: 850.000 ₫. Số tiền thanh toán dư còn lại: 11.600.000 ₫',
    '2023-03-25',
    850000,
    'DA_XU_LY',
    19524791,
    'km1wA95q',
    'IN'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    16,
    '\'PAYPAL - WALLET\'',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 50.000 ₫. Số tiến đã thanh toán thành công: 50.000 ₫. Số tiền dư thanh toán còn lại: 11.650.000 ₫',
    '2023-03-26',
    50000,
    'DA_XU_LY',
    19524791,
    'EperQQpK',
    'IN'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    17,
    '\'PAYPAL - WALLET\'',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 50.000 ₫. Số tiến đã thanh toán thành công: 50.000 ₫. Số tiền dư thanh toán còn lại: 11.700.000 ₫',
    '2023-03-26',
    50000,
    'DA_XU_LY',
    19524791,
    'tAPsTH0j',
    'IN'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    18,
    '\'PAYPAL - WALLET\'',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 50.000 ₫. Số tiến đã thanh toán thành công: 50.000 ₫. Số tiền dư thanh toán còn lại: 11.750.000 ₫',
    '2023-03-26',
    50000,
    'DA_XU_LY',
    19524791,
    '1b8M39Ap',
    'IN'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    19,
    '\'PAYPAL - WALLET\'',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 500.000 ₫. Số tiến đã thanh toán thành công: 500.000 ₫. Số tiền dư thanh toán còn lại: 12.250.000 ₫',
    '2023-03-28',
    500000,
    'DA_XU_LY',
    19524791,
    'vxx5lT26',
    'IN'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    20,
    NULL,
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.226.550 ₫',
    '2023-04-01',
    23450,
    'DA_XU_LY',
    19524791,
    'ZlUaDWXP',
    'OUT'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    21,
    NULL,
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.203.100 ₫',
    '2023-04-01',
    23450,
    'DA_XU_LY',
    19524791,
    'iBy5Bftn',
    'OUT'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    22,
    NULL,
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.179.650 ₫',
    '2023-04-02',
    23450,
    'DA_XU_LY',
    19524791,
    'Vd3jiQPP',
    'OUT'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    23,
    NULL,
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.156.200 ₫',
    '2023-04-02',
    23450,
    'DA_XU_LY',
    19524791,
    'lMFP434j',
    'OUT'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    24,
    NULL,
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.132.750 ₫',
    '2023-04-02',
    23450,
    'DA_XU_LY',
    19524791,
    'NE2ZMJX6',
    'OUT'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    25,
    'PAYPAL - WALLET',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.156.200 ₫',
    '2023-04-02',
    23450,
    'DA_XU_LY',
    19524791,
    '0tYr3oi3',
    'IN'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    26,
    'PAYPAL - WALLET',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.179.650 ₫',
    '2023-04-02',
    23450,
    'DA_XU_LY',
    19524791,
    '0tYr3oi3',
    'IN'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    27,
    'PAYPAL - WALLET',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.203.100 ₫',
    '2023-04-02',
    23450,
    'DA_XU_LY',
    19524791,
    '0tYr3oi3',
    'IN'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    28,
    'PAYPAL - WALLET',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.226.550 ₫',
    '2023-04-02',
    23450,
    'DA_XU_LY',
    19524791,
    '0tYr3oi3',
    'IN'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    29,
    'STUDENT - WALLET',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 28.760.550 ₫',
    '2023-04-09',
    4250000,
    'DA_XU_LY',
    19524791,
    'Gr48LnkU',
    'OUT'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    30,
    'STUDENT - WALLET',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 24.510.550 ₫',
    '2023-04-09',
    4250000,
    'DA_XU_LY',
    19524791,
    'LJNLEdnM',
    'OUT'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    31,
    'PAYPAL - WALLET',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 49.949 ₫. Số tiến đã thanh toán thành công: 49.949 ₫. Số tiền dư thanh toán còn lại: 24.560.499 ₫',
    '2023-04-15',
    49948.5,
    'DA_XU_LY',
    19524791,
    'E8ohiFLJ',
    'IN'
  );
INSERT INTO
  `phieu_thu` (
    `ma_phieu_thu`,
    `don_vi_thu`,
    `ghi_chu`,
    `ngay_thu`,
    `so_tien`,
    `trang_thai`,
    `ma_sinh_vien`,
    `ma_giao_dich`,
    `loai_phieu_thu`
  )
VALUES
  (
    32,
    'PAYPAL - WALLET',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 49.949 ₫. Số tiến đã thanh toán thành công: 49.949 ₫. Số tiền dư thanh toán còn lại: 24.610.447 ₫',
    '2023-04-15',
    49948.5,
    'DA_XU_LY',
    19524791,
    'G4Ib1daZ',
    'IN'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: role
# ------------------------------------------------------------

INSERT INTO
  `role` (`id`, `name`)
VALUES
  (1, 'MEMBER');
INSERT INTO
  `role` (`id`, `name`)
VALUES
  (2, 'ADMIN');
INSERT INTO
  `role` (`id`, `name`)
VALUES
  (3, 'EMPLOYEE');
INSERT INTO
  `role` (`id`, `name`)
VALUES
  (4, 'TEACHER');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: role_permission_map
# ------------------------------------------------------------

INSERT INTO
  `role_permission_map` (`id_role`, `id_permission`)
VALUES
  (1, 1);
INSERT INTO
  `role_permission_map` (`id_role`, `id_permission`)
VALUES
  (1, 2);
INSERT INTO
  `role_permission_map` (`id_role`, `id_permission`)
VALUES
  (2, 3);
INSERT INTO
  `role_permission_map` (`id_role`, `id_permission`)
VALUES
  (3, 4);
INSERT INTO
  `role_permission_map` (`id_role`, `id_permission`)
VALUES
  (3, 5);
INSERT INTO
  `role_permission_map` (`id_role`, `id_permission`)
VALUES
  (4, 6);
INSERT INTO
  `role_permission_map` (`id_role`, `id_permission`)
VALUES
  (4, 7);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: sinh_vien
# ------------------------------------------------------------

INSERT INTO
  `sinh_vien` (
    `ma_sinh_vien`,
    `avatar`,
    `cccd`,
    `bac_dao_tao`,
    `co_so`,
    `loai_hinh_dao_tao`,
    `dia_chi`,
    `gioi_tinh`,
    `ho_ten`,
    `ngay_sinh`,
    `ngay_vao_truong`,
    `noi_sinh`,
    `sdt`,
    `so_du`,
    `tot_nghiep`,
    `ma_lop_danh_nghia`,
    `ma_tai_khoan`
  )
VALUES
  (
    2,
    'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg',
    '079201030774',
    'DAI_HOC',
    'HA_NOI',
    'CHAT_LUONG_CAO',
    '60/122 KP8 Phường TCH Quận 12 HCM',
    'NAM',
    'Học Sinh B',
    '2020-01-01',
    '2013-01-01',
    'HỒ CHÍ MINH',
    '0338188506',
    24610447,
    b'0',
    1,
    5
  );
INSERT INTO
  `sinh_vien` (
    `ma_sinh_vien`,
    `avatar`,
    `cccd`,
    `bac_dao_tao`,
    `co_so`,
    `loai_hinh_dao_tao`,
    `dia_chi`,
    `gioi_tinh`,
    `ho_ten`,
    `ngay_sinh`,
    `ngay_vao_truong`,
    `noi_sinh`,
    `sdt`,
    `so_du`,
    `tot_nghiep`,
    `ma_lop_danh_nghia`,
    `ma_tai_khoan`
  )
VALUES
  (
    3,
    'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg',
    '079201030774',
    'DAI_HOC',
    'HA_NOI',
    'CHAT_LUONG_CAO',
    '60/122 KP8 Phường TCH Quận 12 HCM',
    'NAM',
    'Học Sinh C',
    '2020-01-01',
    '2019-01-01',
    'HỒ CHÍ MINH',
    '0338188506',
    24610447,
    b'0',
    1,
    6
  );
INSERT INTO
  `sinh_vien` (
    `ma_sinh_vien`,
    `avatar`,
    `cccd`,
    `bac_dao_tao`,
    `co_so`,
    `loai_hinh_dao_tao`,
    `dia_chi`,
    `gioi_tinh`,
    `ho_ten`,
    `ngay_sinh`,
    `ngay_vao_truong`,
    `noi_sinh`,
    `sdt`,
    `so_du`,
    `tot_nghiep`,
    `ma_lop_danh_nghia`,
    `ma_tai_khoan`
  )
VALUES
  (
    4,
    'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg',
    '079201030774',
    'DAI_HOC',
    'HA_NOI',
    'CHAT_LUONG_CAO',
    '60/122 KP8 Phường TCH Quận 12 HCM',
    'NAM',
    'Học Sinh D',
    '2020-01-01',
    '2019-01-01',
    'HỒ CHÍ MINH',
    '0338188506',
    24610447,
    b'0',
    1,
    7
  );
INSERT INTO
  `sinh_vien` (
    `ma_sinh_vien`,
    `avatar`,
    `cccd`,
    `bac_dao_tao`,
    `co_so`,
    `loai_hinh_dao_tao`,
    `dia_chi`,
    `gioi_tinh`,
    `ho_ten`,
    `ngay_sinh`,
    `ngay_vao_truong`,
    `noi_sinh`,
    `sdt`,
    `so_du`,
    `tot_nghiep`,
    `ma_lop_danh_nghia`,
    `ma_tai_khoan`
  )
VALUES
  (
    5,
    'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg',
    '079201030774',
    'DAI_HOC',
    'HA_NOI',
    'CHAT_LUONG_CAO',
    '60/122 KP8 Phường TCH Quận 12 HCM',
    'NAM',
    'Học Sinh E',
    '2020-01-01',
    '2019-01-01',
    'HỒ CHÍ MINH',
    '0338188506',
    24610447,
    b'0',
    1,
    8
  );
INSERT INTO
  `sinh_vien` (
    `ma_sinh_vien`,
    `avatar`,
    `cccd`,
    `bac_dao_tao`,
    `co_so`,
    `loai_hinh_dao_tao`,
    `dia_chi`,
    `gioi_tinh`,
    `ho_ten`,
    `ngay_sinh`,
    `ngay_vao_truong`,
    `noi_sinh`,
    `sdt`,
    `so_du`,
    `tot_nghiep`,
    `ma_lop_danh_nghia`,
    `ma_tai_khoan`
  )
VALUES
  (
    6,
    'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg',
    '079201030774',
    'DAI_HOC',
    'HA_NOI',
    'CHAT_LUONG_CAO',
    '60/122 KP8 Phường TCH Quận 12 HCM',
    'NAM',
    'Học Sinh F',
    '2020-01-01',
    '2019-01-01',
    'HỒ CHÍ MINH',
    '0338188506',
    24610447,
    b'0',
    1,
    9
  );
INSERT INTO
  `sinh_vien` (
    `ma_sinh_vien`,
    `avatar`,
    `cccd`,
    `bac_dao_tao`,
    `co_so`,
    `loai_hinh_dao_tao`,
    `dia_chi`,
    `gioi_tinh`,
    `ho_ten`,
    `ngay_sinh`,
    `ngay_vao_truong`,
    `noi_sinh`,
    `sdt`,
    `so_du`,
    `tot_nghiep`,
    `ma_lop_danh_nghia`,
    `ma_tai_khoan`
  )
VALUES
  (
    7,
    'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg',
    '079201030774',
    'DAI_HOC',
    'HA_NOI',
    'CHAT_LUONG_CAO',
    '60/122 KP8 Phường TCH Quận 12 HCM',
    'NAM',
    'Học Sinh G',
    '2020-01-01',
    '2019-01-01',
    'HỒ CHÍ MINH',
    '0338188506',
    24610447,
    b'0',
    1,
    10
  );
INSERT INTO
  `sinh_vien` (
    `ma_sinh_vien`,
    `avatar`,
    `cccd`,
    `bac_dao_tao`,
    `co_so`,
    `loai_hinh_dao_tao`,
    `dia_chi`,
    `gioi_tinh`,
    `ho_ten`,
    `ngay_sinh`,
    `ngay_vao_truong`,
    `noi_sinh`,
    `sdt`,
    `so_du`,
    `tot_nghiep`,
    `ma_lop_danh_nghia`,
    `ma_tai_khoan`
  )
VALUES
  (
    8,
    'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg',
    '079201030774',
    'DAI_HOC',
    'HA_NOI',
    'CHAT_LUONG_CAO',
    '60/122 KP8 Phường TCH Quận 12 HCM',
    'NAM',
    'Học Sinh H',
    '2020-01-01',
    '2019-01-01',
    'HỒ CHÍ MINH',
    '0338188506',
    24610447,
    b'0',
    1,
    11
  );
INSERT INTO
  `sinh_vien` (
    `ma_sinh_vien`,
    `avatar`,
    `cccd`,
    `bac_dao_tao`,
    `co_so`,
    `loai_hinh_dao_tao`,
    `dia_chi`,
    `gioi_tinh`,
    `ho_ten`,
    `ngay_sinh`,
    `ngay_vao_truong`,
    `noi_sinh`,
    `sdt`,
    `so_du`,
    `tot_nghiep`,
    `ma_lop_danh_nghia`,
    `ma_tai_khoan`
  )
VALUES
  (
    9,
    'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg',
    '079201030774',
    'DAI_HOC',
    'HA_NOI',
    'CHAT_LUONG_CAO',
    '60/122 KP8 Phường TCH Quận 12 HCM',
    'NAM',
    'Học Sinh I',
    '2020-01-01',
    '2000-01-01',
    'HỒ CHÍ MINH',
    '0338188506',
    24610447,
    b'0',
    1,
    12
  );
INSERT INTO
  `sinh_vien` (
    `ma_sinh_vien`,
    `avatar`,
    `cccd`,
    `bac_dao_tao`,
    `co_so`,
    `loai_hinh_dao_tao`,
    `dia_chi`,
    `gioi_tinh`,
    `ho_ten`,
    `ngay_sinh`,
    `ngay_vao_truong`,
    `noi_sinh`,
    `sdt`,
    `so_du`,
    `tot_nghiep`,
    `ma_lop_danh_nghia`,
    `ma_tai_khoan`
  )
VALUES
  (
    10,
    'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg',
    '079201030774',
    'DAI_HOC',
    'HA_NOI',
    'CHAT_LUONG_CAO',
    '60/122 KP8 Phường TCH Quận 12 HCM',
    'NAM',
    'Học Sinh J',
    '2020-01-01',
    '1999-01-01',
    'HỒ CHÍ MINH',
    '0338188506',
    24610447,
    b'0',
    1,
    13
  );
INSERT INTO
  `sinh_vien` (
    `ma_sinh_vien`,
    `avatar`,
    `cccd`,
    `bac_dao_tao`,
    `co_so`,
    `loai_hinh_dao_tao`,
    `dia_chi`,
    `gioi_tinh`,
    `ho_ten`,
    `ngay_sinh`,
    `ngay_vao_truong`,
    `noi_sinh`,
    `sdt`,
    `so_du`,
    `tot_nghiep`,
    `ma_lop_danh_nghia`,
    `ma_tai_khoan`
  )
VALUES
  (
    11,
    'https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg',
    '079201030774',
    'DAI_HOC',
    'HA_NOI',
    'CHAT_LUONG_CAO',
    '60/122 KP8 Phường TCH Quận 12 HCM',
    'NAM',
    'Học Sinh K',
    '2020-01-01',
    '2019-01-01',
    'HỒ CHÍ MINH',
    '0338188506',
    24610447,
    b'0',
    1,
    14
  );
INSERT INTO
  `sinh_vien` (
    `ma_sinh_vien`,
    `avatar`,
    `cccd`,
    `bac_dao_tao`,
    `co_so`,
    `loai_hinh_dao_tao`,
    `dia_chi`,
    `gioi_tinh`,
    `ho_ten`,
    `ngay_sinh`,
    `ngay_vao_truong`,
    `noi_sinh`,
    `sdt`,
    `so_du`,
    `tot_nghiep`,
    `ma_lop_danh_nghia`,
    `ma_tai_khoan`
  )
VALUES
  (
    19524791,
    'https://res.cloudinary.com/dopzctbyo/image/upload/v1672644566/sv-iuh-avatar-pattern_oyubmc.jpg',
    '079201030774',
    'DAI_HOC',
    'HA_NOI',
    'CHAT_LUONG_CAO',
    '60/122 KP8 Phường TCH Quận 12 HCM',
    'NAM',
    'Phan Tấn Tài',
    '2020-01-01',
    '2019-01-01',
    'HỒ CHÍ MINH',
    '0338188506',
    24610447,
    b'0',
    1,
    4
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: sinh_vien_lop_hoc_phan
# ------------------------------------------------------------

INSERT INTO
  `sinh_vien_lop_hoc_phan` (
    `id`,
    `da_thu_hoc_phi`,
    `ngay_dang_ky`,
    `ma_lop_hoc_phan`,
    `ma_sinh_vien`,
    `ma_thoi_khoa_bieu`,
    `ma_thoi_khoa_bieu_con`
  )
VALUES
  (
    3,
    b'1',
    '2023-03-12',
    2,
    19524791,
    6,
    4
  );
INSERT INTO
  `sinh_vien_lop_hoc_phan` (
    `id`,
    `da_thu_hoc_phi`,
    `ngay_dang_ky`,
    `ma_lop_hoc_phan`,
    `ma_sinh_vien`,
    `ma_thoi_khoa_bieu`,
    `ma_thoi_khoa_bieu_con`
  )
VALUES
  (
    7,
    b'1',
    '2023-03-12',
    1,
    19524791,
    1,
    NULL
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: tai_khoan
# ------------------------------------------------------------

INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (1, NULL, 'GIAO_VIEN', 1);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (2, NULL, 'NHAN_VIEN', 2);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (3, 'taiproduaxe@gmail.com', 'ADMIN', 3);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (4, 'taiproduaxe@gmail.com', 'SINH_VIEN', 4);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (5, 'nhito1odraemon@gmail.com', 'SINH_VIEN', 5);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (6, 'phantanduy1234567@gmail.com', 'SINH_VIEN', 6);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (7, 'phantantri1234567@gmail.com', 'SINH_VIEN', 7);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (8, 'nguyenvan8@gmail.com', 'SINH_VIEN', 8);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (9, 'nguyenvan9@gmail.com', 'SINH_VIEN', 9);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (10, 'nguyenvan10@gmail.com', 'SINH_VIEN', 10);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (11, 'nguyenvan11@gmail.com', 'SINH_VIEN', 11);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (12, 'nguyenvan12@gmail.com', 'SINH_VIEN', 12);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (13, 'nguyenvan13@gmail.com', 'SINH_VIEN', 13);
INSERT INTO
  `tai_khoan` (`id`, `email`, `type`, `id_user`)
VALUES
  (14, 'nguyenvan14@gmail.com', 'SINH_VIEN', 14);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: thanh_toan_giao_dich
# ------------------------------------------------------------

INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '02Ywivl5',
    256000000,
    '2023-03-25 22:40:02',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '0aKjahwP',
    256000000,
    '2023-03-25 22:39:50',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '0blvHhlX',
    0,
    '2023-04-09 00:22:27',
    '',
    b'0',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '0dq4zfIB',
    200000,
    '2023-03-26 14:49:45',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '0e0Y9F7P',
    0,
    '2023-04-15 11:56:54',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '0tYr3oi3',
    23450,
    '2023-04-09 09:50:51',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.226.550 ₫',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '15CyF2xg',
    500000,
    '2023-03-26 14:35:34',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '1b8M39Ap',
    50000,
    '2023-03-26 15:33:07',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 50.000 ₫. Số tiến đã thanh toán thành công: 50.000 ₫. Số tiền dư thanh toán còn lại: 11.750.000 ₫',
    b'1',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '1OhJJLU4',
    4250000,
    '2023-03-05 10:26:16',
    '',
    b'0',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '3CGkOmkK',
    850000,
    '2023-03-26 11:29:29',
    '',
    b'0',
    '27',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '3KPwstnm',
    0,
    '2023-04-01 22:39:19',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '5vjRPFPX',
    500000,
    '2023-03-26 10:39:53',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '6mnpFmW4',
    0,
    '2023-04-15 11:54:13',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '8vN6Bbut',
    50000,
    '2023-03-26 10:35:19',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '9AfwpN22',
    0,
    '2023-04-01 23:13:05',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    '9D4HGJd4',
    0,
    '2023-04-09 00:27:45',
    '',
    b'0',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'AoAK8Stw',
    0,
    '2023-04-09 10:14:21',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'av1GhOOD',
    0,
    '2023-04-09 00:24:53',
    '',
    b'0',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'awHwoGtw',
    0,
    '2023-04-09 00:28:19',
    '',
    b'0',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'BuLE6Bb7',
    200000,
    '2023-03-26 15:03:14',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'C15BLpfB',
    0,
    '2023-04-02 09:01:09',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'CJLBPhmE',
    0,
    '2023-04-01 22:40:29',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'cLaqkt63',
    850000,
    '2023-03-26 11:29:00',
    '',
    b'0',
    '27',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'CxY5zLco',
    0,
    '2023-04-01 23:12:11',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'D82nKueS',
    0,
    '2023-04-01 23:14:12',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'dE16BWRh',
    0,
    '2023-04-01 23:17:55',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'drp4t0F1',
    200000,
    '2023-03-26 14:55:33',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'e1Lbdd47',
    0,
    '2023-04-02 08:22:26',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'E8ohiFLJ',
    49948.5,
    '2023-04-15 11:57:38',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 49.949 ₫. Số tiến đã thanh toán thành công: 49.949 ₫. Số tiền dư thanh toán còn lại: 24.560.499 ₫',
    b'1',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'EagoJ5P4',
    0,
    '2023-04-01 22:46:44',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'EperQQpK',
    50000,
    '2023-03-26 15:26:19',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 50.000 ₫. Số tiến đã thanh toán thành công: 50.000 ₫. Số tiền dư thanh toán còn lại: 11.650.000 ₫',
    b'1',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'ERQIzVaL',
    0,
    '2023-04-01 22:45:59',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'EUBEPyVa',
    0,
    '2023-04-09 00:26:26',
    '',
    b'0',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'EyvoHogQ',
    0,
    '2023-04-01 22:53:20',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'fOVX7FvY',
    200000,
    '2023-03-26 14:46:54',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'FTwnc5P6',
    200000,
    '2023-03-26 15:01:46',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'G4Ib1daZ',
    49948.5,
    '2023-04-15 12:11:19',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 49.949 ₫. Số tiến đã thanh toán thành công: 49.949 ₫. Số tiền dư thanh toán còn lại: 24.610.447 ₫',
    b'1',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'GH8ZhWvp',
    200000,
    '2023-03-26 14:51:30',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'gIv6uBEf',
    200000,
    '2023-03-26 14:59:55',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'gPeE4gW9',
    500000,
    '2023-04-02 19:25:34',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'Gr48LnkU',
    4250000,
    '2023-04-09 00:30:03',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 28.760.550 ₫',
    b'1',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'gvfNJcFe',
    0,
    '2023-04-01 22:37:15',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'gvmbq2io',
    200000,
    '2023-03-26 14:55:41',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'Hh5M8VN2',
    0,
    '2023-04-01 22:44:24',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'HN01CROR',
    200000,
    '2023-03-26 15:05:04',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'Hx51pu1P',
    0,
    '2023-04-01 23:00:48',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'i76NDGgL',
    25600000,
    '2023-03-25 22:36:58',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'iBy5Bftn',
    23450,
    '2023-04-01 23:56:38',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.203.100 ₫',
    b'1',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'isI22gPX',
    0,
    '2023-04-09 10:15:08',
    '',
    b'0',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'JnqTQg3F',
    0,
    '2023-04-01 23:52:30',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'KFCQV4KF',
    0,
    '2023-04-01 23:49:44',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'ki6qZsJG',
    0,
    '2023-04-09 00:23:37',
    '',
    b'0',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'km1wA95q',
    850000,
    '2023-03-25 12:13:33',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 12.450.000 ₫. Số tiến đã thanh toán thành công: 850.000 ₫. Số tiền thanh toán dư còn lại: 11.600.000 ₫',
    b'1',
    '26',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'KP2np9BE',
    0,
    '2023-04-01 22:57:01',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'kxnmPorw',
    200000,
    '2023-03-26 14:51:02',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'lASxcHYr',
    200000,
    '2023-03-26 14:59:43',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'lgSpoWuG',
    500000,
    '2023-03-26 11:24:13',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'LJNLEdnM',
    4250000,
    '2023-04-09 00:20:48',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 24.510.550 ₫',
    b'1',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'LKVPGDf8',
    0,
    '2023-04-02 09:02:00',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'llCknOhp',
    0,
    '2023-04-09 10:02:52',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'llrmg44i',
    200000,
    '2023-03-26 14:53:35',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'lmClucMq',
    0,
    '2023-04-01 23:44:34',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'lMFP434j',
    23450,
    '2023-04-02 09:07:36',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.156.200 ₫',
    b'1',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'lmQV9rYv',
    256000000,
    '2023-03-25 22:39:23',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'LxguS2V5',
    500000,
    '2023-04-09 17:29:06',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'NE2ZMJX6',
    23450,
    '2023-04-02 09:08:57',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.132.750 ₫',
    b'1',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'NSvb1geq',
    4250000,
    '2023-03-05 10:37:37',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 0 ₫',
    b'1',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'nZE4mzti',
    0,
    '2023-04-01 22:42:00',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'o1YXk30b',
    500000,
    '2023-03-25 21:29:45',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'OR34ZN8T',
    200000,
    '2023-03-26 14:58:14',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'Oz03fdmB',
    200000,
    '2023-03-26 14:58:53',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'PQNZicK1',
    0,
    '2023-04-15 11:55:55',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'pS1yg8O1',
    2566000000,
    '2023-03-25 22:40:27',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'QdCJYh5z',
    50000,
    '2023-03-26 10:39:36',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'qlwqELku',
    850000,
    '2023-03-26 10:53:56',
    '',
    b'0',
    '27',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'qSaAkSQR',
    0,
    '2023-04-15 11:46:11',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'QxwszJyV',
    850000,
    '2023-03-26 14:23:13',
    '',
    b'0',
    '27',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'RtOWV9in',
    200000,
    '2023-03-26 14:50:56',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'S2uEPytI',
    256000000,
    '2023-03-25 22:39:39',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'SAFFSisu',
    200000,
    '2023-03-26 14:48:55',
    '',
    b'0',
    '1,2',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'siPt4mjt',
    0,
    '2023-04-09 00:23:27',
    '',
    b'0',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'SydUIMie',
    0,
    '2023-04-01 22:47:30',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'sYps8YDf',
    0,
    '2023-04-01 22:42:39',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'tAPsTH0j',
    50000,
    '2023-03-26 15:30:17',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 50.000 ₫. Số tiến đã thanh toán thành công: 50.000 ₫. Số tiền dư thanh toán còn lại: 11.700.000 ₫',
    b'1',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'Vd3jiQPP',
    23450,
    '2023-04-02 08:22:44',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.179.650 ₫',
    b'1',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'vlFD3JjK',
    0,
    '2023-04-01 23:17:52',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'vMYpOi63',
    200000,
    '2023-03-26 14:54:22',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'VpL9Rr0D',
    200000,
    '2023-03-26 14:58:25',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'vxx5lT26',
    500000,
    '2023-03-28 20:48:08',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 500.000 ₫. Số tiến đã thanh toán thành công: 500.000 ₫. Số tiền dư thanh toán còn lại: 12.250.000 ₫',
    b'1',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'wEBTEe3d',
    0,
    '2023-04-01 23:51:04',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'wKSn5ghV',
    0,
    '2023-04-02 09:11:50',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'XDbv6DOj',
    0,
    '2023-04-02 09:06:52',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'XjujA9Qt',
    0,
    '2023-04-15 11:52:01',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'xXCUNm0a',
    0,
    '2023-04-01 23:04:16',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'Y3Kmwt5X',
    0,
    '2023-04-09 10:04:53',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'YeIUhK1I',
    200000,
    '2023-03-26 14:54:11',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'zjDp1W3A',
    256000000,
    '2023-03-25 22:40:13',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'ZlUaDWXP',
    23450,
    '2023-04-01 23:55:39',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 23.450 ₫. Số tiến đã thanh toán thành công: 23.450 ₫. Số tiền dư thanh toán còn lại: 12.226.550 ₫',
    b'1',
    '1',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'znL5J7tk',
    0,
    '2023-04-01 23:46:39',
    '',
    b'0',
    'Array',
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'znUfmIVh',
    1700000,
    '2023-02-04 09:56:48',
    '',
    b'0',
    NULL,
    19524791
  );
INSERT INTO
  `thanh_toan_giao_dich` (
    `ma_giao_dich`,
    `balance`,
    `expired_time`,
    `ghi_chu`,
    `status`,
    `un_debt_ids`,
    `ma_sinh_vien`
  )
VALUES
  (
    'ZRczboRF',
    4250000,
    '2023-04-09 00:29:14',
    'Thanh toán thành công: 1/1 mục. Tổng tiền đã thanh toán: 4.250.000 ₫. Số tiến đã thanh toán thành công: 4.250.000 ₫. Số tiền dư thanh toán còn lại: 33.010.550 ₫',
    b'1',
    '1',
    19524791
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: thoi_khoa_bieu
# ------------------------------------------------------------

INSERT INTO
  `thoi_khoa_bieu` (
    `ma_thoi_khoa_bieu`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`,
    `ma_lop_hoc_phan`,
    `so_luong_da_dang_ky`,
    `ma_giao_vien`
  )
VALUES
  (
    1,
    'T3',
    'LÝ THUYẾT NHÓM 1',
    'LT',
    '2023-02-12',
    '2023-03-31',
    1,
    'B1.01',
    b'0',
    'T2',
    'T1',
    1,
    1,
    1
  );
INSERT INTO
  `thoi_khoa_bieu` (
    `ma_thoi_khoa_bieu`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`,
    `ma_lop_hoc_phan`,
    `so_luong_da_dang_ky`,
    `ma_giao_vien`
  )
VALUES
  (
    2,
    'T6',
    'LÝ THUYẾT NHÓM 2',
    'LT',
    '2023-02-12',
    '2023-02-28',
    2,
    'B1.02',
    b'0',
    'T2',
    'T4',
    1,
    0,
    1
  );
INSERT INTO
  `thoi_khoa_bieu` (
    `ma_thoi_khoa_bieu`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`,
    `ma_lop_hoc_phan`,
    `so_luong_da_dang_ky`,
    `ma_giao_vien`
  )
VALUES
  (
    6,
    'T15',
    'HỌc lý thuyet buooi dau nho di hoc day du nha cac em',
    'LT',
    '2023-03-20',
    '2023-03-31',
    0,
    'A1.01',
    b'0',
    'T2',
    'T13',
    2,
    2,
    1
  );
INSERT INTO
  `thoi_khoa_bieu` (
    `ma_thoi_khoa_bieu`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`,
    `ma_lop_hoc_phan`,
    `so_luong_da_dang_ky`,
    `ma_giao_vien`
  )
VALUES
  (
    7,
    'T9',
    'DI HOC LY THUYET NHO PHOTO DE CUONG NHA',
    'LT',
    '2023-03-21',
    '2023-03-31',
    0,
    'V5.01',
    b'0',
    'T2',
    'T7',
    3,
    5,
    1
  );
INSERT INTO
  `thoi_khoa_bieu` (
    `ma_thoi_khoa_bieu`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`,
    `ma_lop_hoc_phan`,
    `so_luong_da_dang_ky`,
    `ma_giao_vien`
  )
VALUES
  (
    8,
    'T15',
    'Thứ 2- T1-> T5. Dự đoán là lịch này sẽ trùng với nhiều lịch khác vì',
    'LT',
    '2023-04-01',
    '2023-04-30',
    0,
    'V2.01',
    b'0',
    'T3',
    'T13',
    4,
    0,
    1
  );
INSERT INTO
  `thoi_khoa_bieu` (
    `ma_thoi_khoa_bieu`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`,
    `ma_lop_hoc_phan`,
    `so_luong_da_dang_ky`,
    `ma_giao_vien`
  )
VALUES
  (
    9,
    'T12',
    'Lớp này dành cho DH12 T10-12 T5',
    'LT',
    '2023-04-05',
    '2023-04-30',
    0,
    'V5.03',
    b'0',
    'T5',
    'T10',
    6,
    0,
    1
  );
INSERT INTO
  `thoi_khoa_bieu` (
    `ma_thoi_khoa_bieu`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`,
    `ma_lop_hoc_phan`,
    `so_luong_da_dang_ky`,
    `ma_giao_vien`
  )
VALUES
  (
    10,
    'T5',
    '',
    'LT',
    '2023-04-25',
    '2023-04-30',
    0,
    'H6.02',
    b'0',
    'T2',
    'T1',
    7,
    0,
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: thoi_khoa_bieu_con
# ------------------------------------------------------------

INSERT INTO
  `thoi_khoa_bieu_con` (
    `ma_thoi_khoa_bieu_con`,
    `so_luong_da_dang_ky`,
    `ma_thoi_khoa_bieu`,
    `ma_giao_vien`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`
  )
VALUES
  (
    1,
    7,
    1,
    1,
    'T3',
    'HOC THUC HANH NHA CAC BAN NHO DEM LAPTOP',
    'TH',
    '2023-02-12',
    '2023-02-28',
    1,
    'H6.01',
    b'0',
    'T5',
    'T1'
  );
INSERT INTO
  `thoi_khoa_bieu_con` (
    `ma_thoi_khoa_bieu_con`,
    `so_luong_da_dang_ky`,
    `ma_thoi_khoa_bieu`,
    `ma_giao_vien`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`
  )
VALUES
  (
    2,
    0,
    1,
    1,
    'T3',
    'HOC THUC HANH CAC BAN NHOM 2 NHO DEM LAPTOP NHA',
    'TH',
    '2023-02-12',
    '2023-02-28',
    2,
    'H6.02',
    b'0',
    'T5',
    'T1'
  );
INSERT INTO
  `thoi_khoa_bieu_con` (
    `ma_thoi_khoa_bieu_con`,
    `so_luong_da_dang_ky`,
    `ma_thoi_khoa_bieu`,
    `ma_giao_vien`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`
  )
VALUES
  (
    3,
    0,
    6,
    1,
    'T6',
    'HOC THUC HANH NHA NHOM 1',
    'TH',
    '2023-03-20',
    '2023-03-31',
    1,
    'H8.01',
    b'0',
    'T3',
    'T4'
  );
INSERT INTO
  `thoi_khoa_bieu_con` (
    `ma_thoi_khoa_bieu_con`,
    `so_luong_da_dang_ky`,
    `ma_thoi_khoa_bieu`,
    `ma_giao_vien`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`
  )
VALUES
  (
    4,
    2,
    6,
    1,
    'T15',
    'NHO MANG LAPTOP NHA NHÓM 2',
    'TH',
    '2023-02-20',
    '2023-03-31',
    2,
    'H8.02',
    b'0',
    'T3',
    'T13'
  );
INSERT INTO
  `thoi_khoa_bieu_con` (
    `ma_thoi_khoa_bieu_con`,
    `so_luong_da_dang_ky`,
    `ma_thoi_khoa_bieu`,
    `ma_giao_vien`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`
  )
VALUES
  (
    5,
    0,
    8,
    1,
    'T5',
    'T1-5 CN HỌC THỰC HÀNH NHA CÁC EM NHỚ MANG THEO LAPTOP CÁ NHÂN!',
    'TH',
    '2023-04-01',
    '2023-04-30',
    0,
    'H3.01 (Phòng H3 TH 1)',
    b'0',
    'CN',
    'T1'
  );
INSERT INTO
  `thoi_khoa_bieu_con` (
    `ma_thoi_khoa_bieu_con`,
    `so_luong_da_dang_ky`,
    `ma_thoi_khoa_bieu`,
    `ma_giao_vien`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`
  )
VALUES
  (
    6,
    2,
    9,
    1,
    'T5',
    'T1-5 T7 HỌC THỰC HÀNH NHA CÁC EM NHỚ MANG THEO LAPTOP CÁ NHÂN!',
    'TH',
    '2023-04-05',
    '2023-04-30',
    1,
    'H4.01 (Phòng H4 TH 1)',
    b'0',
    'T7',
    'T1'
  );
INSERT INTO
  `thoi_khoa_bieu_con` (
    `ma_thoi_khoa_bieu_con`,
    `so_luong_da_dang_ky`,
    `ma_thoi_khoa_bieu`,
    `ma_giao_vien`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`
  )
VALUES
  (
    7,
    19,
    9,
    1,
    'T5',
    'T1-5 T6 N2 HỌC THỰC HÀNH NHA CÁC EM NHỚ MANG THEO LAPTOP CÁ NHÂN!',
    'TH',
    '2023-04-05',
    '2023-04-30',
    2,
    'H4.01 (Phòng H4 TH 1)',
    b'0',
    'T6',
    'T1'
  );
INSERT INTO
  `thoi_khoa_bieu_con` (
    `ma_thoi_khoa_bieu_con`,
    `so_luong_da_dang_ky`,
    `ma_thoi_khoa_bieu`,
    `ma_giao_vien`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`
  )
VALUES
  (
    8,
    0,
    10,
    1,
    'T5',
    'Nhóm 1 nha',
    'TH',
    '2023-04-25',
    '2023-04-30',
    1,
    'H6.01 (Phòng TH 1)',
    b'0',
    'T3',
    'T1'
  );
INSERT INTO
  `thoi_khoa_bieu_con` (
    `ma_thoi_khoa_bieu_con`,
    `so_luong_da_dang_ky`,
    `ma_thoi_khoa_bieu`,
    `ma_giao_vien`,
    `den_tiet_hoc`,
    `ghi_chu`,
    `loai_buoi_hoc`,
    `ngay_bat_dau`,
    `ngay_ket_thuc`,
    `nhom_hoc`,
    `phong_hoc`,
    `thi`,
    `thu_hoc`,
    `tu_tiet_hoc`
  )
VALUES
  (
    9,
    0,
    10,
    1,
    'T12',
    'Nhóm 2 nha',
    'TH',
    '2023-04-25',
    '2023-04-30',
    2,
    'H6.01 (Phòng TH 2)',
    b'0',
    'T3',
    'T7'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: thong_bao
# ------------------------------------------------------------

INSERT INTO
  `thong_bao` (
    `id`,
    `create_at`,
    `is_read`,
    `linking`,
    `message`,
    `title`,
    `ma_sinh_vien`
  )
VALUES
  (
    1,
    NULL,
    b'0',
    'aaa',
    'aa',
    'aaaa',
    19524791
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: thong_bao_khoa
# ------------------------------------------------------------

INSERT INTO
  `thong_bao_khoa` (
    `ma_thong_bao`,
    `ngay_xuat_ban`,
    `noi_dung`,
    `tieu_de`,
    `ma_khoa`
  )
VALUES
  (
    1,
    '2021-01-01',
    'Gửi tới các em sinh viên hệ CLC / Đại trà. Cũng đã sắp đến tết cận kề, nhà nhà đã mang không khí nôn nao của lễ hội tết truyền thống. Nhằm mục đích hỗ trợ cho việc các sinh viên có thể bắt xe trở về quê ăn tết thuận tiện với gia đình tốt nhất. Nhà trường quyết định sẽ tổ chức các buổi học cận kề ngày nghĩ tết thành lịch học online (có thể). Một vài trường hợp môn học bắt buộc học offline như thực hành sẽ vẫn tiếp tục.',
    'THÔNG BÁO LỊCH NGHĨ TẾT DƯƠNG LỊCH CHO TOÀN BỘ SINH VIÊN TRƯỜNG ĐẠI HỌC CÔNG NGHIỆP IV (IUH)',
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: token
# ------------------------------------------------------------

INSERT INTO
  `token` (`id`, `token`, `token_exp_date`, `created_by`)
VALUES
  (
    1,
    'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzdjE5NTI0NzkxIiwiZXhwIjoxNjgyNTY2OTMwLCJpYXQiOjE2ODI1NDg5MzB9.iP_pFidZFXcZ4R6_L0ELhwWic0kJkj69TfpT44gvTFnDBeadfRt0ldOYt3sGjRnSXCdhW6ZCDGV8Y1BxE5m3jA',
    '2023-02-04 14:46:52',
    4
  );
INSERT INTO
  `token` (`id`, `token`, `token_exp_date`, `created_by`)
VALUES
  (
    2,
    'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJndjEiLCJleHAiOjE2ODI1NjU1MjgsImlhdCI6MTY4MjU0NzUyOH0.oET4-Ey2oTLYIP5Zh-vZWpS83rXnaPxOnknC-9rtTA_QDwCG5ewDfsNZqQ8eKAnRMSYtwKgslCcyj_0nyKzDxw',
    '2023-02-04 20:15:46',
    1
  );
INSERT INTO
  `token` (`id`, `token`, `token_exp_date`, `created_by`)
VALUES
  (
    3,
    'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJudjIxMDUyMDAyIiwiZXhwIjoxNjgyNTk5MDEzLCJpYXQiOjE2ODI1ODEwMTN9.BaSuHCZ6sSdiP8eH3xmAU_TigMX34TZ9Ftn9yJCm9pM88W3p-NYqbvLqAb5UFQt1wO_EaN8clZHJaG5l_x_ccA',
    '2023-02-05 01:08:03',
    2
  );
INSERT INTO
  `token` (`id`, `token`, `token_exp_date`, `created_by`)
VALUES
  (
    4,
    'eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJzYSIsImV4cCI6MTY4MTUwNTU5MCwiaWF0IjoxNjgxNDg3NTkwfQ.jalt9_rCs1v0vKueIzSjDviMNHbze3HvtL15AOJJxPNF0nFJ3gILyLS4JwoRN4BhTknWRNjAIaSaqfd8nSqvpg',
    '2023-04-15 03:53:10',
    3
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: user
# ------------------------------------------------------------

INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    1,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'gv1'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    2,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'nv21052002'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    3,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'sa'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    4,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'sv19524791'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    5,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'sv2'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    6,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'sv3'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    7,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'sv4'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    8,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'sv5'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    9,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'sv6'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    10,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'sv7'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    11,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'sv8'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    12,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'sv9'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    13,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'sv10'
  );
INSERT INTO
  `user` (`id`, `password`, `username`)
VALUES
  (
    14,
    '$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6',
    'sv11'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: user_role_map
# ------------------------------------------------------------

INSERT INTO
  `user_role_map` (`id_user`, `id_role`)
VALUES
  (1, 4);
INSERT INTO
  `user_role_map` (`id_user`, `id_role`)
VALUES
  (2, 3);
INSERT INTO
  `user_role_map` (`id_user`, `id_role`)
VALUES
  (3, 2);
INSERT INTO
  `user_role_map` (`id_user`, `id_role`)
VALUES
  (4, 1);

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
