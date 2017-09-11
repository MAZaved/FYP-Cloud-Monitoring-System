package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ResourceAgent;
import service.ResourceAgentService;

public class ResourceAgentServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
     response.setContentType("text/html;charset=UTF-8");
     
     PrintWriter out = response.getWriter();
     
     int userID = Integer.parseInt(request.getParameter("userId"));
     String hostname = request.getParameter("hostname");
     int proxyType = Integer.parseInt(request.getParameter("proxyType"));
     int port = Integer.parseInt(request.getParameter("port"));
     int groupID = Integer.parseInt(request.getParameter("groupID"));
     
     
     ResourceAgent resourceagent = new ResourceAgent(userID, hostname, port, groupID);
     
     try { 
    	 ResourceAgentService registerService = new ResourceAgentService();
         boolean result = registerService.registerService(resourceagent);      
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
