package com.se.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonIgnore;

@Table
@Entity
@Data
@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class LopHocDanhNghia implements Serializable {
    /**
	 * 
	 */
	private static final long serialVersionUID = 3428114285393639188L;
	@Id
    @GeneratedValue( strategy = GenerationType.IDENTITY)
    private long maLop;
    private String tenLop;
    private int soLuong;
    
    @JsonIgnore
    @ToString.Exclude
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "lopHocDanhNghia")
    private Set<SinhVien> sinhViens = new HashSet<>();
    
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="maGiaoVien", referencedColumnName = "maGiaoVien", nullable = false)
    private GiaoVien giaoVien;
    
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="maKhoaHoc", referencedColumnName = "maKhoaHoc", nullable = false)
    private KhoaHoc khoaHoc;
    
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="maNganh", referencedColumnName = "maNganh", nullable = false)
    private Nganh nganh;
}
