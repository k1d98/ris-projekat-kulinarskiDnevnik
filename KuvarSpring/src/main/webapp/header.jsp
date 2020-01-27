<%@ taglib prefix="s" uri="http://www.springframework.org/security/tags"%>

<script type="text/javascript" src="/Kuvar/js/jquery-3.4.1.min.js"></script>
<!-- Bootstrap tooltips -->
<script type="text/javascript" src="/Kuvar/js/popper.min.js"></script>
<!-- Bootstrap core JavaScript -->
<script type="text/javascript" src="/Kuvar/js/bootstrap.min.js"></script>
<!-- MDB core JavaScript -->
<script type="text/javascript" src="/Kuvarjs/mdb.min.js"></script>
<meta charset="UTF-8">
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.8.2/css/all.css">
<!-- Bootstrap core CSS -->
<link href="/Kuvar/css/bootstrap.min.css" rel="stylesheet">
<!-- Material Design Bootstrap -->
<link href="/Kuvar/css/mdb.min.css" rel="stylesheet">
<!-- Your custom styles (optional) -->
<link href="/Kuvar/css/style.css" rel="stylesheet">



<!--Main Navigation-->
<header>

	<nav class="navbar navbar-expand-lg navbar-dark #e53935 red darken-1 ">
		<a class="navbar-brand" href="/Kuvar/index.jsp"><strong>Koolinarka</strong></a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto" id="n">
			<li class="nav-item"><a class="nav-link" href="/Kuvar/controller/search">Search</a></li>
			<li class="nav-item"><a class="nav-link" href="/Kuvar/controller/allRecepts">All recipes</a></li>
			</ul>
			<!-- Search form -->

			<ul class="navbar-nav nav-flex-icons">
				<s:authorize access="hasRole('admin')">
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/admin/addCategory.jsp">Add
							Category</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/controller/admin/statistics">Statistics</a></li>
				</s:authorize>

				<s:authorize access="isAuthenticated()">
					<li class="nav-item"><a class="nav-link"
						href="/Kuvar/controller/users/profile">Profil</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/logout">Log Out</a></li>
				</s:authorize>
				<s:authorize access="!isAuthenticated()">
					<li class="nav-item"><a class="nav-link"
						href="/Kuvar/signup.jsp">Sign Up</a></li>
					<li class="nav-item"><a class="nav-link"
						href="/Kuvar/login.jsp">Log In</a></li>
				</s:authorize>
			</ul>
		</div>
	</nav>

</header>
<!--Main Navigation-->









