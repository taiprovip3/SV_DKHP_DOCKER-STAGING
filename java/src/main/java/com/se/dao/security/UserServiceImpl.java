package com.se.dao.security;

import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Service;

import com.se.entity.security.User;
import com.se.entity.security.UserPrincipal;
import com.se.repo.security.UserRepository;
import com.se.service.security.UserService;

@Service
public class UserServiceImpl implements UserService{
	
	private UserRepository userRepository;
	
	@Autowired
	public UserServiceImpl(UserRepository userRepository) {
		this.userRepository = userRepository;
	}
	
	@Override
	public UserPrincipal getUserPrincipalByUsername(String username) {
		User user = userRepository.findByUsername(username);
		UserPrincipal userPrincipal = new UserPrincipal();
		if(user != null) {
			Set<GrantedAuthority> grantedAuthorities = new HashSet<GrantedAuthority>();
			if(user.getRoles() != null) {
				user.getRoles().forEach(role -> {
					GrantedAuthority authority = new SimpleGrantedAuthority(role.getName());
					grantedAuthorities.add(authority);
				});
			}
			userPrincipal.setId(user.getId());
			userPrincipal.setUsername(user.getUsername());
			userPrincipal.setPassword(user.getPassword());
			userPrincipal.setAuthorities(grantedAuthorities);
		}
		return userPrincipal;
	}

	@Override
	public User saveUser(User user) {
		return userRepository.save(user);
	}

	@Override
	public User getUserByUserName(String username) {
		return userRepository.findByUsername(username);
	}
}
