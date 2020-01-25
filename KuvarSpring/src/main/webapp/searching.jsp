<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<body id="index">
	<div class="background">
		<div class="transbox">
		<br><br>
		<h2 align="center">Search results</h2>
		<c:if test="${empty kategorijeSearch && empty contains }">
		<div align="center" class="alert alert-danger" role="alert">
			<h1>Nothing to show</h1>
			
		</div>
		</c:if>
			<c:if test="${!empty kategorijeSearch }">
				<c:forEach items="${kategorijeSearch }" var="r">
					<ul class="list-group list-group-flush">
			
						<li class="list-group-item">
							<h3>
								<a href="/Kuvar/controller/showRecept?idR=${r.idRecipe }" class="deep-orange-text font-weight-bold">${r.name }</a>
							</h3> posted by ${r.user.username } 
							<s:authorize access="isAuthenticated()">
								<div align="right" class="trans0">
									<form action="/Kuvar/controller/users/addReceptToCategory?idR=${r.idRecipe }" method="post">
										<c:if test="${!empty omiljeneCR }">
											<select name="idFavKat" class="white-text btn #558b2f light-green darken-3 dropdown-toggle mr-4" data-toggle="dropdown"
  aria-haspopup="true" aria-expanded="false">
												<c:forEach items="${omiljeneCR }" var="k">
													<option value="${k.idFavouriteCategory }" class="dropdown-item white-text">${k.name}</option>
												</c:forEach>
											</select>
											<input type="submit" value="add" class="btn btn-outline-danger btn-rounded waves-effect white-text">
										</c:if>
									</form>
								</div>
							</s:authorize>
						</li>
			
			</ul>
				</c:forEach>
			</c:if>
			
			
			<c:if test="${!empty contains }">
				<c:forEach items="${contains }" var="r">
					<ul class="list-group list-group-flush">
			
						<li class="list-group-item">
							<h3>
								<a href="/Kuvar/controller/showRecept?idR=${r.recipe.idRecipe }" class="deep-orange-text font-weight-bold">${r.recipe.name }</a>
							</h3> posted by ${r.recipe.user.username } 
							<s:authorize access="isAuthenticated()">
								<div align="right" class="trans0">
									<form action="/Kuvar/controller/users/addReceptToCategory?idR=${r.recipe.idRecipe }" method="post">
										<c:if test="${!empty omiljeneCR }">
											<select name="idFavKat" class="white-text btn #558b2f light-green darken-3 dropdown-toggle mr-4" data-toggle="dropdown"
  aria-haspopup="true" aria-expanded="false">
												<c:forEach items="${omiljeneCR }" var="k">
													<option value="${k.idFavouriteCategory }" class="dropdown-item white-text">${k.name}</option>
												</c:forEach>
											</select>
											<input type="submit" value="add" class="btn btn-outline-danger btn-rounded waves-effect white-text">
										</c:if>
									</form>
								</div>
							</s:authorize>
						</li>				
			</ul>
				</c:forEach>
			</c:if>
		</div>
	</div>
</body>
</html>