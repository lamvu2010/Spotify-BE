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
<form action="/Spotify/forget/requestEmail.htm" method="POST" >
							<c:if test="${btnStatus=='sendEmail'}">
							<div>
								<label>Email</label>
								<input name="email" type="text" maxlength="254"/>
							</div>
							</c:if>
							<c:if test="${btnStatus=='confirm'}">
							<div>
								<label>Email: </label>
								${email}
							</div>
							<div>
								<label>Mã xác thực</label>
								<input name="code" type="text" maxlength="8"/>
							</div>
							</c:if>
							<div >
								<div style="margin-left: 2.5em">
								<button onclick="location.href='http://localhost:8080/Spotify/forget/requestEmail.htm'"
									type="button">Tải lại trang</button>
								<c:if test="${btnStatus=='sendEmail'}">
									<button name="${btnStatus}">Gửi email</button>
								</c:if>
								<c:if test="${btnStatus=='confirm'}">
									<button name="${btnStatus}">Xác thực </button>
								</c:if>
									<p>${message}</p>
								</div>
							</div>
	</form>
</body>
</html>