package com.se.service;

import java.util.List;

import com.se.dto.PhieuThu2DTO;
import com.se.dto.PhieuThuDTO;
import com.se.entity.PhieuThu;

public interface PhieuThuService {
	public PhieuThu saveOrderDetail(PhieuThu phieuThu);
	public PhieuThu resolveOderDetail(PhieuThuDTO phieuThuDTO);
	public PhieuThu createOrderDetailBy(PhieuThu2DTO phieuThu2DTO);
	public List<PhieuThu> getOrderDetailsByStudentId(long studentId);
}
