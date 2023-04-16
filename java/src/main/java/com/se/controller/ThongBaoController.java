package com.se.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.se.dto.ThongBaoDto;
import com.se.entity.ThongBao;
import com.se.service.ThongBaoService;

import io.swagger.v3.oas.annotations.parameters.RequestBody;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class ThongBaoController {
	
	@Autowired
	private ThongBaoService thongBaoService;
	
	@PostMapping("/announcement")
	public ThongBao getDebtsByStudentId(@RequestBody ThongBaoDto thongBaoDto) {
		return thongBaoService.createNotification(thongBaoDto);
	}
}
