package com.se.repo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.SinhVien;

@Repository
public interface SinhVienRepository extends CrudRepository<SinhVien, Long> {
	@Query(value = "SELECT ma_sinh_vien FROM sinh_vien ORDER BY ma_sinh_vien DESC LIMIT 1", nativeQuery = true)
	public long getLatestIdStudent();
	@Query(value = "SELECT so_du FROM sinh_vien WHERE ma_sinh_vien = ?1", nativeQuery = true)
	public double getStudentBalance(long studentId);
	@Query(value = "SELECT lhdn.ma_nganh FROM sinh_vien sv JOIN lop_hoc_danh_nghia lhdn ON sv.ma_lop_danh_nghia = lhdn.ma_lop WHERE sv.ma_sinh_vien = ?1", nativeQuery = true)
    public long getMaNganhByStudentId(long studentId);
}
