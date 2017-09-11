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
import model.Security;
import service.LoginService;
 
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class LoginServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
    	 HttpSession session = request.getSession();
   	     User userSession = (User) session.getAttribute("user");
   	     
    	 Logger log = new Logger();
    	 Security sec = new Security();
    	 
	     String username = request.getParameter("username");   
	     String password = request.getParameter("password");
	     LoginService loginService = new LoginService();
	     
	     String secure_password = sec.SHA_256_SecurePassword(password);
	     //check if user is valid
	     boolean result = loginService.authenticateUser(username, secure_password);
	     User user = loginService.getUserByUserId(username);
	     
	     //if the user successfully logs in
	     if(result == true){
	         request.getSession().setAttribute("user", user);      
	         response.sendRedirect("index.jsp");
	         
	         
		     log.log(user.getUsername(), "Logged In","" );
	     }
	     else
	     {
	    	 request.setAttribute("errorMessage", "Invalid user or password");
             RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
             rd.forward(request, response);   
	     }
    }
}

