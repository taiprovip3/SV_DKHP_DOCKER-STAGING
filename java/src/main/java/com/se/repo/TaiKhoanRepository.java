package com.se.repo;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.TaiKhoan;

@Repository
public interface TaiKhoanRepository extends CrudRepository<TaiKhoan, Long>{
}
