<!DOCTYPE html>

    <head>
    	
    	<title>Home Page || RuleSearch</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="css/RuleHome.css">
  
  <link rel="shortcut icon" href="images/bee.png" />
  
    	


    </head>
	
    <body id="body">
	

	<%
		System.out.println("Redirected Page"+request.getAttribute("RuleId"));
	%>
	
	
	
	<div id="header" class="container" >
		  <div class="page-header">
		  <h1 class="font-weight-bold" ><img src="../images/HeaderIBMLogo.png" style="height:50px; width:100px"/> B2B Rule Validator</h1> 
		        
		  </div>
		  <nav>
		     <ul id="nav" class="nav navbar-nav"> 
		           		             <li><a href="../login.jsp" class="external">Login</a></li>
		         </ul>
		    </nav>  
		    
    </div>
		
 
		      
		      
				
       
       
       
	<div style="margin-left:30px" >
	  <h4 class="display-8">OOPS, Session Timed Out. Login again!!!</h4>
	  
	  <hr class="my-4">
	  
	</div>
	
	

  
  
  
    </body>
</html>
