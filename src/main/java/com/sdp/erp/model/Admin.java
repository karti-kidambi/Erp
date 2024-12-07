package com.sdp.erp.model;

import jakarta.persistence.*;

@Entity
public class Admin {

    @Id
    private String username;
    @Column(nullable = false)
    private String password;
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
}
