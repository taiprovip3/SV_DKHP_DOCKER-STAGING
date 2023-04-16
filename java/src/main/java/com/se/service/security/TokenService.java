package com.se.service.security;

import com.se.entity.security.Token;

public interface TokenService {
	public void saveToken(Token token);
	public boolean checkTokenUser(String username);
	public void updateToken(Token token);
}
