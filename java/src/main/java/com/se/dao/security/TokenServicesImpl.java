package com.se.dao.security;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.entity.security.Token;
import com.se.repo.security.TokenRepository;
import com.se.service.security.TokenService;


@Service
@Transactional
public class TokenServicesImpl implements TokenService{

	@Autowired
	private TokenRepository tokenRepository;
	
	@Override
	public void saveToken(Token token) {
//		System.out.println(token);
		tokenRepository.save(token);
	}

	@Override
	public boolean checkTokenUser(String username) {
		Token t = tokenRepository.findTokenByUsername(username);
		if(t == null)
			return false;
		return true;
	}

	@Override
	public void updateToken(Token token) {
		tokenRepository.updateToNewToken(token.getUser().getId(), token.getToken());
	}

}
