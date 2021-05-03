<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
<title>Insert title here</title>
</head>
<body>

	<form action="/user/loginPost" method="post">
		<div class="form-group has feedback">
			<input type="text" name="uid" class="form-control" placeholder="ID" />
			<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
		</div>
		<div class="form-group has-feedback">
			<input type="text" name="upw" class="form-control" placeholder="PW" />
			<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
		</div>
		<div class="row">
			<div class="col-xs-8">
				<div class="checkbox icheck">
					<label>
						<input type="checkbox" name="useCookie">Remember Me
					</label>
				</div>
			</div>
			<div class="col-xs-4">
				<button type="submit" class="btn btn-primary btn-block btn-flat">Sign in</button>
			</div>
		</div>
	</form>
</body>
</html>