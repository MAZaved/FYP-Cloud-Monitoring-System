package model;

import javax.annotation.Generated;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
@Entity 
public class ResourceAgent {
	
	@Id @GeneratedValue
	private int agentID;
	private int userID;
	private String hostname;
	private int port;
	private int groupID;

	public ResourceAgent() {
    }
	
	public ResourceAgent(int agentID, int userID, String hostname, int port, int groupID) {
		this.agentID = agentID;
		this.userID = userID;
		this.hostname = hostname;
		this.port = port;
		this.groupID = groupID;
	}
	
	public ResourceAgent( int userID, String hostname, int port, int groupID) {
		
		this.userID = userID;
		this.hostname = hostname;
		this.port = port;
		this.groupID = groupID;
	}

	public int getAgentID() {
		return agentID;
	}

	public void setAgentID(int agentID) {
		this.agentID = agentID;
	}
	
	public int getUserID() {
		return userID;
	}

	public void setUserID(int userID) {
		this.userID = userID;
	}

	public String getHostname() {
		return hostname;
	}

	public void setHostname(String hostname) {
		this.hostname = hostname;
	}

	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}

	public int getGroupID() {
		return groupID;
	}

	public void setGroupID(int groupID) {
		this.groupID = groupID;
	} 
}
