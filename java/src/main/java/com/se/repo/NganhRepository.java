package com.se.repo;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.Nganh;

@Repository
public interface NganhRepository extends CrudRepository<Nganh, Long>{
}
