//Connection to DB2 server 

package Func;
import java.sql.*;
//THIS FILE IS REQUIRED TO FETCH THE VALUES FROM DB2
import java.util.HashMap;
import java.util.Map;


public class DB2Connection {
	static String jdbcClassName = "com.ibm.db2.jcc.DB2Driver";
	static String jdbcUrl = "jdbc:db2://9.30.161.135:50001/RS"; //"jdbc:db2://9.30.161.135:50000/";
	static String jdbcUserName = "db2inst1"; //"db2user";
	static String jdbcPassword = "db@inst!";//"db2user@";
	static String jdbcSchemaName = "RS";
	static String FTPServerUrl = "209.95.232.130";
	static int FTPPortNo = 21;

	 Connection con;
     Statement stmt;
     ResultSet rs,rs_temp;
   
	
	public void getConnection()
	{
		
	    
	   try {
	                        
//-----------------------------------CONNECTION ----------------------------------------------------------//
		   
	       
	        // Load the driver
	        Class.forName("com.ibm.db2.jcc.DB2Driver");                             
	        //System.out.println("**** Loaded the JDBC driver");

	        // Create the connection using the IBM Data Server Driver for JDBC and SQLJ
	        con = DriverManager.getConnection (jdbcUrl, jdbcUserName, jdbcPassword);                
	        // Commit changes manually
	        con.setAutoCommit(false);
	        //System.out.println("**** Created a JDBC connection to the data source");

	        // Create the Statement
	        stmt = con.createStatement();                                           
 	        //System.out.println("**** Created JDBC Statement object");
	        
	        System.out.println("Connection Establieshed to DB2 Server");

	        
//--------------------------------CONNECTION COMPLETED----------------------------------------------------------//
	        
	        
	    }
	   catch (ClassNotFoundException e)
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
	   
	}
	
	
//------------------ Searching Functions-------------------//	
	
