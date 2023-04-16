package com.se.repo;

import java.util.List;


import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.LopHocPhan;

@Repository
public interface LopHocPhanRepository extends CrudRepository<LopHocPhan, Long> {
	@Query(value = "SELECT * FROM lop_hoc_phan WHERE ma_mon_hoc = ?1 AND loai_hoc = ?2 AND ma_khoa_hoc = ?3", nativeQuery = true)
	public List<LopHocPhan> getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc(long maMonHoc, String loaiHoc, long maKhoaHoc);
	@Query(value = "SELECT lhp.* FROM lop_hoc_phan lhp JOIN sinh_vien_lop_hoc_phan svlhp ON lhp.ma_lop_hoc_phan = svlhp.ma_lop_hoc_phan WHERE svlhp.ma_sinh_vien = ?1 AND lhp.ma_khoa_hoc = ?2", nativeQuery = true)
	public List<LopHocPhan> getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc(long id, long maKhoaHoc);
	@Query(value = "SELECT * FROM sinh_vien_lop_hoc_phan svlhp JOIN lop_hoc_phan lhp ON svlhp.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan WHERE lhp.ma_mon_hoc = ?1 AND lhp.ma_khoa_hoc = ?2 AND svlhp.ma_sinh_vien = ?3", nativeQuery = true)
	public LopHocPhan getUnitClassBySubjectIdAndCourseId(long subjectId, long courseId, long studentId);
}
