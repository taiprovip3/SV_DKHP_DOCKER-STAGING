package com.se.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.entity.HocKy;
import com.se.repo.HocKyRepository;
import com.se.service.HocKyService;

@Service
public class HocKyImpl implements HocKyService {

	@Autowired
	private HocKyRepository hocKyRepository;
	
	@Override
	public HocKy addSemester(HocKy hk) {
		return hocKyRepository.save(hk);
	}

	@Override
	public int getTongSoTinChiByMaNganh(long id) {
		try {
			return hocKyRepository.getTongSoTinChiByMaNganh(id);	
		} catch (Exception e) {
			System.out.println("getTongSoTinChiByMaNganh Exception id: " + id);
			return 0;
		}
	}

	@Override
	public List<Long> getListSemesterIdByStudentRegister(long studentId) {
		return hocKyRepository.getListSemesterIdByStudentRegister(studentId);
	}

	@Override
	public List<HocKy> getSemestersByMajorsId(long majorsId) {
		return hocKyRepository.getSemestersByMajorsId(majorsId);
	}

}
