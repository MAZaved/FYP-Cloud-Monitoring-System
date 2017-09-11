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
import model.ServiceMonitoring;
import model.User;
import model.Security;
import service.RegisterService;
 
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class RegisterServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
	 HttpSession session = request.getSession();
	 User userSession = (User) session.getAttribute("user");
	 Logger log = new Logger();
	 Security sec = new Security();
	 
	 String updateUser = request.getParameter("updateUser");
     String removeUser = request.getParameter("removeUser");
     response.setContentType("text/html;charset=UTF-8");
     PrintWriter out = response.getWriter();
     
     String username = request.getParameter("username");
     String password = request.getParameter("password");
     String email = request.getParameter("email");
     String userType = request.getParameter("userType");
     
     String secure_password = sec.SHA_256_SecurePassword(password);
     
     System.out.println(userType);
           
     try { 
         RegisterService registerService = new RegisterService();
         
         //if the user created a User
         if(updateUser == null && removeUser == null)
    	 {
         
        	 User user = new User(username, secure_password, email, userType);
	         boolean result = registerService.register(user);   
	         
	         if(result){
	        	 
	        	 if(userSession == null)
	        	 {
	 		     log.log("Super User", "Registered User", username );
	        	 }
	        	 else
	        	 {
	        		 log.log(userSession.getUsername(), "Registered User", username );
	        	 }
	 		    log.log(username, "First Created", "" );
	 		     
	        	 request.setAttribute("successMessage", "User Created");
	             RequestDispatcher rd = request.getRequestDispatcher("/user_config.jsp");
	             rd.forward(request, response);
	         }else{
	        	 request.setAttribute("errorMessage", "User Not Created");
	             RequestDispatcher rd = request.getRequestDispatcher("/user_config.jsp");
	             rd.forward(request, response);
	         }
    	 }
       //if the user updated a User
         else if(updateUser != null)
    	 {
    		 
        	 int userId = Integer.parseInt(request.getParameter("userId"));
        	 User user = new User(userId, username, secure_password, email, userType);
    		 boolean result = registerService.updateUser(user);      
	         if(result)
	         {
	        	 
	        	 
	 		     log.log(userSession.getUsername(), "Updated user", username );
	 		     
	        	 response.sendRedirect("user_management.jsp");
	         }
	         else
	         {
	        	 response.sendRedirect("user_management.jsp");
	         }
    	 }
       //if the user removed a User
    	 else if(removeUser != null)
    	 {
    		 int userId = Integer.parseInt(request.getParameter("userId"));
    		 User user = new User(userId, username, secure_password, email, userType);
    		 boolean result = registerService.removeUser(user);      
	         if(result)
	         {
	 		     log.log(userSession.getUsername(), "Removed User", username );
	 		     
	        	 response.sendRedirect("user_management.jsp");
	         }
	         else
	         {
	        	 response.sendRedirect("user_management.jsp");
	         }
    	 }
         
     } finally {       
         out.close();
     }
}
 
}

