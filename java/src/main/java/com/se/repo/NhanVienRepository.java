package com.se.repo;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.NhanVien;

@Repository
public interface NhanVienRepository extends CrudRepository<NhanVien, Long>{
	@Query(value = "SELECT ma_nhan_vien FROM nhan_vien ORDER BY ma_nhan_vien DESC LIMIT 1", nativeQuery = true)
	public long getLatestIdEmployee();
}
