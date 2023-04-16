package com.se.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.LopHocDanhNghiaDTO;
import com.se.entity.GiaoVien;
import com.se.entity.KhoaHoc;
import com.se.entity.LopHocDanhNghia;
import com.se.entity.Nganh;
import com.se.repo.GiaoVienRepository;
import com.se.repo.KhoaHocRepository;
import com.se.repo.LopHocDanhNghiaRepository;
import com.se.repo.NganhRepository;
import com.se.service.LopHocDanhNghiaService;

@Service
public class LopHocDanhNghiaImpl implements LopHocDanhNghiaService {

	@Autowired
	private LopHocDanhNghiaRepository lopHocDanhNghiaRepository;
	@Autowired
	private GiaoVienRepository giaoVienRepository;
	@Autowired
	private KhoaHocRepository khoaHocRepository;
	@Autowired
	private NganhRepository nganhRepository;

	@Override
	public LopHocDanhNghia addClass(LopHocDanhNghiaDTO lopHoc) {
		GiaoVien gv = giaoVienRepository.findById(lopHoc.getMaGiaoVien()).orElse(null);
		KhoaHoc kh = khoaHocRepository.findById(lopHoc.getMaKhoaHoc()).orElse(null);
		Nganh n = nganhRepository.findById(lopHoc.getMaNganh()).orElse(null);
		LopHocDanhNghia lh = LopHocDanhNghia
				.builder()
				.tenLop(lopHoc.getTenLop())
				.soLuong(lopHoc.getSoLuong())
				.giaoVien(gv)
				.khoaHoc(kh)
				.nganh(n)
				.build();
		return lopHocDanhNghiaRepository.save(lh);
	}

}
