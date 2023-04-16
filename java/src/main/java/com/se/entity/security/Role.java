package com.se.entity.security;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Entity
@Table
@Data
@ToString
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Role implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 7663756688410704131L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	private String name;
	@JsonIgnore
	@ToString.Exclude
	@OneToMany(fetch = FetchType.EAGER)
	@JoinTable(name = "role_permission_map", joinColumns = {@JoinColumn(name = "idRole")},
    inverseJoinColumns = {@JoinColumn(name = "idPermission")})
	private Set<Permission> permissions;
}
