//Validates all the Conditions and Constraints 


package Func;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
public class Validator {
	
	static String jdbcClassName = "com.ibm.db2.jcc.DB2Driver";
	static String jdbcUrl = "jdbc:db2://9.30.161.135:50001/RS"; //"jdbc:db2://9.30.161.135:50000/";
	static String jdbcUserName = "db2inst1"; //"db2user";
	static String jdbcPassword = "db@inst!";//"db2user@";
	static String jdbcSchemaName = "RS";
	static String FTPServerUrl = "209.95.232.130";
	static int FTPPortNo = 21;
	
	public static String ResultNames="",ResultConds="";
	
	
	Connection con;
    Statement stmt;
    ResultSet rs;
    
    
    String ExistCondSql="", ExistNameSql="";
    
    
   
    Queries sql=new Queries();
    
	
	
	//Returns Error number and the respective message 
	public HashMap<Integer,String> checkRuleValidity(String condFieldName[],String operator[],String[] fieldvalue, String isEn, String isDef,String RuleSet,String name,String Alias, String[] Action)
	{
		
		boolean error=false;
		HashMap <Integer, String> errorState=new  HashMap <Integer, String>();
		
		int ERROR_COUNT=0;
		
		ExistCondSql=sql.getConditionQuery(condFieldName,fieldvalue,operator);
		ExistNameSql=sql.getExactNameQuery(name);
		
		
		
		
		ExistCondSql+= " AND RULES.BUSINESSALIAS='"+Alias+"'";
		ExistNameSql+= " AND RULES.BUSINESSALIAS='"+Alias+"'";
		
		
		//Condition 1
		if(!isDef.equals("Default") && !isEn.equals("ON"))
		{
			System.out.println("**Default and Enabled Both not Selected!!!**");
			
			error=true;
			errorState.put(ERROR_COUNT++,"Enabled and Default both not selected, select atleast one of the two");
			
			
		}
		
		
		//Condition 2
		if(isDef.equals("Default"))
		{
			
			if(condFieldName.length>0 && condFieldName[0].length()>1)
			{
				System.out.println("**Defaults checked with Conditions**");
				error=true;
				errorState.put(ERROR_COUNT++, " A rule if set as default should not have any conditions.");
								
			}
		}
		
	
		else if(condFieldName.length>0)
		{
			for(int i=0;i<operator.length;i++)
			{
			if(operator[i].equals("NE"))
				error=true;
			else
				{
				error=false;
				break;
				}
			
			}
			
			if(error==true)
			errorState.put(ERROR_COUNT++," A rule should not have only != as condition operator");
		}
		
		
		
		
		
		//Condition 3
		 if(!(isDef.equals("Default")) && isEn.equals("ON"))
	    {
			if(condFieldName[0].length()==0)
			{
				error=true;
				errorState.put(ERROR_COUNT++," A rule if enabled and not default should have at least one condition");
								
			}
			
	     }
		
		 int actionFlag=0;
		 
		//Condition 4
		 if(!RuleSet.startsWith("BPN_Receive"))
		 {
			 
			 
			 for(int i=0;i<Action.length;i++)
			 {
				 
				 if(Action[i].endsWith("Track"))
				 {

					 actionFlag=1;
					 break;
				 }
				 
			 }
			 
			 if(actionFlag==1)
			   errorState.put(ERROR_COUNT++,"A rule should have tracking RuleSet enabled only in a rule under BPN_Receive* ruleset.");

			
		 }
		 
		 
		 
		
		 
		 try {
			 
	//-----------------------------------CONNECTION ----------------------------------------------------------//

			   System.out.println("DB2 Connection for Existing Rules Establishing...");
		        // Load the driver
		        Class.forName("com.ibm.db2.jcc.DB2Driver");                             
		        System.out.println("*** Loaded the JDBC driver");

		        // Create the connection using the IBM Data Server Driver for JDBC and SQLJ
		        con = DriverManager.getConnection (jdbcUrl, jdbcUserName, jdbcPassword);                
		        // Commit changes manually
		        con.setAutoCommit(false);
		        System.out.println("**** Created a JDBC connection to the data source");

		        // Create the Statement
		        stmt = con.createStatement();                                           
		        System.out.println("**** Created JDBC Statement object");
		        
	//--------------------------------CONNECTION COMPLETED----------------------------------------------------------//
		        
		       
		        rs=stmt.executeQuery(ExistNameSql);
		        
		        
		        
		        
		        int count=0;
		        
		        ResultNames="";
		        while(rs.next())
		        {
		        count++;
		        ResultNames+=rs.getString(1)+",";
		        }
		        
		      //Condition 5- Similar existing rule under the same Alias
		        if(count!=0)
		        {
					errorState.put(ERROR_COUNT++, " Rule(s) with same Name under the Same Business Alias Exist!");

		        }
		        
		        count=0;
		        
		        
		        System.out.println(ExistCondSql);
		        if(ExistCondSql.contains("FIELDNAME")) {
		        ResultConds="";
		        rs=stmt.executeQuery(ExistCondSql);
		       
		        while(rs.next())
		        {
		        count++;
		        System.out.println(rs.getString(1));
		        ResultConds+=rs.getString(1)+",";
		        }
		        
		        
		        }else {
		        	
		        	
		        }
		      //Condition 6 Similar existing Conditions under the same Alias
		        if(count!=0)
		        {
					errorState.put(ERROR_COUNT++, " Rule(s) with same Condition(s) under the same Business Alias Exist!");

		        }
		        
		        rs.close();
		        
		        
		        
		        
			 
		 } catch (ClassNotFoundException e)
		    {
		      System.err.println("Could not load JDBC driver");
		      System.out.println("Exception: " + e);
		      e.printStackTrace();
		    }
		   
		   catch(SQLException ex)                                                     
		    {
		      System.err.println("SQLException information");
		      while(ex!=null) {
		        System.err.println ("Error msg: " + ex.getMessage());
		        System.err.println ("SQLSTATE: " + ex.getSQLState());
		        System.err.println ("Error code: " + ex.getErrorCode());
		        ex.printStackTrace();
		        ex = ex.getNextException(); // For drivers that support chained exceptions
		      }}

		 
		 
		 
		 
		 
		 
		
		if(error)
		{
			
			return errorState;
		}
		
		return errorState;
		
		
	}
	

}
