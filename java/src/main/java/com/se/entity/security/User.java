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
import javax.persistence.ManyToMany;
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
public class User implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6990795570828179037L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	private String username;
	@JsonIgnore
	@ToString.Exclude
	private String password;
	@JsonIgnore
	@ToString.Exclude
	@ManyToMany(fetch = FetchType.EAGER)
	@JoinTable(
		name="user_role_map",
		joinColumns = @JoinColumn(
			name="idUser",
			referencedColumnName = "id"
		),
		inverseJoinColumns = @JoinColumn(
			name="idRole",
			referencedColumnName = "id"
		)
	)
	private Set<Role> roles;
}
