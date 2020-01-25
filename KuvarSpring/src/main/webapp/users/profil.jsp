<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Profile</title>
<link
	href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css"
	rel="stylesheet" id="bootstrap-css">
<script
	src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->

</head>
<body id="index">
	<div class="container emp-profile">
		<form method="post">
			<div class="row">

				<div class="col-md-12">
					<div class="profile-head">
						<div align="center">
							<h3 class="deep-orange-text font-weight-bold">${user.name }
								${user.surname }</h3>
							<h6 class="deep-orange-text font-weight-bold">Username:
								${user.username }</h6>
						</div>
						<ul class="nav nav-tabs " id="myTab" role="tablist">
							<li class="nav-item"><a class="nav-link black-text"
								id="home-tab" data-toggle="tab" role="tab" aria-controls="home"
								aria-selected="true">Recipes</a></li>
							<li class="nav-item"><a class="nav-link black-text"
								id="profile-tab" data-toggle="tab"
								href="/Kuvar/controller/users/fwdAddRecipe" role="tab"
								aria-controls="profile" aria-selected="false">Add Your
									Recipe</a></li>
							<li class="nav-item"><a class="nav-link black-text"
								id="profile-tab" data-toggle="tab"
								href="/Kuvar/users/addFavCat.jsp" role="tab"
								aria-controls="profile" aria-selected="false">Add New Fav
									Category</a></li>
							<li class="nav-item"><a class="nav-link black-text "
								id="profile-tab" data-toggle="tab"
								href="/Kuvar/controller/users/myRecipes" role="tab"
								aria-controls="profile" aria-selected="false">My recipes</a></li>
						</ul>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="profile-work">
						<div class="list-group">
							<a href="#"
								class="list-group-item #d32f2f red darken-2 list-group-item-action active">
								Your friends:</a>
							<c:forEach items="${prijatelji }" var="s">
								<li class="list-group-item">${s.username }<div align="right"><a href="/Kuvar/controller/users/sendMessages?idUser=${s.idUser }"><i
										class="fas fa-envelope mr-3"></i> </a></div>
								</li>
							</c:forEach>
						</div>
						<div class="list-group">
							<a href="#"
								class="list-group-item #d32f2f red darken-2 list-group-item-action active">
								All users</a>
							<c:forEach items="${svi }" var="s">
								<li class="list-group-item">${s.username }<div align="right"><a href="/Kuvar/controller/users/addFriend?idP=${s.idUser }" ><i class="fab fa-lg fa-facebook-f"></i></a></div></li>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="col-md-8">
					<div class="tab-content profile-tab" id="myTabContent">
						<div class="tab-pane fade show active" id="home" role="tabpanel"
							aria-labelledby="home-tab">
							<c:if test="${! empty omiljene }">
								<c:forEach items="${omiljene }" var="o">
									<div class="list-group">
										<button type="button"
											class="list-group-item #d32f2f red darken-2 list-group-item-action active">
											${o.name }</button>
										<c:if test="${! empty o.recipes }">
											<c:forEach items="${o.recipes }" var="r">
												<a href="/Kuvar/controller/showRecept?idR=${r.idRecipe }" class="list-group-item list-group-item-action">
													${r.name }</a>
											</c:forEach>
										</c:if>
									</div>
								</c:forEach>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>