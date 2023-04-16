package com.se.dao;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.GiaoVienDTO;
import com.se.entity.GiaoVien;
import com.se.entity.TaiKhoan;
import com.se.entity.security.Role;
import com.se.entity.security.User;
import com.se.enums.GioiTinh;
import com.se.enums.LoaiGiaoVien;
import com.se.enums.LoaiTaiKhoan;
import com.se.repo.GiaoVienRepository;
import com.se.repo.TaiKhoanRepository;
import com.se.repo.security.RoleRepository;
import com.se.service.GiaoVienService;
import com.se.service.security.UserService;

@Service
public class GiaoVienImpl implements GiaoVienService{
	
	@Autowired
	private GiaoVienRepository giaoVienRepository;
	@Autowired
	private TaiKhoanRepository taiKhoanRepository;
	@Autowired
	private RoleRepository roleRepository;
	@Autowired
	private UserService userService;

	@Override
	public GiaoVien addGiaoVien(GiaoVienDTO giaoVien) {
		long latestMaGiaoVien = 0;
		try {
			latestMaGiaoVien = giaoVienRepository.getLatestIdTeacher();
		} catch (Exception e) {
			System.out.println("latestMaGiaoVien not found, set to 0!");
		}
		try {
			Role teacherRole = roleRepository.findById(Long.valueOf(4)).orElse(null);
			Set<Role> roles = new HashSet<>();
			roles.add(teacherRole);
			User teacherAccount = new User();
			teacherAccount.setPassword(giaoVien.getPassword());
			teacherAccount.setUsername("gv" + String.valueOf(latestMaGiaoVien + 1));
			teacherAccount.setRoles(roles);
			User u = userService.saveUser(teacherAccount);
			TaiKhoan tk = TaiKhoan
					.builder()
					.email(null)
					.type(LoaiTaiKhoan.GIAO_VIEN)
					.user(u)
					.build();
			taiKhoanRepository.save(tk);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date parsed = sdf.parse(giaoVien.getNgaySinh());
			Date sql = new Date(parsed.getTime());
			GiaoVien gv = GiaoVien
					.builder()
					.tenGiaoVien(giaoVien.getTenGiaoVien())
					.diaChi(giaoVien.getDiaChi())
					.gioiTinh(GioiTinh.valueOf(giaoVien.getGioiTinh()))
					.loaiGiaoVien(LoaiGiaoVien.valueOf(giaoVien.getLoaiGiaoVien()))
					.ngaySinh(sql)
					.sdt(giaoVien.getSdt())
					.taiKhoan(tk)
					.build();
			return giaoVienRepository.save(gv);
		} catch (ParseException e) {
			System.out.println("GiaoVienImpl parsed date exception error try catched!");
		}
		return null;
	}

	@Override
	public GiaoVien getTeacherById(long maGiaoVien) {
		return giaoVienRepository.findById(maGiaoVien).orElse(null);
	}

}
