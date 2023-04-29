package com.se.repo;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.ThoiKhoaBieuCon;

@Repository
public interface ThoiKhoaBieuConRepository extends CrudRepository<ThoiKhoaBieuCon, Long> {

    @Query(value = "SELECT tbkc.* FROM thoi_khoa_bieu_con tbkc JOIN sinh_vien_lop_hoc_phan svlhp ON tbkc.ma_thoi_khoa_bieu_con = svlhp.ma_thoi_khoa_bieu_con WHERE ((?1 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?2 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?3 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?4 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?5 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?6 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?7 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc)) AND svlhp.ma_sinh_vien = ?8", nativeQuery = true)
	public List<ThoiKhoaBieuCon> getTimeTablesBy7DaysForStudent(String currentDate, String datePrev1, String datePrev2, String datePrev3, String datePrev4, String datePrev5, String datePrev6, long maSinhVien);
	@Query(value = "SELECT tbkc.* FROM thoi_khoa_bieu_con tbkc JOIN sinh_vien_lop_hoc_phan svlhp ON tbkc.ma_thoi_khoa_bieu_con = svlhp.ma_thoi_khoa_bieu_con WHERE ((?1 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?2 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?3 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?4 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?5 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?6 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?7 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc)) AND svlhp.ma_sinh_vien = ?8 AND tbkc.thi = 0", nativeQuery = true)
	public List<ThoiKhoaBieuCon> getTimeTablesBy7DaysWithoutThiForStudent(String currentDate, String datePrev1, String datePrev2, String datePrev3, String datePrev4, String datePrev5, String datePrev6, long maSinhVien);
	@Query(value = "SELECT tbkc.* FROM thoi_khoa_bieu_con tbkc JOIN sinh_vien_lop_hoc_phan svlhp ON tbkc.ma_thoi_khoa_bieu_con = svlhp.ma_thoi_khoa_bieu_con WHERE ((?1 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?2 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?3 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?4 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?5 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?6 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc) OR (?7 BETWEEN tbkc.ngay_bat_dau AND tbkc.ngay_ket_thuc)) AND svlhp.ma_sinh_vien = ?8 AND tbkc.thi = 1", nativeQuery = true)
	public List<ThoiKhoaBieuCon> getTimeTablesBy7DaysOnlyThiForStudent(String currentDate, String datePrev1, String datePrev2, String datePrev3, String datePrev4, String datePrev5, String datePrev6, long maSinhVien);

    
    @Query(value = "SELECT tkbc.* FROM thoi_khoa_bieu_con tkbc JOIN sinh_vien_lop_hoc_phan svlhp ON tkbc.ma_thoi_khoa_bieu_con = svlhp.ma_thoi_khoa_bieu_con WHERE (?2 BETWEEN tkbc.ngay_bat_dau AND tkbc.ngay_ket_thuc) AND svlhp.ma_sinh_vien = ?1 AND tkbc.thu_hoc = ?3", nativeQuery = true)
	public List<ThoiKhoaBieuCon> getStudentTimeTableByDay(long maSinhVien, String theDate, String dateOfWeek);
}
