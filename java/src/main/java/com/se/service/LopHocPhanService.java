package com.se.service;

import java.util.List;

import com.se.dto.LopHocPhanDTO;
import com.se.entity.LopHocPhan;

public interface LopHocPhanService {
	public LopHocPhan addUnitClass(LopHocPhanDTO lopHocPhanDTO);
	public List<LopHocPhan> getUnitClassesBySubjectIdAndLoaiHocAndMaKhoaHoc(long maMonHoc, String loaiHoc, long maKhoaHoc);
	public List<LopHocPhan> getUnitClassesStudentRegisterByStudentIdAndMaKhoaHoc(long id, long maKhoaHoc);
	public LopHocPhan getUnitClassById(long id);
}
