package com.se.repo;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.ThoiKhoaBieu;

@Repository
public interface ThoiKhoaBieuRepository extends CrudRepository<ThoiKhoaBieu, Long>{
	@Query("SELECT tkb FROM ThoiKhoaBieu tkb WHERE tkb.lopHocPhan.maLopHocPhan = ?1")
	public List<ThoiKhoaBieu> getTimeTablesByUnitClassId(long id);
	@Query(value = "SELECT svlhp.ma_thoi_khoa_bieu_con FROM thoi_khoa_bieu_con tkbc JOIN sinh_vien_lop_hoc_phan svlhp ON tkbc.ma_thoi_khoa_bieu_con = svlhp.ma_thoi_khoa_bieu_con WHERE ((?1 BETWEEN tkbc.ngay_bat_dau AND tkbc.ngay_ket_thuc) OR (?2 BETWEEN tkbc.ngay_bat_dau AND tkbc.ngay_ket_thuc) OR (?3 BETWEEN tkbc.ngay_bat_dau AND tkbc.ngay_ket_thuc) OR (?4 BETWEEN tkbc.ngay_bat_dau AND tkbc.ngay_ket_thuc) OR (?5 BETWEEN tkbc.ngay_bat_dau AND tkbc.ngay_ket_thuc) OR (?6 BETWEEN tkbc.ngay_bat_dau AND tkbc.ngay_ket_thuc) OR (?7 BETWEEN tkbc.ngay_bat_dau AND tkbc.ngay_ket_thuc)) AND svlhp.ma_sinh_vien = ?8", nativeQuery = true)
	public List<Long> getIdsThoiKhoaBieuCon(String currentDate, String datePrev1, String datePrev2, String datePrev3, String datePrev4, String datePrev5, String datePrev6, long maSinhVien);
	@Query(value = "SELECT tkb.* FROM thoi_khoa_bieu tkb JOIN sinh_vien_lop_hoc_phan svlhp ON tkb.ma_thoi_khoa_bieu = svlhp.ma_thoi_khoa_bieu WHERE ((?1 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?2 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?3 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?4 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?5 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?6 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?7 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc)) AND svlhp.ma_sinh_vien = ?8", nativeQuery = true)
	public List<ThoiKhoaBieu> getTimeTablesBy7DaysForStudent(String currentDate, String datePrev1, String datePrev2, String datePrev3, String datePrev4, String datePrev5, String datePrev6, long maSinhVien);
	@Query(value = "SELECT tkb.* FROM thoi_khoa_bieu tkb JOIN sinh_vien_lop_hoc_phan svlhp ON tkb.ma_thoi_khoa_bieu = svlhp.ma_thoi_khoa_bieu WHERE ((?1 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?2 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?3 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?4 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?5 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?6 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?7 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc)) AND svlhp.ma_sinh_vien = ?8 AND tkb.thi = 0", nativeQuery = true)
	public List<ThoiKhoaBieu> getTimeTablesBy7DaysWithoutThiForStudent(String currentDate, String datePrev1, String datePrev2, String datePrev3, String datePrev4, String datePrev5, String datePrev6, long maSinhVien);
	@Query(value = "SELECT tkb.* FROM thoi_khoa_bieu tkb JOIN sinh_vien_lop_hoc_phan svlhp ON tkb.ma_thoi_khoa_bieu = svlhp.ma_thoi_khoa_bieu WHERE ((?1 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?2 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?3 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?4 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?5 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?6 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?7 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc)) AND svlhp.ma_sinh_vien = ?8 AND tkb.thi = 1", nativeQuery = true)
	public List<ThoiKhoaBieu> getTimeTablesBy7DaysOnlyThiForStudent(String currentDate, String datePrev1, String datePrev2, String datePrev3, String datePrev4, String datePrev5, String datePrev6, long maSinhVien);
	
	@Query(value = "SELECT tkb.* FROM thoi_khoa_bieu tkb JOIN lop_hoc_phan lhp ON tkb.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan JOIN giao_vien gv ON lhp.ma_giao_vien = gv.ma_giao_vien WHERE ((?1 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?2 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?3 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?4 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?5 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?6 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?7 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc)) AND gv.ma_giao_vien = ?8", nativeQuery = true)
	public List<ThoiKhoaBieu> getTimeTablesBy7DaysForTeacher(String currentDate, String datePrev1, String datePrev2, String datePrev3, String datePrev4, String datePrev5, String datePrev6, long maGiaoVien);
	@Query(value = "SELECT tkb.* FROM thoi_khoa_bieu tkb JOIN lop_hoc_phan lhp ON tkb.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan JOIN giao_vien gv ON lhp.ma_giao_vien = gv.ma_giao_vien WHERE ((?1 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?2 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?3 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?4 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?5 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?6 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?7 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc)) AND gv.ma_giao_vien = ?8 AND tkb.thi = 0", nativeQuery = true)
	public List<ThoiKhoaBieu> getTimeTablesBy7DaysWithoutThiForTeacher(String currentDate, String datePrev1, String datePrev2, String datePrev3, String datePrev4, String datePrev5, String datePrev6, long maGiaoVien);
	@Query(value = "SELECT tkb.* FROM thoi_khoa_bieu tkb JOIN lop_hoc_phan lhp ON tkb.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan JOIN giao_vien gv ON lhp.ma_giao_vien = gv.ma_giao_vien WHERE ((?1 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?2 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?3 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?4 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?5 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?6 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) OR (?7 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc)) AND gv.ma_giao_vien = ?8 AND tkb.thi = 1", nativeQuery = true)
	public List<ThoiKhoaBieu> getTimeTablesBy7DaysOnlyThiForTeacher(String currentDate, String datePrev1, String datePrev2, String datePrev3, String datePrev4, String datePrev5, String datePrev6, long maGiaoVien);
	
	@Query(value = "SELECT tkb.* FROM thoi_khoa_bieu tkb JOIN lop_hoc_phan lhp ON tkb.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan JOIN giao_vien gv ON lhp.ma_giao_vien = gv.ma_giao_vien WHERE (?2 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) AND gv.ma_giao_vien = ?1", nativeQuery = true)
	public List<ThoiKhoaBieu> getTeacherTimeTableByDay(long maGiaoVien, String theDate);
	@Query(value = "SELECT tkb.* FROM thoi_khoa_bieu tkb JOIN sinh_vien_lop_hoc_phan svlhp ON tkb.ma_thoi_khoa_bieu = svlhp.ma_thoi_khoa_bieu WHERE (?2 BETWEEN tkb.ngay_bat_dau AND tkb.ngay_ket_thuc) AND svlhp.ma_sinh_vien = ?1", nativeQuery = true)
	public List<ThoiKhoaBieu> getStudentTimeTableByDay(long maSinhVien, String theDate);
}

