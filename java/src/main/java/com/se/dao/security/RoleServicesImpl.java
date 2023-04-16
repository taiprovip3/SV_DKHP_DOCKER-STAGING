package com.se.dao.security;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.entity.security.Role;
import com.se.repo.security.RoleRepository;
import com.se.service.security.RoleService;

@Service
@Transactional
public class RoleServicesImpl implements RoleService {
	
	@Autowired
	private RoleRepository roleRepository;

	@Override
	public Role getMemberRole(Long id) {
		return roleRepository.findById(id).orElse(null);
	}
}
