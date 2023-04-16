package com.se.repo;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.Diem;

@Repository
public interface DiemRepository extends CrudRepository<Diem, Long> {
	@Query(value = "SELECT * FROM diem WHERE ma_sinh_vien = ?1 AND ma_lop_hoc_phan = ?2 ORDER BY ma_diem DESC LIMIT 1", nativeQuery = true)
	public Diem findScoreByStudentIdAndUnitClassId(long studentId, long unitClassId);

	@Query(value = "SELECT d.* FROM diem d JOIN lop_hoc_phan lhp ON d.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan JOIN mon_hoc mh ON lhp.ma_mon_hoc = mh.ma_mon_hoc JOIN hoc_ky hk ON mh.ma_hoc_ky = hk.ma_hoc_ky WHERE d.ma_sinh_vien = ?1 AND mh.ma_hoc_ky = ?2", nativeQuery = true)
	public List<Diem> getStudentScoresBySemesterId(long studentId, long semesterId);

	@Query(value = "SELECT d.* FROM diem d JOIN lop_hoc_phan lhp ON d.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan WHERE d.ma_sinh_vien = ?1 AND lhp.ma_mon_hoc = ?2", nativeQuery = true)
	public Diem getScoreByStudentIdAndSubjectId(long studentId, long subjectId);
	
	@Modifying
	@Query(value = "DELETE FROM diem WHERE ma_diem = ?1", nativeQuery = true)
	public void deleteScoreById(long maDiem);
}
