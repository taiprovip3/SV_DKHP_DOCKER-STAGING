package com.se.repo;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.Khoa;

@Repository
public interface KhoaRepository extends CrudRepository<Khoa, Long>{
}
