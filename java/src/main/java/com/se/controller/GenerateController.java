package com.se.controller;

import java.sql.Date;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.se.dto.GiaoVienDTO;
import com.se.dto.KhoaHocDTO;
import com.se.dto.LopHocDanhNghiaDTO;
import com.se.dto.LopHocPhanDTO;
import com.se.dto.NhanVienDTO;
import com.se.dto.SinhVienDTO;
import com.se.dto.SinhVien_LopHocPhanDTO;
import com.se.dto.ThoiKhoaBieuDTO;
import com.se.dto.ThongBaoKhoaDTO;
import com.se.entity.HocKy;
import com.se.entity.Khoa;
import com.se.entity.LopHocPhan;
import com.se.entity.MonHoc;
import com.se.entity.Nganh;
import com.se.entity.PhieuThu;
import com.se.entity.SinhVien;
import com.se.entity.TaiKhoan;
import com.se.entity.ThanhToanGiaoDich;
import com.se.entity.ThoiKhoaBieu;
import com.se.entity.security.Permission;
import com.se.entity.security.Role;
import com.se.entity.security.User;
import com.se.enums.LoaiMon;
import com.se.enums.LoaiTaiKhoan;
import com.se.repo.KhoaRepository;
import com.se.repo.NganhRepository;
import com.se.repo.TaiKhoanRepository;
import com.se.repo.security.PermissionRepository;
import com.se.repo.security.RoleRepository;
import com.se.service.CongNoService;
import com.se.service.GiaoVienService;
import com.se.service.HocKyService;
import com.se.service.KhoaHocService;
import com.se.service.LopHocDanhNghiaService;
import com.se.service.LopHocPhanService;
import com.se.service.MonHocService;
import com.se.service.NhanVienService;
import com.se.service.PhieuThuService;
import com.se.service.SinhVienService;
import com.se.service.SinhVien_LopHocPhanService;
import com.se.service.ThanhToanGiaoDichService;
import com.se.service.ThoiKhoaBieuService;
import com.se.service.ThongBaoKhoaService;
import com.se.service.security.UserService;

@RestController
@RequestMapping("/api")
@CrossOrigin(origins = "http://localhost:19006")
public class GenerateController {
	
	@Autowired
	private NhanVienService nhanVienService;
	@Autowired
	private KhoaRepository khoaRepository;
	@Autowired
	private NganhRepository nganhRepository;
	@Autowired
	private TaiKhoanRepository taiKhoanRepository;
	@Autowired
	private KhoaHocService khoaHocService;
	@Autowired
	private GiaoVienService giaoVienService;
	@Autowired
	private LopHocDanhNghiaService lopHocDanhNghiaService;
	@Autowired
	private SinhVienService sinhVienService;
	@Autowired
	private ThongBaoKhoaService thongBaoKhoaService;
	@Autowired
	private HocKyService hocKyService;
	@Autowired
	private MonHocService monHocService;
	@Autowired private PermissionRepository permissionRepository;
	@Autowired private RoleRepository roleRepository;
	@Autowired private UserService userService;
	@Autowired
	private PhieuThuService phieuThuService;
	@Autowired
	private ThanhToanGiaoDichService thanhToanGiaoDichService;
	@Autowired
	private LopHocPhanService lopHocPhanService;
	@Autowired
	private ThoiKhoaBieuService thoiKhoaBieuService;
	@Autowired
	private SinhVien_LopHocPhanService sinhVien_LopHocPhanService;
	@Autowired
	private CongNoService congNoService;
	
