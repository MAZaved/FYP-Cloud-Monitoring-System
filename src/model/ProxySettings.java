package model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
@Entity
public class ProxySettings {
	
	@Id @GeneratedValue
	private int proxyId;
	private int userId;
	private String proxyType;
	private String url;
	private int port;
	private String username;
	private String password;
	
	public ProxySettings() {
	}
	 
	public ProxySettings(int userId, String proxyType, String url, int port, String username, String password) {
		this.userId = userId;
		this.proxyType = proxyType;
		this.url = url;
		this.port = port;
		this.username = username;
		this.password = password;
	}
	
	public ProxySettings(int proxyId, int userId, String proxyType, String url, int port, String username, String password) {
		this.proxyId = proxyId;
		this.userId = userId;
		this.proxyType = proxyType;
		this.url = url;
		this.port = port;
		this.username = username;
		this.password = password;
	}
	public int getProxyId() {
		return proxyId;
	}
	public void setProxyId(int proxyId) {
		this.proxyId = proxyId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getProxyType() {
		return proxyType;
	}
	public void setProxyType(String proxyType) {
		this.proxyType = proxyType;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getPort() {
		return port;
	}
	public void setPort(int port) {
		this.port = port;
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
}
