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

import com.se.dto.SinhVienAddBalanceDTO;
import com.se.dto.SinhVienDTO;
import com.se.entity.SinhVien;
import com.se.service.SinhVienService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class SinhVienController {
	
	@Autowired
	private SinhVienService sinhVienService;

	@PostMapping("/student/add")
	public SinhVien addStudent(@RequestBody SinhVienDTO sinhVien) {
		return sinhVienService.addStudent(sinhVien);
	}
	@PostMapping("/student/remove")
	public List<Long> removeStudent(@RequestBody List<Long> listIdStudent){
		return sinhVienService.removeStudent(listIdStudent);
	}
	@GetMapping("/student/getStudentById/{id}")
	public SinhVien getStudetnById(@PathVariable int id) {
		return sinhVienService.getStudentById(id);
	}
	@GetMapping("/student/updateBalance/{studentId}/{soDu}")
	public double updateBalance(@PathVariable long studentId, @PathVariable double soDu) {
		return sinhVienService.updateBalance(studentId, soDu);
	}
	@GetMapping("/student/getStudentBalance/{studentId}")
	public double getStudentBalance(@PathVariable long studentId) {
		return sinhVienService.getStudentBalance(studentId);
	}
	@PostMapping("/student/addStudentBalance")
	public double addStudentBalance(@RequestBody SinhVienAddBalanceDTO sinhVienAddBalanceDTO) {
		return sinhVienService.addStudentBalance(sinhVienAddBalanceDTO);
	}
	@GetMapping("/student/reduceStudentBalance/{studentId}/{balanceToReduce}")
	public double reduceStudentBalance(@PathVariable long studentId, @PathVariable long balanceToReduce) {
		return sinhVienService.reduceStudentBalance(studentId, balanceToReduce);
	}
}
