package com.se.service;

import java.util.List;

import com.se.entity.MonHoc;

public interface MonHocService {
	public MonHoc addSubject(MonHoc mh);
	public List<MonHoc> getListSinhVienDangKyHocPhanByMaSinhVienAndMaKhoaHoc(long studentId, long CourseId);
	public List<MonHoc> getSubjectsByCourseId(long courseId, long studentId);
	public List<MonHoc> getSubjectsBySemesterIdAndMajorsId(long semesterId, long majorsId);
	public List<MonHoc> getSubjectsPassed(long studentId);
}
