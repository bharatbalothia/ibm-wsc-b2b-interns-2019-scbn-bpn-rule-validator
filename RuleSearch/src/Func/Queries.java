//Generates the Final SQL query and runs the command at one sho 
//Returns names and date modified

package Func;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashMap;

public class Queries {

	static String jdbcClassName = "com.ibm.db2.jcc.DB2Driver";
	static String jdbcUrl = "jdbc:db2://9.30.161.135:50001/RS"; //"jdbc:db2://9.30.161.135:50000/";
	static String jdbcUserName = "db2inst1"; //"db2user";
	static String jdbcPassword = "db@inst!";//"db2user@";
	static String jdbcSchemaName = "RS";
	static String FTPServerUrl = "209.95.232.130";
	static int FTPPortNo = 21;
	
	
	Connection con;
    Statement stmt;
    ResultSet rs;
  
    
	public String ValidatorCond="",Alias="", Name="", Rulesetid="", Ruleset="", Enabled="", Default="", Condition="", Assignment="", Action="", ActionEn="";
	
	
	public String[] validatorQuery(String condFieldName[],String operator[],String[] CondFieldValue) {
		
		String s[]=new String[10];
		
		ValidatorCond="SELECT COUNT(RULES.RULEID) FROM RULES WHERE ";
		return  s;
		
	}
	
	
	//Sub-Module of Generate Query Function (Condition Query creation)
	public String getConditionQuery(String[] FieldName,String[] FieldValue,String[] Operator) {
		
	Condition="select DISTINCT RULES.RULENAME,RULES.LASTMODIFIED  from RULES FULL OUTER JOIN CONDITIONS ON RULES.RULEID=CONDITIONS.RULEID where ";
	String ConditionFinal="";
		
	for(int i=0;i<FieldName.length;i++)
	{
	
		
		if(!FieldName[i].equals("") && !FieldName[i].equals(""))
		{
		if(Operator[i].equals("*"))
		 ConditionFinal+=Condition+" (CONDITIONS.FIELDNAME='"+FieldName[i]+"' AND CONDITIONS.FIELDVALUE LIKE'%"+FieldValue[i]+"%') intersect ";
		else if(Operator[i].equals("EQ") )
		 ConditionFinal+=Condition+" (CONDITIONS.FIELDNAME='"+FieldName[i]+"' AND CONDITIONS.FIELDVALUE='"+FieldValue[i]+"' AND CONDITIONS.OPERATOR='"+Operator[i]+"') intersect ";
		else if(Operator[i].equals("NE") )
		 ConditionFinal+=Condition+" (CONDITIONS.FIELDNAME='"+FieldName[i]+"' AND CONDITIONS.FIELDVALUE='"+FieldValue[i]+"' AND CONDITIONS.OPERATOR='"+Operator[i]+"') intersect ";
		else if(Operator[i].equals("SW"))
		 ConditionFinal+=Condition+" (CONDITIONS.FIELDNAME='"+FieldName[i]+"' AND CONDITIONS.FIELDVALUE LIKE'"+FieldValue[i]+"%' AND CONDITIONS.OPERATOR='"+Operator[i]+"') intersect ";
		else if(Operator[i].equals("EW"))
		 ConditionFinal+=Condition+" (CONDITIONS.FIELDNAME='"+FieldName[i]+"' AND CONDITIONS.FIELDVALUE LIKE'%"+FieldValue[i]+"' AND CONDITIONS.OPERATOR='"+Operator[i]+"') intersect ";
			
		}
	}
	int startCnd;
	startCnd=ConditionFinal.lastIndexOf("intersect");
	
	if(ConditionFinal.contains("intersect"))
		ConditionFinal=ConditionFinal.substring(0,startCnd);
	
	
	
	ConditionFinal+=" AND LENGTH(CONDITIONS.RULEID)>0";
		
		return ConditionFinal;
	}
	
   
	//Sub-Module of Generate Query Function (Assignment Query creation)
   public String getAssignmentQuery(String FieldName[], String[] FieldValue) {
	   
	    String AssignmentFinal="";
		Assignment="select DISTINCT RULES.RULENAME,RULES.LASTMODIFIED  from RULES FULL OUTER JOIN ACTIONS ON RULES.RULEID=ACTIONS.RULEID FULL OUTER JOIN ASSIGNMENTS ON ACTIONS.ACTIONID=ASSIGNMENTS.ACTIONID where ";

		

		for(int i=0;i<FieldName.length;i++)
		{
			
		   if(!FieldName[i].equals("") && !FieldValue[i].equals(""))	
			AssignmentFinal+=Assignment+" (ASSIGNMENTS.FIELDNAME='"+FieldName[i]+"' AND ASSIGNMENTS.FIELDVALUE LIKE '%"+FieldValue[i]+"%') intersect ";
			
		}
		int startAss;
		
		
		startAss=AssignmentFinal.lastIndexOf("intersect");
		
		
		if(AssignmentFinal.contains("intersect"))
		AssignmentFinal=AssignmentFinal.substring(0,startAss);
		
	
		AssignmentFinal+= " AND LENGTH(ASSIGNMENTS.ACTIONID)>0";
		
		
		
		return AssignmentFinal;
	}
	
