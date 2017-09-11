package controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;



/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class GetGraph extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	/* 
	 * doPost method for return graph data
	 * (non-Javadoc)
	 * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String metricName = request.getParameter("metricName");

		response.setContentType("application/json");
		PrintWriter out = response.getWriter();
		
		out.println(GetGraphData.getGraph(metricName));
	
		out.close();
	}

}
