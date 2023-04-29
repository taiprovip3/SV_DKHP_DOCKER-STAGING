package com.se.dao;

import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashSet;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.ThoiKhoaBieu2DTO;
import com.se.dto.ThoiKhoaBieuDTO;
import com.se.entity.GiaoVien;
import com.se.entity.LopHocPhan;
import com.se.entity.SinhVien_LopHocPhan;
import com.se.entity.ThoiKhoaBieu;
import com.se.entity.ThoiKhoaBieuCon;
import com.se.enums.LoaiBuoiHoc;
import com.se.enums.ThuHoc;
import com.se.enums.TietHoc;
import com.se.repo.GiaoVienRepository;
import com.se.repo.LopHocPhanRepository;
import com.se.repo.ThoiKhoaBieuConRepository;
import com.se.repo.ThoiKhoaBieuRepository;
import com.se.service.ThoiKhoaBieuService;
import com.se.util.ThoiKhoaBieuComparator;

@Service
public class ThoiKhoaBieuImpl implements ThoiKhoaBieuService {
	
	@Autowired
	private ThoiKhoaBieuRepository thoiKhoaBieuRepository;
	@Autowired
	private LopHocPhanRepository lopHocPhanRepository;
	@Autowired
	private GiaoVienRepository giaoVienRepository;
	@Autowired
	private ThoiKhoaBieuConRepository thoiKhoaBieuConRepository;

