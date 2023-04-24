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

import com.se.dto.KhoaHocDTO;
import com.se.entity.KhoaHoc;
import com.se.service.KhoaHocService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class KhoaHocController {
	
	@Autowired
	private KhoaHocService khoaHocService;
	
	@PostMapping("/course/add")
	public KhoaHoc addCourse(@RequestBody KhoaHocDTO khoaHoc) {
		return khoaHocService.addCourse(khoaHoc);
	}
	@GetMapping("/course/getCourses")
	public List<KhoaHoc> getCourses(){
		return khoaHocService.getCourses();
	}
	@GetMapping("/course/getCoursesByStudentId/{studentId}")
	public List<KhoaHoc> getCoursesByStudentId(@PathVariable long studentId){
		return khoaHocService.getCoursesByStudentId(studentId);
	}
	@GetMapping("/course/getCounterStudentsByCourseId/{courseId}")
	public int getCounterStudentsByCourseId(@PathVariable long courseId) {
		return khoaHocService.getCounterStudentsByCourseId(courseId);
	}
}
