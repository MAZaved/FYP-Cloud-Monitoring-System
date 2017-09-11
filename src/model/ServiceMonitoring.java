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
public class ServiceMonitoring {
	
	@Id @GeneratedValue
	private int serviceMonitorId;
	private int userId;
	private String host;
	private int port;
	private String username;
	private String password;
	private String serviceName;
	private String selectTool;
	private String url;
	private int Timeinterval;
	private int duration;
	private String webUrl;
	
	public ServiceMonitoring() {
    }
	
	public ServiceMonitoring(int serviceMonitorId, int userId, String host, int port, String username, String password,
			String serviceName, String selectTool, String url, int Timeinterval, int duration, String webUrl) {
		this.serviceMonitorId = serviceMonitorId;
		this.userId = userId;
		this.host = host;
		this.port = port;
		this.username = username;
		this.password = password;
		this.serviceName = serviceName;
		this.selectTool = selectTool;
		this.url = url;
		this.Timeinterval = Timeinterval;
		this.duration = duration;
		this.webUrl = webUrl;
	}
	
	public ServiceMonitoring( int userId, String host, int port, String username, String password,
			String serviceName, String selectTool, String url, int Timeinterval, int duration, String webUrl) {
		this.userId = userId;
		this.host = host;
		this.port = port;
		this.username = username;
		this.password = password;
		this.serviceName = serviceName;
		this.selectTool = selectTool;
		this.url = url;
		this.Timeinterval = Timeinterval;
		this.duration = duration;
		this.webUrl = webUrl;
	}

	public int getServiceMonitorId() {
		return serviceMonitorId;
	}
	public void setServiceMonitorId(int serviceMonitorId) {
		this.serviceMonitorId = serviceMonitorId;
	}
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	public String getHost() {
		return host;
	}
	public void setHost(String host) {
		this.host = host;
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
	public String getServiceName() {
		return serviceName;
	}
	public void setServiceName(String serviceName) {
		this.serviceName = serviceName;
	}
	public String getSelectTool() {
		return selectTool;
	}
	public void setSelectTool(String selectTool) {
		this.selectTool = selectTool;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public int getInterval() {
		return Timeinterval;
	}
	public void setInterval(int interval) {
		this.Timeinterval = interval;
	}
	public int getDuration() {
		return duration;
	}
	public void setDuration(int duration) {
		this.duration = duration;
	}
	public String getWebUrl() {
		return webUrl;
	}
	public void setWebUrl(String webUrl) {
		this.webUrl = webUrl;
	}
	
}
