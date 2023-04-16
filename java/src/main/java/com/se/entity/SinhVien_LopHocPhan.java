package com.se.entity;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.ColumnDefault;

import com.se.enums.LoaiBuoiHoc;

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
public class SinhVien_LopHocPhan implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 397874747181507802L;
	@Id
	@GeneratedValue( strategy = GenerationType.IDENTITY)
	private long id;
	private boolean daThuHocPhi;
	private Date ngayDangKy;
	
	@ManyToOne
	@JoinColumn(name = "maSinhVien", nullable = false)
	private SinhVien sinhVien;
	
	@ManyToOne
	@JoinColumn(name = "maLopHocPhan", nullable = false)
	private LopHocPhan lopHocPhan;

	@ManyToOne
	@JoinColumn(name = "maThoiKhoaBieu", nullable = false)
	private ThoiKhoaBieu thoiKhoaBieu;

	@ManyToOne
	@JoinColumn(name = "maThoiKhoaBieuCon", nullable = true)
	@ColumnDefault("null")
	private ThoiKhoaBieuCon thoiKhoaBieuCon;
}