	@Override
	public ThoiKhoaBieu addTimeTable(ThoiKhoaBieuDTO thoiKhoaBieuDTO) {
		Date ngayBatDauSql = null;
		Date ngayKetThucSql = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date ngayBatDauUtil = sdf.parse(thoiKhoaBieuDTO.getNgayBatDau());
			java.util.Date ngayKetThucUtil = sdf.parse(thoiKhoaBieuDTO.getNgayKetThuc());
			ngayBatDauSql = new Date(ngayBatDauUtil.getTime());
			ngayKetThucSql = new Date(ngayKetThucUtil.getTime());
		} catch (Exception e) {
			System.out.println("addTimeTable Exception maybe parse " + e.getMessage());
		}
		LopHocPhan lhp = lopHocPhanRepository.findById(thoiKhoaBieuDTO.getMaLopHocPhan()).orElse(null);
		boolean thi = false;
		if(thoiKhoaBieuDTO.getThi() != null) {
			thi = true;
		}
		GiaoVien gv = giaoVienRepository.findById(thoiKhoaBieuDTO.getMaGiaoVien()).orElse(null);
		ThoiKhoaBieu tkb = ThoiKhoaBieu
				.builder()
				.lopHocPhan(lhp)
				.tuTietHoc(TietHoc.valueOf(thoiKhoaBieuDTO.getTuTietHoc()))
				.denTietHoc(TietHoc.valueOf(thoiKhoaBieuDTO.getDenTietHoc()))
				.phongHoc(thoiKhoaBieuDTO.getPhongHoc())
				.thuHoc(ThuHoc.valueOf(thoiKhoaBieuDTO.getThuHoc()))
				.thi(thi)
				.ghiChu(thoiKhoaBieuDTO.getGhiChu())
				.loaiBuoiHoc(LoaiBuoiHoc.valueOf(thoiKhoaBieuDTO.getLoaiBuoiHoc()))
				.nhomHoc(thoiKhoaBieuDTO.getNhomHoc())
				.ngayBatDau(ngayBatDauSql)
				.ngayKetThuc(ngayKetThucSql)
				.soLuongDaDangKy(0)
				.giaoVien(gv)
				.build();
		return thoiKhoaBieuRepository.save(tkb);
	}
	
	@Override
	public ThoiKhoaBieuCon addTimeTableCon(ThoiKhoaBieuDTO thoiKhoaBieuDTO) {
		Date ngayBatDauSql = null;
		Date ngayKetThucSql = null;
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date ngayBatDauUtil = sdf.parse(thoiKhoaBieuDTO.getNgayBatDau());
			java.util.Date ngayKetThucUtil = sdf.parse(thoiKhoaBieuDTO.getNgayKetThuc());
			ngayBatDauSql = new Date(ngayBatDauUtil.getTime());
			ngayKetThucSql = new Date(ngayKetThucUtil.getTime());
		} catch (Exception e) {
			System.out.println("addTimeTable Exception maybe parse " + e.getMessage());
		}
		LopHocPhan lhp = lopHocPhanRepository.findById(thoiKhoaBieuDTO.getMaLopHocPhan()).orElse(null);
		boolean thi = false;
		if(thoiKhoaBieuDTO.getThi() != null) {
			thi = true;
		}
		
		GiaoVien gv = giaoVienRepository.findById(thoiKhoaBieuDTO.getMaGiaoVien()).orElse(null);
		ThoiKhoaBieu tkbCha = thoiKhoaBieuRepository.findById(thoiKhoaBieuDTO.getChungWithMaThoiKhoaBieu()).orElse(null);
		ThoiKhoaBieuCon tkbCon = ThoiKhoaBieuCon
				.builder()
				.tuTietHoc(TietHoc.valueOf(thoiKhoaBieuDTO.getTuTietHoc()))
				.denTietHoc(TietHoc.valueOf(thoiKhoaBieuDTO.getDenTietHoc()))
				.phongHoc(thoiKhoaBieuDTO.getPhongHoc())
				.thuHoc(ThuHoc.valueOf(thoiKhoaBieuDTO.getThuHoc()))
				.thi(thi)
				.ghiChu(thoiKhoaBieuDTO.getGhiChu())
				.loaiBuoiHoc(LoaiBuoiHoc.valueOf(thoiKhoaBieuDTO.getLoaiBuoiHoc()))
				.nhomHoc(thoiKhoaBieuDTO.getNhomHoc())
				.ngayBatDau(ngayBatDauSql)
				.ngayKetThuc(ngayKetThucSql)
				.giaoVien(gv)
				.soLuongDaDangKy(0)
				.thoiKhoaBieu(tkbCha)
				.build();
		return thoiKhoaBieuConRepository.save(tkbCon);
	}

	@Override
	public List<ThoiKhoaBieu> getTimeTablesByUnitClassId(long id) {
		return thoiKhoaBieuRepository.getTimeTablesByUnitClassId(id);
	}

	@Override
	public ThoiKhoaBieu getTimeTableById(long id) {
		return thoiKhoaBieuRepository.findById(id).orElse(null);
	}

	@Override
	public List<ThoiKhoaBieu> getTimeTablesBy7Days(ThoiKhoaBieu2DTO thoiKhoaBieu2DTO) {
		String currentDate = thoiKhoaBieu2DTO.getCurrentDate();
		String datePrev1 = thoiKhoaBieu2DTO.getDatePrev1();
		String datePrev2 = thoiKhoaBieu2DTO.getDatePrev2();
		String datePrev3 = thoiKhoaBieu2DTO.getDatePrev3();
		String datePrev4 = thoiKhoaBieu2DTO.getDatePrev4();
		String datePrev5 = thoiKhoaBieu2DTO.getDatePrev5();
		String datePrev6 = thoiKhoaBieu2DTO.getDatePrev6();
		String filterLoaiLich = thoiKhoaBieu2DTO.getFilterLoaiLich();
		if(thoiKhoaBieu2DTO.getMaGiaoVien() == 0) {
			long maSinhVien = thoiKhoaBieu2DTO.getMaSinhVien();
			if(filterLoaiLich.equalsIgnoreCase("lich_hoc")) {
				List<ThoiKhoaBieu> listThoiKhoaBieu = thoiKhoaBieuRepository.getTimeTablesBy7DaysWithoutThiForStudent(currentDate, datePrev1, datePrev2, datePrev3, datePrev4, datePrev5, datePrev6, maSinhVien);
				List<ThoiKhoaBieuCon> listTHoBieuCon = thoiKhoaBieuConRepository.getTimeTablesBy7DaysWithoutThiForStudent(currentDate, datePrev1, datePrev2, datePrev3, datePrev4, datePrev5, datePrev6, maSinhVien);
				List<ThoiKhoaBieu> ls = this.mixTimeTable(listThoiKhoaBieu, listTHoBieuCon);
				return ls;
			}
			if(filterLoaiLich.equalsIgnoreCase("lich_thi")) {
				List<ThoiKhoaBieu> listThoiKhoaBieu = thoiKhoaBieuRepository.getTimeTablesBy7DaysOnlyThiForStudent(currentDate, datePrev1, datePrev2, datePrev3, datePrev4, datePrev5, datePrev6, maSinhVien);
				List<ThoiKhoaBieuCon> listTHoBieuCon = thoiKhoaBieuConRepository.getTimeTablesBy7DaysOnlyThiForStudent(currentDate, datePrev1, datePrev2, datePrev3, datePrev4, datePrev5, datePrev6, maSinhVien);
				List<ThoiKhoaBieu> ls = this.mixTimeTable(listThoiKhoaBieu, listTHoBieuCon);
				return ls;
			}
			List<ThoiKhoaBieu> listThoiKhoaBieu = thoiKhoaBieuRepository.getTimeTablesBy7DaysForStudent(currentDate,datePrev1,datePrev2,datePrev3,datePrev4,datePrev5,datePrev6, maSinhVien);
			List<ThoiKhoaBieuCon> listTHoBieuCon = thoiKhoaBieuConRepository.getTimeTablesBy7DaysForStudent(currentDate,datePrev1,datePrev2,datePrev3,datePrev4,datePrev5,datePrev6, maSinhVien);
			List<ThoiKhoaBieu> ls = this.mixTimeTable(listThoiKhoaBieu, listTHoBieuCon);
			return ls;
		}
		long maGiaoVien = thoiKhoaBieu2DTO.getMaGiaoVien();
		if(filterLoaiLich.equalsIgnoreCase("lich_hoc"))
			return thoiKhoaBieuRepository.getTimeTablesBy7DaysWithoutThiForTeacher(currentDate, datePrev1, datePrev2, datePrev3, datePrev4, datePrev5, datePrev6, maGiaoVien);
		if(filterLoaiLich.equalsIgnoreCase("lich_thi"))
			return thoiKhoaBieuRepository.getTimeTablesBy7DaysOnlyThiForTeacher(currentDate, datePrev1, datePrev2, datePrev3, datePrev4, datePrev5, datePrev6, maGiaoVien);
		return thoiKhoaBieuRepository.getTimeTablesBy7DaysForTeacher(currentDate,datePrev1,datePrev2,datePrev3,datePrev4,datePrev5,datePrev6, maGiaoVien);
	}

	@Override
	public List<ThoiKhoaBieu> getTeacherTimeTableByDay(long maGiaoVien, String theDate) {
		return thoiKhoaBieuRepository.getTeacherTimeTableByDay(maGiaoVien, theDate);
	}

	@Override
	public List<ThoiKhoaBieu> getStudentTimeTableByDay(long maSinhVien, String theDate) {
		String dayOfWeek = this.getDayOfWeek(theDate);
		List<ThoiKhoaBieu> listThoiKhoaBieu = thoiKhoaBieuRepository.getStudentTimeTableByDay(maSinhVien, theDate, dayOfWeek);
		List<ThoiKhoaBieuCon> listThoiKhoaBieuCon = thoiKhoaBieuConRepository.getStudentTimeTableByDay(maSinhVien, theDate, dayOfWeek);
		List<ThoiKhoaBieu> ls = this.mixTimeTable(listThoiKhoaBieu, listThoiKhoaBieuCon);
		return ls;
	}

	@Override
	public List<Long> getIdsThoiKhoaBieuCon(ThoiKhoaBieu2DTO thoiKhoaBieu2DTO) {
		String currentDate = thoiKhoaBieu2DTO.getCurrentDate();
		String datePrev1 = thoiKhoaBieu2DTO.getDatePrev1();
		String datePrev2 = thoiKhoaBieu2DTO.getDatePrev2();
		String datePrev3 = thoiKhoaBieu2DTO.getDatePrev3();
		String datePrev4 = thoiKhoaBieu2DTO.getDatePrev4();
		String datePrev5 = thoiKhoaBieu2DTO.getDatePrev5();
		String datePrev6 = thoiKhoaBieu2DTO.getDatePrev6();
		long maSinhVien = thoiKhoaBieu2DTO.getMaSinhVien();
		return thoiKhoaBieuRepository.getIdsThoiKhoaBieuCon(currentDate,datePrev1,datePrev2,datePrev3,datePrev4,datePrev5,datePrev6, maSinhVien);
	}

	private String getDayOfWeek(String theDate) {
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
        try {
            java.util.Date date = format.parse(theDate);
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(date);
            int dayOfWeek = calendar.get(Calendar.DAY_OF_WEEK);
            String[] daysOfWeek = new String[] {"CN", "T2", "T3", "T4", "T5", "T6", "T7"};
            return daysOfWeek[dayOfWeek-1];
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

	private List<ThoiKhoaBieu> mixTimeTable(List<ThoiKhoaBieu> listThoiKhoaBieu, List<ThoiKhoaBieuCon> listThoiKhoaBieuCon) {
		List<ThoiKhoaBieu> ls = new ArrayList<ThoiKhoaBieu>();
		ls.addAll(listThoiKhoaBieu);
		for (ThoiKhoaBieuCon thoiKhoaBieuCon : listThoiKhoaBieuCon) {
			ThoiKhoaBieu thoiKhoaBieuConvert = ThoiKhoaBieu
				.builder()
				.maThoiKhoaBieu(thoiKhoaBieuCon.getMaThoiKhoaBieuCon())
				.thuHoc(thoiKhoaBieuCon.getThuHoc())
				.tuTietHoc(thoiKhoaBieuCon.getTuTietHoc())
				.denTietHoc(thoiKhoaBieuCon.getDenTietHoc())
				.phongHoc(thoiKhoaBieuCon.getPhongHoc())
				.ghiChu(thoiKhoaBieuCon.getGhiChu())
				.thi(thoiKhoaBieuCon.isThi())
				.loaiBuoiHoc(thoiKhoaBieuCon.getLoaiBuoiHoc())
				.nhomHoc(thoiKhoaBieuCon.getNhomHoc())
				.ngayBatDau(thoiKhoaBieuCon.getNgayBatDau())
				.ngayKetThuc(thoiKhoaBieuCon.getNgayKetThuc())
				.soLuongDaDangKy(thoiKhoaBieuCon.getSoLuongDaDangKy())
				.lopHocPhan(thoiKhoaBieuCon.getThoiKhoaBieu().getLopHocPhan())
				.thoiKhoaBieuCons(new ArrayList<ThoiKhoaBieuCon>())
				.giaoVien(thoiKhoaBieuCon.getGiaoVien())
				.sinhVien_LopHocPhans(new HashSet<SinhVien_LopHocPhan>())
				.build();
			ls.add(thoiKhoaBieuConvert);
		}
		Collections.sort(ls, new ThoiKhoaBieuComparator());
		return ls;
	}
}
