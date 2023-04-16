package com.se.service;

import java.util.List;

import com.se.dto.SinhVien_LopHocPhanDTO;
import com.se.entity.SinhVien_LopHocPhan;

public interface SinhVien_LopHocPhanService {
	public SinhVien_LopHocPhan saveUnitSubject(SinhVien_LopHocPhanDTO sinhVien_LopHocPhanDTO);
	public boolean isStudentRegisThisUnitClass(long maLopHocPhan, long maMonHoc, long maKhoaHoc, long maSinhVien);
	public SinhVien_LopHocPhan getSVLHPByMaLopHocPhanId(long id);
	public String deleteById(long id);
	public SinhVien_LopHocPhan updateStudentRegisSVLHP(long maSinhVien, long maLopHocPhan);
    public SinhVien_LopHocPhan getSvlhpById(long svlhpId);
	public List<SinhVien_LopHocPhan> getSVLHPStudentRegistered(long maSinhVien, long courseId);
}
