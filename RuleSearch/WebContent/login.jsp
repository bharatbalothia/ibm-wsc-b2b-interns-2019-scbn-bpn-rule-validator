
<!DOCTYPE html>
<html>
<head>
 <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<link rel="stylesheet" type="text/css" href="css/login2.css">
<link rel="shortcut icon" href="images/bee.png" />

<title>Login || RuleSearch</title>

</head>

<body>

<div class="wrapper fadeInDown">
  <div id="formContent">
     
    <!-- Icon -->
    <div class="fadeIn first">
      <img src="img/IBM-logo.jpg" id="icon" alt="User Icon" />
    </div>
    
    <!-- Login Form -->
    <form class="login100-form validate-form flex-sb flex-w" action="loginServlet" method="post">
       <div class="error"></div>
      <input type="text" id="login" class="fadeIn second" name="UserName" placeholder="IBM Intranet Email ID">
      <input type="password" id="password" class="fadeIn third" name="Password" placeholder="IBM Intranet Password">
      <input type="submit" class="fadeIn fourth" value="Log In" >
    </form>

    <!-- Remind Passowrd -->
    

  </div>
</div>

</body>
</html>

