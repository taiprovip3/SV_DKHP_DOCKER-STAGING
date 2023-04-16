package com.se.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.entity.KhoaHoc;
import com.se.entity.MonHoc;
import com.se.enums.TenKhoaHoc;
import com.se.repo.KhoaHocRepository;
import com.se.repo.MonHocRepository;
import com.se.repo.SinhVienRepository;
import com.se.service.MonHocService;

@Service
public class MonHocImpl implements MonHocService {

	@Autowired
	private MonHocRepository monHocRepository;

	@Autowired
	private KhoaHocRepository khoaHocRepository;

	@Autowired
	private SinhVienRepository sinhVienRepository;
	
	@Override
	public MonHoc addSubject(MonHoc mh) {
		return monHocRepository.save(mh);
	}

	@Override
	public List<MonHoc> getListSinhVienDangKyHocPhanByMaSinhVienAndMaKhoaHoc(long studentId, long CourseId) {
		return monHocRepository.getListSinhVienDangKyHocPhanByMaSinhVienAndMaKhoaHoc(studentId, CourseId);
	}

	@Override
	public List<MonHoc> getSubjectsByCourseId(long courseId, long studentId) {
		KhoaHoc khoaHoc = khoaHocRepository.findById(courseId).orElse(null);
		if(khoaHoc.getTenKhoaHoc() == TenKhoaHoc.HOC_KY_III) {// Nếu mã khóa học là HK3 thì lấy những môn mà có mở LHP
			long majorId = sinhVienRepository.getMaNganhByStudentId(studentId);
			return monHocRepository.getSubjectsUnitClassOpen(courseId, majorId);
		}
		return monHocRepository.getSubjectsByCourseId(courseId);
	}

	@Override
	public List<MonHoc> getSubjectsBySemesterIdAndMajorsId(long semesterId, long majorsId) {
		return monHocRepository.getSubjectsBySemesterIdAndMajorsId(semesterId, majorsId);
	}

	@Override
	public List<MonHoc> getSubjectsPassed(long studentId) {
		return monHocRepository.getSubjectsPassed(studentId);
	}
}
