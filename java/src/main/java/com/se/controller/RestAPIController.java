package com.se.controller;

import java.time.LocalDateTime;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import com.se.dto.security.ChangePasswordRequestDTO;
import com.se.dto.security.UserDTO;
import com.se.entity.security.Token;
import com.se.entity.security.User;
import com.se.entity.security.UserPrincipal;
import com.se.jwt.JwtUltility;
import com.se.service.security.TokenService;
import com.se.service.security.UserService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class RestAPIController {
	
	@Autowired private UserService userService;
	@Autowired private PasswordEncoder passwordEncoder;
	@Autowired private AuthenticationManager authenticationManagerBean;
	@Autowired private TokenService tokenService;
	@Autowired private JwtUltility jwtUltility;
	
	@GetMapping("/hello")
	public String helloWorld() {
		return "Hello World";
	}
	
	@PostMapping("/login")
	public ResponseEntity<?> signInUser(@RequestBody UserDTO u){
		
		UserPrincipal userPrincipal = userService.getUserPrincipalByUsername(u.getUsername());
		if(userPrincipal == null || !passwordEncoder.matches(u.getPassword(), userPrincipal.getPassword()))
//			return ResponseEntity.status(HttpStatus.BAD_REQUEST)
//                    .body("Account password is wrong!");
			return null;
		try {
			Authentication authentication = authenticationManagerBean.authenticate(new UsernamePasswordAuthenticationToken(u.getUsername(), u.getPassword()));
			SecurityContextHolder.getContext().setAuthentication(authentication);
			System.out.println("["+ LocalDateTime.now() +"] user id `" + u.getUsername() + "` sign in success..");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		boolean isTokenUserExisted = tokenService.checkTokenUser(u.getUsername());
		Token token = new Token();
		String tokenString = jwtUltility.generateHS512Token(userPrincipal);
		token.setToken(tokenString);
		token.setTokenExpDate(jwtUltility.getExpirationDateFromToken(tokenString));
		token.setUser(userService.getUserByUserName(u.getUsername()));
		if(isTokenUserExisted)
			tokenService.updateToken(token);
		else
			tokenService.saveToken(token);
		return ResponseEntity.ok(token.getToken());
	}
	
	@GetMapping("/signout")
	public String signOut() {
		SecurityContextHolder.getContext();
		return "\n\n(!) Sign out account success\n\n";
	}

	@PostMapping("/change-password")
    public ResponseEntity<?> changePassword (
		@RequestBody ChangePasswordRequestDTO changePasswordRequestDTO,
		@AuthenticationPrincipal UserDetails userDetails
	) {
		String username = userDetails.getUsername();
		String oldPassword = changePasswordRequestDTO.getOldPassword();
		String newPassword = changePasswordRequestDTO.getNewPassword();
		User user = userService.getUserByUserName(username);
		if (user == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found with username: " + username);
		}
		if (!passwordEncoder.matches(oldPassword, user.getPassword())) {
			throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Old password is incorrect");
		}
		user.setPassword(passwordEncoder.encode(newPassword));
		userService.saveUser(user);
        return ResponseEntity.ok("Password changed successfully");
    }
	
}
