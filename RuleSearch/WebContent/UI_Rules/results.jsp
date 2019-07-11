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
   <meta name="viewport" content="width=device-width, initial-scale=1">

   <link rel="stylesheet" type="text/css" href="./css/login2.css">
   <link rel="shortcut icon" href="../images/bee.png" />
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
   <link rel="stylesheet" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
   
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
   <script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
   <script type="text/javascript">
      $(document).ready( function () {
         $('#example').DataTable();
      } );
   </script>
   
   
   
   <head>
      <title>Rules</title>
   </head>
   
   <%
      if (session.getAttribute("name") == null) {
      	
      	request.getRequestDispatcher("SessionTimeOut.jsp").forward(request,
      			response);
      }
      %>
   <%! 
      static int count;
      String tmp[];
      String dateModified,file,sendName;
      RuleExport export=new RuleExport();
      
      int c=0;
      
      
      String t1=" ",t2=" ",t3=" ",t4=" ",c1=" ",c2=" ", bpname=" ", c3=" ";
      
      String FieldNameCondition="", FieldValueCondition="", OperatorCondition ; 
      String FieldNameAssignment="", FieldValueAssignment="";
      String fieldname[],fieldvalue[],operator[];
      String assfield[],assvalue[];
      DB2Connection db2=new DB2Connection();
      
      
      Queries SQL=new Queries();
      int isPresent[]=new int[10];
      
      %>
   <!--------------------- Fetching of all form inputs----------------------- -->
   <%
      System.out.println("Start of application");
      
      
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
      
      bpname=request.getParameter("bpnname");
      bpname=bpname.trim();
      
      assfield=request.getParameterValues("assfield");
      assvalue=request.getParameterValues("assvalue");
      
      
      for(int i=0;i<isPresent.length;i++)
      isPresent[i]=0;
      
      System.out.println("------------"+assfield.length);
      
      if(t1.length()>0)
      isPresent[0]=1;
      
      if(t2.length()>0)
      isPresent[1]=1;
      
      if(t3.length()>0)
      isPresent[2]=1;
      
      if(t4.length()>0)
      isPresent[3]=1;
      
      if(c1.equals("ON"))
      isPresent[4]=1;
      
      if(c2.equals("Default"))
      isPresent[5]=1;
      
      if(fieldname.length>=1)
      {
      if(fieldname[0].length()>0)
      isPresent[6]=1;
      }
      
      if(bpname.length()>0)
      isPresent[7]=1;
      
     /* if(c3.equals("EnabledAction"))
      isPresent[8]=1;*/
      
      
      
      if(assfield.length>=1)
      { 
      if(assfield[0].length()>0)
       isPresent[9]=1;
      
      }
      
      
      System.out.println("Assignment size:"+ assfield.length);
      HashMap<Integer, String> FetchedValues = new HashMap<Integer, String>();
      
      FetchedValues.put(0, t1);
      FetchedValues.put(1, t2);
      FetchedValues.put(2, t3);
      FetchedValues.put(3, t4);
      
      FetchedValues.put(4, c1);
      FetchedValues.put(5, c2);
      
      FetchedValues.put(6, FieldNameCondition);
      FetchedValues.put(7, FieldValueCondition);
      FetchedValues.put(8, OperatorCondition);
      
      FetchedValues.put(9, bpname);
      FetchedValues.put(10, c3);
      
      FetchedValues.put(11, FieldNameAssignment);
      FetchedValues.put(12, FieldValueAssignment);
     
      String result[]= SQL.GenerateQuery(FetchedValues, isPresent, fieldname, fieldvalue, operator, assfield, assvalue);
      
      String arr[]=result[0].split(",");
      String Date[]=result[1].split(",");
      
      
      
      count=arr.length;
      %>
   <!--------------------------- Form inputs end ----------------------------------->
   
   
   
   <!---------------- Blank Rule Check Code Segment -------------------------------->
   <%
      if(arr.length==1) //THIS SEGMENT CHECKS FOR BLANK RESULTS AND RECTIFIES THE RESULT
      { 
      c=0;
      for(int k=0;k<arr[0].length();k++)
      {
      char ch=arr[0].charAt(k);
      if(!Character.isLetter(ch))
      { 
      	c++;
      }
      }
      
      
      if(arr[0].length()==c)
      { 
      arr[0]="NONE";
      count=0;
      }
      }
      
      
      %>
   <!--------------------------- Check End-------------------- ------------------------>
   <body>
      <form id="previous" action="../RuleSearch.jsp"></form>
      <div style="margin-left:550px">
         <% if(arr[0].equals("NONE")){count=0;} %>
         <h1 >RULES&nbsp;&nbsp;<input form="previous" type="image" name="submit" src="../images/previous.png" style="height:20px; width:20px"></h1>
         <h2><%=count %> Rules Found</h2>
      </div>
   <!---------------------------------------- Rule Printing in Table ---------------------- -->
      <%
         if(arr[0].equals("NONE"))
         {
         	%>
      <h2>Sorry, No Rules found in the database...</h2>
      <%}
         else{
         	
         
         %>
      <div class=container>
         <table class="table table-striped" id="example">
            <thead>
               <tr>
                  <th>Rule Name</th>
                  <th>Last Modified</th>
               </tr>
            </thead>
            <tbody>
               <%    
                  if(result[0].length()>0 || !result[0].contains("NONE")){
                   for(int i=0;i<arr.length;i++){
                    	 
                    dateModified=Date[i];
                    
                    if(dateModified.length()>=19)
                      dateModified=dateModified.substring(0,19);
                    
                     %> 
               <tr>
               <%  sendName=arr[i].replace("&", "%26"); %>
                  <td><span ><a href="ruleConfig.jsp?res=<%=sendName%>&EnabledAction=<%=c3%>"> <%=arr[i]%> </a></span></td>
                  <td><span class="font"> <%= dateModified %></span></td>
               </tr>
               <%}
                  }
                     else if((result[0].contains("NONE") && result[0].length()<=4)){%>
               <tr>
                  <td><a href="ruleConfig.jsp"> <%="NONE!"%></a></td>
               </tr>
               <%}
                  }%>
               <hr>
            </tbody>
         </table>
      </div>
      <!---------------------------------------- Rule printing end------------------------ --- -->         
      
         
      <!---------------------------- Export rules to file Functionality ------------------------->
      <%
         if(!arr[0].equals("NONE")){ 
              
            export.storeRules(result[0]);
            
            %>
      <div align="left" style="margin-left:40px">
      <a  href='/Rules/RuleNames.txt' download='RuleNames.txt'>
      <img src='../images/download.png' width='100' heigth='100' alt='Download' >
      </a>
      <div>
      <%} %>
      <!---------------------------- Export End ------------------------------------------------->
      
      
      
      
      <!---------------------------- Export rules to file Functionality ------------------------->
      <%if(arr[0].equals("NONE")){ %>
      <form action="../RuleSearch.jsp" method="post"> 
         <input name="Back" type="hidden" />
         <input type="submit" value="Back" />
      </form>
      <%} %>
      <!---------------------------- Export End ------------------------------------------------->
   </body>
</html>