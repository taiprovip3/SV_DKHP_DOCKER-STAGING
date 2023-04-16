package com.se.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
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

import com.se.enums.XepLoai;

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
public class Diem implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 107202037931687552L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private long maDiem;
	private float diemGK;
	private float diemLT1;
	private float diemLT2;
	private float diemLT3;
	private float diemTH1;
	private float diemTH2;
	private float diemTH3;
	private float diemCK;
	private float diemTongKet;
	private float diem4;
	private String diemChu;
	@Enumerated(EnumType.STRING)
	private XepLoai xepLoai;
	private String ghiChu;
	private boolean pass;
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="maLopHocPhan", referencedColumnName = "maLopHocPhan")
	private LopHocPhan lopHocPhan;
	
	@ManyToOne
	@JoinColumn(name="maSinhVien", nullable = false)
	private SinhVien sinhVien;
	
}
