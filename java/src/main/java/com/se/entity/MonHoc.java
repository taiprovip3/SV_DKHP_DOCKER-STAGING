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
import javax.persistence.PostLoad;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Formula;

import com.se.enums.LoaiMon;

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
public class MonHoc implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 7706469952925732295L;
	@Id
	private long maMonHoc;
	private String tenMonHoc;
	private long maMonYeuCau;
	private int soTinChi;
	private int soTietLT;
	private int soTietTH;
	private double hocPhi;
	@Enumerated(EnumType.STRING)
	private LoaiMon loaiMon; //TU_CHON, BAT_BUOC
	private int nhomMon; //0 la ko thuoc nhom nao, 1 la nhom 1 neu là TU CHOn, 2 la nhom 2
	@ManyToOne
	@JoinColumn(name="maNganh", nullable = false)
	private Nganh nganh;
	@ManyToOne
	@JoinColumn(name="maHocKy", nullable = false)
	private HocKy hocKy;
	@PreUpdate
	@PrePersist
	public void calc() {
	    this.hocPhi = soTinChi * 850000;
	}
}
