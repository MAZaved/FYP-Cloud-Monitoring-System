package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.User;
import service.LoginService;
 
 
public class LogOutServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	HttpSession session = request.getSession();
    	
    	if (request.getParameter("logout") != null) {
    		session.removeAttribute("username");
            session.removeAttribute("password");
    	    session.invalidate();
    	    response.sendRedirect("index.jsp");
    	    return; // <--- Here.
    	}
    }
}
