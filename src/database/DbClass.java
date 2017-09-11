package database;

/**
 *
 * @author Shiny, @author  Michael Mullarkey(112457292)
 */
import java.sql.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

import javax.mail.MessagingException;
import javax.mail.internet.AddressException;

import model.ChartModel;
import model.EmailUtility;
public class DbClass 
{
    private Statement statementObject;
    private Connection connectionObject;
    //Connections to database
    private static final String HOST  = "localhost";
    private static final String DATABASE  = "2016_mm37";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";
   
    private static  List<ChartModel> CHART_MODELS;
    private boolean setup = false;
    public boolean queryCorrect = false;
    
    /**
     * Method for setting up the database connection
     * @return
     */
    public String setupDB()
    {
        String URL = "jdbc:mysql://" + HOST + "/" + DATABASE;
        System.out.println("Setting up DB");
        try 
        {// Initialiase drivers
            Class.forName("com.mysql.jdbc.Driver");
        } 
        catch (Exception exceptionObject) 
        {
            writeLogSQL(URL + " caused error " + exceptionObject.getMessage()+" Error dbclass.setup.1. ");
            return("Failed to load JDBC/ODBC driver. Error dbclass.setup.1 PLEASE report this error");
        }
        
        try 
        {
            // Establish connection to database
            connectionObject = DriverManager.getConnection(URL, USERNAME, PASSWORD);
            setup=true;
        } 
        catch (SQLException exceptionObject) 
        {
            writeLogSQL(URL + " caused error " + exceptionObject.getMessage()+" Error dbclass.setup.2");
            return("Problem with setting up " + URL+" Error dbclass.setup.2 PLEASE report this error");
        }

        return "";
    } 
    
    
    /**
     * Method for checking all alerts of the given user
     * @param userEmail - the users email
     * @param metric - name metric of the alert
     * @param num - the number of the threshold
     * @return
     * @throws AddressException
     * @throws MessagingException
     */
    public String checkAlerts(String userEmail, String metric, String num) throws AddressException, MessagingException
    {
    	String URL = "jdbc:mysql://" + HOST + "/" + DATABASE;
        
        try 
        {// Initialiase drivers
            Class.forName("com.mysql.jdbc.Driver");
        } 
        catch (Exception exceptionObject) 
        {
            writeLogSQL(URL + " caused error " + exceptionObject.getMessage()+" Error dbclass.setup.1. ");
            return("Failed to load JDBC/ODBC driver. Error dbclass.setup.1 PLEASE report this error");
        }
        
        try 
        {
        	if(connectionObject == null)
        	{
        		System.out.println("IT WAS NULL");
        		setupDB();
        	}

            Statement statementObject = connectionObject.createStatement();
            ResultSet statementResult = statementObject.executeQuery("SELECT * FROM INFRESOURCEMETRICS WHERE '" +metric+ "' > '" +num+ "' ");

            if( statementResult.next() )
            {
            	EmailUtility e = new EmailUtility();
            	e.sendEmail(userEmail, metric, num);
            }
        } 
        catch (SQLException exceptionObject) 
        {
            writeLogSQL(URL + " caused error " + exceptionObject.getMessage()+" Error dbclass.setup.2");
            return("Problem with setting up " + URL+" Error dbclass.setup.2 PLEASE report this error");
        }

        return "";
    }

    /**
     * Method for querying the data of a static chart between two dates
     * @param start
     * @param end
     * @return
     */
    public String writeStaticChart(String start, String end)
    {
    	try{
	    	setup=true;
    		if(connectionObject == null)
    		{
	    		System.out.println("IT WAS NULL");
	    		setupDB();
    		}
    	
            String vmName ="1432397156";
            
            Statement statementObject = connectionObject.createStatement();
            ResultSet statementResult = statementObject.executeQuery("SELECT * FROM INFRESOURCEMETRICS Where VMIP ='" + vmName + "' AND REPORTTIME BETWEEN '" + start + "' AND '" + end + "';");
            
            CHART_MODELS = new ArrayList<ChartModel>();
          
            while( statementResult.next() )
            {
                
                CHART_MODELS.add(new ChartModel(statementResult.getString(3), statementResult.getDouble(4)));
            }
    } catch (SQLException exceptionObject) {System.out.println("In Catch");}
       
       
        return "";
        
    }

    /**
     * Method for returning all chart data
     * @return
     */
    public static List<ChartModel> getHighChartDataList() {
        return CHART_MODELS;
    }
    
    /**
     * A method which checks if a query is true or not
     * @param query the query to be checked
     * @return a boolean if the query is true or not
     */
    public String checkQuery(String query)
    { 
        try 
        {
            // Establish connection to database
            setup=true;
            
            Statement st = connectionObject.createStatement(); 
            ResultSet rs = st.executeQuery(query); 
            
            if( rs.next() ) 
            { 
               queryCorrect = true;
            } 
 
        } catch (SQLException exceptionObject) {}

        return "";
    }
    
    
    /**
     * Get the length of a outputs from a query
     * @param query the query to be checked
     * @return int number
     */
    public int getLength(String query)
    {
        int rowcount = 0;
        
        try 
        {
            statementObject = connectionObject.createStatement();

            ResultSet statementResult = statementObject.executeQuery(query); //Should connection be left open?
            rowcount = 0;
            if (statementResult.last()) 
            {
                rowcount = statementResult.getRow();
                statementResult.beforeFirst(); // not rs.first() because the rs.next() below will move on, missing the first element
            }
        
        } catch (SQLException exceptionObject) {}
        
        return rowcount;
    }
    
