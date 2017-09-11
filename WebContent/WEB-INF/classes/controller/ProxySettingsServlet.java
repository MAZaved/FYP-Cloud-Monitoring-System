package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProxySettings;
import service.ProxySettingsService;

/**
 * Servlet implementation class ProxySettingsServlet
 */
@WebServlet("/ProxySettingsServlet")
public class ProxySettingsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProxySettingsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
		
     response.setContentType("text/html;charset=UTF-8");
     
     PrintWriter out = response.getWriter();
     
     int userID = Integer.parseInt(request.getParameter("userId"));
     String url = request.getParameter("url");
     String proxyType = request.getParameter("proxyType");
     int port = Integer.parseInt(request.getParameter("port"));
     String username = request.getParameter("username");
     String password = request.getParameter("password");
     
     ProxySettings proxysettings = new ProxySettings(userID, proxyType, url, port, username, password);
     
     try { 
    	 ProxySettingsService registerService = new ProxySettingsService();
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
         
     } finally {       
         out.close();
     }
	
	}
	

}
