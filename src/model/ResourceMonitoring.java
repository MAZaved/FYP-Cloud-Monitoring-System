package model;

import java.util.ArrayList;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
@Entity
public class ResourceMonitoring {
	
	@Id @GeneratedValue
	private int resourceMonitorId;
	private int userId;
	private String host;
	private int port;
	private String username;
	private String password;
	private int groupID;
	private int Timeinterval;
	private int duration;
	private ArrayList<String> agents = new ArrayList<String>();
	
	public ResourceMonitoring() {
    }
	
	public ResourceMonitoring(int resourceMonitorId, int userId, String host, int port, String username,
			String password, int groupID, int Timeinterval, int duration) {
		this.resourceMonitorId = resourceMonitorId;
		this.userId = userId;
		this.host = host;
		this.port = port;
		this.username = username;
		this.password = password;
		this.groupID = groupID;
		this.Timeinterval = Timeinterval;
		this.duration = duration;
	}
	
	public ResourceMonitoring(int userId, String host, int port, String username,
			String password, int groupID, int Timeinterval, int duration) {
		this.userId = userId;
		this.host = host;
		this.port = port;
		this.username = username;
		this.password = password;
		this.groupID = groupID;
		this.Timeinterval = Timeinterval;
		this.duration = duration;
	}
	
	public int getResourceMonitorId() {
		return resourceMonitorId;
	}
	public void setResourceMonitorId(int resourceMonitorId) {
		this.resourceMonitorId = resourceMonitorId;
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
	public int getGroup() {
		return groupID;
	}
	public void setGroup(int group) {
		this.groupID = group;
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
	public ArrayList<String> getAgents() {
		return agents;
	}
	public void setAgents(ArrayList<String> agents) {
		this.agents = agents;
	}
}
