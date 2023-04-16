package com.se.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.se.dto.SinhVien_LopHocPhanDTO;
import com.se.entity.SinhVien_LopHocPhan;
import com.se.service.SinhVien_LopHocPhanService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class SinhVien_LopHocPhanController {
	
	@Autowired
	private SinhVien_LopHocPhanService sinhVien_LopHocPhanService;
	
	@PostMapping("/sv_lhp/addAndUpdateSoLuong")
	public SinhVien_LopHocPhan saveUnitSubject(@RequestBody SinhVien_LopHocPhanDTO sinhVien_LopHocPhanDTO) {
		return sinhVien_LopHocPhanService.saveUnitSubject(sinhVien_LopHocPhanDTO);
	}
	@GetMapping("/sv_lhp/isStudentRegisThisUnitClass/{maLopHocPhan}/{maMonHoc}/{maKhoaHoc}/{maSinhVien}")
	public boolean isStudentRegisThisUnitClass(@PathVariable long maLopHocPhan, @PathVariable long maMonHoc, @PathVariable long maKhoaHoc, @PathVariable long maSinhVien) {
		return sinhVien_LopHocPhanService.isStudentRegisThisUnitClass(maLopHocPhan, maMonHoc, maKhoaHoc, maSinhVien);
	}
	@GetMapping("/sv_lhp/getSVLHPByMaLopHocPhanId/{id}")
	public SinhVien_LopHocPhan getSVLHPByMaLopHocPhanId(@PathVariable long id) {
		return sinhVien_LopHocPhanService.getSVLHPByMaLopHocPhanId(id);
	}
	@DeleteMapping("/sv_lhp/deleteById/{id}")
	public String deleteById(@PathVariable long id) {
		return sinhVien_LopHocPhanService.deleteById(id);
	}
	
	@GetMapping("/sv_lhp/updateStudentRegisSVLHP/{maSinhVien}/{maLopHocPhan}")
	public SinhVien_LopHocPhan updateStudentRegisSVLHP(@PathVariable long maSinhVien, @PathVariable long maLopHocPhan) {
		return sinhVien_LopHocPhanService.updateStudentRegisSVLHP(maSinhVien, maLopHocPhan);
	}

	@GetMapping("/sv_lhp/getSvlhpById/{svlhpId}")
	public SinhVien_LopHocPhan getSvlhpById(@PathVariable long svlhpId) {
		return sinhVien_LopHocPhanService.getSvlhpById(svlhpId);
	}
	@GetMapping("/sv_lhp/getSVLHPStudentRegistered/{studentId}/{courseId}")
	public List<SinhVien_LopHocPhan> getSVLHPStudentRegistered(@PathVariable long studentId, @PathVariable long courseId) {
		return sinhVien_LopHocPhanService.getSVLHPStudentRegistered(studentId, courseId);
	}

}
