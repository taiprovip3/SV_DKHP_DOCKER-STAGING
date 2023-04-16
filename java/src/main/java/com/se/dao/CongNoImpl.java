package com.se.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.entity.CongNo;
import com.se.repo.CongNoRepository;
import com.se.service.CongNoService;

@Service
public class CongNoImpl implements CongNoService {

	@Autowired
	private CongNoRepository congNoRepository;

	@Override
	public CongNo updateDebt(long id) {
		CongNo c = congNoRepository.findById(id).orElse(null);
		c.setTrangThai("DA_NOP");
		return congNoRepository.save(c);
	}

	@Override
	public List<CongNo> getDebtsByStudentId(long studentId) {
		return congNoRepository.getDebtsByStudentId(studentId);
	}

	@Override
	public List<CongNo> getDebtsByStudentIdAndCourseId(long studentId, long courseId) {
		return congNoRepository.getDebtsByStudentIdAndCourseId(studentId, courseId);
	}

	@Override
	public List<CongNo> getUnDebtsByStudentId(long studentId) {
		return congNoRepository.getUnDebtsByStudentId(studentId);
	}

	@Override
	public List<CongNo> getUnDebtsByStuentIdAndCourseId(long studentId, long courseId) {
		return congNoRepository.getUnDebtsByStuentIdAndCourseId(studentId, courseId);
	}

	@Override
	public CongNo getUndebtById(long debtId) {
		return congNoRepository.findById(debtId).orElse(null);
	}

	@Override
	public double getSoTienByDebtId(long debtId) {
		double soTien = 0;
		CongNo c = congNoRepository.findById(debtId).orElse(null);
		if(c.getSoTien() == 0) {
			soTien = c.getMonHoc().getSoTinChi() * 850000;
		} else { //TH danh cho dong tien bao hiem Y te or... cai j do khac
			soTien = c.getSoTien();
		}
		return soTien;
	}

	@Override
	public CongNo updateUnDebtById(long debtId) {
		CongNo congNo = congNoRepository.findById(debtId).orElse(null);
		double soTien = congNo.getMonHoc().getSoTinChi() * 850000;
		congNo.setCongNo(0);
		congNo.setDaNop(soTien);
		congNo.setTrangThai("DA_NOP");
		return congNoRepository.save(congNo);
	}

	@Override
	public CongNo getDebtById(long unDebtId) {
		return congNoRepository.getDebtById(unDebtId);
	}

	@Override
	public List<CongNo> getPayedDebts(long studentId) {
		return congNoRepository.getPayedDebts(studentId);
	}
	

}
