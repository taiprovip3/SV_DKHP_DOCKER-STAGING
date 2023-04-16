package com.se.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.se.enums.ChucVu;

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
public class NhanVien implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 559988265694646729L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private long maNhanVien;
	private String tenNhanVien;
	private String sdt;
	private String diaChi;
	@Enumerated(EnumType.STRING)
	private ChucVu chucVu;
	
	@OneToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "maTaiKhoan", referencedColumnName = "id")
    private TaiKhoan taiKhoan;
}
