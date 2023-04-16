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

import com.se.dto.ThoiKhoaBieu2DTO;
import com.se.dto.ThoiKhoaBieuDTO;
import com.se.entity.ThoiKhoaBieu;
import com.se.service.ThoiKhoaBieuService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class ThoiKhoaBieuController {
	
	@Autowired
	private ThoiKhoaBieuService thoiKhoaBieuService;
	
	@PostMapping("/time_table/add")
	public String addTimeTable(@RequestBody ThoiKhoaBieuDTO thoiKhoaBieuDTO) {
		long isChungWithTKB = thoiKhoaBieuDTO.getChungWithMaThoiKhoaBieu();
		if(isChungWithTKB == 0)
			thoiKhoaBieuService.addTimeTable(thoiKhoaBieuDTO);
		else thoiKhoaBieuService.addTimeTableCon(thoiKhoaBieuDTO);
		return "OK";
	}
	@GetMapping("/time_table/getTimeTablesByUnitClassId/{id}")
	public List<ThoiKhoaBieu> getTimeTablesByUnitClassId(@PathVariable long id) {
		return thoiKhoaBieuService.getTimeTablesByUnitClassId(id);
	}
	@GetMapping("/time_table/getTimeTableById/{id}")
	public ThoiKhoaBieu getTimeTableById(@PathVariable long id) {
		return thoiKhoaBieuService.getTimeTableById(id);
	}
	@GetMapping("/time_table/getTimeTables/{id}")
	public List<ThoiKhoaBieu> getTimeTables(@PathVariable long id) {
		return thoiKhoaBieuService.getTimeTablesByUnitClassId(id);
	}
	@PostMapping("/time_table/getIdsThoiKhoaBieuCon")
	public List<Long> getIdsThoiKhoaBieuCon(@RequestBody ThoiKhoaBieu2DTO thoiKhoaBieu2DTO) {
		return thoiKhoaBieuService.getIdsThoiKhoaBieuCon(thoiKhoaBieu2DTO);
	}
	@PostMapping("/time_table/getTimeTablesBy7Days")
	public List<ThoiKhoaBieu> getTimeTablesBy7Days(@RequestBody ThoiKhoaBieu2DTO thoiKhoaBieu2DTO) {
		return thoiKhoaBieuService.getTimeTablesBy7Days(thoiKhoaBieu2DTO);
	}
	@GetMapping("/time_table/getTeacherTimeTableByDay/{maGiaoVien}/{theDate}")
	public List<ThoiKhoaBieu> getTeacherTimeTableByDay(@PathVariable long maGiaoVien, @PathVariable String theDate) {
		return thoiKhoaBieuService.getTeacherTimeTableByDay(maGiaoVien, theDate);
	}
	@GetMapping("/time_table/getStudentTimeTableByDay/{maSinhVien}/{theDate}")
	public List<ThoiKhoaBieu> getStudentTimeTableByDay(@PathVariable long maSinhVien, @PathVariable String theDate) {
		return thoiKhoaBieuService.getStudentTimeTableByDay(maSinhVien, theDate);
	}
}
