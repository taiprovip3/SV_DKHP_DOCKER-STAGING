package com.se.entity;

import java.io.Serializable;
import java.sql.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

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
public class ThongBaoKhoa implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7552144357256606509L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private long maThongBao;
	private Date ngayXuatBan;
	private String tieuDe;
	@Column(columnDefinition = "text")
	private String noiDung;
	@JsonIgnore
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "maKhoa", nullable = false)
	private Khoa khoa;
	
}