    /**
     * Get all the rows from a query
     * @param query the query we want the data from
     * @param num the number of the result set we want
     * @return a list of the data from all the rows
     */
    public  ArrayList<String> outputAllRows(String query, int num)
    {
        ArrayList<String> list = new ArrayList<>();
        
        try 
        {// Make connection to database
           statementObject = connectionObject.createStatement();
           ResultSet statementResult = statementObject.executeQuery(query);

           while( statementResult.next() )
           {
               list.add(statementResult.getString(num));
           }
        } 
        catch (SQLException exceptionObject) {}
     
        return list;
    }
    
     public boolean issetup()
    {
        return setup;
    }
    
    public void Close()
    {
        try {
            // Establish connection to database
            connectionObject.close(); 
        }
        catch (SQLException exceptionObject)
        {
            System.out.println("Problem with closing up ");
            writeLogSQL("closing caused error " + exceptionObject.getMessage());
        }
    } //CloseDatabaseConnection

    public void Insert(String SQLinsert)
    {
        // Setup database connection details
        try {
            // Setup statement object
            statementObject = connectionObject.createStatement();

            // execute SQL commands to insert data
            statementObject.executeUpdate(SQLinsert);
            writeLogSQL(SQLinsert +" Executed OK");
            }
        catch (SQLException exceptionObject) {
            System.out.println(SQLinsert+" - Problem is : " + exceptionObject.getMessage());
            writeLogSQL(SQLinsert + " caused error " + exceptionObject.getMessage());
            }
    } // End Insert

   public String[] SelectRow(String SQLquery)
   {
        String Result[];
        // Send an SQL query to a database and return the *single column* result in an array of strings
        try 
        {   // Make connection to database
            statementObject = connectionObject.createStatement();

            ResultSet statementResult = statementObject.executeQuery(SQLquery); //Should connection be left open?

            ResultSetMetaData rsmd = statementResult.getMetaData();
            int nrOfColumns = rsmd.getColumnCount();

            Result = new String[nrOfColumns];

            statementResult.next();
            
            int currentCounter = 0;

            while (currentCounter<nrOfColumns) // While there are rows to process
            {
                // Get the first cell in the current row
                Result[currentCounter] = statementResult.getString(currentCounter+1);
                currentCounter++;
            }
            // Close the link to the database when finished 
        } 
        catch (Exception e) 
        {
            System.err.println("Select problems with SQL " + SQLquery);
            System.err.println("Select problem is " + e.getMessage());
            Result = new String[0]; //Need to setup result array to avoid initialisation error
            writeLogSQL(SQLquery + " caused error " + e.getMessage());
        
        }
        writeLogSQL(SQLquery + "worked ");
        
        return Result;
    } // End SelectRow
   
    public String[] SelectColumn(String SQLquery)
    {
        String Result[];
        // Send an SQL query to a database and return the *single column* result in an array of strings
        try 
        {// Make connection to database
            statementObject = connectionObject.createStatement(); //Should connection be left open?

            ResultSet statementResult = statementObject.executeQuery(SQLquery);

            // Start solution from http://www.coderanch.com/t/303346/JDBC/java/find-number-rows-resultset
            int rowcount = 0;
            if (statementResult.last()) {
                rowcount = statementResult.getRow();
                statementResult.beforeFirst(); // not rs.first() because the rs.next() below will move on, missing the first element
                }
            // End solution from http://www.coderanch.com/t/303346/JDBC/java/find-number-rows-resultset

            Result = new String[rowcount];

            int currentCounter = 0;

            while (statementResult.next()) // While there are rows to process
            {
                // Get the first cell in the current row
                Result[currentCounter] = statementResult.getString(1);
                currentCounter++;

            }
            // Close the link to the database when finished
        } 
        catch (Exception e) 
        {
            System.err.println("Select problems with SQL " + SQLquery);
            System.err.println("Select problem is " + e.getMessage());
            Result = new String[0]; //Need to setup result array to avoid initialisation error
            writeLogSQL(SQLquery + " caused error " + e.getMessage());
        }
        
        writeLogSQL(SQLquery + "worked ");
        return Result;
    } // End Select

    public void writeLogSQL(String message) 
    {
        PrintStream output;
        try 
        {
            output = new PrintStream(new FileOutputStream("sql-logfile.txt", true));
            output.println(new java.util.Date() + " " + message);
            System.out.println(new java.util.Date() + " " + message);
            output.close();
        } catch (IOException ieo) {}
    } // End writeLog

    public static String getHost()
    {
        return HOST;
    }
    
    public static String getDatabase()
    {
        return DATABASE;
    }
    
    public static String getUser()
    {
        return USERNAME;
    }
    
    public static String getPassword()
    {
        return PASSWORD;
    }
    
} //End dblib
