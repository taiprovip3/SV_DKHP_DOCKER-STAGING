package com.se.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.se.dto.DiemDTO;
import com.se.entity.Diem;
import com.se.enums.XepLoai;
import com.se.service.DiemService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class DiemController {
	
	@Autowired
	private DiemService diemService;

	@PostMapping("/score/addScore")
	public Diem addScore(@RequestBody DiemDTO diemDTO) {
		return diemService.addScore(diemDTO);
	}
	
	@GetMapping("/score/getScores")
	public List<Diem> getScores() {
		return diemService.getScores();
	}
	
	@GetMapping("/score/getStudentScoresBySemesterId/{studentId}/{semesterId}")
	public List<Diem> getStudentScoresBySemesterId(@PathVariable long studentId, @PathVariable long semesterId) {
		return diemService.getStudentScoresBySemesterId(studentId, semesterId);
	}
	
	@GetMapping("/score/getScoreByStudentIdAndSubjectId/{studentId}/{subjectId}")
	public Diem getScoreByStudentIdAndSubjectId(@PathVariable long studentId, @PathVariable long subjectId) {
		return diemService.getScoreByStudentIdAndSubjectId(studentId, subjectId);
	}
	
	@DeleteMapping("/score/deleteScoreById/{maDiem}")
	public String deleteScoreById(@PathVariable long maDiem) {
		return diemService.deleteScoreById(maDiem);
	}
	
	@GetMapping("/score/getCounterByXepLoai/{xepLoai}")
	public int getCounterByXepLoai(@PathVariable String xepLoai) {
		try {
			return diemService.getCounterByXepLoai(xepLoai);
		} catch (IllegalArgumentException e) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid xepLoai value", e);
	    }
	}
}
