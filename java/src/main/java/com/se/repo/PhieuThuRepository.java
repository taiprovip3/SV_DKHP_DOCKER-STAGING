package com.se.repo;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.PhieuThu;

@Repository
public interface PhieuThuRepository extends CrudRepository<PhieuThu, Long> {
	@Query(value = "SELECT * FROM phieu_thu WHERE ma_sinh_vien = ?1", nativeQuery = true)
	public List<PhieuThu> getOrderDetailsByStudentId(long studentId);
}
