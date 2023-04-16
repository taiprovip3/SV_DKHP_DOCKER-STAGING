package com.se.jwt;

import java.io.IOException;
import java.time.LocalDateTime;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.WebAuthenticationDetailsSource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.web.filter.OncePerRequestFilter;

import com.se.entity.security.UserPrincipal;
import com.se.service.security.UserService;

import io.jsonwebtoken.ExpiredJwtException;

@Component
public class JwtRequestFilter extends OncePerRequestFilter{

	@Autowired
	private JwtUltility jwtUltility;
	
	@Autowired
	private UserService userService;
	
	@Override
	protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
			throws ServletException, IOException {
		
		String tokenString = null;
		String usernameString = null;
		try {
			tokenString = request.getHeader("Authorization");
			if(tokenString != null) {
				usernameString = jwtUltility.getUsernameFromToken(tokenString);
				UserPrincipal userPrincipal = userService.getUserPrincipalByUsername(usernameString);
				if(jwtUltility.validateToken(tokenString, userPrincipal)) {
					 UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(userPrincipal, null, userPrincipal.getAuthorities());
		                usernamePasswordAuthenticationToken.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
		                SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
		                System.out.println("["+LocalDateTime.now()+"] request success bypass with token..");
				}
			} else {
				System.out.println("["+LocalDateTime.now()+"] req access with header but null token!");
			}
		} catch (IllegalArgumentException e) {
			System.out.println("["+LocalDateTime.now()+"] req access with invalid token!");
		} catch (ExpiredJwtException e) {
			System.out.println("["+LocalDateTime.now()+"] req access with token is expired!");
		} catch (Exception e) {
			System.out.println("["+LocalDateTime.now()+"] req access without header authorization!");
		}
		filterChain.doFilter(request, response);
	}

}
