package com.se.dao;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.PhieuThu2DTO;
import com.se.dto.PhieuThuDTO;
import com.se.entity.PhieuThu;
import com.se.entity.SinhVien;
import com.se.entity.ThanhToanGiaoDich;
import com.se.enums.LoaiPhieuThu;
import com.se.repo.PhieuThuRepository;
import com.se.repo.SinhVienRepository;
import com.se.repo.ThanhToanGiaoDichRepository;
import com.se.service.PhieuThuService;

@Service
public class PhieuThuImpl implements PhieuThuService {

	@Autowired
	private PhieuThuRepository phieuThuRepository;
	@Autowired
	private SinhVienRepository sinhVienRepository;
	@Autowired
	private ThanhToanGiaoDichRepository thanhToanGiaoDichRepository;
	
	@Override
	public PhieuThu saveOrderDetail(PhieuThu phieuThu) {
		return phieuThuRepository.save(phieuThu);
	}

	@Override
	public PhieuThu resolveOderDetail(PhieuThuDTO phieuThuDTO) {
		String trangThai = phieuThuDTO.getTrangThai();
		PhieuThu phieuThu = phieuThuRepository.findById(phieuThuDTO.getMaPhieuThu()).orElse(null);
		phieuThu.setDonViThu(phieuThuDTO.getDonViThu());
		phieuThu.setTrangThai(phieuThuDTO.getTrangThai());
		SinhVien sv = phieuThu.getSinhVien();
		if(trangThai.equalsIgnoreCase("DA_XU_LY")) {
			sv = sinhVienRepository.findById(phieuThuDTO.getMaSV()).orElse(null);
			sv.setSoDu(sv.getSoDu() + phieuThuDTO.getSoTien());
			sv = sinhVienRepository.save(sv);
		}
		return phieuThuRepository.save(phieuThu);
	}

	@Override
	public PhieuThu createOrderDetailBy(PhieuThu2DTO phieuThu2DTO) {
		SinhVien sinhVien = sinhVienRepository.findById(phieuThu2DTO.getMaSinhVien()).orElse(null);
		ThanhToanGiaoDich thanhToanGiaoDich = thanhToanGiaoDichRepository.findById(phieuThu2DTO.getMaGiaoDich()).orElse(null);
		PhieuThu phieuThu = PhieuThu
				.builder()
				.donViThu(phieuThu2DTO.getDonViThu())
				.ghiChu(phieuThu2DTO.getGhiChu())
				.ngayThu(new Date(new java.util.Date().getTime()))
				.soTien(phieuThu2DTO.getSoTien())
				.trangThai(phieuThu2DTO.getTrangThai())
				.sinhVien(sinhVien)
				.thanhToanGiaoDich(thanhToanGiaoDich)
				.loaiPhieuThu(LoaiPhieuThu.valueOf(phieuThu2DTO.getLoaiPhieuThu()))
				.build();
		return phieuThuRepository.save(phieuThu);
	}

	@Override
	public List<PhieuThu> getOrderDetailsByStudentId(long studentId) {
		return phieuThuRepository.getOrderDetailsByStudentId(studentId);
	}

}
