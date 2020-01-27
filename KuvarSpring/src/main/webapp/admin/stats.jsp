<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Statistics</title>
</head>
<body id="index">
	<div class="background">
		<div class="transbox">
			<br>
			<h1 align="center">Statistics</h1>
			<h3>Number of recipes per category</h3>
			<c:if test="${!empty cat }">
				<ul class="list-group">
					<c:forEach items="${cat }" var="r">
						<li class="list-group-item">${r.name }= ${r.recipes.size() }</li>
					</c:forEach>
				</ul>
			</c:if>
			<h2>Report</h2>
			<form action="/Kuvar/controller/admin/generateReportCat" method="post">
			<input type="submit" value="generate">
			</form>
	<br><br>
			<h3>Number of recipes per day</h3>
			Choose date:
			<form action="/Kuvar/controller/admin/datePicker">
				<input type="date" name="date">
				 <input type="submit" value="Get number">
			</form>
			<c:if test="${!empty datumBr }">
				On the date ${datum } users posted ${datumBr } recipes
			</c:if>
		</div>
	</div>
</body>
</html>