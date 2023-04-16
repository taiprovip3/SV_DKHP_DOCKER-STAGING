package com.se.service;

import com.se.dto.ThongBaoDto;
import com.se.entity.ThongBao;

public interface ThongBaoService {
	public ThongBao createNotification(ThongBaoDto thongBaoDto);
}
