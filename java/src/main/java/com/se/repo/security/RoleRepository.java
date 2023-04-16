package com.se.repo.security;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.security.Role;

@Repository
public interface RoleRepository extends CrudRepository<Role, Long>{
}
