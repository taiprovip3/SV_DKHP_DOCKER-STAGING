package com.se.dao;

import java.sql.Date;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.SinhVien_LopHocPhanDTO;
import com.se.entity.CongNo;
import com.se.entity.LopHocPhan;
import com.se.entity.SinhVien;
import com.se.entity.SinhVien_LopHocPhan;
import com.se.entity.ThoiKhoaBieu;
import com.se.entity.ThoiKhoaBieuCon;
import com.se.enums.TrangThai;
import com.se.repo.SinhVien_LopHocPhanRepository;
import com.se.repo.ThoiKhoaBieuConRepository;
import com.se.repo.CongNoRepository;
import com.se.repo.LopHocPhanRepository;
import com.se.repo.SinhVienRepository;
import com.se.repo.ThoiKhoaBieuRepository;
import com.se.service.SinhVien_LopHocPhanService;

@Service
public class SinhVien_LopHocPhanImpl implements SinhVien_LopHocPhanService {

	@Autowired
	private SinhVien_LopHocPhanRepository sinhVien_LopHocPhanRepository;
	@Autowired
	private SinhVienRepository sinhVienRepository;
	@Autowired
	private ThoiKhoaBieuRepository thoiKhoaBieuRepository;
	@Autowired
	private LopHocPhanRepository lopHocPhanRepository;
	@Autowired
	private CongNoRepository congNoRepository;
	@Autowired
	private ThoiKhoaBieuConRepository thoiKhoaBieuConRepository;
	
	@Override
	public SinhVien_LopHocPhan saveUnitSubject(SinhVien_LopHocPhanDTO sinhVien_LopHocPhanDTO) {
		//Task:
		// - Tạo công nợ sinh viên DKHP
		// - Tạo sv_lhp đã đăng ký
		// - Cập nhật số lượng LHP slot
		// - Cập nhật thời khoá biểu, soluongDaDangKy vao tkb nay
		ThoiKhoaBieu tkb = thoiKhoaBieuRepository.findById(sinhVien_LopHocPhanDTO.getMaThoiKhoaBieu()).orElse(null);
		long maLopHocPhan = tkb.getLopHocPhan().getMaLopHocPhan();
		LopHocPhan lhp = lopHocPhanRepository.findById(maLopHocPhan).orElse(null);
		SinhVien sv = sinhVienRepository.findById(sinhVien_LopHocPhanDTO.getMaSinhVien()).orElse(null);
		CongNo congNo = CongNo
				.builder()
				.soTien(0)
				.mienGiam(0)
				.daNop(0)
				.khauTru(0)
				.congNo(0)
				.trangThai("CHUA_NOP")
				.sinhVien(sv)
				.monHoc(lhp.getMonHoc())
				.lopHocPhan(lhp)
				.build();
		congNoRepository.save(congNo);
		long maThoiKhoaBieuCon = sinhVien_LopHocPhanDTO.getMaThoiKhoaBieuCon();
		ThoiKhoaBieuCon tkbCon = thoiKhoaBieuConRepository.findById(maThoiKhoaBieuCon).orElse(null);
		SinhVien_LopHocPhan sv_lhp = SinhVien_LopHocPhan
				.builder()
				.daThuHocPhi(false)
				.ngayDangKy(new Date(new java.util.Date().getTime()))
				.lopHocPhan(lhp)
				.sinhVien(sv)
				.thoiKhoaBieu(tkb)
				.thoiKhoaBieuCon(tkbCon)
				.build();
		//Update sl lhp
		lhp.setSoLuong(lhp.getSoLuong()+1);
		lopHocPhanRepository.save(lhp);
		//Update sl tkbLT
		tkb.setSoLuongDaDangKy(tkb.getSoLuongDaDangKy()+1);
		thoiKhoaBieuRepository.save(tkb);
		//Update sl tkbTH
		if(tkbCon != null) {
			tkbCon.setSoLuongDaDangKy(tkbCon.getSoLuongDaDangKy() + 1);
			thoiKhoaBieuConRepository.save(tkbCon);
		}
		return sinhVien_LopHocPhanRepository.save(sv_lhp);
	}

