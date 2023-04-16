package com.se.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;


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
public class ChuongTrinhKhung implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -2872567885391517700L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private long id;//Chỉ là stt để thuận tiện crud
	private boolean done;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="maSinhVien", referencedColumnName = "maSinhVien")
	private SinhVien sinhVien;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="maMonHoc", referencedColumnName = "maMonHoc")
	private MonHoc monHoc;
}
