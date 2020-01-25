<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Main Page</title>
</head>
<body id="index">
	<div class="background">
		<div class="transbox">
		<br><br>
			<h1 align="center">Welcome to Koolinarka</h1>
			<h2 align="center">Amazing site for recipes</h2>
			<hr>
			<s:authorize access="!isAuthenticated()">
			<h5 align="center">Start with <a href="/Kuvar/signup.jsp">Sign up</a></h5>
			<h5 align="center">Or if you have an account then <a href="/Kuvar/login.jsp">Log in</a></h5>
			<hr>
			<h6 align="center">As guest you can see all recipes <a href="/Kuvar/controller/allRecepts">here</a></h6>
			</s:authorize>
			<s:authorize access="isAuthenticated()">
			
			<h3 align="center">You can see all recipes <a href="/Kuvar/controller/allRecepts">here</a></h3>
			</s:authorize>
		</div>
	</div>
</body>
</html>