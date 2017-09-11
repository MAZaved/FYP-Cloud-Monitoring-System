package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.User;
import service.RegisterService;
 
 
public class RegisterServlet extends HttpServlet {

	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
     response.setContentType("text/html;charset=UTF-8");
     PrintWriter out = response.getWriter();
     String username = request.getParameter("username");
     String password = request.getParameter("password");
     String email = request.getParameter("email");
     User user = new User(username, password, email);
             
     try { 
         RegisterService registerService = new RegisterService();
         boolean result = registerService.register(user);      
         if(result){
        	 request.setAttribute("successMessage", "User Created");
             RequestDispatcher rd = request.getRequestDispatcher("/user_config.jsp");
             rd.forward(request, response);
         }else{
        	 request.setAttribute("errorMessage", "User Not Created");
             RequestDispatcher rd = request.getRequestDispatcher("/user_config.jsp");
             rd.forward(request, response);
         }
         
     } finally {       
         out.close();
     }
}
 
}

