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

import com.se.dto.PhieuThu2DTO;
import com.se.dto.PhieuThuDTO;
import com.se.entity.PhieuThu;
import com.se.service.PhieuThuService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class PhieuThuController {
	
	@Autowired
	private PhieuThuService phieuThuService;
	
	@PostMapping("/order_detail/resolveOderDetail")
	public PhieuThu resolveOderDetail(@RequestBody PhieuThuDTO phieuThuDTO) {
		return phieuThuService.resolveOderDetail(phieuThuDTO);
	}
	
	@PostMapping("/order_detail/createOrderDetailBy")
	public PhieuThu createOrderDetailBy(@RequestBody PhieuThu2DTO phieuThu2DTO) {
		return phieuThuService.createOrderDetailBy(phieuThu2DTO);
	}
	
	@GetMapping("/order_detail/getOrderDetailsByStudentId/{studentId}")
	public List<PhieuThu> getOrderDetailsByStudentId(@PathVariable long studentId) {
		return phieuThuService.getOrderDetailsByStudentId(studentId);
	}
}
