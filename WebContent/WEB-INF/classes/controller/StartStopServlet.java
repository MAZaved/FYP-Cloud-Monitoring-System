package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import service.StartStopService;
 
 
public class StartStopServlet extends HttpServlet {
	
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	 StartStopService service = new StartStopService();
	     String startButton = request.getParameter("StartServlet");
	     String stopButton = request.getParameter("StopServlet");
	     
	     int serviceMonitorId = Integer.parseInt(request.getParameter("serviceMonitorId"));
	     int userId = Integer.parseInt(request.getParameter("userId"));
	     String host = request.getParameter("host");
	     int port = Integer.parseInt(request.getParameter("port"));
	     String username = request.getParameter("username");
	     String password = request.getParameter("password");
	     String serviceName = request.getParameter("serviceName");
	     String selectTool = request.getParameter("selectTool");
	     String url = request.getParameter("url");
	     int timeInterval = Integer.parseInt(request.getParameter("timeInterval"));
	     int duration = Integer.parseInt(request.getParameter("duration"));
	     String webUrl = request.getParameter("webUrl");
	     
	     if(startButton != null)
	     {
	    	 System.out.println("Start Button Pressed");
	    	 service.getInstance().run(serviceMonitorId, userId, host, port, username, password, serviceName, selectTool,
	    			 url, timeInterval, duration, webUrl);
	         request.setAttribute("startedMessage", "Started");
             RequestDispatcher rd = request.getRequestDispatcher("/monitor_management.jsp");
             rd.forward(request, response);
	     }
	     
	     if(stopButton != null)
	     {
	    	 System.out.println("Stop Button Pressed");
	    	 service.getInstance().suspend();
	    	 request.setAttribute("stoppedMessage", "Stoped");
             RequestDispatcher rd = request.getRequestDispatcher("/monitor_management.jsp");
             rd.forward(request, response);
	     }
    }
    
}
