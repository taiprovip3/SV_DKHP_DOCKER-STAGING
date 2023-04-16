package com.se.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.se.dto.LopHocDanhNghiaDTO;
import com.se.entity.LopHocDanhNghia;
import com.se.service.LopHocDanhNghiaService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class LopHocDanhNghiaController {
	
	@Autowired
	private LopHocDanhNghiaService lopHocDanhNghiaService;
	
	@PostMapping("/class/add")
	public LopHocDanhNghia addClass(@RequestBody LopHocDanhNghiaDTO lopHoc) {
		return lopHocDanhNghiaService.addClass(lopHoc);
	}
}
