package controller;

import flotjf.*;

import java.util.Calendar;
import java.util.Random;
import java.util.TimeZone;
import database.DbClass;


/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class GetGraphData {

	/**
	 * Method for creating graph options
	 * @return chart data
	 */
	public static String getGraphOptions() {
		
		Chart chart = new Chart();
		
		Grid grid = new Grid();
		grid.setHoverable(true);
		chart.addGrid(grid);
	
		Axis yAxis = new Axis();
		yAxis.setMax(100D);
		chart.addYAxis(yAxis);

		Axis xAxis = new Axis();
		xAxis.setMode("time");
		chart.addXAxis(xAxis);
	
		return chart.printChartOptions();
	}
	

	/**
	 * Method for return real time graph data
	 * @param metricName name of the metric being graphed
	 * @return graph data
	 */
	public static String getGraph(String metricName) {
			Chart chart = new Chart();
		
			
			Calendar cal = Calendar.getInstance(TimeZone.getTimeZone("GMT+0000"));
			Calendar localCal = Calendar.getInstance();
			// Timespan in seconds
			Integer timeSpan = 300;
	
			Long endTime = cal.getTimeInMillis();
			// Adjust endTime
			endTime += localCal.getTimeZone().getOffset(cal.getTimeInMillis());
			Long startTime = endTime-(timeSpan*1000);
		
			PlotData sinPlot = new PlotData(metricName, null);
				
			// Create new random generator using seed 1
			Random rand = new Random();
			// Create sequence based on time to be used to retrieve numbers from random seed
			int startIntSeed = (int)Math.floor((startTime % 10000000) / 1000);
			// Forward to the current next random number
			for (int seq = 0; seq < startIntSeed; seq++) {
				rand.nextInt(100);
			}
			
			// Add marker every 2 sec between startTime and endTime
			for (int loop = 0; loop < timeSpan; loop+=2) {
				sinPlot.addPoint(startTime+(loop*1000), rand.nextInt(100));
			}
			
			
			System.out.println();
			chart.addElements(sinPlot);
		
			return chart.printChart();
		
	}
	
	


}
