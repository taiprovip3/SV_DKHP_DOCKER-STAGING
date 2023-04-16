package com.se.entity;

import java.io.Serializable;
import java.sql.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonManagedReference;
import com.se.enums.LoaiHoc;
import com.se.enums.TrangThai;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@Entity
@Table
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class LopHocPhan implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7352871636208506507L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private long maLopHocPhan;
	private String tenLopHocPhan;
	private int soLuong;
	private int soLuongMax;
	@Enumerated(EnumType.STRING)
	private TrangThai trangThai;
	private Date hanNopHocPhi;
	private Date ngayBatDau;
	private Date ngayKetThuc;
	@Enumerated(EnumType.STRING)
	private LoaiHoc loaiHoc;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="maGiaoVien", referencedColumnName = "maGiaoVien")
	private GiaoVien giaoVien;
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "maMonHoc", referencedColumnName = "maMonHoc")
	private MonHoc monHoc;
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="maKhoaHoc", referencedColumnName = "maKhoaHoc")
	private KhoaHoc khoaHoc;

	@OneToMany(mappedBy = "lopHocPhan")
	@JsonIgnoreProperties("lopHocPhan")
	private List<ThoiKhoaBieu> thoiKhoaBieus;
}
