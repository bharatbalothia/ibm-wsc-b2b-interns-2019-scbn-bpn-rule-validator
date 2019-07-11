<jsp:include page="common\header.jsp" />

<body>
	<%
		if (session.getAttribute("name") == null) {
			request.getRequestDispatcher("login.jsp").forward(request,
					response);
		}
	%>
	<div id="wrapper">
		<div id="page">
			<div id="page-bgtop">
				<div id="page-bgbtm">
					<div id="content">
						<div class="post">
							<jsp:include page="common\logout.jsp" />
							<h2 class="date">B2B AppStore</h2>
							<div style="clear: both;">&nbsp;</div>
						</div>
						<div class="post">
							<h3 class="date">B2B AppStore is collection of common utilities, created to assist developers from B2B SaaS group with their routine deliverables or support work.
These utilities hosted here are designed to save manual efforts by automating the various human tasks carried out by SaaS teams such as Implementation, Map Development, Map Change, & PER during development, testing and support activities.</h3>
							<div style="clear: both;">&nbsp;</div>

						</div>
						<div style="clear: both;">&nbsp;</div>
					</div>
					<div id="sidebar">
						<h3 style="color: red;">
							Welcome,
							<%=session.getAttribute("name")%>

						</h3>
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
									style="background: url(images/img05.jpg) no-repeat left top;"><strong>Utilities</strong></a></li>
							</ul>
							<ul>
								<li><a
									style="background: url(images/img05.jpg) no-repeat left top;"
									href="reports.jsp"><strong>Reports</strong></a></li>
							</ul>
						</div>
					</div>
					<div style="clear: both;">&nbsp;</div>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="common\footer.jsp"></jsp:include>
</body>
</html>
