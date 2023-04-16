package com.se.repo.security;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.se.entity.security.Permission;

@Repository
public interface PermissionRepository extends CrudRepository<Permission, Long> {
}
