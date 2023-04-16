package com.se.repo;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.SinhVien_LopHocPhan;

@Repository
public interface SinhVien_LopHocPhanRepository extends CrudRepository<SinhVien_LopHocPhan, Long>{
	@Query(value = "SELECT * FROM sinh_vien_lop_hoc_phan WHERE ma_lop_hoc_phan = ?1", nativeQuery = true)
	public SinhVien_LopHocPhan isStudentRegisThisUnitClass(long id);

	@Query(value = "SELECT * FROM sinh_vien_lop_hoc_phan WHERE ma_lop_hoc_phan = ?1", nativeQuery = true)
	public SinhVien_LopHocPhan getSVLHPByMaLopHocPhanId(long id);

	@Query(value = "SELECT * FROM sinh_vien_lop_hoc_phan WHERE ma_sinh_vien = ?1 AND ma_lop_hoc_phan = ?2", nativeQuery = true)
	public SinhVien_LopHocPhan getSVLHPsByMaLopHocPhanIdAndStudentId(long maSinhVien, long maLopHocPhan);
	@Query(value = "SELECT * FROM sinh_vien_lop_hoc_phan svlhp JOIN lop_hoc_phan lhp ON svlhp.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan WHERE ma_sinh_vien = ?1 and lhp.ma_khoa_hoc = ?2", nativeQuery = true)
	public List<SinhVien_LopHocPhan> getSVLHPStudentRegistered(long maSinhVien, long courseId);
}
