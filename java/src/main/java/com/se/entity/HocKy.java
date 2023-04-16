package com.se.entity;

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

@Data
@Table
@Entity
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HocKy {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
	private long maHocKy;
	private String tenHocKy;
	
	@JsonIgnore
	@ToString.Exclude
	@OneToMany(fetch = FetchType.LAZY, mappedBy = "hocKy")
	private Set<MonHoc> monHocs = new HashSet<>();
	@ManyToOne
	@JoinColumn(name = "maNganh", nullable = false)
	private Nganh nganh;
	private int soTinChi;
}
