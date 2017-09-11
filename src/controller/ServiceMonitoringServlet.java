package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.plaf.synth.SynthSpinnerUI;

import model.Logger;
import model.ServiceMonitoring;
import model.User;
import service.ServiceMonitoringService;
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class ServiceMonitoringServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
     response.setContentType("text/html;charset=UTF-8");
     
     PrintWriter out = response.getWriter();
     
     String updateService = request.getParameter("updateService");
     String removeService = request.getParameter("removeService");
     int userId = Integer.parseInt(request.getParameter("userId"));
     String host = request.getParameter("host");
     int port = Integer.parseInt(request.getParameter("port"));
     String username = request.getParameter("username");
     String password = request.getParameter("password");
     String serviceName = request.getParameter("serviceName");
     String selectTool = request.getParameter("selectTool");
     String url = request.getParameter("url");
     int interval = Integer.parseInt(request.getParameter("interval"));
     int duration = Integer.parseInt(request.getParameter("duration"));
     String webUrl = request.getParameter("webUrl");
     
     HttpSession session = request.getSession();
     User user = (User) session.getAttribute("user");
     Logger log = new Logger();
     
     try { 
    	 
    	 ServiceMonitoringService registerService = new ServiceMonitoringService();
    	//if the user created a Service Monitor
    	 if(updateService == null && removeService == null)
    	 {
    		 ServiceMonitoring servicemonitoring = new ServiceMonitoring(userId, host, port, username, password, serviceName, selectTool, url, interval, duration, webUrl);
    	     
	         boolean result = registerService.registerService(servicemonitoring);      
	         if(result)
	         {
	 		     log.log(user.getUsername(), "Created Service Monitor", serviceName );
	 		     
	        	 request.setAttribute("successMessage", "User Created");
	             RequestDispatcher rd = request.getRequestDispatcher("/monitor_config.jsp");
	             rd.forward(request, response);
	         }
	         else
	         {
	        	 request.setAttribute("errorMessage", "User Not Created");
	             RequestDispatcher rd = request.getRequestDispatcher("/monitor_config.jsp");
	             rd.forward(request, response);
	         }
    	 }
    	//if the user updated a Service Monitor
    	 else if(updateService != null)
    	 {
    		 
    		 int serviceMonitorId = Integer.parseInt(request.getParameter("serviceMonitorId"));
    	     ServiceMonitoring servicemonitoring = new ServiceMonitoring(serviceMonitorId, userId, host, port, username, password, serviceName, selectTool, url, interval, duration, webUrl);
    		 boolean result = registerService.updateService(servicemonitoring);      
	         if(result)
	         {
	        	 
	        	 
	 		     log.log(user.getUsername(), "Updated Service Monitor", serviceName );
	 		     
	        	 response.sendRedirect("monitor_management.jsp");
	         }
	         else
	         {
	        	 response.sendRedirect("monitor_management.jsp");
	         }
    	 }
    	//if the user removed a Service Monitor
    	 else if(removeService != null)
    	 {
    		 int serviceMonitorId = Integer.parseInt(request.getParameter("serviceMonitorId"));
    	     ServiceMonitoring servicemonitoring = new ServiceMonitoring(serviceMonitorId, userId, host, port, username, password, serviceName, selectTool, url, interval, duration, webUrl);
    		 boolean result = registerService.removeService(servicemonitoring);      
	         if(result)
	         {
	        	 
	        	
	 		     log.log(user.getUsername(), "Removed Service Monitor", serviceName );
	 		     
	        	 response.sendRedirect("monitor_management.jsp");
	         }
	         else
	         {
	        	 response.sendRedirect("monitor_management.jsp");
	         }
    	 }
     } finally {       
         out.close();
     }
	
	}	

}
