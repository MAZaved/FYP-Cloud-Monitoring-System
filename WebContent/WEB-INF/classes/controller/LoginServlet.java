package controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.User;
import service.LoginService;
 
 
public class LoginServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 
	     String username = request.getParameter("username");   
	     String password = request.getParameter("password");
	     LoginService loginService = new LoginService();
	     boolean result = loginService.authenticateUser(username, password);
	     User user = loginService.getUserByUserId(username);
	     if(result == true){
	         request.getSession().setAttribute("user", user);      
	         response.sendRedirect("index.jsp");
	     }
	     else
	     {
	    	 request.setAttribute("errorMessage", "Invalid user or password");
             RequestDispatcher rd = request.getRequestDispatcher("/index.jsp");
             rd.forward(request, response);   
	     }
    }
}

