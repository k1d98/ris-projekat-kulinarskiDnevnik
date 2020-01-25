<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ include file="header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign Up</title>
</head>
<body id="index">
	<!-- Material form register -->
	<div class="card">

		<h5 class="card-header #d32f2f red darken-2 white-text text-center py-4">
			<strong>Sign up</strong>
		</h5>

		<!--Card content-->
		<div class="card-body px-lg-5 pt-0">

			<!-- Form -->
			<form class="text-center" style="color: #757575;" action="${pageContext.request.contextPath}/controller/newUser" method="post">

				<div class="form-row">
					<div class="col">
						<!-- First name -->
						<div class="md-form">
							<input type="text" name="name" id="materialRegisterFormFirstName"
								class="form-control" placeholder="First name"> 
						</div>
					</div>
					<div class="col">
						<!-- Last name -->
						<div class="md-form">
							<input type="text"  name="surname" id="materialRegisterFormLastName"
								class="form-control" placeholder="Last name">
						</div>
					</div>
				</div>

				<!-- E-mail -->
				<div class="md-form mt-0">
					<input type="email"  name="email" id="materialRegisterFormEmail"
						class="form-control" placeholder="email"> 
				</div>
				<div class="md-form">
							<input type="text" name="username" id="materialRegisterFormFirstName"
								class="form-control" placeholder="Username"> 
						</div>
				<!-- Password -->
				<div class="md-form">
					<input type="password"  name="password" id="materialRegisterFormPassword"
						class="form-control"
						aria-describedby="materialRegisterFormPasswordHelpBlock" placeholder="Password">
						<small
						id="materialRegisterFormPasswordHelpBlock"
						class="form-text text-muted mb-4"> At least 8 characters
						and 1 digit </small>
				</div>

				<!-- Sign up button -->
				<button
					class="btn btn-outline-danger btn-rounded btn-block my-4 waves-effect z-depth-0"
					type="submit">Sign in</button>



			</form>
			<!-- Form -->

		</div>

	</div>
	<!-- Material form register -->
</body>
</html>