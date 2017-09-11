package service;

/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class StartStopService implements Runnable {
	   public Thread t;
	   private String threadName;
	   boolean stop = false;
	   
	   private static StartStopService instance= null;
	   private static Object mutex= new Object();
	   
	   public StartStopService(){
	    }
	 
	   /**
	    * A singleton method for getting one instance of the object
	    * @return
	    */
	    public static StartStopService getInstance(){
	        if(instance==null){
	            synchronized (mutex){
	                if(instance==null) instance= new StartStopService();
	            }
	        }
	        return instance;
	    }
	 
	   /**
	    * Method for running a service monitor
	    * @param serviceMonitorId
	    * @param userId
	    * @param host
	    * @param port
	    * @param username
	    * @param password
	    * @param serviceName
	    * @param selectTool
	    * @param url
	    * @param timeInterval
	    * @param duration
	    * @param webUrl
	    */
	   public void runService(int serviceMonitorId, int userId, String host, int port, String username, String password,
			   String serviceName, String selectTool, String url, int timeInterval, int duration, String webUrl) {
		  stop = false;
	      System.out.println("First Running " +  threadName );
	      try {
	    	  
	    	  while(!stop) {
		         
		            synchronized(this) {
		            	System.out.println(serviceMonitorId + " "+ userId+ " "+ host+ " "+ port+ " "+ username+ " "+ password+ " "+ serviceName+ " "+ selectTool+ " "+
	    			 url+ " "+ timeInterval+ " "+ duration+ " "+webUrl);
		            	System.out.println("Server: Runnig.... " + stop + ", " );
		            	Thread.sleep(3000);
			            // Let the thread sleep for a while.
		            	System.out.println("Server: sleeping.... " + stop + ", " );
			            Thread.sleep(2000);
		            }
		          }
	         
	     } catch (InterruptedException e) {
	         System.out.println("Server " + " interrupted.");
	     }
	     System.out.println("Server... " + " exiting.");
	   }
	   
	   /**
	    * Method for running resource monitor
	    * @param resourceMonitorId
	    * @param userId
	    * @param host
	    * @param port
	    * @param username
	    * @param password
	    * @param url
	    * @param timeInterval
	    * @param duration
	    */
	   public void runResource(int resourceMonitorId, int userId, String host, int port, String username, String password,
			    String url, int timeInterval, int duration ) {
		  stop = false;
	      System.out.println("First Running " +  threadName );
	      try {
	    	  
	    	  while(!stop) {
		         
		            synchronized(this) {
		            	System.out.println(resourceMonitorId + " "+ userId+ " "+ host+ " "+ port+ " "+ username+ " "+ password+ " "+
	    			 url+ " "+ timeInterval+ " "+ duration);
		            	System.out.println("Server: Runnig.... " + stop + ", " );
		            	Thread.sleep(3000);
			            // Let the thread sleep for a while.
		            	System.out.println("Server: sleeping.... " + stop + ", " );
			            Thread.sleep(2000);
		            }
		          }
	         
	     } catch (InterruptedException e) {
	         System.out.println("Server " + " interrupted.");
	     }
	     System.out.println("Server... " + " exiting.");
	   }
	   
	   /**
	    * Method for starting thread
	    */
	   public void start ()
	   {
	      System.out.println("Starting " +  threadName );
	      if (t == null)
	      {
	         t = new Thread (this, threadName);
	         t.start ();
	      }
	   }
	   
	   /**
	    * Method for suspending thread
	    */
	   public void suspend() {
		   stop = true;
		   System.out.println(stop);
	   }
	   synchronized void resume() {
		   stop = false;
	       notify();
	   }

	@Override
	public void run() {
		// TODO Auto-generated method stub
		
	}
}