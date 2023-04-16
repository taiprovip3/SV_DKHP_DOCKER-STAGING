package com.se.dao;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.ChuongTrinhKhungDTO;
import com.se.entity.ChuongTrinhKhung;
import com.se.entity.MonHoc;
import com.se.entity.SinhVien;
import com.se.repo.ChuongTrinhKhungRepository;
import com.se.repo.MonHocRepository;
import com.se.repo.SinhVienRepository;
import com.se.service.ChuongTrinhKhungService;

@Service
public class ChuongTrinhKhungImpl implements ChuongTrinhKhungService {
	
	@Autowired
	private ChuongTrinhKhungRepository chuongTrinhKhungRepository;
	@Autowired
	private SinhVienRepository sinhVienRepository;
	@Autowired
	private MonHocRepository monHocRepository;

	@Override
	public ChuongTrinhKhung addPattern(ChuongTrinhKhungDTO chuongTrinhKhung) {
		boolean isDone = false;
		if(chuongTrinhKhung.getDone().equalsIgnoreCase("on"))
			isDone = true;
		SinhVien sv = sinhVienRepository.findById(chuongTrinhKhung.getMaSinhVien()).orElse(null);
		MonHoc mh = monHocRepository.findById(chuongTrinhKhung.getMaMonHoc()).orElse(null);
		ChuongTrinhKhung ctk = ChuongTrinhKhung
				.builder()
				.sinhVien(sv)
				.monHoc(mh)
				.done(isDone)
				.build();
		return chuongTrinhKhungRepository.save(ctk);
	}

	@Override
	public int getSoTinChiDoneByStudentId(long id) {
		try {
			return chuongTrinhKhungRepository.getSoTinChiDoneByStudentId(id);
		} catch (Exception e) {
			System.out.println("getSoTinChiDoneByStudentId Exception id: " + id);
			return 0;
		}
	}

	

}
