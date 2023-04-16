package com.se.service;

import java.util.List;

import com.se.entity.HocKy;

public interface HocKyService {
	public HocKy addSemester(HocKy hk);
	public int getTongSoTinChiByMaNganh(long id);
	public List<Long> getListSemesterIdByStudentRegister(long studentId);
	public List<HocKy> getSemestersByMajorsId(long majorsId);
}
