package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Logger;
import model.ProxySettings;
import model.User;
import service.ProxySettingsService;
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class ProxySettingsServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
     response.setContentType("text/html;charset=UTF-8");
     
     HttpSession session = request.getSession();
     User user = (User) session.getAttribute("user");
     Logger log = new Logger();
     
     PrintWriter out = response.getWriter();
     String updateProxy = request.getParameter("updateProxy");
     String removeProxy = request.getParameter("removeProxy");
     
     
     int userID = Integer.parseInt(request.getParameter("userId"));
     String url = request.getParameter("url");
     String proxyType = request.getParameter("proxyType");
     int port = Integer.parseInt(request.getParameter("port"));
     String username = request.getParameter("username");
     String password = request.getParameter("password");
     
     try { 
    	 ProxySettingsService registerService = new ProxySettingsService();
    	//if the user created a Proxy setting
    	 if(updateProxy == null && removeProxy == null)
    	 {
    		
 		     log.log(user.getUsername(), "Created Proxy Settings", url );
    		 
    		 ProxySettings proxysettings = new ProxySettings(userID, proxyType, url, port, username, password);
    		 boolean result = registerService.registerService(proxysettings);      
	    	      
	         if(result){
	        	 request.setAttribute("successMessage", "User Created");
	             RequestDispatcher rd = request.getRequestDispatcher("/monitor_config.jsp");
	             rd.forward(request, response);
	         }else{
	        	 request.setAttribute("errorMessage", "User Not Created");
	             RequestDispatcher rd = request.getRequestDispatcher("/monitor_config.jsp");
	             rd.forward(request, response);
	         }
         
    	 }
    	//if the user updated a Proxy setting
    	 else if(updateProxy != null)
    	 {
    	
 		     log.log(user.getUsername(), "Updated Proxy Settings", url );
    		 
    		 int proxyID = Integer.parseInt(request.getParameter("proxyId"));
    	     ProxySettings proxysettings = new ProxySettings(proxyID, userID, proxyType, url, port, username, password);
    	     boolean result = registerService.updateProxy(proxysettings);      
	         if(result)
	         {
	        	 response.sendRedirect("monitor_management.jsp");
	         }
	         else
	         {
	        	 response.sendRedirect("monitor_management.jsp");
	         }
    	 }
    	//if the user removed a Proxy setting
    	 else if(removeProxy != null)
    	 {
    		 
    	
 		     log.log(user.getUsername(), "Removed Proxy Settings", url );
 		     
    		 int proxyID = Integer.parseInt(request.getParameter("proxyId"));
    	     ProxySettings proxysettings = new ProxySettings(proxyID, userID, proxyType, url, port, username, password);
    	     boolean result = registerService.removeProxy(proxysettings);      
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
