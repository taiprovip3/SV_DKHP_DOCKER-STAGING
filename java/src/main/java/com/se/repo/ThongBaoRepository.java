package com.se.repo;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.ThongBao;
import com.se.entity.ThongBaoKhoa;

@Repository
public interface ThongBaoRepository extends CrudRepository<ThongBao, Long> {
}
