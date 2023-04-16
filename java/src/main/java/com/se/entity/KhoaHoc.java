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
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.se.enums.TenKhoaHoc;

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
public class KhoaHoc implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 2345959882246442944L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private long maKhoaHoc;
	@Enumerated(EnumType.STRING)
	private TenKhoaHoc tenKhoaHoc;
	private String alias;
	private int namBatDau;
	private int namKetThuc;
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name = "maHocKy", referencedColumnName = "maHocKy", nullable = true)
	private HocKy hocKy;
}
