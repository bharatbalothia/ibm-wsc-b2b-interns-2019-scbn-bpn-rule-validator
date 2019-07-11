<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
   <%@page import="Func.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>RuleSearch || Pagination</title>


  <link rel="shortcut icon" href="images/bee.png" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
  <script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
   
  <script type="text/javascript">
  
  
  $(document).ready( function () {
	    $('#example').DataTable();
	} );
  </script>
  
    


</head>



<style>


/* Style the active class, and buttons on mouse-over */
.active, .btn:hover {
  background-color: #666;
  color: white;
}
</style>
</style>


<!-- Session -->
<%

		if (session.getAttribute("name") == null) {
			
			request.getRequestDispatcher("login.jsp").forward(request,
					response);
		}
	%>

<!-- Declaration -->
			<%! 
			
			int count,c,start,pageid;
			String dateModified,result,ResultSession;
			String arr[];
			DB2Connection db2=new DB2Connection();
			RuleExport export=new RuleExport();
			
		   %>



<body>



<%


arr=request.getParameter("Result").split(",");
count=arr.length;








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

<form id="previous" action="RuleSearch.jsp"></form>
 
 <div style="margin-left:550px"><h1>RULES&nbsp;&nbsp;<input form="previous" type="image" name="submit" src="images/previous.png" style="height:20px; width:20px">
 </h1><h2><%=count %> Rules Found</h2></div>
 
 

<ol width="1" cellspacing="2" cellpadding="3">



<!---------------------------------------- Rule Printing as list ---------------------- -->
<%

if(arr[0].equals("NONE"))
{
	%>
	<h2>Sorry, No Rules found in the database...</h2>

<%}
else{
	 
	
%>
	<br/>

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

if(result.length()>0 || !result.contains("NONE")){
	
	 if(result.length()>0 || !result.contains("NONE")){
   	  for(int i=0;i<arr.length;i++){
       	 
   		  dateModified=db2.getDateModified(arr[i]);
   		  
   		  if(dateModified.length()>=19)
   		    dateModified=dateModified.substring(0,19);
		  
  %> 
  
<tr><td><span ><a href="UI_Rules/ruleConfig.jsp?res=<%=arr[i]%>"> <%=arr[i]%> </a></span></td> <td><span class="font"> <%= dateModified %></span></td></tr>

 <%}
  

}
  else if((result.contains("NONE") && result.length()<=4)){%>
<tr> <td><a href="ruleConfig.jsp"> <%="NONE!"%></a></td></tr>
<%}

}  

}%>
   
     </tbody>
   </table> 
   </div>
     
<!---------------------------------------- Rule printing end------------------------ --- -->            




<!---------------------------- Export rules to file Functionality ------------------------->



<%
if(!arr[0].equals("NONE")){ 

export.storeRules(result);

%>
<div align="left" style="margin-left:40px">
<a  href='/Rules/RuleNames.txt' download='RuleNames.txt'>
<img src='images/download.png' width='100' heigth='100' alt='Download' >
</a>
<div>
<%} %>

<!---------------------------- Export End ------------------------------------------------->

<!---------------------------- Export rules to file Functionality ------------------------->

<%if(arr[0].equals("NONE")){ %>

<form action="RuleSearch.jsp" method="post"> 

<input name="Back" type="hidden" />
<input type="submit" value="Back" />
</form>
<%} %>



<!---------------------------- Export End ------------------------------------------------->






</body>
</html>