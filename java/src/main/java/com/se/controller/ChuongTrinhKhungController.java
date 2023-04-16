package com.se.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.se.dto.ChuongTrinhKhungDTO;
import com.se.entity.ChuongTrinhKhung;
import com.se.service.ChuongTrinhKhungService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class ChuongTrinhKhungController {
	
	@Autowired
	private ChuongTrinhKhungService chuongTrinhKhungService;
	
	@PostMapping("/pattern/add")
	public ChuongTrinhKhung addPattern(@RequestBody ChuongTrinhKhungDTO ctk) {
		return chuongTrinhKhungService.addPattern(ctk);
	}
	@GetMapping("/pattern/getSoTinChiDoneByStudentId/{id}")
	public int getSoTinChiDoneByStudentId(@PathVariable long id) {
		return chuongTrinhKhungService.getSoTinChiDoneByStudentId(id);
	}
}
