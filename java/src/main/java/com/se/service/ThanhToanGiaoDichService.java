package com.se.service;

import com.se.dto.ThanhToanGiaoDich2DTO;
import com.se.dto.ThanhToanGiaoDichDTO;
import com.se.entity.ThanhToanGiaoDich;

public interface ThanhToanGiaoDichService {
    public String createTransaction(long studentId, double balance, String unDebtIds);
    public ThanhToanGiaoDich getPaymentById(String id);
	public ThanhToanGiaoDich updatePaymentToPassById(ThanhToanGiaoDichDTO thanhToanGiaoDichDTO);
	public String createTransaction(ThanhToanGiaoDich2DTO thanhToanGiaoDich2DTO);
    public String getTokenByPaymentAndStudentId(String paymentId, long studentId);
    public ThanhToanGiaoDich getStudentPayedDebtByDebtId(long debtId, long studentId);
}
