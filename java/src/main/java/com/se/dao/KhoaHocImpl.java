package com.se.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.KhoaHocDTO;
import com.se.entity.HocKy;
import com.se.entity.KhoaHoc;
import com.se.enums.TenKhoaHoc;
import com.se.repo.HocKyRepository;
import com.se.repo.KhoaHocRepository;
import com.se.service.KhoaHocService;

@Service
public class KhoaHocImpl implements KhoaHocService{

	@Autowired
	private KhoaHocRepository khoaHocRepository;
	@Autowired
	private HocKyRepository hocKyRepository;
	@Override
	public KhoaHoc addCourse(KhoaHocDTO khoaHoc) {
		HocKy hk = hocKyRepository.findById(khoaHoc.getMaHocKy()).orElse(null);
		KhoaHoc kh = KhoaHoc.builder()
				.tenKhoaHoc(TenKhoaHoc.valueOf(khoaHoc.getTenKhoaHoc()))
				.alias(khoaHoc.getAlias())
				.namBatDau(khoaHoc.getNamBatDau())
				.namKetThuc(khoaHoc.getNamKetThuc())
				.hocKy(hk)
				.build();
		return khoaHocRepository.save(kh);
	}

	@Override
	public List<KhoaHoc> getCourses() {
		List<KhoaHoc> ls = (List<KhoaHoc>) khoaHocRepository.findAll();
		return ls;
	}

	@Override
	public List<KhoaHoc> getCoursesByStudentId(long studendId) {
		return khoaHocRepository.getCoursesByStudentId(studendId);
	}

	@Override
	public int getCounterStudentsByCourseId(long courseId) {
		return khoaHocRepository.getCounterStudentsByCourseId(courseId);
	}

}
