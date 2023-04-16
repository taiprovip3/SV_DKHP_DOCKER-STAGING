package com.se.entity;

import java.io.Serializable;
import java.sql.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.se.enums.GioiTinh;
import com.se.enums.LoaiGiaoVien;

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
public class GiaoVien implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -7716163581672632602L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
	private long maGiaoVien;
	private String tenGiaoVien;
	@Enumerated(EnumType.STRING)
	private GioiTinh gioiTinh;
	private Date ngaySinh;
	private String diaChi;
	private String sdt;
	@Column(columnDefinition = "varchat(255) default 'https://smilemedia.vn/wp-content/uploads/2022/09/cach-chup-hinh-the-dep.jpeg'")
	private String avatar;
	@Enumerated(EnumType.STRING)
	private LoaiGiaoVien loaiGiaoVien;
	
	@OneToOne
    @JoinColumn(name = "maTaiKhoan", referencedColumnName = "id")
    private TaiKhoan taiKhoan;
	
	@JsonIgnore
    @ToString.Exclude
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "giaoVien")
    private Set<ThoiKhoaBieu> thoiKhoaBieus = new HashSet<>();
	
	@JsonIgnore
    @ToString.Exclude
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "giaoVien")
    private Set<ThoiKhoaBieuCon> thoiKhoaBieuCons = new HashSet<>();
}
