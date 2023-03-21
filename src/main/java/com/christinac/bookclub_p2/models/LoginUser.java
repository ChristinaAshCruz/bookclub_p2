package com.christinac.bookclub_p2.models;

public class LoginUser {

	@NotEmpty
	@Email
	private String email;
	@NotEmpty
	@Size(min=8)
	private String password;
	
	// constructor
	public LoginUser() {}
	
	//getters and setters
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
}