	@GetMapping("/generate")
	public String generateMysqlData() {
		//Generate permission
		Permission p1 = new Permission();
		p1.setId(1);
		p1.setPermission("member.read");
		permissionRepository.save(p1);
		Permission p2 = new Permission();
		p2.setId(2);
		p2.setPermission("member.write");
		permissionRepository.save(p2);
		Permission p3 = new Permission();
		p3.setId(3);
		p3.setPermission("*");
		permissionRepository.save(p3);
		Permission p4 = new Permission();
		p4.setId(4);
		p4.setPermission("employee.read");
		permissionRepository.save(p4);
		Permission p5 = new Permission();
		p5.setId(5);
		p5.setPermission("employee.write");
		permissionRepository.save(p5);
		Permission p6 = new Permission();
		p6.setId(6);
		p6.setPermission("teacher.read");
		permissionRepository.save(p6);
		Permission p7 = new Permission();
		p7.setId(7);
		p7.setPermission("teacher.write");
		permissionRepository.save(p7);
		Set<Permission> member_permissions = new HashSet<Permission>();
		member_permissions.add(p1);
		member_permissions.add(p2);
		Set<Permission> admin_permissions = new HashSet<Permission>();
		admin_permissions.add(p3);
		Set<Permission> employee_permissions = new HashSet<Permission>();
		employee_permissions.add(p4);
		employee_permissions.add(p5);
		Set<Permission> teacher_permissions = new HashSet<Permission>();
		teacher_permissions.add(p6);
		teacher_permissions.add(p7);
		//Generate role
		Role role_member = new Role();
		role_member.setId(1);
		role_member.setName("MEMBER");
		role_member.setPermissions(member_permissions);
		Role role_admin = new Role();
		role_admin.setId(2);
		role_admin.setName("ADMIN");
		role_admin.setPermissions(admin_permissions);
		Role role_employee = new Role();
		role_employee.setId(3);
		role_employee.setName("EMPLOYEE");
		role_employee.setPermissions(employee_permissions);
		Role role_teacher = new Role();
		role_teacher.setId(4);
		role_teacher.setName("TEACHER");
		role_teacher.setPermissions(teacher_permissions);
		roleRepository.save(role_member);
		roleRepository.save(role_admin);
		roleRepository.save(role_employee);
		roleRepository.save(role_teacher);
		//Generate teacher
		GiaoVienDTO gvdto = new GiaoVienDTO();
		gvdto.setTenGiaoVien("Giáo Viên A");
		gvdto.setDiaChi("163 Bùi Quan Là");
		gvdto.setGioiTinh("NU");
		gvdto.setLoaiGiaoVien("GIAO_VIEN_BO_MON");
		gvdto.setNgaySinh("2018-01-01");
		gvdto.setSdt("0338188506");
		gvdto.setPassword("$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6");
		giaoVienService.addGiaoVien(gvdto);
		//Generate employee
		NhanVienDTO nvdto = new NhanVienDTO();
		nvdto.setTenNhanVien("Nhân Viên A");
		nvdto.setSdt("0338188506");
		nvdto.setDiaChi("60/122 To 10 KP8 Phuong TCH Q12 TP.HCM");
		nvdto.setChucVu("THO_DIEN");
		nvdto.setMatKhau("$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6");
		nhanVienService.addEmployee(nvdto);
		//Generate admin account
		Set<Role> roles = new HashSet<>();
		roles.add(role_admin);
		User userAdmin = new User();
		userAdmin.setUsername("sa");
		userAdmin.setPassword("$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6");
		userAdmin.setRoles(roles);
		User u = userService.saveUser(userAdmin);
		TaiKhoan taiKhoan = TaiKhoan
				.builder()
				.email("taito1doraemon@gmail.com")
				.type(LoaiTaiKhoan.ADMIN)
				.user(u)
				.build();
		taiKhoanRepository.save(taiKhoan);
		//Generate department
		Khoa cntt = Khoa.builder().maKhoa(Long.valueOf(1)).tenKhoa("Khoa Công Nghệ Thông Tin").build();
		Khoa cnck = Khoa.builder().maKhoa(Long.valueOf(2)).tenKhoa("Khoa Công Nghệ Cơ Khí").build();
		Khoa cnd = Khoa.builder().maKhoa(Long.valueOf(3)).tenKhoa("Khoa Công Nghệ Điện").build();
		Khoa cndt = Khoa.builder().maKhoa(Long.valueOf(4)).tenKhoa("Koa Công Nghệ Điện Tử").build();
		Khoa cndl = Khoa.builder().maKhoa(Long.valueOf(5)).tenKhoa("Khoa Công Nghệ Động Lực").build();
		Khoa cnnl = Khoa.builder().maKhoa(Long.valueOf(6)).tenKhoa("Khoa Công Nghệ Nhiệt Lạnh").build();
		Khoa cnmtt = Khoa.builder().maKhoa(Long.valueOf(7)).tenKhoa("Khoa Công Nghệ May - Thời Trang").build();
		Khoa cnhh = Khoa.builder().maKhoa(Long.valueOf(8)).tenKhoa("Khoa Công Nghệ Hóa Học").build();
		Khoa ktkt = Khoa.builder().maKhoa(Long.valueOf(9)).tenKhoa("Khoa Kế Toán - Kiểm Toán").build();
		Khoa khcb = Khoa.builder().maKhoa(Long.valueOf(10)).tenKhoa("Khoa Khoa Học Cơ Bản").build();
		Khoa llct = Khoa.builder().maKhoa(Long.valueOf(11)).tenKhoa("Khoa Lý Luận Chính Trị").build();
		Khoa nn = Khoa.builder().maKhoa(Long.valueOf(12)).tenKhoa("Khoa Ngoại Ngữ").build();
		Khoa qtkd = Khoa.builder().maKhoa(Long.valueOf(13)).tenKhoa("Khoa Quản Trị Kinh Doanh").build();
		Khoa tcnh = Khoa.builder().maKhoa(Long.valueOf(14)).tenKhoa("Khoa Tài Chính - Ngân Hàng").build();
		Khoa tmdl = Khoa.builder().maKhoa(Long.valueOf(15)).tenKhoa("Khoa Thương Mại - Du Lịch").build();
		Khoa ktxd = Khoa.builder().maKhoa(Long.valueOf(16)).tenKhoa("Khoa Kỹ Thuật Xây Dựng").build();
		Khoa l = Khoa.builder().maKhoa(Long.valueOf(17)).tenKhoa("Khoa Luật").build();
		khoaRepository.save(cntt);
		khoaRepository.save(cnck);
		khoaRepository.save(cnd);
		khoaRepository.save(cndt);
		khoaRepository.save(cndl);
		khoaRepository.save(cnnl);
		khoaRepository.save(cnmtt);
		khoaRepository.save(cnhh);
		khoaRepository.save(ktkt);
		khoaRepository.save(khcb);
		khoaRepository.save(llct);
		khoaRepository.save(nn);
		khoaRepository.save(qtkd);
		khoaRepository.save(tcnh);
		khoaRepository.save(tmdl);
		khoaRepository.save(ktxd);
		khoaRepository.save(l);
		//Generate Ngành
		//cntt
		Nganh cntt_cntt = Nganh.builder().maNganh(1).tenNganh("Công nghệ thông tin").khoa(cntt).build();
		Nganh cntt_ktpm = Nganh.builder().maNganh(2).tenNganh("Kỹ thuật phần mềm").khoa(cntt).build();
		Nganh cntt_khmt = Nganh.builder().maNganh(3).tenNganh("Khoa học máy tính").khoa(cntt).build();
		Nganh cntt_httt = Nganh.builder().maNganh(4).tenNganh("Hệ thống thông tin").khoa(cntt).build();
		Nganh cntt_khdlvcnqldttmvbv = Nganh.builder().maNganh(5).tenNganh("Khoa học dữ liệu và chuyên ngành Quản lý đô thị thông minh và bền vững").khoa(cntt).build();
		nganhRepository.save(cntt_cntt);
		nganhRepository.save(cntt_httt);
		nganhRepository.save(cntt_khdlvcnqldttmvbv);
		nganhRepository.save(cntt_khmt);
		nganhRepository.save(cntt_ktpm);
		//cnck
		Nganh cnck_cnktck = Nganh.builder().maNganh(6).tenNganh("Công nghệ kỹ thuật cơ khí").khoa(cnck).build();
		Nganh cnck_cnctm = Nganh.builder().maNganh(7).tenNganh("Công nghệ Chế tạo máy").khoa(cnck).build();
		nganhRepository.save(cnck_cnktck);
		nganhRepository.save(cnck_cnctm);
		//cnd
		Nganh cnd_ktd = Nganh.builder().maNganh(8).tenNganh("Kỹ thuật điện").khoa(cnd).build();
		Nganh cnd_dktd = Nganh.builder().maNganh(9).tenNganh("Điều khiển tự động").khoa(cnd).build();
		nganhRepository.save(cnd_ktd);
		nganhRepository.save(cnd_dktd);
		//cndt
		Nganh cndt_cnktdt = Nganh.builder().maNganh(10).tenNganh("Công nghệ kỹ thuật điện tử").khoa(cndt).build();
		Nganh cndt_nltt = Nganh.builder().maNganh(11).tenNganh("Năng lượng tái tạo").khoa(cndt).build();
		Nganh cndt_dtcn = Nganh.builder().maNganh(12).tenNganh("Điện tử công nghiệp").khoa(cndt).build();
		nganhRepository.save(cndt_cnktdt);
		nganhRepository.save(cndt_nltt);
		nganhRepository.save(cndt_dtcn);
		//cndl
		Nganh cndl_cnktot = Nganh.builder().maNganh(13).tenNganh("Công nghệ kỹ thuật ô tô").khoa(cndl).build();
		nganhRepository.save(cndl_cnktot);
		//cnnl
		Nganh cnnl_cnktn = Nganh.builder().maNganh(14).tenNganh("Công nghệ Kỹ thuật nhiệt").khoa(cnnl).build();
		nganhRepository.save(cnnl_cnktn);
		//cnmtt
		Nganh cnmtt_cnm = Nganh.builder().maNganh(15).tenNganh("Công nghệ May").khoa(cnmtt).build();
		Nganh cnmtt_tktt = Nganh.builder().maNganh(16).tenNganh("Thiết kế thời trang").khoa(cnmtt).build();
		nganhRepository.save(cnmtt_cnm);
		nganhRepository.save(cnmtt_tktt);
		//cnhh
		Nganh cnhh_cnhc = Nganh.builder().maNganh(17).tenNganh("Công nghệ Hữu cơ").khoa(cnhh).build();
		Nganh cnhh_cnvcvl = Nganh.builder().maNganh(18).tenNganh("Công nghệ Vô cơ-Vật liệu").khoa(cnhh).build();
		Nganh cnhh_cnhd = Nganh.builder().maNganh(19).tenNganh("Công nghệ Hóa dầu").khoa(cnhh).build();
		Nganh cnhh_kthpt = Nganh.builder().maNganh(20).tenNganh("Kỹ thuật Hóa phân tích").khoa(cnhh).build();
		nganhRepository.save(cnhh_cnhc);
		nganhRepository.save(cnhh_cnvcvl);
		nganhRepository.save(cnhh_cnhd);
		nganhRepository.save(cnhh_kthpt);
		//ktkt
		Nganh ktkt_ketoan = Nganh.builder().maNganh(21).tenNganh("Kế toán").khoa(ktkt).build();
		Nganh ktkt_kiemtoan = Nganh.builder().maNganh(22).tenNganh("Kiểm toán").khoa(ktkt).build();
		nganhRepository.save(ktkt_ketoan);
		nganhRepository.save(ktkt_kiemtoan);
		//khcb
		Nganh khcb_khdl = Nganh.builder().maNganh(23).tenNganh("Khoa học dữ liệu").khoa(khcb).build();
		nganhRepository.save(khcb_khdl);
		//llct
		Nganh llct_llct = Nganh.builder().maNganh(24).tenNganh("Lý luận chính trị").khoa(llct).build();
		nganhRepository.save(llct_llct);
		//nn
		Nganh nn_nna = Nganh.builder().maNganh(25).tenNganh("Ngôn Ngữ Anh").khoa(nn).build();
		nganhRepository.save(nn_nna);
		//qtkd
		Nganh qtkd_qtkd = Nganh.builder().maNganh(26).tenNganh("Quản trị kinh doanh").khoa(qtkd).build();
		Nganh qtkd_qtcuvl = Nganh.builder().maNganh(27).tenNganh("Quản trị cung ứng và logistic").khoa(qtkd).build();
		Nganh qtkd_qtns = Nganh.builder().maNganh(28).tenNganh("Quản trị nhân sự").khoa(qtkd).build();
		Nganh qtkd_qtm = Nganh.builder().maNganh(29).tenNganh("Quản trị marketing").khoa(qtkd).build();
		nganhRepository.save(qtkd_qtkd);
		nganhRepository.save(qtkd_qtcuvl);
		nganhRepository.save(qtkd_qtns);
		nganhRepository.save(qtkd_qtm);
		//tcnh
		Nganh tcnh_tcnh = Nganh.builder().maNganh(30).tenNganh("Tài chính – Ngân hàng").khoa(tcnh).build();
		Nganh tcnh_tcdn = Nganh.builder().maNganh(31).tenNganh("Tài chính doanh nghiệp").khoa(tcnh).build();
		nganhRepository.save(tcnh_tcnh);
		nganhRepository.save(tcnh_tcdn);
		//tmdl
		Nganh tmdl_kdqt = Nganh.builder().maNganh(32).tenNganh("Kinh doanh quốc tế").khoa(tmdl).build();
		Nganh tmdl_tmdt = Nganh.builder().maNganh(33).tenNganh("Thương mại điện tử").khoa(tmdl).build();
		Nganh tmdl_qtdvdlvlh = Nganh.builder().maNganh(34).tenNganh("Quản trị dịch vụ du lịch và lữ hành").khoa(tmdl).build();
		Nganh tmdl_qtks = Nganh.builder().maNganh(35).tenNganh("Quản trị khách sạn").khoa(tmdl).build();
		Nganh tmdl_qtnhvdvau = Nganh.builder().maNganh(36).tenNganh("Quản trị nhà hàng và dịch vụ ăn uống").khoa(tmdl).build();
		nganhRepository.save(tmdl_kdqt);
		nganhRepository.save(tmdl_tmdt);
		nganhRepository.save(tmdl_qtdvdlvlh);
		nganhRepository.save(tmdl_qtks);
		nganhRepository.save(tmdl_qtnhvdvau);
		//ktxd
		Nganh ktxd_ktxd = Nganh.builder().maNganh(37).tenNganh("Kỹ thuật xây dựng").khoa(ktxd).build();
		Nganh ktxd_ktxdctgt = Nganh.builder().maNganh(38).tenNganh("Kỹ thuật xây dựng công trình giao thông").khoa(ktxd).build();
		nganhRepository.save(ktxd_ktxd);
		nganhRepository.save(ktxd_ktxdctgt);
		//l
		Nganh l_lkt = Nganh.builder().maNganh(39).tenNganh("Luật kinh tế").khoa(l).build();
		Nganh l_lqt = Nganh.builder().maNganh(40).tenNganh("Luật quốc tế").khoa(l).build();
		nganhRepository.save(l_lkt);
		nganhRepository.save(l_lqt);
		//Generate semester
		HocKy hk1 = HocKy
				.builder()
				.maHocKy(1)
				.tenHocKy("Học kỳ 1")
				.nganh(cntt_ktpm)
				.soTinChi(17)
				.build();
		HocKy hk2 = HocKy
				.builder()
				.maHocKy(2)
				.tenHocKy("Học kỳ 2")
				.nganh(cntt_ktpm)
				.soTinChi(23)
				.build();	
		HocKy hk3 = HocKy
				.builder()
				.maHocKy(3)
				.tenHocKy("Học kỳ 3")
				.nganh(cntt_ktpm)
				.soTinChi(27)
				.build();
		HocKy hk4 = HocKy
				.builder()
				.maHocKy(4)
				.tenHocKy("Học kỳ 4")
				.nganh(cntt_ktpm)
				.soTinChi(28)
				.build();
		HocKy hk5 = HocKy
				.builder()
				.maHocKy(5)
				.tenHocKy("Học kỳ 5")
				.nganh(cntt_ktpm)
				.soTinChi(21)
				.build();
		HocKy hk6 = HocKy
				.builder()
				.maHocKy(6)
				.tenHocKy("Học kỳ 6")
				.nganh(cntt_ktpm)
				.soTinChi(17)
				.build();
		HocKy hk7 = HocKy
				.builder()
				.maHocKy(7)
				.tenHocKy("Học kỳ 7")
				.nganh(cntt_ktpm)
				.soTinChi(15)
				.build();
		HocKy hk8 = HocKy
				.builder()
				.maHocKy(8)
				.tenHocKy("Học kỳ 8")
				.nganh(cntt_ktpm)
				.soTinChi(10)
				.build();
		hocKyService.addSemester(hk1);
		hocKyService.addSemester(hk2);
		hocKyService.addSemester(hk3);
		hocKyService.addSemester(hk4);
		hocKyService.addSemester(hk5);
		hocKyService.addSemester(hk6);
		hocKyService.addSemester(hk7);
		hocKyService.addSemester(hk8);
		//Generate course
		KhoaHocDTO hk1_2019_2020 = new KhoaHocDTO();
		hk1_2019_2020.setTenKhoaHoc("HOC_KY_I");
		hk1_2019_2020.setAlias("Học kỳ 1");
		hk1_2019_2020.setNamBatDau(2019);
		hk1_2019_2020.setNamKetThuc(2020);
		hk1_2019_2020.setMaHocKy(1);
		KhoaHocDTO hk2_2019_2020 = new KhoaHocDTO();
		hk2_2019_2020.setTenKhoaHoc("HOC_KY_II");
		hk2_2019_2020.setAlias("Học kỳ 2");
		hk2_2019_2020.setNamBatDau(2019);
		hk2_2019_2020.setNamKetThuc(2020);
		hk2_2019_2020.setMaHocKy(2);
		KhoaHocDTO hk1_2020_2021 = new KhoaHocDTO();
		hk1_2020_2021.setTenKhoaHoc("HOC_KY_I");
		hk1_2020_2021.setAlias("Học kỳ 1");
		hk1_2020_2021.setNamBatDau(2020);
		hk1_2020_2021.setNamKetThuc(2021);
		hk1_2020_2021.setMaHocKy(3);
		KhoaHocDTO hk2_2020_2021 = new KhoaHocDTO();
		hk2_2020_2021.setTenKhoaHoc("HOC_KY_II");
		hk2_2020_2021.setAlias("Học kỳ 2");
		hk2_2020_2021.setNamBatDau(2020);
		hk2_2020_2021.setNamKetThuc(2021);
		hk2_2020_2021.setMaHocKy(4);
		KhoaHocDTO hk1_2021_2022 = new KhoaHocDTO();
		hk1_2021_2022.setTenKhoaHoc("HOC_KY_I");
		hk1_2021_2022.setAlias("Học kỳ 1");
		hk1_2021_2022.setNamBatDau(2021);
		hk1_2021_2022.setNamKetThuc(2022);
		hk1_2021_2022.setMaHocKy(5);
		KhoaHocDTO hk2_2021_2022 = new KhoaHocDTO();
		hk2_2021_2022.setTenKhoaHoc("HOC_KY_II");
		hk2_2021_2022.setAlias("Học kỳ 2");
		hk2_2021_2022.setNamBatDau(2021);
		hk2_2021_2022.setNamKetThuc(2022);
		hk2_2021_2022.setMaHocKy(6);
		KhoaHocDTO hk1_2022_2023 = new KhoaHocDTO();
		hk1_2022_2023.setTenKhoaHoc("HOC_KY_I");
		hk1_2022_2023.setAlias("Học kỳ 1");
		hk1_2022_2023.setNamBatDau(2022);
		hk1_2022_2023.setNamKetThuc(2023);
		hk1_2022_2023.setMaHocKy(7);
		KhoaHocDTO hk2_2022_2023 = new KhoaHocDTO();
		hk2_2022_2023.setTenKhoaHoc("HOC_KY_II");
		hk2_2022_2023.setAlias("Học kỳ 2");
		hk2_2022_2023.setNamBatDau(2022);
		hk2_2022_2023.setNamKetThuc(2023);
		hk2_2022_2023.setMaHocKy(8);
		khoaHocService.addCourse(hk1_2019_2020);
		khoaHocService.addCourse(hk2_2019_2020);
		khoaHocService.addCourse(hk1_2020_2021);
		khoaHocService.addCourse(hk2_2020_2021);
		khoaHocService.addCourse(hk1_2021_2022);
		khoaHocService.addCourse(hk2_2021_2022);
		khoaHocService.addCourse(hk1_2022_2023);
		khoaHocService.addCourse(hk2_2022_2023);
		//Generate class
				LopHocDanhNghiaDTO lhdndto = new LopHocDanhNghiaDTO();
				lhdndto.setTenLop("DHKTPM11ATT");
				lhdndto.setSoLuong(50);
				lhdndto.setMaNganh(2);
				lhdndto.setMaKhoaHoc(1);
				lhdndto.setMaGiaoVien(1);
				lopHocDanhNghiaService.addClass(lhdndto);
		//Generate student
				SinhVienDTO svdto = new SinhVienDTO();
				svdto.setHoTen("Học Sinh A");
				svdto.setGioiTinh("NAM");
				svdto.setNgaySinh("2020-01-01");
				svdto.setNoiSinh("HỒ CHÍ MINH");
				svdto.setSdt("0338188506");
				svdto.setDiaChi("60/122 KP8 Phường TCH Quận 12 HCM");
				svdto.setCccd("079201030774");
				svdto.setNgayVaoTruong("2019-01-01");
				svdto.setMaLopDanhNghia(1);
				svdto.setTotNghiep(false);
				svdto.setSoDu(0);
				svdto.setMatKhau("$2a$10$b4fPmnLkxcV4Y4MBDp05WeBhR8cIVizWbsjdpgvcztLPhSQBXNiF6");
				svdto.setEmail("taito1doraemon@gmail.com");
				svdto.setAvatar("https://res.cloudinary.com/dopzctbyo/image/upload/v1649587847/sample.jpg");
				svdto.setBacDaoTao("DAI_HOC");
				svdto.setLoaiHinhDaoTao("CHAT_LUONG_CAO");
				svdto.setCoSo("HO_CHI_MINH");
				SinhVien sv = sinhVienService.addStudent(svdto);
		//Generate department_announcement
				ThongBaoKhoaDTO tbkdto = new ThongBaoKhoaDTO();
				tbkdto.setMaKhoa(1);
				tbkdto.setTieuDe("THÔNG BÁO LỊCH NGHĨ TẾT DƯƠNG LỊCH CHO TOÀN BỘ SINH VIÊN TRƯỜNG ĐẠI HỌC CÔNG NGHIỆP IV (IUH)");
				tbkdto.setNoiDung("Gửi tới các em sinh viên hệ CLC / Đại trà. Cũng đã sắp đến tết cận kề, nhà nhà đã mang không khí nôn nao của lễ hội tết truyền thống. Nhằm mục đích hỗ trợ cho việc các sinh viên có thể bắt xe trở về quê ăn tết thuận tiện với gia đình tốt nhất. Nhà trường quyết định sẽ tổ chức các buổi học cận kề ngày nghĩ tết thành lịch học online (có thể). Một vài trường hợp môn học bắt buộc học offline như thực hành sẽ vẫn tiếp tục.");
				tbkdto.setNgayXuatBan("2021-01-01");
				thongBaoKhoaService.addAnnouncement(tbkdto);
		//Generate subject
		MonHoc nmth = MonHoc
				.builder()
				.maMonHoc(1000001)
				.tenMonHoc("Nhập môn tin học")
				.soTinChi(2)
				.soTietLT(30)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk1)
				.build();
		MonHoc gdqpvan1 = MonHoc
				.builder()
				.maMonHoc(1000002)
				.tenMonHoc("Giáo dục quốc phòng và an ninh 1")
				.soTinChi(4)
				.soTietLT(60)
				.soTietTH(0)
				.loaiMon(LoaiMon.SUPER_BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk1)
				.build();
		MonHoc gdtc1 = MonHoc
				.builder()
				.maMonHoc(1000003)
				.tenMonHoc("Giáo dục thể chất 1")
				.soTinChi(2)
				.soTietLT(0)
				.soTietTH(60)
				.loaiMon(LoaiMon.SUPER_BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk1)
				.build();
		MonHoc tcc1 = MonHoc
				.builder()
				.maMonHoc(1000004)
				.tenMonHoc("Toán cao cấp 1")
				.soTinChi(2)
				.soTietLT(30)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk1)
				.build();
		MonHoc nmlt = MonHoc
				.builder()
				.maMonHoc(1000005)
				.tenMonHoc("Nhập môn lập trình")
				.soTinChi(2)
				.soTietLT(0)
				.soTietTH(60)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk1)
				.build();
		MonHoc thml = MonHoc
				.builder()
				.maMonHoc(1000006)
				.tenMonHoc("Triết học Mác - Lênin")
				.soTinChi(3)
				.soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk1)
				.build();
		MonHoc ktctml = MonHoc
				.builder()
				.maMonHoc(1000007)
				.tenMonHoc("Kinh tế chính trị Mác-Lênin")
				.soTinChi(2)
				.soTietLT(30)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk1)
				.build();
		monHocService.addSubject(nmth);
		monHocService.addSubject(gdqpvan1);
		monHocService.addSubject(gdtc1);
		monHocService.addSubject(tcc1);
		monHocService.addSubject(nmlt);
		monHocService.addSubject(thml);
		monHocService.addSubject(ktctml);
		MonHoc av1 = MonHoc.builder().maMonHoc(1000008).tenMonHoc("Anh văn 1").soTinChi(3).soTietLT(30).soTietTH(0).loaiMon(LoaiMon.BAT_BUOC).maMonYeuCau(0).nhomMon(0).nganh(cntt_ktpm).hocKy(hk2).build();
		MonHoc ktlt = MonHoc.builder().maMonHoc(1000009).tenMonHoc("Kỹ thuật lập trình").soTinChi(3).soTietLT(30).soTietTH(30).loaiMon(LoaiMon.BAT_BUOC).maMonYeuCau(1000005).nhomMon(0).nganh(cntt_ktpm).hocKy(hk2).build();
		MonHoc knlvn = MonHoc.builder().maMonHoc(1000010).tenMonHoc("Kỹ năng làm việc nhóm").soTinChi(2).soTietLT(30).soTietTH(0).loaiMon(LoaiMon.BAT_BUOC).maMonYeuCau(0).nhomMon(0).nganh(cntt_ktpm).hocKy(hk2).build();
		MonHoc tcc2 = MonHoc.builder().maMonHoc(1000011).tenMonHoc("Toán cao cấp 2").soTinChi(2).soTietLT(30).soTietTH(0).loaiMon(LoaiMon.BAT_BUOC).maMonYeuCau(0).nhomMon(0).nganh(cntt_ktpm).hocKy(hk2).build();
		MonHoc gdqpvan2 = MonHoc.builder().maMonHoc(1000012).tenMonHoc("Giáo dục Quốc phòng và An ninh 2").soTinChi(4).soTietLT(30).soTietTH(60).loaiMon(LoaiMon.SUPER_BAT_BUOC).maMonYeuCau(0).nhomMon(0).nganh(cntt_ktpm).hocKy(hk2).build();
		MonHoc gdtc2 = MonHoc.builder().maMonHoc(1000013).tenMonHoc("Giáo dục thể chất 2").soTinChi(2).soTietLT(0).soTietTH(60).loaiMon(LoaiMon.SUPER_BAT_BUOC).maMonYeuCau(0).nhomMon(0).nganh(cntt_ktpm).hocKy(hk2).build();
		MonHoc htmt = MonHoc.builder().maMonHoc(1000014).tenMonHoc("Hệ thống máy tính").soTinChi(4).soTietLT(45).soTietTH(30).loaiMon(LoaiMon.BAT_BUOC).maMonYeuCau(0).nhomMon(0).nganh(cntt_ktpm).hocKy(hk2).build();
		MonHoc tlhdc = MonHoc.builder().maMonHoc(1000015).tenMonHoc("Tâm lý học đại cương").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.TU_CHON).maMonYeuCau(0).nhomMon(1).nganh(cntt_ktpm).hocKy(hk2).build();
		MonHoc tvth = MonHoc.builder().maMonHoc(1000016).tenMonHoc("Tiếng Việt thực hành").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.TU_CHON).maMonYeuCau(0).nhomMon(1).nganh(cntt_ktpm).hocKy(hk2).build();
		MonHoc annlvgcb = MonHoc.builder().maMonHoc(1000017).tenMonHoc("Âm nhạc – Nhạc lý và Guitar căn bản").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.TU_CHON).maMonYeuCau(0).nhomMon(1).nganh(cntt_ktpm).hocKy(hk2).build();
		MonHoc xhh = MonHoc.builder().maMonHoc(1000018).tenMonHoc("Xã hội học").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.TU_CHON).maMonYeuCau(0).nhomMon(1).nganh(cntt_ktpm).hocKy(hk2).build();
		MonHoc csvhvn = MonHoc.builder().maMonHoc(1000019).tenMonHoc("Cơ sở văn hóa Việt Nam").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.TU_CHON).maMonYeuCau(0).nhomMon(1).nganh(cntt_ktpm).hocKy(hk2).build();
		MonHoc hh = MonHoc.builder().maMonHoc(1000020).tenMonHoc("Hội họa").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.TU_CHON).maMonYeuCau(0).nhomMon(1).nganh(cntt_ktpm).hocKy(hk2).build();
		monHocService.addSubject(av1);
		monHocService.addSubject(ktlt);
		monHocService.addSubject(knlvn);
		monHocService.addSubject(tcc2);
		monHocService.addSubject(gdqpvan2);
		monHocService.addSubject(gdtc2);
		monHocService.addSubject(htmt);
		monHocService.addSubject(tlhdc);
		monHocService.addSubject(tvth);
		monHocService.addSubject(annlvgcb);
		monHocService.addSubject(xhh);
		monHocService.addSubject(csvhvn);
		monHocService.addSubject(hh);
		MonHoc av2 = MonHoc.builder().maMonHoc(1000021).tenMonHoc("Anh văn 2").soTinChi(4).soTietLT(60).soTietTH(0).loaiMon(LoaiMon.BAT_BUOC).maMonYeuCau(1000008).nhomMon(0).nganh(cntt_ktpm).hocKy(hk3).build();
		MonHoc ctrr = MonHoc.builder().maMonHoc(1000022).tenMonHoc("Cấu trúc rời rạc").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.BAT_BUOC).maMonYeuCau(0).nhomMon(0).nganh(cntt_ktpm).hocKy(hk3).build();
		MonHoc ctdlvgt = MonHoc.builder().maMonHoc(1000023).tenMonHoc("Cấu trúc dữ liệu và giải thuật").soTinChi(4).soTietLT(45).soTietTH(30).loaiMon(LoaiMon.BAT_BUOC).maMonYeuCau(1000005).nhomMon(0).nganh(cntt_ktpm).hocKy(hk3).build();
		MonHoc hcsdl = MonHoc.builder().maMonHoc(1000024).tenMonHoc("Hệ cơ sở dữ liệu").soTinChi(4).soTietLT(45).soTietTH(30).loaiMon(LoaiMon.BAT_BUOC).maMonYeuCau(1000001).nhomMon(0).nganh(cntt_ktpm).hocKy(hk3).build();
		MonHoc mmt = MonHoc.builder().maMonHoc(1000025).tenMonHoc("Mạng máy tính").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.BAT_BUOC).maMonYeuCau(0).nhomMon(0).nganh(cntt_ktpm).hocKy(hk3).build();
		MonHoc lthdt = MonHoc.builder().maMonHoc(1000026).tenMonHoc("Lập trình hướng đối tượng").soTinChi(3).soTietLT(30).soTietTH(30).loaiMon(LoaiMon.BAT_BUOC).maMonYeuCau(1000005).nhomMon(0).nganh(cntt_ktpm).hocKy(hk3).build();
		MonHoc sptclsvcn = MonHoc.builder().maMonHoc(1000027).tenMonHoc("Sự phát triển của lịch sử và công nghệ").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.BAT_BUOC).maMonYeuCau(0).nhomMon(0).nganh(cntt_ktpm).hocKy(hk3).build();
		MonHoc ppt = MonHoc.builder().maMonHoc(1000028).tenMonHoc("Phương pháp tính").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.TU_CHON).maMonYeuCau(0).nhomMon(1).nganh(cntt_ktpm).hocKy(hk3).build();
		MonHoc vldc = MonHoc.builder().maMonHoc(1000029).tenMonHoc("Vật lý đại cương").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.TU_CHON).maMonYeuCau(0).nhomMon(1).nganh(cntt_ktpm).hocKy(hk3).build();
		MonHoc tud = MonHoc.builder().maMonHoc(1000030).tenMonHoc("Toán ứng dụng").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.TU_CHON).maMonYeuCau(0).nhomMon(1).nganh(cntt_ktpm).hocKy(hk3).build();
		MonHoc hpvpbdl = MonHoc.builder().maMonHoc(1000031).tenMonHoc("Hàm phức và phép biến đổi Laplace").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.TU_CHON).maMonYeuCau(0).nhomMon(1).nganh(cntt_ktpm).hocKy(hk3).build();
		MonHoc lh = MonHoc.builder().maMonHoc(1000032).tenMonHoc("Logic học").soTinChi(3).soTietLT(45).soTietTH(0).loaiMon(LoaiMon.TU_CHON).maMonYeuCau(0).nhomMon(1).nganh(cntt_ktpm).hocKy(hk3).build();
		monHocService.addSubject(av2);
		monHocService.addSubject(ctrr);
		monHocService.addSubject(ctdlvgt);
		monHocService.addSubject(hcsdl);
		monHocService.addSubject(mmt);
		monHocService.addSubject(lthdt);
		monHocService.addSubject(sptclsvcn);
		monHocService.addSubject(ppt);
		monHocService.addSubject(vldc);
		monHocService.addSubject(tud);
		monHocService.addSubject(hpvpbdl);
		monHocService.addSubject(lh);
		MonHoc av3 = MonHoc
				.builder()
				.maMonHoc(1000033)
				.tenMonHoc("Anh văn 3")
				.soTinChi(4).soTietLT(60)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(1000021)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc ltdt = MonHoc
				.builder()
				.maMonHoc(1000034)
				.tenMonHoc("Lý thuyết đồ thị")
				.soTinChi(3).soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(1000022)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc htvcnw = MonHoc
				.builder()
				.maMonHoc(1000035)
				.tenMonHoc("Hệ Thống và Công nghệ Web")
				.soTinChi(3).soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc pplnckh = MonHoc
				.builder()
				.maMonHoc(1000036)
				.tenMonHoc("Phương pháp luận nghiên cứu khoa học")
				.soTinChi(2).soTietLT(30)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc pttkht = MonHoc
				.builder()
				.maMonHoc(1000037)
				.tenMonHoc("Phân tích thiết kế hệ thống")
				.soTinChi(3).soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(1000024)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc tkmtvud = MonHoc
				.builder()
				.maMonHoc(1000038)
				.tenMonHoc("Thống kê máy tính và ứng dụng")
				.soTinChi(3).soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(1000009)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc hqtcsdl = MonHoc
				.builder()
				.maMonHoc(1000039)
				.tenMonHoc("Hệ quản trị cơ sở dữ liệu")
				.soTinChi(3).soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000024)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc ttnm = MonHoc
				.builder()
				.maMonHoc(1000040)
				.tenMonHoc("Tương tác người máy")
				.soTinChi(3).soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000014)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc tmdt = MonHoc
				.builder()
				.maMonHoc(1000041)
				.tenMonHoc("Thương mại điện tử")
				.soTinChi(3).soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(0)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc lthskvcnj = MonHoc
				.builder()
				.maMonHoc(1000042)
				.tenMonHoc("Lập trình hướng sự kiện với công nghệ Java")
				.soTinChi(4).soTietLT(45)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000005)
				.nhomMon(2)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc lthskvcnNET = MonHoc
				.builder()
				.maMonHoc(1000043)
				.tenMonHoc("Lập Trình Hướng Sự Kiện với Công Nghệ .NET")
				.soTinChi(4).soTietLT(45)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000005)
				.nhomMon(2)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc ltGvQtF = MonHoc
				.builder()
				.maMonHoc(1000044)
				.tenMonHoc("Lập trình GUI với Qt Framework")
				.soTinChi(4).soTietLT(45)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000005)
				.nhomMon(2)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc qth = MonHoc
				.builder()
				.maMonHoc(1000045)
				.tenMonHoc("Quản trị học")
				.soTinChi(3).soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(0)
				.nhomMon(3)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc knxdkh = MonHoc
				.builder()
				.maMonHoc(1000046)
				.tenMonHoc("Kỹ năng xây dựng kế hoạch")
				.soTinChi(3).soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(0)
				.nhomMon(3)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc gtkd = MonHoc
				.builder()
				.maMonHoc(1000047)
				.tenMonHoc("Giao tiếp kinh doanh")
				.soTinChi(3).soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(0)
				.nhomMon(3)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc qtdn = MonHoc
				.builder()
				.maMonHoc(1000048)
				.tenMonHoc("Quản trị doanh nghiệp")
				.soTinChi(3).soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(0)
				.nhomMon(3)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc ktcb = MonHoc
				.builder()
				.maMonHoc(1000049)
				.tenMonHoc("Kế toán cơ bản")
				.soTinChi(3).soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(0)
				.nhomMon(3)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		MonHoc mtvcn = MonHoc
				.builder()
				.maMonHoc(1000050)
				.tenMonHoc("Môi trường và con người")
				.soTinChi(3).soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(0)
				.nhomMon(3)
				.nganh(cntt_ktpm)
				.hocKy(hk4)
				.build();
		monHocService.addSubject(av3);
		monHocService.addSubject(ltdt);
		monHocService.addSubject(htvcnw);
		monHocService.addSubject(pplnckh);
		monHocService.addSubject(pttkht);
		monHocService.addSubject(tkmtvud);
		monHocService.addSubject(hqtcsdl);
		monHocService.addSubject(ttnm);
		monHocService.addSubject(tmdt);
		monHocService.addSubject(lthskvcnj);
		monHocService.addSubject(lthskvcnNET);
		monHocService.addSubject(ltGvQtF);
		monHocService.addSubject(qth);
		monHocService.addSubject(knxdkh);
		monHocService.addSubject(gtkd);
		monHocService.addSubject(qtdn);
		monHocService.addSubject(ktcb);
		monHocService.addSubject(mtvcn);
		MonHoc av4 = MonHoc
				.builder()
				.maMonHoc(1000051)
				.tenMonHoc("Anh văn 4")
				.soTinChi(3).soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(1000033)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk5)
				.build();
		MonHoc nmattt = MonHoc
				.builder()
				.maMonHoc(1000052)
				.tenMonHoc("Nhập môn an toàn thông tin")
				.soTinChi(3).soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(1000014)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk5)
				.build();
		MonHoc cnpm = MonHoc
				.builder()
				.maMonHoc(1000053)
				.tenMonHoc("Công nghệ phần mềm")
				.soTinChi(3).soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(1000026)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk5)
				.build();
		MonHoc nvdxhvddnn = MonHoc
				.builder()
				.maMonHoc(1000054)
				.tenMonHoc("Những vấn đề xã hội và đạo đức nghề nghiệp")
				.soTinChi(3).soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk5)
				.build();
		MonHoc ptud = MonHoc
				.builder()
				.maMonHoc(1000055)
				.tenMonHoc("Phát triển ứng dụng")
				.soTinChi(3).soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk5)
				.build();
		MonHoc ltptvcnj = MonHoc
				.builder()
				.maMonHoc(1000056)
				.tenMonHoc("Lập trình phân tán với công nghệ Java")
				.soTinChi(3).soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000042)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk5)
				.build();
		MonHoc ltptvcnNET = MonHoc
				.builder()
				.maMonHoc(1000057)
				.tenMonHoc("Lập trình Phân Tán Công Nghệ .NET")
				.soTinChi(3).soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000043)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk5)
				.build();
		MonHoc ltmvQtF = MonHoc
				.builder()
				.maMonHoc(1000058)
				.tenMonHoc("Lập trình mạng với Qt Framework")
				.soTinChi(3).soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000044)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk5)
				.build();
		MonHoc ltptdl1 = MonHoc
				.builder()
				.maMonHoc(1000059)
				.tenMonHoc("Lập trình phân tích dữ liệu 1")
				.soTinChi(3).soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000009)
				.nhomMon(2)
				.nganh(cntt_ktpm)
				.hocKy(hk5)
				.build();
		MonHoc ktdlvud = MonHoc
				.builder()
				.maMonHoc(1000060)
				.tenMonHoc("Khai thác dữ liệu và ứng dụng")
				.soTinChi(3).soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000024)
				.nhomMon(2)
				.nganh(cntt_ktpm)
				.hocKy(hk5)
				.build();
		MonHoc ktdt = MonHoc
				.builder()
				.maMonHoc(1000061)
				.tenMonHoc("Kỹ thuật điện tử")
				.soTinChi(3).soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(0)
				.nhomMon(2)
				.nganh(cntt_ktpm)
				.hocKy(hk5)
				.build();
		monHocService.addSubject(av4);
		monHocService.addSubject(nmattt);
		monHocService.addSubject(cnpm);
		monHocService.addSubject(nvdxhvddnn);
		monHocService.addSubject(ptud);
		monHocService.addSubject(ltptvcnj);
		monHocService.addSubject(ltptvcnNET);
		monHocService.addSubject(ltmvQtF);
		monHocService.addSubject(ltptdl1);
		monHocService.addSubject(ktdlvud);
		monHocService.addSubject(ktdt);
		MonHoc lttbdd = MonHoc
				.builder()
				.maMonHoc(1000062)
				.tenMonHoc("Lập trình thiết bị di động")
				.soTinChi(4)
				.soTietLT(45)
				.soTietTH(30)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk6)
				.build();
		monHocService.addSubject(lttbdd);
		MonHoc pldc = MonHoc
				.builder()
				.maMonHoc(1000063)
				.tenMonHoc("Pháp luật đại cương")
				.soTinChi(2)
				.soTietLT(30)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk6)
				.build();
		monHocService.addSubject(pldc);
		MonHoc dbclvktpm = MonHoc
				.builder()
				.maMonHoc(1000064)
				.tenMonHoc("Đảm bảo chất lượng và Kiểm thử phần mềm")
				.soTinChi(3)
				.soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(1000053)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk6)
				.build();
		monHocService.addSubject(dbclvktpm);
		MonHoc cnxhkh = MonHoc
				.builder()
				.maMonHoc(1000065)
				.tenMonHoc("Chủ nghĩa xã hội khoa học")
				.soTinChi(2)
				.soTietLT(30)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk6)
				.build();
		monHocService.addSubject(cnxhkh);
		MonHoc lsdcsvn = MonHoc
				.builder()
				.maMonHoc(1000066)
				.tenMonHoc("Lịch sử Đảng Cộng sản Việt Nam")
				.soTinChi(2)
				.soTietLT(30)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk6)
				.build();
		monHocService.addSubject(lsdcsvn);
		MonHoc wwwjava = MonHoc
				.builder()
				.maMonHoc(1000066)
				.tenMonHoc("Lập trình WWW (Java)")
				.soTinChi(4)
				.soTietLT(45)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000035)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk6)
				.build();
		monHocService.addSubject(wwwjava);
		MonHoc ltIoTs = MonHoc
				.builder()
				.maMonHoc(1000067)
				.tenMonHoc("Lập trình IoTs")
				.soTinChi(4)
				.soTietLT(30)
				.soTietTH(60)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(0)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk6)
				.build();
		monHocService.addSubject(ltIoTs);
		MonHoc wwwNET = MonHoc
				.builder()
				.maMonHoc(1000068)
				.tenMonHoc("Lập trình WWW (.NET)")
				.soTinChi(4)
				.soTietLT(45)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000035)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk6)
				.build();
		monHocService.addSubject(wwwNET);
		MonHoc ptudwvQtF = MonHoc
				.builder()
				.maMonHoc(1000069)
				.tenMonHoc("Phát triển ứng dụng Web với Qt Engine")
				.soTinChi(4)
				.soTietLT(45)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000058)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk6)
				.build();
		monHocService.addSubject(ptudwvQtF);
		//hk7
		MonHoc tthcm = MonHoc
				.builder()
				.maMonHoc(1000070)
				.tenMonHoc("Tư tưởng Hồ Chí Minh")
				.soTinChi(2)
				.soTietLT(30)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk7)
				.build();
		monHocService.addSubject(tthcm);
		MonHoc kttkpm = MonHoc
				.builder()
				.maMonHoc(1000071)
				.tenMonHoc("Kiến trúc và Thiết kế phần mềm")
				.soTinChi(2)
				.soTietLT(30)
				.soTietTH(0)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(1000037)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk7)
				.build();
		monHocService.addSubject(kttkpm);
		MonHoc cnm = MonHoc
				.builder()
				.maMonHoc(1000072)
				.tenMonHoc("Công nghệ mới trong phát triển ứng dụng CNTT")
				.soTinChi(3)
				.soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk7)
				.build();
		monHocService.addSubject(cnm);
		MonHoc automat = MonHoc
				.builder()
				.maMonHoc(1000073)
				.tenMonHoc("Automat & ngôn ngữ hình thức")
				.soTinChi(3)
				.soTietLT(45)
				.soTietTH(0)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000034)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk7)
				.build();
		monHocService.addSubject(automat);
		MonHoc ttdt = MonHoc
				.builder()
				.maMonHoc(1000074)
				.tenMonHoc("Tiếp thị điện tử")
				.soTinChi(3)
				.soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(0)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk7)
				.build();
		monHocService.addSubject(ttdt);
		MonHoc ltptdl2 = MonHoc
				.builder()
				.maMonHoc(1000075)
				.tenMonHoc("Lập trình phân tích dữ liệu 2")
				.soTinChi(3)
				.soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000038)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk7)
				.build();
		monHocService.addSubject(ltptdl2);
		MonHoc nmdll = MonHoc
				.builder()
				.maMonHoc(1000076)
				.tenMonHoc("Nhập môn dữ liệu lớn")
				.soTinChi(3)
				.soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000024)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk7)
				.build();
		monHocService.addSubject(nmdll);
		MonHoc lttbddnc = MonHoc
				.builder()
				.maMonHoc(1000077)
				.tenMonHoc("Lập trình thiết bị di động nâng cao")
				.soTinChi(3)
				.soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(1000062)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk7)
				.build();
		monHocService.addSubject(lttbddnc);
		MonHoc qlda_cntt = MonHoc
				.builder()
				.maMonHoc(1000078)
				.tenMonHoc("Quản lý dự án CNTT")
				.soTinChi(3)
				.soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(0)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk7)
				.build();
		monHocService.addSubject(qlda_cntt);
		MonHoc kthdvvdtdm = MonHoc
				.builder()
				.maMonHoc(1000079)
				.tenMonHoc("Kiến trúc hướng dịch vụ và Điện toán đám mây")
				.soTinChi(3)
				.soTietLT(30)
				.soTietTH(30)
				.loaiMon(LoaiMon.TU_CHON)
				.maMonYeuCau(0)
				.nhomMon(1)
				.nganh(cntt_ktpm)
				.hocKy(hk7)
				.build();
		monHocService.addSubject(kthdvvdtdm);
		//hk8
		MonHoc toeic = MonHoc
				.builder()
				.maMonHoc(1000080)
				.tenMonHoc("Chứng chỉ TOEIC 450")
				.soTinChi(0)
				.soTietLT(0)
				.soTietTH(0)
				.loaiMon(LoaiMon.SUPER_BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk8)
				.build();
		monHocService.addSubject(toeic);
		MonHoc ttdn = MonHoc
				.builder()
				.maMonHoc(1000081)
				.tenMonHoc("Thực tập doanh nghiệp")
				.soTinChi(5)
				.soTietLT(0)
				.soTietTH(150)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk8)
				.build();
		monHocService.addSubject(ttdn);
		MonHoc kltn = MonHoc
				.builder()
				.maMonHoc(1000082)
				.tenMonHoc("Khóa luận tốt nghiệp")
				.soTinChi(5)
				.soTietLT(0)
				.soTietTH(150)
				.loaiMon(LoaiMon.BAT_BUOC)
				.maMonYeuCau(0)
				.nhomMon(0)
				.nganh(cntt_ktpm)
				.hocKy(hk8)
				.build();
		monHocService.addSubject(kltn);
		//Generate LHP
		LopHocPhanDTO lhpDTO = new LopHocPhanDTO();
		lhpDTO.setHanNopHocPhi("2023-02-14");
		lhpDTO.setNgayBatDau("2023-02-14");
		lhpDTO.setNgayKetThuc("2023-02-28");
		lhpDTO.setTenLopHocPhan("DHKTPM1ATT");
		lhpDTO.setLoaiHoc("HOC_MOI");
		lhpDTO.setMaGiaoVien(1);
		lhpDTO.setMaMonHoc(1000082);
		lhpDTO.setMaKhoaHoc(8);
		lhpDTO.setSoLuongMax(33);
		lhpDTO.setTrangThai("DA_KHOA");
		LopHocPhan lhp = lopHocPhanService.addUnitClass(lhpDTO);
		//Generate tkb
		ThoiKhoaBieuDTO tkbDTO = new ThoiKhoaBieuDTO();
		tkbDTO.setMaLopHocPhan(lhp.getMaLopHocPhan());
		tkbDTO.setTuTietHoc("T1");
		tkbDTO.setDenTietHoc("T3");
		tkbDTO.setPhongHoc("B1.01");
		tkbDTO.setThuHoc("CN");
		tkbDTO.setThi(null);
		tkbDTO.setGhiChu("Các em nhớ đi học vào lớp đúng giờ nhé!");
		tkbDTO.setLoaiBuoiHoc("LT");
		tkbDTO.setNhomHoc(0);
		tkbDTO.setChungWithMaThoiKhoaBieu(0);
		tkbDTO.setNgayBatDau("2023-02-14");
		tkbDTO.setNgayKetThuc("2023-02-28");
		ThoiKhoaBieu tkb = thoiKhoaBieuService.addTimeTable(tkbDTO);
		//Generate sv_lhp
		SinhVien_LopHocPhanDTO svLhpDTO = new SinhVien_LopHocPhanDTO();
		svLhpDTO.setMaSinhVien(1);
		svLhpDTO.setMaThoiKhoaBieu(tkb.getMaThoiKhoaBieu());
		sinhVien_LopHocPhanService.saveUnitSubject(svLhpDTO);
		//Generate thanhToanGiaoDich
		String maGiaoDich = thanhToanGiaoDichService.createTransaction(sv.getMaSinhVien(), 1700000, "1");
		ThanhToanGiaoDich ttgd = thanhToanGiaoDichService.getPaymentById(maGiaoDich);
		//Generate phieuThu
		PhieuThu phieuThu = PhieuThu
				.builder()
				.maPhieuThu(1)
				.ngayThu(new Date(new java.util.Date().getTime()))
				.donViThu("Ngân hàng Agribank")
				.ghiChu("Giao dich truc tiep tai QGD GoVap")
				.soTien(15300000)
				.trangThai("DANG_CHO_XU_LY")
				.sinhVien(sv)
				.thanhToanGiaoDich(ttgd)
				.build();
		phieuThuService.saveOrderDetail(phieuThu);
		return "Generate success!";
	}
	
}
