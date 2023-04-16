package com.se.repo;

import java.util.List;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.se.entity.CongNo;

@Repository
public interface CongNoRepository extends CrudRepository<CongNo, Long> {
	
	@Query(value = "SELECT * FROM cong_no WHERE ma_sinh_vien = ?1", nativeQuery = true)
	public List<CongNo> getDebtsByStudentId(long studentId);

	@Query(value = "SELECT cn.* FROM cong_no cn JOIN lop_hoc_phan lhp ON cn.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan WHERE cn.ma_sinh_vien = ?1 AND lhp.ma_khoa_hoc = ?2", nativeQuery = true)
	public List<CongNo> getDebtsByStudentIdAndCourseId(long studentId, long courseId);

	@Query(value = "SELECT * FROM cong_no WHERE ma_sinh_vien = ?1 AND trang_thai = 'CHUA_NOP'", nativeQuery = true)
	public List<CongNo> getUnDebtsByStudentId(long studentId);

	@Query(value = "SELECT cn.* FROM cong_no cn JOIN lop_hoc_phan lhp ON cn.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan WHERE cn.ma_sinh_vien = ?1 AND lhp.ma_khoa_hoc = ?2 AND cn.trang_thai = 'CHUA_NOP'", nativeQuery = true)
	public List<CongNo> getUnDebtsByStuentIdAndCourseId(long studentId, long courseId);

	@Query(value = "SELECT * FROM cong_no WHERE id = ?1 AND trang_thai = 'DA_NOP'", nativeQuery = true)
	public CongNo getDebtById(long unDebtId);

	@Transactional
	@Modifying
	@Query(value = "DELETE FROM cong_no WHERE ma_sinh_vien = ?1 AND ma_lop_hoc_phan = ?2", nativeQuery = true)
	public void deleteDebByStudentAndUnitClassId(long studentId, long unitClassId);
	@Query(value = "SELECT * FROM cong_no WHERE ma_sinh_vien = ?1 AND trang_thai = 'DA_NOP'", nativeQuery = true)
	public List<CongNo> getPayedDebts(long studentId);
	
}
