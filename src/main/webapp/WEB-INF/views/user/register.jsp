<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
<base href ="${pageContext.servletContext.contextPath }/">
</head>
<body>
<form:form modelAttribute="user" action="/SpotifyWeb/user/register/form.htm" method="POST">
						
							<div>
								<label>Username</label>
								<form:input path="username" type="text" maxlength="20"/>
								<p style="color: red; font-style: oblique">
									<form:errors path="username" />
								</p>
							</div>
							<div>
								<label>Password</label>
								<form:input path="password" type="password" maxlength="20"/>
								<p style="color: red; font-style: oblique">
									<form:errors path="password" />
								</p>
							</div>
							<div>
								<label>Confirm password</label>
								<input name="password2" value="${password2}" type="password" maxlength="20"/>
								<p>
								</p>
							</div>
							<div>
								<label>Fullname</label>
								<form:input path="fullname" type="text" maxlength="60"/>
								<p style="color: red; font-style: oblique">
									<form:errors path="fullname" />
								</p>
							</div>
							<div>
								<label>Birthday</label>
								<form:input path="birthday" type="date"/>
								<p style="color: red; font-style: oblique">
									<form:errors path="birthday" />
								</p>
							</div>
							<div>
								<label>Phonenumber</label>
								<form:input path="phonenumber" type="text" maxlength="10"/>
								<p style="color: red; font-style: oblique">
									<form:errors path="phonenumber" />
								</p>
							</div>
							<div>
								<label>Nation</label>
								<form:input path="nation" type="text" maxlength="56"/>
								<p style="color: red; font-style: oblique">
									<form:errors path="nation" />
								</p>
							</div>
							<div>
								<label>Email</label>
								<form:input path="email" type="text" maxlength="254"/>
								<p style="color: red; font-style: oblique">
									<form:errors path="email" />
								</p>
							</div>
							<div >
								<div style="margin-left: 2.5em">
									<button>Đăng ký</button>
									<p5 class="text-danger">${message}</p5>
								</div>
								<button onclick="location.href='http://localhost:8080/SpotifyWeb/home/login.htm'"
									type="button">Về trang đăng nhập</button>
							</div>
	</form:form>
</body>
</html>