	@Override
	public boolean isStudentRegisThisUnitClass(long maLopHocPhan, long maMonHoc, long maKhoaHoc, long maSinhVien) {
		SinhVien_LopHocPhan svlhp = sinhVien_LopHocPhanRepository.isStudentRegisThisUnitClass(maLopHocPhan);
		//false :: ko có giá trị, cho đăng ký ; true:: có giá trị, ko ko cho
		if(svlhp != null)
			return true;
		//Xem coi có Lhp có maMonHoc & maKhoaHoc này mà sv đăng ký ko.
		LopHocPhan lhp = lopHocPhanRepository.getUnitClassBySubjectIdAndCourseId(maMonHoc, maKhoaHoc, maSinhVien);
		if(lhp != null)
			return true;
		return false;
	}

	@Override
	public SinhVien_LopHocPhan getSVLHPByMaLopHocPhanId(long id) {
		return sinhVien_LopHocPhanRepository.getSVLHPByMaLopHocPhanId(id);
	}

	@Override
	public String deleteById(long id) {
		try {
			SinhVien_LopHocPhan sv_lhp = sinhVien_LopHocPhanRepository.findById(id).orElse(null);
			LopHocPhan lhp = sv_lhp.getLopHocPhan();
			LocalDate startDay = lhp.getNgayBatDau().toLocalDate();
			LocalDate today = LocalDate.now();
			if(startDay.isEqual(today)) {
				if(lhp.getTrangThai().equals(TrangThai.DANG_CHO_SINH_VIEN_DANG_KY)) {
					lhp.setTrangThai(TrangThai.CHAP_NHAN_MO_LOP);
					lopHocPhanRepository.save(lhp);
				}
				return "OUT_OF_DATE";
			} else if(startDay.isAfter(today)) {
				// Cập nhật số lượng cho LHP
				lhp.setSoLuong(lhp.getSoLuong() - 1);
				lopHocPhanRepository.save(lhp);
				// Cập nhật số lượng tkb
				ThoiKhoaBieu thoiKhoaBieu = sv_lhp.getThoiKhoaBieu();
				thoiKhoaBieu.setSoLuongDaDangKy(thoiKhoaBieu.getSoLuongDaDangKy() - 1);
				thoiKhoaBieuRepository.save(thoiKhoaBieu);
				// Cập nhật số lượng tkbCon
				ThoiKhoaBieuCon thoiKhoaBieuCon = sv_lhp.getThoiKhoaBieuCon();
				if(thoiKhoaBieuCon != null) {
					thoiKhoaBieuCon.setSoLuongDaDangKy(thoiKhoaBieuCon.getSoLuongDaDangKy() - 1);
					thoiKhoaBieuConRepository.save(thoiKhoaBieuCon);
				}
				sinhVien_LopHocPhanRepository.deleteById(sv_lhp.getId());
				long studentId = sv_lhp.getSinhVien().getMaSinhVien();
				long unitClassId = lhp.getMaLopHocPhan();
				congNoRepository.deleteDebByStudentAndUnitClassId(studentId, unitClassId);
				return "OK";
			} else {
				if(lhp.getTrangThai().equals(TrangThai.DANG_CHO_SINH_VIEN_DANG_KY)) {
					lhp.setTrangThai(TrangThai.DA_KHOA);
					lopHocPhanRepository.save(lhp);
				}
				return "OUT_OF_DATE";
			}
		} catch (DateTimeParseException e) {
			System.out.println("Chuỗi ngày không hợp lệ!");
      		e.printStackTrace();
		}
		return "ERROR";
	}

	@Override
	public SinhVien_LopHocPhan updateStudentRegisSVLHP(long maSinhVien, long maLopHocPhan) {
		SinhVien_LopHocPhan sinhVien_LopHocPhan = sinhVien_LopHocPhanRepository.getSVLHPsByMaLopHocPhanIdAndStudentId(maSinhVien, maLopHocPhan);
		sinhVien_LopHocPhan.setDaThuHocPhi(true);
		return sinhVien_LopHocPhanRepository.save(sinhVien_LopHocPhan);
	}

	@Override
	public SinhVien_LopHocPhan getSvlhpById(long svlhpId) {
		return sinhVien_LopHocPhanRepository.findById(svlhpId).orElse(null);
	}

	@Override
	public List<SinhVien_LopHocPhan> getSVLHPStudentRegistered(long maSinhVien, long courseId) {
		return sinhVien_LopHocPhanRepository.getSVLHPStudentRegistered(maSinhVien, courseId);
	}

}
