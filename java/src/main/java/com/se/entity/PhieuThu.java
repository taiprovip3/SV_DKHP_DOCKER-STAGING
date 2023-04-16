package com.se.entity;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.se.enums.LoaiPhieuThu;

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
public class PhieuThu implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1989602594627019573L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private long maPhieuThu;
	private Date ngayThu;
	private double soTien;
	private String donViThu;
	private String trangThai;
	private String ghiChu;
	@Enumerated(EnumType.STRING)
	@Column(nullable = false, columnDefinition = "vachar(255) default 'OUT' comment 'IN: la nap tien vao vi, OUT: la thanh toan hoc phi'")
	private LoaiPhieuThu loaiPhieuThu;
	@ManyToOne
	@JoinColumn(name = "maSinhVien", nullable = false)
	private SinhVien sinhVien;
	@OneToOne
	@JoinColumn(name="maGiaoDich", referencedColumnName = "maGiaoDich", nullable = true)
	private ThanhToanGiaoDich thanhToanGiaoDich;
}
