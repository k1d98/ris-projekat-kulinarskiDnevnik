<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add ingredients</title>
</head>
<body id="index">
	<!-- Material form subscription -->
	<div class="card">

		<h5
			class="card-header #d32f2f red darken-2 white-text text-center py-4">
			<strong>Add ingredient</strong>
		</h5>

		<!--Card content-->
		<div class="card-body px-lg-5">

			<!-- Form -->
			<form class="text-center" style="color: #757575;"
				action="/Kuvar/controller/users/addIngredient" method="post">

				<!-- Name -->
				<div class="md-form mt-3">
					<input type="text" id="materialSubscriptionFormPasswords"
						name="name" class="form-control" placeholder="name">
				</div>
				<div class="md-form mt-3">
					<input type="text" id="materialSubscriptionFormPasswords"
						name="amount" class="form-control" placeholder="amount">
				</div>



				<!-- Sign in button -->
				<button
					class="btn btn-outline-danger btn-rounded btn-block z-depth-0 my-4 waves-effect"
					type="submit">Add ingredient</button>

			</form>
			<!-- Form -->
			<form action="/Kuvar/users/addPics.jsp">
				<button
					class="btn btn-outline-danger btn-rounded btn-block z-depth-0 my-4 waves-effect"
					type="submit">Add pictures</button>
			</form>
		</div>

	</div>
	<!-- Material form subscription -->
</body>
</html>