<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search</title>
</head>
<body>
<body id="index">
	<div class="background">
		<div class="transbox">
			<h3>Search by:</h3>
			<form action="/Kuvar/controller/searchCategory" method="get">
				<c:if test="${!empty kategorije }">
					<select name="idKat"
						class="white-text btn #558b2f light-green darken-3 dropdown-toggle mr-4"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<c:forEach items="${kategorije }" var="k">
							<option value="${k.idCategory }" class="dropdown-item white-text">${k.name}</option>
						</c:forEach>
					</select>
				</c:if>
				<input type="submit" value="Search by category">
			</form>
			<h3>OR</h3>
			<form action="/Kuvar/controller/searchIngredient" method="get">
				<c:if test="${!empty ingredients }">
					<select name="idI"
						class="white-text btn #558b2f light-green darken-3 dropdown-toggle mr-4"
						data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
						<c:forEach items="${ingredients }" var="k">
							<option value="${k.idIngredient }" class="dropdown-item white-text">${k.name}</option>
						</c:forEach>
					</select>
				</c:if>
				<input type="submit" value="Search by ingredient">
			</form>
			<br>
			<br>
			<h2 align="center">Search results</h2>
			 ${greska}
			<c:if test="${!empty kategorijeSearch }">
				<c:forEach items="${kategorijeSearch }" var="r">
					<ul class="list-group list-group-flush">

						<li class="list-group-item">
							<h3>
								<a href="/Kuvar/controller/showRecept?idR=${r.idRecipe }"
									class="deep-orange-text font-weight-bold">${r.name }</a>
							</h3> posted by ${r.user.username } <s:authorize
								access="isAuthenticated()">
								<div align="right" class="trans0">
									<form
										action="/Kuvar/controller/users/addReceptToCategory?idR=${r.idRecipe }"
										method="post">
										<c:if test="${!empty omiljeneCR }">
											<select name="idFavKat"
												class="white-text btn #558b2f light-green darken-3 dropdown-toggle mr-4"
												data-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false">
												<c:forEach items="${omiljeneCR }" var="k">
													<option value="${k.idFavouriteCategory }"
														class="dropdown-item white-text">${k.name}</option>
												</c:forEach>
											</select>
											<input type="submit" value="add"
												class="btn btn-outline-danger btn-rounded waves-effect white-text">
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
								<a href="/Kuvar/controller/showRecept?idR=${r.recipe.idRecipe }"
									class="deep-orange-text font-weight-bold">${r.recipe.name }</a>
							</h3> posted by ${r.recipe.user.username } <s:authorize
								access="isAuthenticated()">
								<div align="right" class="trans0">
									<form
										action="/Kuvar/controller/users/addReceptToCategory?idR=${r.recipe.idRecipe }"
										method="post">
										<c:if test="${!empty omiljeneCR }">
											<select name="idFavKat"
												class="white-text btn #558b2f light-green darken-3 dropdown-toggle mr-4"
												data-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false">
												<c:forEach items="${omiljeneCR }" var="k">
													<option value="${k.idFavouriteCategory }"
														class="dropdown-item white-text">${k.name}</option>
												</c:forEach>
											</select>
											<input type="submit" value="add"
												class="btn btn-outline-danger btn-rounded waves-effect white-text">
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