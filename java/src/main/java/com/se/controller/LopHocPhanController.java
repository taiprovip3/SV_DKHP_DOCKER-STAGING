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

import com.se.dto.LopHocPhanDTO;
import com.se.entity.LopHocPhan;
import com.se.service.LopHocPhanService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class LopHocPhanController {
	
	@Autowired
	private LopHocPhanService lopHocPhanService;
	
	@PostMapping("/unit_class/add")
	public LopHocPhan addUnitClass(@RequestBody LopHocPhanDTO lopHocPhanDTO ) {
		return lopHocPhanService.addUnitClass(lopHocPhanDTO);
	}
	@GetMapping("/unit_class/getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc/{maMonHoc}/{loaiHoc}/{maKhoaHoc}")
	public List<LopHocPhan> getUnitClassesBySubjectId(@PathVariable long maMonHoc, @PathVariable String loaiHoc, @PathVariable long maKhoaHoc) {
		return lopHocPhanService.getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc(maMonHoc, loaiHoc, maKhoaHoc);
	}
	@GetMapping("/unit_class/getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc/{id}/{maKhoaHoc}")
	public List<LopHocPhan> getUnitClassesStudentRegisterAndMaKhoaHoc(@PathVariable long id, @PathVariable long maKhoaHoc){
		return lopHocPhanService.getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc(id, maKhoaHoc);
	}
	@GetMapping("/unit_class/getUnitClassesById/{id}")
	public LopHocPhan getUnitClassesById(@PathVariable long id) {
		return lopHocPhanService.getUnitClassById(id);
	}
}
