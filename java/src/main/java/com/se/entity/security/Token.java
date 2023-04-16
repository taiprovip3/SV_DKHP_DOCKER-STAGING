package com.se.entity.security;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

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
public class Token implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 6243711454594684732L;
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long id;
	@Column(columnDefinition = "TEXT")
	private String token;
	private Date tokenExpDate;
	
	@OneToOne(cascade = CascadeType.REMOVE)
	@JoinColumn(
			name= "createdBy",
			referencedColumnName = "id"
	)
	private User user;
}
