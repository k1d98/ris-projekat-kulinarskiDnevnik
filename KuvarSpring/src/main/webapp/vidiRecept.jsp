<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Recipe</title>
</head>
<body id="index">
	<div class="container emp-profile">
		<form method="post">
			<div class="row">

				<div class="col-md-12">
					<div class="profile-head">
						<div align="center">
							<h2 class="deep-orange-text font-weight-bold">${rec.name }</h2>
							<h6 class="deep-orange-text font-weight-bold">Posted by:
								${rec.user.username }</h6>
						</div>

					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-md-4">
					<div class="profile-work">
						<div class="list-group">
							<a href="#"
								class="list-group-item #d32f2f red darken-2 list-group-item-action active">
								Igredients:</a>
							<c:forEach items="${rec.contains}" var="s">
								<li class="list-group-item">${s.ingredient.name }<div
										align="right">${s.amount}</div>
								</li>
							</c:forEach>
						</div>
					</div>
				</div>
				<div class="col-md-8">
					<div class="tab-content profile-tab" id="myTabContent">
						<h2>Category: ${rec.category.name }</h2>
						<h3>Description:</h3>
						<p>${rec.description }</p>
						<h4>Added on ${rec.date }</h4>
						<c:forEach items="${rec.pictures }" var="p">
							<div class="gallery">
								<a target="_blank" href="${p.path}"> <img src="${p.path }"
									width="600" height="400">
								</a>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</form>
	</div>
</body>
</html>