package com.se.dao;

import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.LopHocPhanDTO;
import com.se.entity.GiaoVien;
import com.se.entity.KhoaHoc;
import com.se.entity.LopHocPhan;
import com.se.entity.MonHoc;
import com.se.enums.LoaiHoc;
import com.se.enums.TrangThai;
import com.se.repo.GiaoVienRepository;
import com.se.repo.KhoaHocRepository;
import com.se.repo.MonHocRepository;
import com.se.repo.LopHocPhanRepository;
import com.se.service.LopHocPhanService;

@Service
public class LopHocPhanImpl implements LopHocPhanService {
	
	@Autowired
	private LopHocPhanRepository lopHocPhanRepository;
	@Autowired
	private MonHocRepository monHocRepository;
	@Autowired
	private GiaoVienRepository giaoVienRepository;
	@Autowired
	private KhoaHocRepository khoaHocRepository;

	@Override
	public LopHocPhan addUnitClass(LopHocPhanDTO lopHocPhanDTO) {
		try {
			DateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date hanNopHocPhiUtil = sdf.parse(lopHocPhanDTO.getHanNopHocPhi());
			Date hanNopHocPhiSql = new Date(hanNopHocPhiUtil.getTime());
			java.util.Date ngayBatDauUtil = sdf.parse(lopHocPhanDTO.getNgayBatDau());
			Date ngayBatDauSql = new Date(ngayBatDauUtil.getTime());
			java.util.Date ngayKetThucUtil = sdf.parse(lopHocPhanDTO.getNgayKetThuc());
			Date ngayKetThucSql = new Date(ngayKetThucUtil.getTime());
			MonHoc monHoc = monHocRepository.findById(lopHocPhanDTO.getMaMonHoc()).orElse(null);
			GiaoVien giaoVien = giaoVienRepository.findById(lopHocPhanDTO.getMaGiaoVien()).orElse(null);
			KhoaHoc khoaHoc = khoaHocRepository.findById(lopHocPhanDTO.getMaKhoaHoc()).orElse(null);
			LopHocPhan lopHocPhan = LopHocPhan
					.builder()
					.tenLopHocPhan(lopHocPhanDTO.getTenLopHocPhan())
					.soLuong(0)
					.soLuongMax(lopHocPhanDTO.getSoLuongMax())
					.trangThai(TrangThai.valueOf(lopHocPhanDTO.getTrangThai()))
					.hanNopHocPhi(hanNopHocPhiSql)
					.ngayBatDau(ngayBatDauSql)
					.ngayKetThuc(ngayKetThucSql)
					.loaiHoc(LoaiHoc.valueOf(lopHocPhanDTO.getLoaiHoc()))
					.monHoc(monHoc)
					.giaoVien(giaoVien)
					.khoaHoc(khoaHoc)
					.build();
			return lopHocPhanRepository.save(lopHocPhan);
		} catch (Exception e) {
			System.out.println("Exception error in SinhVienDangKyHocPhan try catch!: " + e);
			return null;
		}
	}

	@Override
	public List<LopHocPhan> getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc(long maMonHoc, String loaiHoc, long maKhoaHoc) {
		return lopHocPhanRepository.getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc(maMonHoc, loaiHoc, maKhoaHoc);
	}

	@Override
	public List<LopHocPhan> getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc(long id, long maKhoaHoc) {
		return lopHocPhanRepository.getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc(id, maKhoaHoc);
	}

	@Override
	public LopHocPhan getUnitClassById(long id) {
		return lopHocPhanRepository.findById(id).orElse(null);
	}

}
