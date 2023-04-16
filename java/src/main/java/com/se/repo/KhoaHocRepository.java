package com.se.repo;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.KhoaHoc;

@Repository
public interface KhoaHocRepository extends CrudRepository<KhoaHoc, Long>{
	@Query(value = "SELECT DISTINCT kh.* FROM sinh_vien_lop_hoc_phan svlhp JOIN lop_hoc_phan lhp ON svlhp.ma_lop_hoc_phan = lhp.ma_lop_hoc_phan JOIN khoa_hoc kh ON lhp.ma_khoa_hoc = kh.ma_khoa_hoc WHERE svlhp.ma_sinh_vien = ?1 ORDER BY kh.ma_khoa_hoc DESC", nativeQuery = true)
	public List<KhoaHoc> getCoursesByStudentId(long id);
}
