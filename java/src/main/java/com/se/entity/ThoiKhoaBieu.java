package com.se.entity;

import java.io.Serializable;
import java.sql.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.se.enums.LoaiBuoiHoc;
import com.se.enums.ThuHoc;
import com.se.enums.TietHoc;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@Entity
@Table
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ThoiKhoaBieu implements Serializable{//TKB là TKB Lý thuyết
	/**
	 *
	 */
	private static final long serialVersionUID = 9218943034296153244L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private long maThoiKhoaBieu;
	@Enumerated(EnumType.STRING)
	private ThuHoc thuHoc;
	@Enumerated(EnumType.STRING)
	private TietHoc tuTietHoc;
	@Enumerated(EnumType.STRING)
	private TietHoc denTietHoc;
	private String phongHoc;
	private String ghiChu;
	private boolean thi;
	@Enumerated(EnumType.STRING)
	private LoaiBuoiHoc loaiBuoiHoc;
	private int nhomHoc;
	private Date ngayBatDau;
	private Date ngayKetThuc;
	private int soLuongDaDangKy;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="maLopHocPhan", nullable = false)
	@JsonIgnoreProperties("thoiKhoaBieus")
	private LopHocPhan lopHocPhan;

	@JsonManagedReference
    @OneToMany(mappedBy = "thoiKhoaBieu")
    private List<ThoiKhoaBieuCon> thoiKhoaBieuCons;
	
	@ManyToOne
	@JoinColumn(name="maGiaoVien", nullable = false)
	private GiaoVien giaoVien;

	@JsonIgnore
	@ToString.Exclude
	@OneToMany(mappedBy = "thoiKhoaBieu")
    private Set<SinhVien_LopHocPhan> sinhVien_LopHocPhans;
}
