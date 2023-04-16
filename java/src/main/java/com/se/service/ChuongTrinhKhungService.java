package com.se.service;

import com.se.dto.ChuongTrinhKhungDTO;
import com.se.entity.ChuongTrinhKhung;

public interface ChuongTrinhKhungService {
	public ChuongTrinhKhung addPattern(ChuongTrinhKhungDTO chuongTrinhKhung);
	public int getSoTinChiDoneByStudentId(long id);
}
