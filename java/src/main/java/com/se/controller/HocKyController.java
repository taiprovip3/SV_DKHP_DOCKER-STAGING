package com.se.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.se.entity.HocKy;
import com.se.service.HocKyService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class HocKyController {
	
	@Autowired
	private HocKyService hocKyService;
	
	@GetMapping("/semester/getTongSoTinChiByMaNganh/{id}")
	public int getTongSoTinChiByMaNganh(@PathVariable long id) {
		return hocKyService.getTongSoTinChiByMaNganh(id);
	}
	@GetMapping("/semester/getListSemesterIdByStudentRegister/{studentId}")
	public List<Long> getListSemesterIdByStudentRegister(@PathVariable long studentId) {
		return hocKyService.getListSemesterIdByStudentRegister(studentId);
	}
	@GetMapping("/semester/getSemestersByMajorsId/{majorsId}")
	public List<HocKy> getSemestersByMajorsId(@PathVariable long majorsId) {
		return hocKyService.getSemestersByMajorsId(majorsId);
	}
}
