package model;

import java.text.SimpleDateFormat;
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class ChartModel {

		private String vm_id;
		private String reportTime;
		private double cpuIdle;
		private String date;

	  public ChartModel( String date, double cpuIdle) {
			this.date = date;
			this.vm_id = vm_id;
			this.cpuIdle = cpuIdle;
		}
	  
	    public String getDate() {
		    return date;
		}
		 
	    public void setDate(String date) {
		    this.date = date;
	    }
		
		public String getVm_id() {
			return vm_id;
		}
		public void setVm_id(String vm_id) {
			this.vm_id = vm_id;
		}
		public String getReportTime() {
			return reportTime;
		}
		public void setReportTime(String reportTime) {
			this.reportTime = reportTime;
		}
		
		public String getConvertedDate(){
			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy");
			return sdf.format(reportTime);	
		}
		
		public String getConvertedTime(){
			SimpleDateFormat sdf = new SimpleDateFormat("hh:mm:ss");
			return sdf.format(reportTime);	
		}
		public double getCpuIdle() {
			return cpuIdle;
		}
		public void setCpuIdle(double cpuIdle) {
			this.cpuIdle = cpuIdle;
		}
}

