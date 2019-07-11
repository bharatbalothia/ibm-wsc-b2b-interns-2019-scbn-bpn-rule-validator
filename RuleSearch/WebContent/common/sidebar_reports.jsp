<%-- <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

</body>
</html> --%>


<div id="sidebar">
	<h3 style="color: black;">
		Welcome,
		<%=session.getAttribute("name")%></h3>
	<br />
	<div id="logo">
		<h1>
			<a href="index.jsp">Utility </a>
		</h1>
		<p>
			<a href="index.jsp">AppStore</a>
		</p>
	</div>
	<div id="menu">
		<ul>

			<li><a href="home.jsp"
				style="background: url(images/img05.jpg) no-repeat left top;">Utilities</a></li>
			<li><a
				href="http://9.124.112.216/Reports/frameset?__report=AppStore2.rptdesign&sample=my+parameter">Utility
					Wise Effort Savings</a></li>
			<li><a
				href="http://9.124.112.216/Reports/frameset?__report=AppStore3.rptdesign&sample=my+parameter/error20001.jsp">Project
					Wise Utility Usage - Single User</a></li>
			<li><a
				href="http://9.124.112.216/Reports/frameset?__report=AppStore3a.rptdesign&sample=my+parameter">Ticket
					Wise Utility Usage - Single User</a></li>
			<li><a
				href="http://9.124.112.216/Reports/frameset?__report=AppStore4.rptdesign&sample=my+parameter">Ticket
					Wise Utility Usage - All Users</a></li>
			<li><a
				href="http://9.124.112.216/Reports/frameset?__report=AppStore5.rptdesign&sample=my+parameter">Project
					Wise Utility Usage - All Users</a></li>
			<li><a
				href="http://9.124.112.216/Reports/frameset?__report=AppStore6.rptdesign&sample=my+parameter">Effort
					Saved Ticket Wise</a></li>
			<li><a
				href="http://9.124.112.216/Reports/frameset?__report=AppStore7.rptdesign&sample=my+parameter">Effort
					Saved Team Wise</a></li>


		</ul>
	</div>
</div>