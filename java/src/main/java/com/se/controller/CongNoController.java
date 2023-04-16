package com.se.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.se.entity.CongNo;
import com.se.service.CongNoService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class CongNoController {
	
	@Autowired
	private CongNoService congNoService;
	
	@GetMapping("/debt/getDebtsByStudentId/{studentId}")
	public List<CongNo> getDebtsByStudentId(@PathVariable long studentId) {
		return congNoService.getDebtsByStudentId(studentId);
	}
	@GetMapping("/debt/getDebtsByStudentIdAndCourseId/{studentId}/{courseId}")
	public List<CongNo> getDebtsByStudentIdAndCourseId(@PathVariable long studentId, @PathVariable long courseId) {
		return congNoService.getDebtsByStudentIdAndCourseId(studentId, courseId);
	}
	
	@GetMapping("/debt/getUnDebtsByStudentId/{studentId}")
	public List<CongNo> getUnDebtsByStudentId(@PathVariable long studentId){
		return congNoService.getUnDebtsByStudentId(studentId);
	}
	
	@GetMapping("/debt/getUnDebtsByStuentIdAndCourseId/{studentId}/{courseId}")
	public List<CongNo> getUnDebtsByStuentIdAndCourseId(@PathVariable long studentId, @PathVariable long courseId) {
		return congNoService.getUnDebtsByStuentIdAndCourseId(studentId, courseId);
	}
	
	@GetMapping("/debt/getUnDebtById/{debtId}")
	public CongNo getUndebtById(@PathVariable long debtId) {
		return congNoService.getUndebtById(debtId);
	}

	@GetMapping("/debt/getSoTienByDebtId/{debtId}")
	public double getSoTienByDebtId(@PathVariable long debtId) {
		return congNoService.getSoTienByDebtId(debtId);
	}
	
	@GetMapping("/debt/updateUnDebtById/{debtId}")
	public CongNo updateUnDebtById(@PathVariable long debtId) {
		return congNoService.updateUnDebtById(debtId);
	}
	
	@GetMapping("/debt/getDebtById/{unDebtId}")
	public CongNo getDebtById(@PathVariable long unDebtId) {
		return congNoService.getDebtById(unDebtId);
	}

	@GetMapping("/debt/getPayedDebts/{studentId}")
	public List<CongNo> getPayedDebts(@PathVariable long studentId) {
		return congNoService.getPayedDebts(studentId);
	}
}
