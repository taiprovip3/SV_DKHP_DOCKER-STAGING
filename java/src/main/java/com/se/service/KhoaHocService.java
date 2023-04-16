package com.se.service;

import java.util.List;

import com.se.dto.KhoaHocDTO;
import com.se.entity.KhoaHoc;

public interface KhoaHocService {
	public KhoaHoc addCourse(KhoaHocDTO khoaHoc);
	public List<KhoaHoc> getCourses();
	public List<KhoaHoc> getCoursesByStudentId(long id);
}
