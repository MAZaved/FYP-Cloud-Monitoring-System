package model;

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
@Table(name="Alerts")
public class Alert {

	@Id @GeneratedValue
	private int alertId;
	private int userId;
	private String alertName;
	private String metricName;
	private String threshold;
	private int timeInterval;
	private boolean email;
	private String extraRecipient;
	
	public Alert() {
	}

	public Alert(int alertId, int userId, String alertName, String metricName, String threshold, int timeInterval,
			boolean email, String extraRecipient) {
		this.alertId = alertId;
		this.userId = userId;
		this.alertName = alertName;
		this.metricName = metricName;
		this.threshold = threshold;
		this.timeInterval = timeInterval;
		this.email = email;
		this.extraRecipient = extraRecipient;
	}

	public Alert(int userId, String alertName, String metricName, String threshold, int timeInterval,
			boolean email, String extraRecipient) {
		this.userId = userId;
		this.alertName = alertName;
		this.metricName = metricName;
		this.threshold = threshold;
		this.timeInterval = timeInterval;
		this.email = email;
		this.extraRecipient = extraRecipient;
	}

	public int getAlertId() {
		return alertId;
	}

	public void setAlertId(int alertId) {
		this.alertId = alertId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public String getAlertName() {
		return alertName;
	}

	public void setAlertName(String alertName) {
		this.alertName = alertName;
	}

	public String getMetricName() {
		return metricName;
	}

	public void setMetricName(String metricName) {
		this.metricName = metricName;
	}

	public String getThreshold() {
		return threshold;
	}

	public void setThreshold(String threshold) {
		this.threshold = threshold;
	}

	public int getTimeInterval() {
		return timeInterval;
	}

	public void setTimeInterval(int timeInterval) {
		this.timeInterval = timeInterval;
	}

	public boolean isEmail() {
		return email;
	}

	public void setEmail(boolean email) {
		this.email = email;
	}

	public String getExtraRecipient() {
		return extraRecipient;
	}

	public void setExtraRecipient(String extraRecipient) {
		this.extraRecipient = extraRecipient;
	}

}