	public String searchByName(String search)
	{
		String  name;
		String res="NONE";
		
		if(search.length()==0)
	    {
	    	return "NONE";
	    	
	    }
	     
		
	
		try {
			
			
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("SELECT DISTINCT RULENAME FROM RULES WHERE LENGTH(RULEID)>1 AND RULENAME LIKE '%"+search+"%'");    
          
	    
	       
	        //LOGIC
	        while(rs.next())
	        {
	        	if(res.equals("NONE"))
	        		res="";
	        	name=rs.getString(1);
	        		res+=name+",";
	        }
		
	        return res;
		
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
		
		return res;
		
	}
	
	public String searchByAlias(String search) throws SQLException
	{
		String  name;
		String res="NONE";
	
		if(search.length()==0)
	    {
	    	return "NONE";
	    	
	    }
		
		
		
	
		try {
			 // Execute a query and generate a ResultSet instance
	        rs = stmt.executeQuery("SELECT DISTINCT RULENAME FROM RULES WHERE LENGTH(RULEID)>1 AND RULES.BUSINESSALIAS LIKE '%"+search+"%'");    
          
	        //LOGIC
	        while(rs.next())
	        {
	        	if(res.equals("NONE"))
	        		res="";
	        	name=rs.getString(1);
	        		res+=name+",";
	        		
	        }
		
		
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
		
		return res;
		
	}
	
	public String searchByRuleId(String search)
	{
		String  name;
		String res="NONE";
	
		if(search.length()==0)
	    {
	    	return "NONE";
	    	
	    }
		
	
		try {
			 // Execute a query and generate a ResultSet instance
	        rs = stmt.executeQuery("SELECT DISTINCT RULENAME FROM RULES WHERE LENGTH(RULEID)>1 AND RULES.RULESETID='"+search+"'");    
          
	        //LOGIC
	        while(rs.next())
	        {
	        	if(res.equals("NONE"))
	        		res="";
	        	name=rs.getString(1);
	        		res+=name+",";
	        		
	        		
	        }
		
		
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
		
		return res;
		
	}

	public String searchByRuleSet(String search)
	{
		String  name;
		String res="NONE";
	
		if(search.length()==0)
	    {
	    	return "NONE";
	    	
	    }
		
	
		try {
			 // Execute a query and generate a ResultSet instance
	rs = stmt.executeQuery("select DISTINCT RULES.RULENAME from RULES FULL OUTER JOIN RULESET ON RULES.RULESETID=RULESET.RULESETID"
			+ " where RULESET.RULESETNAME LIKE '%"+search+"%'");
  
          
	        //LOGIC
	        while(rs.next())
	        {
	        	if(res.equals("NONE"))
	        		res="";
	        	name=rs.getString(1);
	        		res+=name+",";
	        		
	        		
	        		
	        }
		
		
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
		
		return res;
		
	}

	public String searchEnabled(String search)
	{
		String  name;
		String res="NONE";
	
		if(search.length()==0)
	    {
	    	return "NONE";
	    	
	    }
		
		
		
		
		try {
			 // Execute a query and generate a ResultSet instance
			
			if(search.equals("ON")) {
	rs = stmt.executeQuery("select DISTINCT RULENAME from RULES where RULES.ISENABLED='0' AND LENGTH(RULEID)>1");
  
	        
          
	        //LOGIC
	        while(rs.next())
	        {
	        	if(res.equals("NONE"))
	        		res="";
	        	name=rs.getString(1);
	        		res+=name+",";
	        		
	        		
	        }   
			}
		
		
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
		
		return res;
		
	}

	public String searchDefault(String search)
	{
		String  name;
		String res="NONE";
	
		if(search.length()==0)
	    {
	    	return "NONE";
	    	
	    }
		
	
		try {
			 // Execute a query and generate a ResultSet instance
			
			if(search.equals("Default")) {
	rs = stmt.executeQuery("select DISTINCT RULENAME from RULES where RULES.ISDEFAULT='0' AND LENGTH(RULEID)>1");
  
          
	        //LOGIC
	        while(rs.next())
	        {
	        	if(res.equals("NONE"))
	        		res="";
	        	name=rs.getString(1);
	        		res+=name+",";
	        		
	        		
	        }   
			}
		
		
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
		
		return res;
		
	}
	
	public String searchByCondition(String[] FieldName,  String op[], String FieldValue[])
	{
		String  name;
		String res="NONE";
		
		int z=-1;
		Map<String, String> map = new HashMap<>();
		   map.put("EQ", "==");
		   map.put("SW", "Starts With");
		   map.put("CO", "Contains");
		   map.put("EW","Ends With");
		   map.put("NE", "!=");
		   map.put("LE","<=");
		   map.put("GE", ">=");
		  
		
		if(FieldName.length==0)
	    {
	    	return "NONE";
	    	
	    }
		
		int conds=FieldName.length;
		
		while(conds>0)
		{
	     
	conds--;
	z++;
		try {
			if(op[z].equals("*"))
			{
				

				 // Execute a query and generate a ResultSet instance
		        rs= stmt.executeQuery("select DISTINCT RULES.RULENAME from RULES FULL OUTER JOIN CONDITIONS "
		        		+ "ON RULES.RULEID=CONDITIONS.RULEID where CONDITIONS.FIELDNAME='"+FieldName[z]+"'"
		        		+ "AND CONDITIONS.FIELDVALUE LIKE '%"+FieldValue[z]+"%'");
	   
	          
		        //LOGIC
		        while(rs.next())
		        {
		        	if(res.equals("NONE"))
		        		res="";
		        	name=rs.getString(1);
		        		res+=name+",";
		        }
			
		       
				
				
			}
			
			else {
				System.out.println("INSIDE");
			
			 // Execute a query and generate a ResultSet instance
				rs= stmt.executeQuery("select RULES.RULENAME from RULES FULL OUTER JOIN CONDITIONS "
		        		+ "ON RULES.RULEID=CONDITIONS.RULEID where CONDITIONS.FIELDNAME='"+FieldName[z]+"'"
		        		+ "AND CONDITIONS.FIELDVALUE LIKE '%"+FieldValue[z]+"%'" + "AND CONDITIONS.OPERATOR='"+op[z]+"'");
   
	        System.out.println("**** Created JDBC ResultSet object SearchByName");
          
	        //LOGIC
	        while(rs.next())
	        {
	        	if(res.equals("NONE"))
	        		res="";
	        	name=rs.getString(1);
	        		res+=name+",";
	        }
		
	       
		}
			
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
		}
		return res;
		
	}	
	
	public String searchByAssignment(String[] FieldName, String FieldValue[])
	{
		String  name;
		String res="NONE";
		
		int z=-1;
		
		
		if(FieldName.length==0)
	    {
	    	return "NONE";
	    	
	    }
		
		int conds=FieldName.length;
		
		while(conds>0)
		{
	     
	conds--;
	z++;
		try {
			 // Execute a query and generate a ResultSet instance
		        rs= stmt.executeQuery("select DISTINCT RULES.RULENAME from RULES FULL OUTER JOIN ACTIONS "
		        		+ "ON RULES.RULEID=ACTIONS.RULEID FULL OUTER JOIN ASSIGNMENTS ON ACTIONS.ACTIONID=ASSIGNMENTS.ACTIONID where ASSIGNMENTS.FIELDNAME='"+FieldName[z]+"'"
		        		+ "AND ASSIGNMENTS.FIELDVALUE LIKE '%"+FieldValue[z]+"%'");
	   
	          
		        //LOGIC
		        while(rs.next())
		        {
		        	if(res.equals("NONE"))
		        		res="";
		        	name=rs.getString(1);
		        		res+=name+",";
		        }
			
			
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
		}
		return res;
		
	}	
	
	public String searchByAction(String search)
	{
		String  name;
		String res="NONE";
		
		if(search.length()==0)
	    {
	    	return "NONE";
	    	
	    }
	     
	
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("SELECT DISTINCT RULENAME FROM RULES FULL OUTER JOIN ACTIONS ON RULES.RULEID=ACTIONS.ACTIONID "
	        		+ " WHERE ACTIONS.BUSINESSPROCESSNAME LIKE '%" + 
	        		search+"%'");    
          
	        //LOGIC
	        while(rs.next())
	        {
	        	if(res.equals("NONE"))
	        		res="";
	        	name=rs.getString(1);
	        		res+=name+",";
	        }
		
	      
		
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
		
		return res;
		
	}
	
	public String searchActionEnabled(String search)
	{
	
		String res="NONE";
		
		if(search.length()==0)
	    {
	    	return "NONE";
	    	
	    }
		
		if(search.equals("EnabledAction"))
		{
	     
	
		try {
		 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("SELECT DISTINCT RULES.RULENAME from RULES WHERE RULES.RULEID IN ( SELECT ACTIONS.RULEID FROM ACTIONS WHERE ISENABLED ='0')");    
          
	        while(rs.next())
	        {
	        	
	        		
	        	if(res.equals("NONE"))
	        		res="";
	        	
	        
	        	    res+=rs.getString(1)+",";
	        	  
	        }
	        
	      
	        return res;
		
	        
		
		} 
		   
		   catch(SQLException ex)                                                     
		    {
		      System.err.println("SQLException action enabled");
		      while(ex!=null) {
		        System.err.println ("Error msg: " + ex.getMessage());
		        System.err.println ("SQLSTATE: " + ex.getSQLState());
		        System.err.println ("Error code: " + ex.getErrorCode());
		        ex.printStackTrace();
		        ex = ex.getNextException(); // For drivers that support chained exceptions
		      }}
		
		}
		
		return res;
		
	}

	
//------------------ Searching Functions END-------------------//
	
	

//-------------------- Rule Configurations Fetching Functions ----------------//
	
	public String getName(String ruleid)
 	{
 		
 		String result="";
 		
 		try {
 			 // Execute a query and generate a ResultSet instance
 	        rs= stmt.executeQuery("SELECT RULENAME FROM RULES WHERE RULEID='"+ruleid+"'");    
 	        
          
 	        //LOGIC
 	        while(rs.next())
 	        {
 	        	result+=rs.getString(1);
 	        	
 	        }
 	       
 		return result;
 	        
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
 		
 		return result;
 			
 	}    
	
	public String getAlias(String ruleid)
	{
		
		String result="";
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("SELECT BUSINESSALIAS FROM RULES WHERE RULEID='"+ruleid+"'");    
	        
         
	        //LOGIC
	        while(rs.next())
	        {
	        	result+=rs.getString(1);
	        	
	        }
	       
		return result;
	        
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
		
		return result;
			
	}
	
	public String getRuleSet(String ruleid)
	{
		String result="";
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("select RULESET.RULESETNAME from RULESET FULL OUTER JOIN RULES ON RULES.RULESETID=RULESET.RULESETID"
			 + " where RULES.RULEID='"+ruleid+"'");    
	        
         
	        //LOGIC
	        while(rs.next())
	        {
	        	result+=rs.getString(1);
	        	
	        	
	        }
	       
		return result;
	        
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
		
		return result;
			
	}

	public String getEnabled(String ruleid)
	{
		String result="";
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("select ISENABLED from RULES where RULES.RULEID='"+ruleid+"'");    
	        
         
	        //LOGIC
	        while(rs.next())
	        {
	        	result+=rs.getString(1);
	        	
	        	
	        }
	       
		return result;
	        
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
		
		return result;
			
	}
 
	public String getDefault(String ruleid)
	{
		String result="";
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("select ISDEFAULT from RULES where RULES.RULEID='"+ruleid+"'");    
	        
         
	        //LOGIC
	        while(rs.next())
	        {
	        	result+=rs.getString(1);
	        	
	        	
	        }
	       
		return result;
	        
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
		
		return result;
			
	}
	
	public String getCond(String ruleid)

	{
		String result="";
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("select CONDITIONS.FIELDNAME,CONDITIONS.OPERATOR,CONDITIONS.FIELDVALUE FROM CONDITIONS FULL "
	        		+ "OUTER JOIN RULES ON RULES.RULEID=CONDITIONS.RULEID WHERE RULES.RULEID='"+ruleid+"'");    
	        
        
	        //LOGIC
	        while(rs.next())
	        {
	        	result+=rs.getString(1)+","+rs.getString(2)+","+rs.getString(3)+",";
	        	
	        	
	        }
	       
		return result;
	        
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
		
		return result;
		
		
	}

	public String getAssignment(String actionid)

	{
		String result="";
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("select ASSIGNMENTS.FIELDNAME,ASSIGNMENTS.FIELDVALUE FROM ASSIGNMENTS FULL OUTER JOIN ACTIONS ON ASSIGNMENTS.ACTIONID=ACTIONS.ACTIONID WHERE ACTIONS.ACTIONID='"+actionid+"'");    
	        
        
	        //LOGIC
	        while(rs.next())
	        {
	        	
	        	
	        	
	        	result+=rs.getString(1)+","+ rs.getString(2)+",";
	        	
	        	
	        }
	       
		return result;
	        
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
		
		return result;
		
		
		
		
	}
 
	public String getAction(String ruleid)
	{
		String result="";
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("select VERSIONAME,BUSINESSPROCESSNAME from ACTIONS FULL OUTER JOIN RULES ON ACTIONS.RULEID = RULES.RULEID where RULES.RULEID='"+ruleid+"'");    
	        
         
	        //LOGIC
	        while(rs.next())
	        {
	        	result+=rs.getString(1)+","+rs.getString(2)+",";
	        	
	        	
	        }
	       
		return result;
	        
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
		
		return result;
			
	}

	public String getRuleID(String name)
	{
		String result="";
		
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("select RULEID from RULES where RULENAME='"+name+"'");    
	        
        
	        //LOGIC
	        while(rs.next())
	        {
	        	result+=rs.getString(1)+",";
	        
	        	
	        }
	       
		return result;
	        
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
		
		return result;
			
		
		
	}
	
    public String getActionEnabled(String ruleId)
	{
		String result="";
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("select ACTIONS.ISENABLED from ACTIONS where RULEID='"+ruleId+"'");    
	        
         
	        //LOGIC
	        while(rs.next())
	        {
	        	result+=rs.getString(1)+",";
	        	
	        	
	        }
	       
		return result;
	        
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
		
		return result;
			
	}
 
    public String getActionId(String ruleid)
    {
        String result="";
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("select ACTIONID from ACTIONS FULL OUTER JOIN RULES ON ACTIONS.RULEID = RULES.RULEID where RULES.RULEID='"+ruleid+"'");    
	        
         
	        //LOGIC
	        while(rs.next())
	        {
	        	result+=rs.getString(1)+",";
	        	
	        	
	        }
	       
		return result;
	        
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
		
		return result;
			
    	
    	
    }
    
	public String getDateModified(String ruleid)
	{
		String result="";
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("select LASTMODIFIED from RULES where RULES.RULEID='"+ruleid+"'");    
	        
         
	        //LOGIC
	        while(rs.next())
	        {
	        	result+=rs.getString(1);
	        	
	        	
	        }
	       
		return result;
	        
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
		
		return result;
			
	}

	
	
//-------------------- Rule Configurations Fetching Functions END ----------------//	
	
	
	
	
//Getting Data for populating the UI (Condition Field Names etc)
	
	public String getConditionFieldNames()
	{
		
        String result="";
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("select DISTINCT FIELDNAME from CONDITIONS ORDER BY FIELDNAME");    
	        
         
	        //LOGIC
	        while(rs.next())
	        {
	        	result+=rs.getString(1)+",";
	        	
	        	
	        }
	       
		return result;
	        
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
		
		return result;
			
		
	}

	public String getAssignmentFieldNames()
	{
		
        String result="";
		
		try {
			 // Execute a query and generate a ResultSet instance
	        rs= stmt.executeQuery("select DISTINCT FIELDNAME from ASSIGNMENTS ORDER BY FIELDNAME");    
	        
         
	        //LOGIC
	        while(rs.next())
	        {
	        	result+=rs.getString(1)+",";
	        	
	        	
	        }
	       
		return result;
	        
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
		
		return result;
			
		
	}
	
	
	
	

	}//End Of Class


