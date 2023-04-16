package com.se.entity;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
public class CongNo implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 8384154540389801375L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
    private long id;
    private double soTien;
    private float mienGiam;
    private double daNop;
    private double khauTru;
    private double congNo;
    private String trangThai;

    @ManyToOne
    @JoinColumn(name="maSinhVien", nullable = false)
    private SinhVien sinhVien;
    @ManyToOne
    @JoinColumn(name="maMonHoc", nullable = false)
    private MonHoc monHoc;
    @OneToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="maLopHocPhan", referencedColumnName = "maLopHocPhan")
    private LopHocPhan lopHocPhan;
}
