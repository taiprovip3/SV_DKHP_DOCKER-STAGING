package com.se.repo;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.ThongBaoKhoa;

@Repository
public interface ThongBaoKhoaRepository extends CrudRepository<ThongBaoKhoa, Long> {
	@Query(value = "SELECT * FROM thong_bao_khoa WHERE ma_khoa = ?1 ORDER BY ma_thong_bao DESC", nativeQuery = true)
	public List<ThongBaoKhoa> getNotificationsByDeparmentId(long maKhoa);
}
