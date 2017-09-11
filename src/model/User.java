package model;

import java.io.Serializable;
import java.util.ArrayList;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
@Entity
@Table(name="Users")
public class User implements Serializable{
	
	@Id @GeneratedValue
	private int userId;
	private String username;
	private String password;
	private String email;
	private String userType;
	
	public User() {
    }
	
	public User(String username, String password, String email, String userType) {
	        this.username = username;
	        this.email = email;
	        this.password = password;
	        this.userType = userType;
	 }
	
	 public User(int userId, String username, String password, String email, String userType) {
		this.userId = userId;
        this.username = username;
        this.email = email;
        this.password = password;
        this.userType = userType;
 	}
	 
	
	 
	public int getUserId() {
		return userId;
	}
	
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
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
	
	public String getEmail() {
		return email;
	}
	
	public void setEmail(String email) {
		this.email = email;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}
}
