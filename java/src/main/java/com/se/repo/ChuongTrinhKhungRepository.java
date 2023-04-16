package com.se.repo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.ChuongTrinhKhung;

@Repository
public interface ChuongTrinhKhungRepository extends CrudRepository<ChuongTrinhKhung, Long> {
	@Query(value = "SELECT SUM(mh.so_tin_chi) FROM `chuong_trinh_khung` ctk JOIN mon_hoc mh ON ctk.ma_mon_hoc = mh.ma_mon_hoc WHERE ma_sinh_vien = ?1 AND done = 1", nativeQuery = true)
	public int getSoTinChiDoneByStudentId(long id);

	@Query(value = "SELECT * FROM chuong_trinh_khung WHERE ma_sinh_vien = ?1 AND ma_mon_hoc = ?2 LIMIT 1", nativeQuery = true)
    public ChuongTrinhKhung getChuongTrinhKhungByStudentAndUnitClass(long studentId, long subjectId);
}
