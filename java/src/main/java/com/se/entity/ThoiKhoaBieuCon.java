package com.se.entity;


import java.io.Serializable;
import java.sql.Date;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
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
public class ThoiKhoaBieuCon implements Serializable {//TKBCon là TKB Thực Hành
	/**
	 * 
	 */
	private static final long serialVersionUID = 5488428175827954541L;

	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private long maThoiKhoaBieuCon;
	
	@JsonBackReference
	@ManyToOne
    @JoinColumn(name = "maThoiKhoaBieu")
    private ThoiKhoaBieu thoiKhoaBieu;
	
	@ManyToOne
    @JoinColumn(name = "maGiaoVien", nullable = false)
    private GiaoVien giaoVien;

	@JsonIgnore
	@ToString.Exclude
	@OneToMany(mappedBy = "thoiKhoaBieuCon")
    private Set<SinhVien_LopHocPhan> sinhVien_LopHocPhans;
	
	private int soLuongDaDangKy;
	
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
	
}
