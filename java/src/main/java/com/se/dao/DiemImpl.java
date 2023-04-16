package com.se.dao;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;

import com.se.dto.DiemDTO;
import com.se.entity.ChuongTrinhKhung;
import com.se.entity.Diem;
import com.se.entity.LopHocPhan;
import com.se.entity.MonHoc;
import com.se.entity.SinhVien;
import com.se.enums.XepLoai;
import com.se.repo.ChuongTrinhKhungRepository;
import com.se.repo.DiemRepository;
import com.se.repo.LopHocPhanRepository;
import com.se.repo.SinhVienRepository;
import com.se.service.DiemService;

@Service
public class DiemImpl implements DiemService {
	
	@Autowired
	private DiemRepository diemRepository;
	@Autowired
	private LopHocPhanRepository lopHocPhanRepository;
	@Autowired
	private SinhVienRepository sinhVienRepository;
	@Autowired
	private ChuongTrinhKhungRepository chuongTrinhKhungRepository;

	@Override
	public Diem addScore(DiemDTO diemDTO) {
		Diem diem = null;
		try {
			diem = diemRepository.findScoreByStudentIdAndUnitClassId(diemDTO.getMaSinhVien(), diemDTO.getMaLopHocPhan());	
		} catch (Exception e) {
			System.out.println("addScore not found Diem obj by maSinhVien mean student input score is the first time!");
			diem = null;
		}
		LopHocPhan lhp = lopHocPhanRepository.findById(diemDTO.getMaLopHocPhan()).orElse(null);
		SinhVien sv = sinhVienRepository.findById(diemDTO.getMaSinhVien()).orElse(null);
		if(diem == null) { //Nếu maSinhVien nhập lần đầu
			diem = Diem
				.builder()
				.diemGK(diemDTO.getDiemGK())
				.diemLT1(diemDTO.getDiemLT1())
				.diemLT2(diemDTO.getDiemLT2())
				.diemLT3(diemDTO.getDiemLT3())
				.diemTH1(diemDTO.getDiemTH1())
				.diemTH2(diemDTO.getDiemTH2())
				.diemTH3(diemDTO.getDiemTH3())
				.diemCK(diemDTO.getDiemCK())
				.diemChu("null")
				.lopHocPhan(lhp)
				.sinhVien(sv)
				.build();
		} else {//Nếu maSinhVien nhập điểm override
			if(diemDTO.getMaLopHocPhan() == 0 || diemDTO.getMaLopHocPhan() == diem.getLopHocPhan().getMaLopHocPhan()) {
				diem.setLopHocPhan(diem.getLopHocPhan());
			} else {
				// LopHocPhan lhp = lopHocPhanRepository.findById(diemDTO.getMaLopHocPhan()).orElse(null);
				diem.setLopHocPhan(lhp);
			}
			if(diemDTO.getMaSinhVien() == 0 || diemDTO.getMaSinhVien() == diem.getSinhVien().getMaSinhVien()) {
				diem.setSinhVien(diem.getSinhVien());
			} else {
				diem.setSinhVien(sv);
			}
			if(diemDTO.getDiemLT1() == 0 || diemDTO.getDiemLT1() == diem.getDiemLT1()) {
				diem.setDiemLT1(diem.getDiemLT1());
			} else {
				diem.setDiemLT1(diemDTO.getDiemLT1());
			}
			if(diemDTO.getDiemLT2() == 0 || diemDTO.getDiemLT2() == diem.getDiemLT2()) {
				diem.setDiemLT2(diem.getDiemLT2());
			} else {
				diem.setDiemLT2(diemDTO.getDiemLT2());
			}
			if(diemDTO.getDiemLT3() == 0 || diemDTO.getDiemLT3() == diem.getDiemLT3()) {
				diem.setDiemLT3(diem.getDiemLT3());
			} else {
				diem.setDiemLT3(diemDTO.getDiemLT3());
			}
			if(diemDTO.getDiemTH1() == 0 || diemDTO.getDiemTH1() == diem.getDiemTH1()) {
				diem.setDiemTH1(diem.getDiemTH1());
			} else {
				diem.setDiemTH1(diemDTO.getDiemTH1());
			}
			if(diemDTO.getDiemTH2() == 0 || diemDTO.getDiemTH2() == diem.getDiemTH2()) {
				diem.setDiemTH2(diem.getDiemTH2());
			} else {
				diem.setDiemTH2(diemDTO.getDiemTH2());
			}
			if(diemDTO.getDiemTH3() == 0 || diemDTO.getDiemTH3() == diem.getDiemTH3()) {
				diem.setDiemTH3(diem.getDiemTH3());
			} else {
				diem.setDiemTH3(diemDTO.getDiemTH3());
			}
			if(diemDTO.getDiemGK() == 0 || diemDTO.getDiemGK() == diem.getDiemGK()) {
				diem.setDiemGK(diem.getDiemGK());
			} else {
				diem.setDiemGK(diemDTO.getDiemGK());
			}
			if(diemDTO.getDiemCK() == 0 || diemDTO.getDiemCK() == diem.getDiemCK()) {
				diem.setDiemCK(diem.getDiemCK());
			} else {// Nếu có nhập điểm CK -> end năm học -> tính điểm TK & add vào CTK
				diem.setDiemCK(diemDTO.getDiemCK());
				float diemTongKiet = calculateDiemTongKet(diem, lhp.getMonHoc());
				float diem4 = calculateDiem4(diemTongKiet);
				String diemChu = calculateDiemChu(diemTongKiet);
				String ghiChu = calculateGhiChu(diemChu);
				boolean pass = calculatePass(diemChu);
				XepLoai xepLoai = calculateXepLoai(diemTongKiet);
				diem.setDiemTongKet(diemTongKiet);
				diem.setDiem4(diem4);
				diem.setDiemChu(diemChu);
				diem.setGhiChu(ghiChu);
				diem.setPass(pass);
				diem.setXepLoai(xepLoai);
				ChuongTrinhKhung chuongTrinhKhung = null;
				try {// Kiểm tra coi CTK này có tồn tại cho sv này vs lhp này hay không để tránh việc tạo ra CTK duplicate
					chuongTrinhKhung = chuongTrinhKhungRepository.getChuongTrinhKhungByStudentAndUnitClass(sv.getMaSinhVien(), lhp.getMonHoc().getMaMonHoc());
				} catch (Exception e) {
					System.out.println("Not found CTK -> First time input diemCK for student!");
				}
				if(chuongTrinhKhung == null) {// Nếu CTK ko tồn tại (input diemCK cho student lần đầu)
					chuongTrinhKhung = new ChuongTrinhKhung();
					chuongTrinhKhung.setDone(true);
					chuongTrinhKhung.setSinhVien(sv);
					chuongTrinhKhung.setMonHoc(lhp.getMonHoc());
					chuongTrinhKhungRepository.save(chuongTrinhKhung);
				}
			}
		}
		return diemRepository.save(diem);
	}

