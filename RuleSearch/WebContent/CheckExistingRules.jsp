<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="shortcut icon" href="images/bee.png" />
<title>RuleSearch || Existing</title>
   <script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
   <link rel="stylesheet" type="text/css" href="./css/login2.css">
   <link rel="shortcut icon" href="../images/bee.png" />
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
   <link rel="stylesheet" href="//cdn.datatables.net/1.10.19/css/jquery.dataTables.min.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
   <script src="//cdn.datatables.net/1.10.19/js/jquery.dataTables.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>


<script type="text/javascript">
      $(document).ready( function () {
         $('#showRes').DataTable();
      } );
   </script>
   
</head>
<body>
<form action="RuleValidator.jsp" id="previous"></form>

    <h1 align="center" >Existing Rules&nbsp;&nbsp;<input form="previous" type="image" name="submit" src="images/previous.png" style="height:20px; width:20px"></h1>



<%
String sendName="";
String RuleNames[]=request.getParameter("Rules").split(",");


%>
  <%
		if (session.getAttribute("name") == null) { //Change address when delpoying to Project
			request.getRequestDispatcher("login.jsp").forward(request,
					response);
		}   
	   %>
	   
	   
	   
	   <div class=container>
         <table class="table table-striped" id="showRes">
            <thead>
               <tr>
                  <th>Rule Name</th>
                 
               </tr>
            </thead>
            <tbody>
            
         
            
            <%for(int i=0;i<RuleNames.length;i++){ 
            
            	sendName=RuleNames[i].replace("&", "%26");
            %>
            <tr><td><a href="UI_Rules/ruleConfig.jsp?res=<%=sendName%>&EnabledAction=0"> <%= RuleNames[i] %> </a></td> </tr>
            <%} %>
            
           
	   
	   </tbody>

	   </table>
	   </div>
	  
	   
	   
	   
	   
	   
	   
	   

</body>
</html>