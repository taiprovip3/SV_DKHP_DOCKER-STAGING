package com.se.service;

import com.se.dto.GiaoVienDTO;
import com.se.entity.GiaoVien;

public interface GiaoVienService {
	public GiaoVien addGiaoVien(GiaoVienDTO giaoVien);
	public GiaoVien getTeacherById(long maGiaoVien);
}
