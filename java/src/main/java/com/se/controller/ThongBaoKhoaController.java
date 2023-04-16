package com.se.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.se.entity.ThongBaoKhoa;
import com.se.service.ThongBaoKhoaService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class ThongBaoKhoaController {
	
	@Autowired
	private ThongBaoKhoaService thongBaoKhoaService;
	
	@GetMapping("/department_announcement/getNotificationsByStudentId/{studentId}")
	public List<ThongBaoKhoa> getNotificationsByStudentId(@PathVariable long studentId) {
		return thongBaoKhoaService.getNotificationsByStudentId(studentId);
	}
	
	@GetMapping("/department_announcement/getNotificationById/{notificationId}")
	public ThongBaoKhoa getNotificationById(@PathVariable long notificationId) {
		return thongBaoKhoaService.getNotificationById(notificationId);
	}
}
