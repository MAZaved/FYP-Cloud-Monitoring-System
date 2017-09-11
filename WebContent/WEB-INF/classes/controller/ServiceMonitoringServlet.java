package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ServiceMonitoring;
import service.ServiceMonitoringService;

public class ServiceMonitoringServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
     response.setContentType("text/html;charset=UTF-8");
     
     PrintWriter out = response.getWriter();
     
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
     
     ServiceMonitoring servicemonitoring = new ServiceMonitoring(userId, host, port, username, password, serviceName, selectTool, url, interval, duration, webUrl);
     
     try { 
    	 ServiceMonitoringService registerService = new ServiceMonitoringService();
         boolean result = registerService.registerService(servicemonitoring);      
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
