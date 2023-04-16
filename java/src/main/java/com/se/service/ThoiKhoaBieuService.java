package com.se.service;

import java.util.List;
import java.util.Optional;

import com.se.dto.ThoiKhoaBieu2DTO;
import com.se.dto.ThoiKhoaBieuDTO;
import com.se.entity.ThoiKhoaBieu;
import com.se.entity.ThoiKhoaBieuCon;

public interface ThoiKhoaBieuService {
	public ThoiKhoaBieu addTimeTable(ThoiKhoaBieuDTO thoiKhoaBieuDTO);
	public ThoiKhoaBieuCon addTimeTableCon(ThoiKhoaBieuDTO thoiKhoaBieuDTO);
	public List<ThoiKhoaBieu> getTimeTablesByUnitClassId(long id);
	public ThoiKhoaBieu getTimeTableById(long id);
	public List<Long> getIdsThoiKhoaBieuCon(ThoiKhoaBieu2DTO thoiKhoaBieu2DTO);
	public List<ThoiKhoaBieu> getTimeTablesBy7Days(ThoiKhoaBieu2DTO thoiKhoaBieu2DTO);
	public List<ThoiKhoaBieu> getTeacherTimeTableByDay(long maGiaoVien, String theDate);
	public List<ThoiKhoaBieu> getStudentTimeTableByDay(long maSinhVien, String theDate);
}
