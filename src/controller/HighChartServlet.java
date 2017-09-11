package controller;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.List;
import database.DbClass;
import javax.servlet.Servlet;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import model.ChartModel;

 
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class HighChartServlet extends HttpServlet {
  private static final long serialVersionUID = 1L;
  List<ChartModel> chartModels;
  String startDate= "";
  String endDate = "";
  DbClass db = new DbClass();
  
  public HighChartServlet() {
	
  }
  
  /**
   * Gets the chart data from the database between the two date
   * @param startDate
   * @param endDate
   */
  public void getChart(String startDate, String endDate) {
		db.writeStaticChart(startDate, endDate);
	    chartModels = db.getHighChartDataList() ;
  }
 
  @Override
  public void init(ServletConfig config) throws ServletException {}
 

  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    doPost(request, response);
  }
 
  /**
   * Method for returning the chart data in JSON format
   */
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String json = "";
    String dateTo = request.getParameter("dateTo");
    String dateFrom = request.getParameter("dateFrom");
    
    
    	getChart(dateTo, dateFrom);
      
      int counter = 1;
      if (chartModels != null) {
        json += "[";
      }
      for (ChartModel chartModel : chartModels) {
        
          json += "[" + chartModel.getDate() + "," + chartModel.getCpuIdle() 
              + "]";
          if (counter < chartModels.size()) {
            json += ",";
          }
          counter++;
        
      }
      if (chartModels != null) {
        json += "]";
      }
      if (chartModels == null) {
        json = "No record found";
      }
    
    System.out.println(json);
    response.getWriter().write(json);
  }
  
}