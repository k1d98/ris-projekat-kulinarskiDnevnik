<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Category</title>
</head>
<body id="index">
	<!-- Material form contact -->
	<div class="card">

		<h5 class="card-header #d32f2f red darken-2 white-text text-center py-4">
			<strong>Add Category</strong>
		</h5>

		<!--Card content-->
		<div class="card-body px-lg-5 pt-0">

			<!-- Form -->
			<form class="text-center" style="color: #757575;"
				action="/Kuvar/controller/users/addFavC" method="post">

				<!-- Name -->
				<div class="md-form mt-3">
					<input type="text" id="materialContactFormName"
						class="form-control" name="name" placeholder="name"> 
				</div>


				<!-- Send button -->
				<button
					class="btn btn-outline-danger btn-rounded btn-block z-depth-0 my-4 waves-effect"
					type="submit">Add Category</button>

			</form>
			<!-- Form -->
		<c:if test="${!empty novaKatFav }">
			<p align="center">You have sucessfully added new Fav Category with ID ${novaKatFav.idFavouriteCategory}, named ${novaKatFav.name}
				</p>
		</c:if>
		</div>

	</div>
	<!-- Material form contact -->
</body>
</html>