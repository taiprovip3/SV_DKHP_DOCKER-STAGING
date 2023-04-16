package com.se.entity;

import java.io.Serializable;
import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.CreationTimestamp;

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
public class ThongBao implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -8133317924178045542L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private long id;
	@Column(columnDefinition = "DEFAULT 'Không có tiêu đề'")
	private String title;
	private String message;
	private String linking;
	private boolean isRead;
	@CreationTimestamp
	private Timestamp createAt;
	@ManyToOne
	@JoinColumn(name = "maSinhVien", nullable = false)
	private SinhVien sinhVien;
}
