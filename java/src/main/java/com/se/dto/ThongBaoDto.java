package com.se.dto;

import lombok.Data;

@Data
public class ThongBaoDto {
	private String title;
	private String message;
	private String linking;
	private boolean isRead;
	private long studentId;
}
