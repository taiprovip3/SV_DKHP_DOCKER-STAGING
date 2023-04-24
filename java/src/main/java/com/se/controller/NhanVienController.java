package com.se.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.se.dto.NhanVienDTO;
import com.se.entity.NhanVien;
import com.se.service.NhanVienService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class NhanVienController {
	
	@Autowired
	private NhanVienService nhanVienService;
	
	@PostMapping("/nhanvien/add")
	public NhanVien addEmployee(@RequestBody NhanVienDTO nhanVien) {
		return nhanVienService.addEmployee(nhanVien);
	}
	
	@PostMapping("/nhanvien/remove")
	public List<Long> removeListEmployee(@RequestBody List<Long> listIdEmployee){
		return nhanVienService.removeListEmployee(listIdEmployee);
	}
	
	@PostMapping("/nhanvien/update")
	public NhanVien updateEmployee(@RequestBody NhanVienDTO nhanVien) {
		return nhanVienService.updateEmployee(nhanVien);
	}
	
	@GetMapping("/nhanvien/getEmployeeById/{employeeId}")
	public NhanVien getEmployeeById(@PathVariable long employeeId) {
		return nhanVienService.getEmployeeById(employeeId);
	}
}
