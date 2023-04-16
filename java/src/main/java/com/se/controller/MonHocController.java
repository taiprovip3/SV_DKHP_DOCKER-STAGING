package com.se.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.se.entity.MonHoc;
import com.se.service.MonHocService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class MonHocController {
	
	@Autowired
	private MonHocService monHocService;
	
	@GetMapping("/subject/getListSinhVienDangKyHocPhanByMaSinhVienAndMaKhoaHoc/{studentId}/{courseId}")
	public List<MonHoc> getListSinhVienDangKyHocPhanByMaSinhVienAndMaKhoaHoc(@PathVariable long studentId, @PathVariable long courseId){
		return monHocService.getListSinhVienDangKyHocPhanByMaSinhVienAndMaKhoaHoc(studentId, courseId);
	}
	@GetMapping("/subject/getSubjectsByCourseId/{courseId}/{studentId}")
	public List<MonHoc> getSubjectsByCourseId(@PathVariable long courseId, @PathVariable long studentId){
		return monHocService.getSubjectsByCourseId(courseId, studentId);
	}
	@GetMapping("/subject/getSubjectsBySemesterIdAndMajorsId/{semesterId}/{majorsId}")
	public List<MonHoc> getSubjectsBySemesterIdAndMajorsId(@PathVariable long semesterId, @PathVariable long majorsId) {
		return monHocService.getSubjectsBySemesterIdAndMajorsId(semesterId, majorsId);
	}
	@GetMapping("/subject/getSubjectsPassed/{studentId}")
	public List<MonHoc> getSubjectsPassed(@PathVariable long studentId) {
		return monHocService.getSubjectsPassed(studentId);
	}
}
