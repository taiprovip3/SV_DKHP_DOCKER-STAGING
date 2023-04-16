package com.se.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Table
@Entity
@Data
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class Nganh implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = -7050041788998707837L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private long maNganh;
	private String tenNganh;
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name="maKhoa", nullable = false)
	private Khoa khoa;
	@JsonIgnore
	@ToString.Exclude
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "nganh")
	private Set<MonHoc> monHocs = new HashSet<>();
	@JsonIgnore
	@ToString.Exclude
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "nganh")
	private Set<HocKy> hocKies = new HashSet<>();
	
}
