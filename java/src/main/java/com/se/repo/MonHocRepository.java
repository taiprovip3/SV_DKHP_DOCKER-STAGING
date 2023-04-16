package com.se.repo;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.MonHoc;

@Repository
public interface MonHocRepository extends CrudRepository<MonHoc, Long> {
	@Query(value = "SELECT mh.* FROM sinh_vien_lop_hoc_phan svlhp JOIN lop_hoc_phan lhp ON svlhp.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan JOIN mon_hoc mh ON lhp.ma_mon_hoc = mh.ma_mon_hoc WHERE svlhp.ma_sinh_vien = ?1 AND lhp.ma_khoa_hoc = ?2", nativeQuery = true)
	public List<MonHoc> getListSinhVienDangKyHocPhanByMaSinhVienAndMaKhoaHoc(long studentId, long CourseId);

	@Query(value = "SELECT mh.* FROM khoa_hoc kh JOIN hoc_ky hk ON kh.ma_hoc_ky = hk.ma_hoc_ky JOIN mon_hoc mh ON hk.ma_hoc_ky = mh.ma_hoc_ky WHERE kh.ma_khoa_hoc = ?1", nativeQuery = true)
	public List<MonHoc> getSubjectsByCourseId(long id);

	@Query(value = "SELECT * FROM mon_hoc WHERE ma_hoc_ky = ?1 AND ma_nganh = ?2", nativeQuery = true)
	public List<MonHoc> getSubjectsBySemesterIdAndMajorsId(long semesterId, long majorsId);

	@Query(value = "SELECT mh.* FROM diem d JOIN lop_hoc_phan lhp ON d.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan JOIN mon_hoc mh ON lhp.ma_mon_hoc = mh.ma_mon_hoc WHERE d.pass = 1 AND d.ma_sinh_vien = ?1", nativeQuery = true)
	public List<MonHoc> getSubjectsPassed(long studentId);

	@Query(value = "SELECT mh.* FROM lop_hoc_phan lhp JOIN mon_hoc mh ON lhp.ma_mon_hoc = mh.ma_mon_hoc WHERE lhp.ma_khoa_hoc = ?1 AND mh.ma_nganh = ?2", nativeQuery = true)
    public List<MonHoc> getSubjectsUnitClassOpen(long courseId, long majorId);
}
