package com.se.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.se.dto.GiaoVienDTO;
import com.se.entity.GiaoVien;
import com.se.service.GiaoVienService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class GiaoVienController {
	
	@Autowired
	private GiaoVienService giaoVienService;
	
	@PostMapping("/teacher/add")
	public GiaoVien addTeacher(@RequestBody GiaoVienDTO giaoVien) {
		return giaoVienService.addGiaoVien(giaoVien);
	}
	
	@GetMapping("/teacher/getTeacherById/{maGiaoVien}")
	public GiaoVien getTeacherById(@PathVariable long maGiaoVien) {
		return giaoVienService.getTeacherById(maGiaoVien);
	}
}
