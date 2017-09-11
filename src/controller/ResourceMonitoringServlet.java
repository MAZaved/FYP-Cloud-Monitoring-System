package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Logger;
import model.ResourceMonitoring;
import model.User;
import service.ResourceMonitoringService;
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class ResourceMonitoringServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
	 HttpSession session = request.getSession();
	 User user = (User) session.getAttribute("user");
	     
     response.setContentType("text/html;charset=UTF-8");
     String updateResource = request.getParameter("updateResource");
     String removeResource = request.getParameter("removeResource");
     PrintWriter out = response.getWriter();
     
     Logger log = new Logger();
     
     int userId = Integer.parseInt(request.getParameter("userId"));
     String host = request.getParameter("host");
     int port = Integer.parseInt(request.getParameter("port"));
     String username = request.getParameter("username");
     String password = request.getParameter("password");
     int groupID = Integer.parseInt(request.getParameter("group"));
     int Timeinterval = Integer.parseInt(request.getParameter("interval"));
     int duration = Integer.parseInt(request.getParameter("duration"));
     
     try {
    	 
    	 ResourceMonitoringService registerService = new ResourceMonitoringService();
    	//if the user created a Resource Monitor
    	 if(updateResource == null && removeResource == null)
    	 {

    	     ResourceMonitoring resourcemonitoring = new ResourceMonitoring(userId, host, port, username, password, groupID, Timeinterval, duration);
	         boolean result = registerService.registerService(resourcemonitoring);      
	         if(result)
	         {
	        	 
	 		     log.log(user.getUsername(), "Created Resource Monitor", host );
	 		     
	        	 request.setAttribute("successMessage", "User Created");
	             RequestDispatcher rd = request.getRequestDispatcher("/monitor_config.jsp");
	             rd.forward(request, response);
	         }else{
	        	 request.setAttribute("errorMessage", "User Not Created");
	             RequestDispatcher rd = request.getRequestDispatcher("/monitor_config.jsp");
	             rd.forward(request, response);
	         }
    	 }
    	//if the user updated a Resource Monitor
         else if(updateResource != null)
    	 {
        	
 		     log.log(user.getUsername(), "Updated Resource Monitor", host );
        	 
             int resourceMonitorId = Integer.parseInt(request.getParameter("resourceMonitorId"));
             ResourceMonitoring resourcemonitoring = new ResourceMonitoring(resourceMonitorId, userId, host, port, username, password, groupID, Timeinterval, duration);
    		 boolean result = registerService.updateResource(resourcemonitoring);      
	         if(result){
	        	 response.sendRedirect("monitor_management.jsp");
	         }
	         else
	         {
	        	 response.sendRedirect("monitor_management.jsp");
	         }
    	 }
    	//if the user removed a Resource Monitor
    	 else if(removeResource != null)
    	 {
    	
 		     log.log(user.getUsername(), "Removed Resource Monitor", host );
    		 
    	     int resourceMonitorId = Integer.parseInt(request.getParameter("resourceMonitorId"));
    	     ResourceMonitoring resourcemonitoring = new ResourceMonitoring(resourceMonitorId, userId, host, port, username, password, groupID, Timeinterval, duration);
    		 boolean result = registerService.removeResource(resourcemonitoring);      
	         if(result){
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
