package com.se.repo;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.LopHocDanhNghia;

@Repository
public interface LopHocDanhNghiaRepository extends CrudRepository<LopHocDanhNghia, Long> {
}