	//Sub-Module of Generate Query Function (Part of Rule Name Exists %name%)
   public String getNameQuery(String name) {
	   
	   return "SELECT DISTINCT RULENAME,LASTMODIFIED  FROM RULES WHERE LENGTH(RULEID)>1 AND RULENAME LIKE '%"+name+"%'";
	   
   }
   
   //Sub-Module of Generate Query Function (Complete Rule Name Exists ==name)
   public String getExactNameQuery(String name) {
	   
	   return "SELECT DISTINCT RULENAME,LASTMODIFIED  FROM RULES WHERE LENGTH(RULEID)>1 AND RULENAME='"+name+"'";
	   
   }
	
	
	
	
	//Generates the queries based on fields of searches intended 
	public String[] GenerateQuery(HashMap<Integer,String> FieldValues,int [] isPresent, String[] ... CondAss)
	{
		
		String res="NONE", date="";
		String FinalSQL="";
		String Results[]=new String[2]; //2 Arrays  0.Names 1.Dates 
		Queries Query=new Queries();
		
		Results[0]="NONE";
		Results[1]="----";
		
		HashMap <Integer,String> Sql= new HashMap<Integer, String>();

		
        Alias="SELECT DISTINCT RULENAME,LASTMODIFIED FROM RULES WHERE LENGTH(RULEID)>1 AND RULES.BUSINESSALIAS LIKE '%"+FieldValues.get(0)+"%'";
		
        Name = Query.getNameQuery(FieldValues.get(1));
        
		Rulesetid="SELECT DISTINCT RULENAME,LASTMODIFIED  FROM RULES WHERE LENGTH(RULEID)>1 AND RULES.RULEID='"+ FieldValues.get(2)+"'";
		
		Ruleset= "SELECT DISTINCT RULES.RULENAME,RULES.LASTMODIFIED  from RULES FULL OUTER JOIN RULESET ON RULES.RULESETID=RULESET.RULESETID where RULESET.RULESETNAME LIKE '%"+FieldValues.get(3)+"%'";
		
		Enabled="select DISTINCT RULENAME,LASTMODIFIED  from RULES where RULES.ISENABLED='0' AND LENGTH(RULEID)>1";
		
		Default ="select DISTINCT RULENAME,LASTMODIFIED  from RULES where RULES.ISDEFAULT='0' AND LENGTH(RULEID)>1";
		
		Action ="SELECT DISTINCT RULENAME,LASTMODIFIED FROM RULES WHERE RULES.RULEID IN (SELECT DISTINCT RULEID FROM ACTIONS WHERE BUSINESSPROCESSNAME='"+FieldValues.get(9)+"')";
		
		
		String AssignmentFinal="",ConditionFinal="";
		ConditionFinal=Query.getConditionQuery(CondAss[0],CondAss[1],CondAss[2]); //sub-module function called
		AssignmentFinal=Query.getAssignmentQuery(CondAss[3], CondAss[4]);    //sub-module function called
		
		
		
		if(!ConditionFinal.contains("FIELDNAME"))
			{
			Condition="";
			ConditionFinal="";
			isPresent[6]=0;
			}
		if(!AssignmentFinal.contains("FIELDNAME"))
			{
			Assignment="";
			AssignmentFinal="";
			isPresent[9]=0;
			}
		
		
		//Hash-Map assignments to store query for the respective Fields
		Sql.put(0, Alias);
		Sql.put(1, Name);
		Sql.put(2, Rulesetid);
		Sql.put(3, Ruleset);
		Sql.put(4, Enabled);
		Sql.put(5, Default);
		Sql.put(6, ConditionFinal);
		Sql.put(7, Action);
		Sql.put(8, "");
		Sql.put(9,AssignmentFinal);
		
		//Combining all the present Fields SQL into one SQL command
		for(int i=0;i<10;i++)
		{
			//Check if correct fields are marked YES- System.out.println(isPresent[i]);
			
			if(isPresent[i]==1) 
			{
				FinalSQL+=Sql.get(i)+" INTERSECT ";   
				
			}
			
		}
		
		FinalSQL=FinalSQL.trim(); //Optional
		
		
		if(FinalSQL.length()>0) //Removal of trailing words
		{
			
		 FinalSQL= FinalSQL.substring(0,FinalSQL.length()-10);
		}
		
		
		System.out.println("Final_SQL: "+FinalSQL+"   "); //Check Console for the SQL query generated 

		
		
		 try {
             
			//-----------------------------------CONNECTION ----------------------------------------------------------//

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
				        
				        if(FinalSQL.length()>0)
				        {   
				      rs=stmt.executeQuery(FinalSQL); //Final_SQL command run here
				      
				      while(rs.next()) //Split into Name and Date
				        {
				        	if(res.equals("NONE"))
				        		res="";
				        	res+=rs.getString(1)+",";
				        	date+=rs.getString(2)+",";
				        		
				        }
					
				      
				        Results[0]=res;
				        Results[1]=date;
				        return Results;
				      
				    }
				        else {
							 
							 Results[0]="NONE";
							 Results[1]="----";
							 return Results;
						 }
				        
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
		 
		 return Results; //Return the Name and Date array
				   
				}
				
		
		
		
		
		
	}
	
	
	
	

