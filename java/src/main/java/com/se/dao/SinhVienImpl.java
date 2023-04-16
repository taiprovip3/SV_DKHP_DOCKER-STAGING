package com.se.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.SinhVienAddBalanceDTO;
import com.se.dto.SinhVienDTO;
import com.se.entity.DaoTao;
import com.se.entity.LopHocDanhNghia;
import com.se.entity.SinhVien;
import com.se.entity.TaiKhoan;
import com.se.entity.security.Role;
import com.se.entity.security.User;
import com.se.enums.BacDaoTao;
import com.se.enums.CoSo;
import com.se.enums.GioiTinh;
import com.se.enums.LoaiHinhDaoTao;
import com.se.enums.LoaiTaiKhoan;
import com.se.repo.LopHocDanhNghiaRepository;
import com.se.repo.SinhVienRepository;
import com.se.repo.TaiKhoanRepository;
import com.se.service.SinhVienService;
import com.se.service.security.RoleService;
import com.se.service.security.UserService;

@Service
public class SinhVienImpl implements SinhVienService {
	
	@Autowired
	private SinhVienRepository sinhVienRepository;
	@Autowired
	private LopHocDanhNghiaRepository lopHocDanhNghiaRepository;
	@Autowired
	private TaiKhoanRepository taiKhoanRepository;
	@Autowired
	private RoleService roleService;
	@Autowired
	private UserService userService;
	
	@Override
	public SinhVien addStudent(SinhVienDTO sinhVien) {
		long latestStudentId = 0;
		try {
			latestStudentId = sinhVienRepository.getLatestIdStudent();
		} catch (Exception e) {
			System.out.println("latestStudentId not found, set to 0!");
		}
		try {
			Role memberRole = roleService.getMemberRole(Long.valueOf(1));
			Set<Role> roles = new HashSet<>();
			roles.add(memberRole);
			User user = new User();
			user.setUsername("sv" + String.valueOf(latestStudentId + 1));
			user.setPassword(sinhVien.getMatKhau());
			user.setRoles(roles);
			User u = userService.saveUser(user);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date ngaySinhUtil = sdf.parse(sinhVien.getNgaySinh());
			java.sql.Date ngaySinhSql = new java.sql.Date(ngaySinhUtil.getTime());
			Date ngayVaoTruongUtil = sdf.parse(sinhVien.getNgayVaoTruong());
			java.sql.Date ngayVaoTruongSql = new java.sql.Date(ngayVaoTruongUtil.getTime());
			LopHocDanhNghia lhdn = lopHocDanhNghiaRepository.findById(sinhVien.getMaLopDanhNghia()).orElse(null);
			TaiKhoan tk = TaiKhoan
					.builder()
					.email(sinhVien.getEmail())
					.type(LoaiTaiKhoan.SINH_VIEN)
					.user(u)
					.build();
			taiKhoanRepository.save(tk);
			DaoTao daoTao = DaoTao
					.builder()
					.bacDaoTao(BacDaoTao.valueOf(sinhVien.getBacDaoTao()))
					.loaiHinhDaoTao(LoaiHinhDaoTao.valueOf(sinhVien.getLoaiHinhDaoTao()))
					.coSo(CoSo.valueOf(sinhVien.getCoSo()))
					.build();
			SinhVien sv = SinhVien
					.builder()
					.hoTen(sinhVien.getHoTen())
					.gioiTinh(GioiTinh.valueOf(sinhVien.getGioiTinh()))
					.ngaySinh(ngaySinhSql)
					.noiSinh(sinhVien.getNoiSinh())
					.sdt(sinhVien.getSdt())
					.diaChi(sinhVien.getDiaChi())
					.ngayVaoTruong(ngayVaoTruongSql)
					.cccd(sinhVien.getCccd())
					.totNghiep(sinhVien.isTotNghiep())
					.soDu(sinhVien.getSoDu())
					.lopHocDanhNghia(lhdn)
					.taiKhoan(tk)
					.avatar(sinhVien.getAvatar())
					.daoTao(daoTao)
					.build();
			SinhVien myStudent = sinhVienRepository.save(sv);
			return myStudent;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	@Override
	public List<Long> removeStudent(List<Long> listIdStudent) {
		for (Long id : listIdStudent) {
				sinhVienRepository.deleteById(id);
		}
		return listIdStudent;
	}

	@Override
	public SinhVien getStudentById(long id) {
		return sinhVienRepository.findById(id).orElse(null);
	}

	@Override
	public double getStudentBalance(long studentId) {
		return sinhVienRepository.getStudentBalance(studentId);
	}

	@Override
	public double updateBalance(long studentId, double soDu) {
		SinhVien sv = sinhVienRepository.findById(studentId).orElse(null);
		sv.setSoDu(soDu);
		sinhVienRepository.save(sv);
		return soDu;
	}

	@Override
	public double addStudentBalance(SinhVienAddBalanceDTO sinhVienAddBalanceDTO) {
		long studentId = sinhVienAddBalanceDTO.getMaSinhVien();
		SinhVien sv = sinhVienRepository.findById(studentId).orElse(null);
		double oldBalance = sv.getSoDu();
		double soTienGiaoDich = sinhVienAddBalanceDTO.getSoTienGiaoDich();
		double newBalance = oldBalance + soTienGiaoDich;
		sv.setSoDu(newBalance);
		sinhVienRepository.save(sv);
		return newBalance;
	}

	@Override
	public double reduceStudentBalance(long studentId, long balanceToReduce) {
		SinhVien sv = sinhVienRepository.findById(studentId).orElse(null);
		double oldBalance = sv.getSoDu();
		double newBalance = oldBalance - balanceToReduce;
		sv.setSoDu(newBalance);
		sinhVienRepository.save(sv);
		return newBalance;
	}

}
