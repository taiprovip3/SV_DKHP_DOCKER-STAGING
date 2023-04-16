package com.se.entity;

import java.io.Serializable;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
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
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Khoa implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = -6124311132597846650L;
	@Id
	@GeneratedValue (strategy = GenerationType.IDENTITY)
    private Long maKhoa;
    private String tenKhoa;
    @JsonIgnore
    @ToString.Exclude
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "khoa")
    private Set<Nganh> nganhs = new HashSet<>();
    @JsonIgnore
    @ToString.Exclude
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "khoa")
    private Set<ThongBaoKhoa> thongBaoKhoas = new HashSet<>();
}
