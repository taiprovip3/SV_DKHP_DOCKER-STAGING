package com.se.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.se.enums.GioiTinh;

import java.io.Serializable;
import java.sql.Date;
import java.util.HashSet;
import java.util.Set;

@Data
@Table
@Entity
@ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class SinhVien implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 8390697101434389005L;
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long maSinhVien;
    private String hoTen;
    @Enumerated(EnumType.STRING)
    private GioiTinh gioiTinh;
    private Date ngaySinh;
    private String noiSinh;
    private String sdt;
    private String diaChi;
    private String cccd;
    private Date ngayVaoTruong;
    private boolean totNghiep;
    private String avatar;
    private double soDu;
    
    @ManyToOne
    @JoinColumn(name = "maLopDanhNghia", nullable = false)
    private LopHocDanhNghia lopHocDanhNghia;
    
    @Embedded
    private DaoTao daoTao;
    
    @OneToOne
    @JoinColumn(name = "maTaiKhoan", referencedColumnName = "id")
    private TaiKhoan taiKhoan;
    
    @JsonIgnore
    @ToString.Exclude
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "sinhVien")
    private Set<Diem> diems = new HashSet<>();
    
    @JsonIgnore
    @ToString.Exclude
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "sinhVien")
    private Set<SinhVien_LopHocPhan> sinhVien_LopHocPhans = new HashSet<>();
   
    @JsonIgnore
    @ToString.Exclude
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "sinhVien")
    private Set<PhieuThu> phieuThus = new HashSet<>();

    @JsonIgnore
    @ToString.Exclude
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "sinhVien")
    private Set<ThanhToanGiaoDich> thanhToanGiaoDichs = new HashSet<>();
    
    @JsonIgnore
    @ToString.Exclude
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "sinhVien")
    private Set<ThongBao> thongBaos = new HashSet<>();
}
