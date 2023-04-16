package com.se.repo;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.HocKy;

@Repository
public interface HocKyRepository extends CrudRepository<HocKy, Long> {
	@Query(value = "SELECT SUM(so_tin_chi) FROM `hoc_ky` WHERE ma_nganh = ?1", nativeQuery = true)
	public int getTongSoTinChiByMaNganh(long id);
	@Query(value = "SELECT DISTINCT mh.ma_hoc_ky FROM `sinh_vien_lop_hoc_phan` svlhp JOIN lop_hoc_phan lhp ON svlhp.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan JOIN mon_hoc mh ON lhp.ma_mon_hoc = mh.ma_mon_hoc JOIN hoc_ky hk ON mh.ma_hoc_ky = hk.ma_hoc_ky WHERE svlhp.ma_sinh_vien = ?1", nativeQuery = true)
	public List<Long> getListSemesterIdByStudentRegister(long studentId);
	@Query(value = "SELECT * FROM hoc_ky WHERE ma_nganh = ?1", nativeQuery = true)
	public List<HocKy> getSemestersByMajorsId(long majorsId);
}