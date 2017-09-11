package model;

import java.util.Date;
import java.util.Properties;
 
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import database.DbClass;
 
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class EmailUtility {
	
	/**
	 * Method for sending email
	 * @param userEmail
	 * @param metricName
	 * @param threshold
	 * @throws AddressException
	 * @throws MessagingException
	 */
    public static void sendEmail(String userEmail, String metricName, String threshold) throws AddressException,
            MessagingException {
    	
    	String host = "smtp.gmail.com";
        int port = 587;
        String userName = "cloudmonitoringfyp@gmail.com";
        String password = "cloudmonitoring";
        
        String recipient = userEmail;
        String subject = "Cloud Monitoring Alert";
        String message = "The " +metricName+ " has passed its threshold of " +threshold;
        
        // sets SMTP server properties
        Properties properties = new Properties();
        properties.put("mail.smtp.host", host);
        properties.put("mail.smtp.port", port);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
 
        // creates a new session with an authenticator
        Authenticator auth = new Authenticator() {
            public PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(userName, password);
            }
        };
 
        Session session = Session.getInstance(properties, auth);
 
        // creates a new e-mail message
        Message msg = new MimeMessage(session);
 
        msg.setFrom(new InternetAddress(userName));
        InternetAddress[] toAddresses = { new InternetAddress(recipient) };
        msg.setRecipients(Message.RecipientType.TO, toAddresses);
        msg.setSubject(subject);
        msg.setSentDate(new Date());
        msg.setText(message);
 
        // sends the e-mail
        Transport.send(msg);
 
    }
}
