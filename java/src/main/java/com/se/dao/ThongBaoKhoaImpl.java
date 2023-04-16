package com.se.dao;

import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.se.dto.ThongBaoKhoaDTO;
import com.se.entity.Khoa;
import com.se.entity.SinhVien;
import com.se.entity.ThongBaoKhoa;
import com.se.repo.KhoaRepository;
import com.se.repo.SinhVienRepository;
import com.se.repo.ThongBaoKhoaRepository;
import com.se.service.ThongBaoKhoaService;
@Service
public class ThongBaoKhoaImpl implements ThongBaoKhoaService {
	
	@Autowired
	private ThongBaoKhoaRepository thongBaoKhoaRepository;
	@Autowired
	private KhoaRepository khoaRepository;
	@Autowired
	private SinhVienRepository sinhVienRepository;

	@Override
	public ThongBaoKhoa addAnnouncement(ThongBaoKhoaDTO thongBao) {
		try {
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date ngayXuatBanUtil = sdf.parse(thongBao.getNgayXuatBan());
			Date ngayXuatBanSql = new Date(ngayXuatBanUtil.getTime());
			Khoa k = khoaRepository.findById(thongBao.getMaKhoa()).orElse(null);
			ThongBaoKhoa tkb = ThongBaoKhoa
					.builder()
					.tieuDe(thongBao.getTieuDe())
					.noiDung(thongBao.getNoiDung())
					.ngayXuatBan(ngayXuatBanSql)
					.khoa(k)
					.build();
			return thongBaoKhoaRepository.save(tkb);
		} catch (ParseException e) {
			System.out.println("Exception parse date: " + e.getMessage());
		}
		return null;
	}

	@Override
	public List<ThongBaoKhoa> getNotificationsByStudentId(Long studentId) {
		SinhVien sv = sinhVienRepository.findById(studentId).orElse(null);
		long maKhoa = sv.getLopHocDanhNghia().getNganh().getKhoa().getMaKhoa();
		return thongBaoKhoaRepository.getNotificationsByDeparmentId(maKhoa);
	}

	@Override
	public ThongBaoKhoa getNotificationById(long notificationId) {
		return thongBaoKhoaRepository.findById(notificationId).orElse(null);
	}

}
