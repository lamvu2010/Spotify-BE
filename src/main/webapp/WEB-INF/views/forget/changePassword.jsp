<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Foget Password</title>
<base href ="${pageContext.servletContext.contextPath }/">
</head>
<body>
<form action="/SpotifyWeb/forget/requestEmail.htm" method="POST" >
							<div>
								<label>Username: </label>
								${username}
							</div>
							<div>
								<label>Mật khẩu mới</label>
								<input name="password1" type="password" maxlength="20"/>
							</div>
							<div>
								<label>Xác nhận</label>
								<input name="password2" type="password" maxlength="20"/>
							</div>
							<div >
								<div style="margin-left: 2.5em">
									<button name="supply">Xác nhận </button>
									<p>${message}</p>
								</div>
								<button onclick="location.href='http://localhost:8080/SpotifyWeb/home/login.htm'"
									type="button">Về trang đăng nhập</button>
							</div>
	</form>
</body>
</html>