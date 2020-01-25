<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add new recipe</title>
</head>
<body id="index">
	<div class="background">

		<!-- Material form subscription -->
		<div class="card">

			<h5
				class="card-header #d32f2f red darken-2 white-text text-center py-4">
				<strong>Add recipe</strong>
			</h5>

			<!--Card content-->
			<div class="card-body px-lg-5">

				<!-- Form -->
				<form class="text-center" style="color: #757575;"
					action="/Kuvar/controller/users/addRecipe" method="post">


					<div class="md-form mt-3">
						<input type="text" id="materialSubscriptionFormPasswords"
							class="form-control" name="name" placeholder="Name">
					</div>
					<!-- Name -->
					<div class="md-form mt-3">
						<input type="text" id="materialSubscriptionFormPasswords"
							class="form-control" name="description" placeholder="Description">
					</div>
					<p>Add to category</p>
					<c:if test="${!empty kategorije }">
						<select name="idKat"
							class="white-text btn #558b2f light-green darken-3 dropdown-toggle mr-4"
							data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
							<c:forEach items="${kategorije }" var="k">
								<option value="${k.idCategory }"
									class="dropdown-item white-text">${k.name}</option>
							</c:forEach>
						</select>
					</c:if>
					
					<button
						class="btn btn-outline-danger btn-rounded btn-block z-depth-0 my-4 waves-effect"
						type="submit">Add recipe</button>

				</form>
				<!-- Form -->
				<c:if test="${!empty recept }">
				You have added new Recipe with id ${recept.idRecipe }
					<form action="/Kuvar/users/addIngr.jsp">
						<button
							class="btn btn-outline-danger btn-rounded btn-block z-depth-0 my-4 waves-effect"
							type="submit">Add ingredient</button>
					</form>
					<form action="/Kuvar/users/addPics.jsp">
						<button
							class="btn btn-outline-danger btn-rounded btn-block z-depth-0 my-4 waves-effect"
							type="submit">Add pictures</button>
					</form>
				</c:if>
			</div>
		</div>
	</div>
	<!-- Material form subscription -->
</body>
</html>