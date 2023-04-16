package com.se.repo;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.ThoiKhoaBieuCon;

@Repository
public interface ThoiKhoaBieuConRepository extends CrudRepository<ThoiKhoaBieuCon, Long> {
}
