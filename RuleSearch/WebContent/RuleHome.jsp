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
		if (session.getAttribute("name") == null) {
			request.getRequestDispatcher("login.jsp").forward(request,
					response);
		}
	%>
	
	
	
	<div id="header" class="container" >
		  <div class="page-header">
		  <h1 class="font-weight-bold" ><img src="images/HeaderIBMLogo.png" style="height:50px; width:100px"/> B2B Rule Validator</h1> 
		        
		  </div>
		  <nav>
		     <ul id="nav" class="nav navbar-nav"> 
		             <li class="current"><a href="#body">Home</a></li>
		             <li><a href="./RuleSearch.jsp" class="external">Rule Search</a></li>
		             <li><a href="./RuleValidator.jsp" class="external">Rule Validator</a></li>
		             <li><a href="./LogoutServlet" class="external">Logout</a></li>
		         </ul>
		    </nav>  
		    
    </div>
		
 
		      
		      
				
       
       
       
	<div style="margin-left:30px" >
	  <h4 class="display-8">Hello, <%=session.getAttribute("name") %>!</h4>
	  
	  <hr class="my-4">
	  
	</div>
	
	<div class="container" style="align-content:left; margin-left:0.05px">
	  <img src="images/Back.jpg" class="backgroundImage">
	  <div class="centered">IBM B2B tool</div>
		
		</div>

  
  
  
    </body>
</html>
