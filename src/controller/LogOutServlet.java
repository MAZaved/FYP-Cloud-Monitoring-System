package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import model.Logger;
import model.User;
import service.LoginService;
 
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */ 
public class LogOutServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    	HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		Logger log = new Logger();
    	
		//if the user logs out
    	if (request.getParameter("logout") != null) {    
    		
		    log.log(user.getUsername(), "Logged Out","" );
    		session.removeAttribute("username");
            session.removeAttribute("password");
    	    session.invalidate();

    	    response.sendRedirect("index.jsp");

    	}
    }
}
