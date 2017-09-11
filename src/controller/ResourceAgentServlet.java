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
import model.ResourceAgent;
import model.User;
import service.ResourceAgentService;
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class ResourceAgentServlet extends HttpServlet {
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
     response.setContentType("text/html;charset=UTF-8");

     HttpSession session = request.getSession();
     User user = (User) session.getAttribute("user");
     Logger log = new Logger();
     
     String updateAgent = request.getParameter("updateAgent");
     String removeAgent = request.getParameter("removeAgent");
     String addAgent = request.getParameter("addAgent"); 

     PrintWriter out = response.getWriter();
     
     int userID = Integer.parseInt(request.getParameter("userId"));
     String hostname = request.getParameter("hostname");
     int port = Integer.parseInt(request.getParameter("port"));
     int groupID = Integer.parseInt(request.getParameter("groupID"));

     try { 
    	 ResourceAgentService registerService = new ResourceAgentService();
    	//if the user created a Agent
    	 if(updateAgent == null && removeAgent == null)
    	 {

 		     log.log(user.getUsername(), "Created Agent", hostname );
    		 
    		 ResourceAgent resourceagent = new ResourceAgent(userID, hostname, port, groupID);
	         boolean result = registerService.registerService(resourceagent);      
	         if(result)
	         {
	        	 if(addAgent != null)
	        	 {
	        		 response.sendRedirect("monitor_management.jsp");
	        	 }
	        	 else
	        	 {
		        	 request.setAttribute("successMessage", "User Created");
		        	 RequestDispatcher rd = request.getRequestDispatcher("/monitor_config.jsp");
		             rd.forward(request, response);
	        	 }
	         }
	         else
	         {
	        	 if(addAgent != null)
	        	 {
	        		 response.sendRedirect("monitor_management.jsp");
	        	 }
	        	 else
	        	 {
	        		 request.setAttribute("errorMessage", "User Not Created");
		        	 RequestDispatcher rd = request.getRequestDispatcher("/monitor_config.jsp");
		             rd.forward(request, response);
	        	 }
	         }
	         
    	 }
    	//if the user updates a Agent
    	 else if(updateAgent != null)
         {
    		
 		     log.log(user.getUsername(), "Updated Agent", hostname );
    		 
        	 int agentID = Integer.parseInt(request.getParameter("agentID"));
    		 ResourceAgent resourceagent = new ResourceAgent(agentID, userID, hostname, port, groupID);
    		 boolean result = registerService.updateAgent(resourceagent);      
	         if(result)
	         {
	        	 response.sendRedirect("monitor_management.jsp");
	         }
	         else
	         {
	        	 response.sendRedirect("monitor_management.jsp");
	         }
         }
    	//if the user removed a Agent
         else if(removeAgent != null)
         {
        	
 		     log.log(user.getUsername(), "Removed Agent", hostname );
        	 
        	 int agentID = Integer.parseInt(request.getParameter("agentID"));
    		 ResourceAgent resourceagent = new ResourceAgent(agentID, userID, hostname, port, groupID);
        	 boolean result = registerService.removeAgent(resourceagent);      
	         if(result)
	         {
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
