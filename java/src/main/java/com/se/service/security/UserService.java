package com.se.service.security;

import com.se.entity.security.User;
import com.se.entity.security.UserPrincipal;

public interface UserService {
	public UserPrincipal getUserPrincipalByUsername(String username);
	public User saveUser(User user);
	public User getUserByUserName(String username);
}
