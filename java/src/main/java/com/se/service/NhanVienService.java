package com.se.service;

import java.util.List;

import com.se.dto.NhanVienDTO;
import com.se.entity.NhanVien;

public interface NhanVienService {
	public NhanVien addEmployee(NhanVienDTO nhanVien);
	public List<Long> removeListEmployee(List<Long> listIdEmployee);
	public NhanVien updateEmployee(NhanVienDTO nhanVien);
}
