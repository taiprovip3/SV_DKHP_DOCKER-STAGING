package com.se.service;

import java.util.List;

import com.se.dto.ThongBaoKhoaDTO;
import com.se.entity.ThongBaoKhoa;

public interface ThongBaoKhoaService {
	public ThongBaoKhoa addAnnouncement(ThongBaoKhoaDTO thongBao);
	public List<ThongBaoKhoa> getNotificationsByStudentId(Long studentId);
	public ThongBaoKhoa getNotificationById(long notificationId);
}
