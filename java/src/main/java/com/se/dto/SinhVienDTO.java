package com.se.dto;

import lombok.Data;

@Data
public class SinhVienDTO {
	private String hoTen;
	private String gioiTinh;
	private String ngaySinh;
	private String noiSinh;
	private String sdt;
	private String diaChi;
	private String cccd;
	private String ngayVaoTruong;
	private boolean totNghiep;
	private double soDu;
	private long maLopDanhNghia;
	private String matKhau;
	private String avatar;
	private String bacDaoTao;
	private String loaiHinhDaoTao;
	private String coSo;
	private String email = "Không";
}