	public XepLoai calculateXepLoai(float diemTongKiet) {
		if (diemTongKiet < 4)
			return XepLoai.KEM;
		if(diemTongKiet >= 4.0 && diemTongKiet<= 4.9)
			return XepLoai.YEU;
		if(diemTongKiet >= 5.0 && diemTongKiet<= 5.4)
			return XepLoai.TRUNG_BINH_YEU;
		if(diemTongKiet >= 5.5 && diemTongKiet<= 6.4)
			return XepLoai.TRUNG_BINH;
		if(diemTongKiet >= 6.5 && diemTongKiet <= 6.9)
			return XepLoai.TRUNG_BINH_KHA;
		if(diemTongKiet >= 7.0 && diemTongKiet <= 7.9)
			return XepLoai.KHA;
		if(diemTongKiet >= 8.0 && diemTongKiet <= 8.4)
			return XepLoai.KHA_GIOI;
		return XepLoai.GIOI;
	}

	private boolean calculatePass(String diemChu) {
		if(diemChu.equalsIgnoreCase("F"))
			return false;
		return true;
	}

	private String calculateGhiChu(String diemChu) {
		if(diemChu.equalsIgnoreCase("F"))
			return "Chưa đạt";
		return "Đạt";
	}

	private String calculateDiemChu(float diemTongKiet) {
		String diemChu = "";
		if (diemTongKiet >= 9) {
			diemChu = "A+";
		} else if (diemTongKiet >= 8.5) {
			diemChu = "A";
		} else if (diemTongKiet >= 8) {
			diemChu = "A-";
		} else if (diemTongKiet >= 7) {
			diemChu = "B+";
		} else if (diemTongKiet >= 6.5) {
			diemChu = "B";
		} else if (diemTongKiet >= 5.5) {
			diemChu = "C+";
		} else if (diemTongKiet >= 4) {
			diemChu = "C";
		} else if (diemTongKiet >= 2) {
			diemChu = "D";
		} else {
			diemChu = "F";
		}
		return diemChu;
	}

	private float calculateDiem4(float diemTongKiet) {
		return diemTongKiet * 4 / 10;
	}

	private float calculateDiemTongKet(Diem diem, MonHoc monHoc) {
		float lt1 = diem.getDiemLT1();
		float lt2 = diem.getDiemLT2();
		float lt3 = diem.getDiemLT3();
		float tbcTK = (lt1 + lt2 + lt3)/3;
		float diemGK = diem.getDiemGK();
		float diemCK = diem.getDiemCK();
		float diemTongKetLyThuyet = ( (tbcTK*20) + (diemGK*30) + (diemCK*50) ) / 100;
		if(diem.getDiemTH1() == 0 && diem.getDiemTH2() == 0 && diem.getDiemTH3() ==0) {// Nếu là môn chỉ có LT
			return diemTongKetLyThuyet;
		}
		// Nếu là môn có TH
		int x = monHoc.getSoTietLT()/15;
		int y = monHoc.getSoTietTH()/15;
		int z = x + y;
		float th1 = diem.getDiemTH1();
		float th2 = diem.getDiemTH2();
		float th3 = diem.getDiemTH3();
		float tbcTH = (th1 + th2 + th3)/3;
		return ((diemTongKetLyThuyet*x) + (tbcTH*y)) / z;
	}

	@Override
	public List<Diem> getScores() {
		return (List<Diem>) diemRepository.findAll();
	}

	@Override
	public List<Diem> getStudentScoresBySemesterId(long studentId, long semesterId) {
		return diemRepository.getStudentScoresBySemesterId(studentId, semesterId);
	}

	@Override
	public Diem getScoreByStudentIdAndSubjectId(long studentId, long subjectId) {
		return diemRepository.getScoreByStudentIdAndSubjectId(studentId, subjectId);
	}

	@Override
	@Transactional
	@Modifying
	public String deleteScoreById(long maDiem) {
//		diemRepository.deleteById(maDiem);
		diemRepository.deleteScoreById(maDiem);
		return "DELETED";
	}
}
