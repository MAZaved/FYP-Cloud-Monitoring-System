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
public class GetGraphOptions extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * doPost method for returning graph data
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		PrintWriter out = response.getWriter();

		out.println(GetGraphData.getGraphOptions());

		out.close();
	}
}
