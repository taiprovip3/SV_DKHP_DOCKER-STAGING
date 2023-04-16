package com.se.repo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.GiaoVien;

@Repository
public interface GiaoVienRepository extends CrudRepository<GiaoVien, Long>{
	@Query(value = "SELECT ma_giao_vien FROM nhan_vien ORDER BY ma_giao_vien DESC LIMIT 1", nativeQuery = true)
	public long getLatestIdTeacher();
}
