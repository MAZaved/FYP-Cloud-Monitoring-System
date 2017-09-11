package model;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;

import com.sun.java.util.*;
import com.sun.xml.internal.bind.CycleRecoverable.Context;
/**
 * 
 * @author Michael Mullarkey (112457292)
 *
 */
public class Logger {

	/**
	 * Method for logging all user activity 
	 * @param user - the user 
	 * @param action - the action the user made
	 * @param actionName - the action itself 
	 */
	public void log(String user, String action, String actionName){
		
		String formattedDate;
		Calendar c = Calendar.getInstance();    
		    SimpleDateFormat df = new SimpleDateFormat("E yyyy-MM-dd 'at' hh:mm:ss a ");
		    formattedDate = df.format(c.getTime());
		   
		    try {
		    	String filename = user + ".txt";
		    	String absoluteFilePath = "";
		    	//Gets the root directory
		    	
		    	//When ran in eclipse this saves files in the eclipse programs folder, if ran outside of eclipse it will save file to the current directory	
				String  workingDirectory = System.getProperty("user.dir");
				
				absoluteFilePath = workingDirectory + File.separator + filename;
				
				System.out.println("Final filepath : " + absoluteFilePath);

				

				File file = new File(absoluteFilePath);

				// if file doesn't exists, then create it
				if (!file.exists())
				{
					file.createNewFile();
				}

				FileWriter fw = new FileWriter(file.getAbsoluteFile(), true);
				BufferedWriter bw = new BufferedWriter(fw);
				bw.newLine();
				bw.write("'"+ action+"':'"+ actionName+"' at :"+formattedDate+"" );
				bw.close();

				

			} catch (IOException e) {
				e.printStackTrace();
			}

	}
	
	/**
	 * Method for reading and presenting the users activity logs
	 * @param user 
	 * @return
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public String read(String user, String action) throws FileNotFoundException, IOException {
		String filename = user + ".txt";
    	String absoluteFilePath = "";
		String  workingDirectory = System.getProperty("user.dir");
		ArrayList<String> create = new ArrayList<String>();
		ArrayList<String> logged = new ArrayList<String>();
		ArrayList<String> updated = new ArrayList<String>();
		ArrayList<String> removed = new ArrayList<String>();
		
		
		//absoluteFilePath = workingDirectory + System.getProperty("file.separator") + filename;
		absoluteFilePath = workingDirectory + File.separator + filename;
		try(BufferedReader br = new BufferedReader(new FileReader(absoluteFilePath))) {
		    StringBuilder sb = new StringBuilder();
		    String line = br.readLine();
		    
		    while (line != null) {
		    	
		    	
		    	String arr[] = line.split(" ");
		    	String firstWord = arr[0];
		    	if(firstWord.equals("'Created"))
		        {
		        	
		        	create.add(line);
		        	
		        }
		    	
		    	else if(firstWord.equals("'Logged"))
		        {
		        	
		        	logged.add(line);
		        	
		        }
		    	
		    	else if(firstWord.equals("'Updated"))
		        {
		        	
		        	updated.add(line);
		        	
		        }
		    	
		    	else if(firstWord.equals("'Removed"))
		        {
		        	
		        	removed.add(line);
		        	
		        }
		    	
		    
		        line = br.readLine();
 
		    }
		    
		    
		   if(action=="logged")
		   {
		        for(String d : logged)
		        {
		        	sb.append("<p style='font-size: 80%'>");
			        sb.append(d);
			        sb.append("</p>");
		        }
		   }
		    
		    
		   else if(action=="create")
	        {
		        for(String d : create)
		        {
		        	sb.append("<p style='font-size: 80%'>");
			        sb.append(d);
			        sb.append("</p>");
		        	
		        }
	        }  
		        
	
		   else if(action=="update")
	        {
		        for(String d : updated)
		        {
		        	sb.append("<p style='font-size: 80%'>");
			        sb.append(d);
			        sb.append("</p>");
	
		        }
	        }
		        
		        
		        
		   else if(action=="remove")    
		    {
		        for(String d : removed)
		        {
		        	sb.append("<p style='font-size: 80%'>");
			        sb.append(d);
			        sb.append("</p>");
	
		        }
		    }
		    
		    
		    String everything = sb.toString();
		    return everything;
		} 
	}
}
