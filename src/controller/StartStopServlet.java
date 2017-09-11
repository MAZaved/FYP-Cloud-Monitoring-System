package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Logger;
import model.User;
import service.StartStopService;
 
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class StartStopServlet extends HttpServlet {
	
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	
    	 HttpSession session = request.getSession();
         User user = (User) session.getAttribute("user");
         Logger log = new Logger();
        
    	 StartStopService service = new StartStopService();
	     String StartResource = request.getParameter("StartResource");
	     String StopResource = request.getParameter("StopResource");
	     
	     String StartService = request.getParameter("StartService");
	     String StopService = request.getParameter("StopService");
	     
	     int userId = Integer.parseInt(request.getParameter("userId"));
	     String host = request.getParameter("host");
	     int port = Integer.parseInt(request.getParameter("port"));
	     String username = request.getParameter("username");
	     String password = request.getParameter("password");
	     String url = request.getParameter("url");
	     int timeInterval = Integer.parseInt(request.getParameter("interval"));
	     int duration = Integer.parseInt(request.getParameter("duration"));
	     
	     String page = request.getParameter("page");
	     
	     //if the user started the service monitor
	     if(StartService != null)
	     {
	    	 int serviceMonitorId = Integer.parseInt(request.getParameter("serviceMonitorId"));
	    	 String serviceName = request.getParameter("serviceName");
		     String selectTool = request.getParameter("selectTool");
		     String webUrl = request.getParameter("webUrl");
	    	 System.out.println("Start Button Pressed");
	    	 
	    	 log.log(user.getUsername(), "Started Service", serviceName );
	    	 
	    	 service.getInstance().runService(serviceMonitorId, userId, host, port, username, password, serviceName, selectTool,
	    			 url, timeInterval, duration, webUrl);
	         request.setAttribute("startedMessage", "Started");
             RequestDispatcher rd = request.getRequestDispatcher("/" +page);
             rd.forward(request, response);
	     }
	     
	     //if the user stopped the service monitor
	     if(StopService != null)
	     {
	    	 String serviceName = request.getParameter("serviceName");
	    	 System.out.println("Stop Button Pressed");
	    	 
	    	 log.log(user.getUsername(), "Removed Service", serviceName );
	    	 
	    	 service.getInstance().suspend();
	    	 request.setAttribute("stoppedMessage", "Stoped");
             RequestDispatcher rd = request.getRequestDispatcher("/" +page);
             rd.forward(request, response);
	     }
	     
	   //if the user started the resource monitor
	     if(StartResource != null)
	     {
	    	 int resourceMonitorId = Integer.parseInt(request.getParameter("resourceMonitorId"));
	    	 System.out.println("Start Button Pressed");
	    	 
	    	 log.log(user.getUsername(), "Started Resource", host );
	    	 
	    	 service.getInstance().runResource(resourceMonitorId, userId, host, port, username, password,
	    			 url, timeInterval, duration);
	         request.setAttribute("startedMessage", "Started");
             RequestDispatcher rd = request.getRequestDispatcher("/" +page);
             rd.forward(request, response);
	     }
	   //if the user stopped the resource monitor
	     if(StopResource != null)
	     {
	    	 System.out.println("Stop Button Pressed");
	    	 
	    	 log.log(user.getUsername(), "Stopped Resource", host );
	    	 
	    	 service.getInstance().suspend();
	    	 request.setAttribute("stoppedMessage", "Stoped");
             RequestDispatcher rd = request.getRequestDispatcher("/" +page);
             rd.forward(request, response);
	     }
    }
}
