package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Alert;
import model.Logger;
import model.User;
import service.AlertService;

/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class AlertServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
		
	 Logger log = new Logger();
     response.setContentType("text/html;charset=UTF-8");
     
     HttpSession session = request.getSession();
     User user = (User) session.getAttribute("user");
     
     PrintWriter out = response.getWriter();
     String updateAlert = request.getParameter("updateAlert");
     String removeAlert = request.getParameter("removeAlert");
     
     
     int userID = Integer.parseInt(request.getParameter("userId"));
     String alertName = request.getParameter("alertName");
     String metricName = request.getParameter("metricName");
     String threshold = request.getParameter("threshold");
     int interval = Integer.parseInt(request.getParameter("interval"));
     boolean email = Boolean.parseBoolean(request.getParameter("email"));
     String extraRecipient = request.getParameter("extraRecipient");
     
     try { 
    	 AlertService registerService = new AlertService();
    	 //if the user created an alert
    	 if(updateAlert == null && removeAlert == null)
    	 {
    		 
 		     log.log(user.getUsername(), "Created Alert", alertName );
    		 
    		 Alert alert = new Alert(userID, alertName, metricName, threshold, interval, email, extraRecipient);
    		 boolean result = registerService.registerService(alert);      
	    	      
	         if(result){
	        	 request.setAttribute("successMessage", "User Created");
	             RequestDispatcher rd = request.getRequestDispatcher("/alert_config.jsp");
	             rd.forward(request, response);
	         }else{
	        	 request.setAttribute("errorMessage", "User Not Created");
	             RequestDispatcher rd = request.getRequestDispatcher("/alert_config.jsp");
	             rd.forward(request, response);
	         }
         
    	 }
    	//if the user updated an alert
    	 else if(updateAlert != null)
    	 {
    		 log.log(user.getUsername(), "Updated Alert", alertName );
    		 
    		 int alertID = Integer.parseInt(request.getParameter("alertId"));
    		 Alert alert = new Alert(alertID, userID, alertName, metricName, threshold, interval, email, extraRecipient);
    	     boolean result = registerService.updateAlert(alert);      
	         if(result)
	         {
	        	 response.sendRedirect("alert_management.jsp");
	         }
	         else
	         {
	        	 response.sendRedirect("alert_management.jsp");
	         }
    	 }
    	//if the user removed an alert
    	 else if(removeAlert != null)
    	 {
    		 log.log(user.getUsername(), "Removed Alert", alertName );
    		 
    		 int alertID = Integer.parseInt(request.getParameter("alertId"));
    		 Alert alert = new Alert(alertID, userID, alertName, metricName, threshold, interval, email, extraRecipient);
    	     boolean result = registerService.removeAlert(alert);      
	         if(result)
	         {
	        	 response.sendRedirect("alert_management.jsp");
	         }
	         else
	         {
	        	 response.sendRedirect("alert_management.jsp");
	         }
    	 }
     } finally {       
         out.close();
     }
	
	}

}
