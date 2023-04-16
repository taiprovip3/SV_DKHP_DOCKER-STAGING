package com.se.dao;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.ThongBaoDto;
import com.se.entity.SinhVien;
import com.se.entity.ThongBao;
import com.se.repo.SinhVienRepository;
import com.se.repo.ThongBaoRepository;
import com.se.service.ThongBaoService;
@Service
public class ThongBaoImpl implements ThongBaoService {
	
	@Autowired
	private ThongBaoRepository thongBaoRepository;
	@Autowired
	private SinhVienRepository sinhVienRepository;
	
	@Override
	public ThongBao createNotification(ThongBaoDto thongBaoDto) {
		SinhVien sinhVien = sinhVienRepository.findById(thongBaoDto.getStudentId()).orElse(null);
		ThongBao thongBao = ThongBao
				.builder()
				.title(thongBaoDto.getTitle())
				.message(thongBaoDto.getMessage())
				.linking(thongBaoDto.getLinking())
				.isRead(false)
				.sinhVien(sinhVien)
				.build();
		return thongBaoRepository.save(thongBao);
	}

}
