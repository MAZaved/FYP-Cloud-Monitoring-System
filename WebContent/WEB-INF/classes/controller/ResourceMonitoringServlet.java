package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ResourceMonitoring;
import service.ResourceMonitoringService;

public class ResourceMonitoringServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
     response.setContentType("text/html;charset=UTF-8");
     
     PrintWriter out = response.getWriter();
     
     int userId = Integer.parseInt(request.getParameter("userId"));
     String host = request.getParameter("host");
     int port = Integer.parseInt(request.getParameter("port"));
     String username = request.getParameter("username");
     String password = request.getParameter("password");
     int groupID = Integer.parseInt(request.getParameter("group"));
     int Timeinterval = Integer.parseInt(request.getParameter("interval"));
     int duration = Integer.parseInt(request.getParameter("duration"));
     
     ResourceMonitoring resourcemonitoring = new ResourceMonitoring(userId, host, port, username, password, groupID, Timeinterval, duration);
     
     try { 
    	 ResourceMonitoringService registerService = new ResourceMonitoringService();
         boolean result = registerService.registerService(resourcemonitoring);      
         if(result){
        	 request.setAttribute("successMessage", "User Created");
             RequestDispatcher rd = request.getRequestDispatcher("/monitor_config.jsp");
             rd.forward(request, response);
         }else{
        	 request.setAttribute("errorMessage", "User Not Created");
             RequestDispatcher rd = request.getRequestDispatcher("/monitor_config.jsp");
             rd.forward(request, response);
         }
         
     } finally {       
         out.close();
     }
	
	}	
}
