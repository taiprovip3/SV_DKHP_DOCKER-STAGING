package com.se.dao;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.NhanVienDTO;
import com.se.entity.NhanVien;
import com.se.entity.TaiKhoan;
import com.se.entity.security.Role;
import com.se.entity.security.User;
import com.se.enums.ChucVu;
import com.se.enums.LoaiTaiKhoan;
import com.se.repo.NhanVienRepository;
import com.se.repo.TaiKhoanRepository;
import com.se.repo.security.RoleRepository;
import com.se.service.NhanVienService;
import com.se.service.security.UserService;

@Service
public class NhanVienImpl implements NhanVienService{
	
	@Autowired
	private NhanVienRepository nhanVienRepository;
	@Autowired
	private TaiKhoanRepository taiKhoanRepository;
	@Autowired
	private RoleRepository roleRepository;
	@Autowired
	private UserService userService;

	@Override
	public NhanVien addEmployee(NhanVienDTO nhanVien) {
		long latestMaNhanVien = 0;
		try {
			latestMaNhanVien = nhanVienRepository.getLatestIdEmployee();
		} catch (Exception e) {
			System.out.println("latestMaNhanVien not found, set to 0!");
		}
		Role employeeRole = roleRepository.findById(Long.valueOf(3)).orElse(null);
		Set<Role> roles = new HashSet<>();
		roles.add(employeeRole);
		User employeeAccount = new User();
		employeeAccount.setPassword(nhanVien.getMatKhau());
		employeeAccount.setUsername("nv" + String.valueOf(latestMaNhanVien+1));
		employeeAccount.setRoles(roles);
		User u = userService.saveUser(employeeAccount);
		TaiKhoan tk = TaiKhoan //TH add
				.builder()
				.email(null)
				.type(LoaiTaiKhoan.NHAN_VIEN)
				.user(u)
				.build();
		taiKhoanRepository.save(tk);
		NhanVien nv = NhanVien
				.builder()
				.tenNhanVien(nhanVien.getTenNhanVien())
				.sdt(nhanVien.getSdt())
				.diaChi(nhanVien.getDiaChi())
				.chucVu(ChucVu.valueOf(nhanVien.getChucVu()))
				.taiKhoan(tk)
				.build();
		NhanVien n = nhanVienRepository.save(nv);
		return n;
	}

	@Override
	public List<Long> removeListEmployee(List<Long> listIdEmployee) {
		for (Long id : listIdEmployee) {
				nhanVienRepository.deleteById(id);
		}
		return listIdEmployee;
	}

	@Override
	public NhanVien updateEmployee(NhanVienDTO nhanVienMoi) {
		long idNhanVien = nhanVienMoi.getMaNhanVien();
		NhanVien nhanVienCu = nhanVienRepository.findById(idNhanVien).orElse(null);
		NhanVien nv = NhanVien.builder()
					.maNhanVien(idNhanVien)
					.chucVu(ChucVu.valueOf(nhanVienMoi.getChucVu()))
					.diaChi(nhanVienMoi.getDiaChi())
					.sdt(nhanVienMoi.getSdt())
					.tenNhanVien(nhanVienMoi.getTenNhanVien())
					.taiKhoan(nhanVienCu.getTaiKhoan())
					.build();
		NhanVien n = nhanVienRepository.save(nv);
		return n;
	}

}
