<%-- 
   Document   : results
   Created on : Feb 18, 2019, 10:45:40 AM
   Author     : DebanshuVENDORMajumd
   --%>
<!DOCTYPE html>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="Func.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*"%>
<html>
   <link rel="stylesheet" type="text/css" href="./css/login2.css">
   <link rel="shortcut icon" href="../images/bee.png" />
   <meta name="viewport" content="width=device-width, initial-scale=1">
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
   <link rel="stylesheet" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
   <script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
  
   <head>
      <title>Rules</title>
   </head>
   <%
      if (session.getAttribute("name") == null) {
      	
      	request.getRequestDispatcher("login.jsp").forward(request,
      			response);
      }
      %>
   <%! 
      static int count;
      String tmp[];
      String dateModified,file,Error="";
     
      int c=0;
      
      
      String t1=" ",t2=" ",t3=" ",t4=" ",c1=" ",c2=" ", bpname[], c3=" ";
      
      String FieldNameCondition="", FieldValueCondition="", OperatorCondition ; 
      String FieldNameAssignment="", FieldValueAssignment="";
      String fieldname[],fieldvalue[],operator[];
      String assfield[],assvalue[];
      DB2Connection db2=new DB2Connection();
      Validator validator =new Validator();
      HashMap <Integer, String> errorState=new  HashMap <Integer, String>();
     
      
      Queries SQL=new Queries();
      
      
      
      
      
      %>
   <!--------------------- Fetching of all form inputs----------------------- -->
   <%
      System.out.println("**Rule Validation Begins**");
      
      
      t1=request.getParameter("t1");
      t2=request.getParameter("t2");
      t3=request.getParameter("t3");
      t4=request.getParameter("t4");
      
      String db2name="";
      db2name=request.getParameter("t2");
      
      c1=request.getParameter("c1");
      c2=request.getParameter("c2");
      c3=request.getParameter("EnabledAction");
      
      
      if(c1==null)
          c1="";
      if(c2==null)
          c2="";
      if(c3==null)
      	c3="";
      
       
      
      fieldname=request.getParameterValues("fieldname");
      fieldvalue=request.getParameterValues("fieldvalue");
      operator=request.getParameterValues("operators");
      
      //Bpname is an array of all the actions
      bpname=request.getParameterValues("bpnname");
      
      
      assfield=request.getParameterValues("assfield");
      assvalue=request.getParameterValues("assvalue");
      
      errorState=validator.checkRuleValidity(fieldname,operator,fieldvalue,c1, c2, t4,t2,t1,bpname);
      
      if(errorState.size()==0)
    	  Error="NONE";
    
      else
      {
    	  Error="";
    	  for(int i=0;i<errorState.size();i++)
    	  Error+=errorState.get(i)+",";
      }
 
      
      request.setAttribute("Error",Error);
      request.getRequestDispatcher("RuleValidator.jsp").forward(request,
				response);
		
      %>
      
      <%if(Error.equals("NONE")){%>
      <h2 style="margin-left:370px">Rule Created Successfully!</h2>
      
      <div style="margin-left:360px">
      <table >
      
      <tbody>
      
      <tr> <td> <hr></td></tr>
      
     <tr> <td style="font-weight:bold">Basic Info:</td></tr>
      <tr>
      <td>Alias-&nbsp;&nbsp;<%=t1%></td>
      </tr>
      <tr>
      <td>Name-&nbsp;&nbsp;<%=t2%></td>
      </tr>
      <tr>
      <td>Rule ID-&nbsp;&nbsp;<%=t3%></td>
      </tr>
      <tr>
      <td>Rule set-&nbsp;&nbsp;<%=t4%></td>
      </tr>
      <tr>
      <td>Enabled-&nbsp;&nbsp;<%=c1%></td>
      </tr>
      <%String tmp="";if(c2.equals("Default")){tmp="ON";} %>
      <tr>
      <td>Default-&nbsp;&nbsp;<%=tmp%></td>
      </tr>
      
    <tr> <td> <hr></td></tr>
      
       
      
      <% 
     
      for(int i=0;i<fieldname.length;i++){
      %>
      <% if(fieldname[i].length()>0) {%>
      
     <%if(i==0){ %> <tr> <td style="font-weight:bold">Conditions:</td></tr><%} %>
        <tr>
        
        <td><%=fieldname[i]%></td>
        <td><%=operator[i] %></td>
        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=fieldvalue[i] %></td>
        
        </tr>   
        <%} %>
      <% }%>
        
        
        <%if(bpname[0].length()>0){ %>
        
        <tr> <td style="font-weight:bold">Action:</td>
        
      <td><%=bpname[0] %></td>  </tr><tr><td>Enabled:<%= c3 %></td></tr>
        
       <% }for(int i=0;i<assfield.length;i++){ 
       
       if(assfield[i].length()>0){
       %>
        
         <%if(i==0){ %> <tr><td style="font-weight:bold">Assignments:</td></tr><%} %>
        <tr>
        
        <td><%=assfield[i]%></td>
        <td><%=assvalue[i] %></td>
        
        
        </tr>   
      <%}} %>
      </tbody>
      </table>
      
      </div>
      
    	  
    	  <%}else{    
    	  String err[]=Error.split(",");
    		  for(int i=0;i<err.length;i++){%>	  
    	 <h2><%= err[i] %></h2>
    	  
    <%}} %>
     
   <body>
      <form id="previous" action="../RuleSearch.jsp"></form>
     
   </body>
</html>