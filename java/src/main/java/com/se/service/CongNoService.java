package com.se.service;

import java.util.List;

import com.se.entity.CongNo;

public interface CongNoService {
	public CongNo updateDebt(long id);
	public List<CongNo> getDebtsByStudentId(long studentId);
	public List<CongNo> getDebtsByStudentIdAndCourseId(long studentId, long courseId);
	public List<CongNo> getUnDebtsByStudentId(long studentId);
	public List<CongNo> getUnDebtsByStuentIdAndCourseId(long studentId, long courseId);
	public CongNo getUndebtById(long debtId);
	public double getSoTienByDebtId(long debtId);
	public CongNo updateUnDebtById(long debtId);
	public CongNo getDebtById(long unDebtId); //Lấy công nợ đã thanh toán dựa theo mã công nợ chưa thanh toán từ ThanhToanGiaoDich
    public List<CongNo> getPayedDebts(long studentId);
}
