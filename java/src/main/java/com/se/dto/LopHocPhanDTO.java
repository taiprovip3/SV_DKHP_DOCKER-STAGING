package com.se.dto;

import lombok.Data;

@Data
public class LopHocPhanDTO {
	private String hanNopHocPhi;
	private String ngayBatDau;
	private String ngayKetThuc;
	private String tenLopHocPhan;
	private String loaiHoc;
	private long maGiaoVien;
	private long maMonHoc;
	private long maKhoaHoc;
	private int soLuongMax;
	private String trangThai;
}
