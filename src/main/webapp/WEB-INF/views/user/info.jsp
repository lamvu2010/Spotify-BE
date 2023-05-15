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
<form:form modelAttribute="user" action="/Spotify/user/info.htm" method="POST">
							<div hidden="true">
								<label>Username</label>
								<form:input path="username" type="text" maxlength="20"/>
							</div>
							<div>
								<label>Username</label>
								<form:input path="username" disabled="true" type="text" maxlength="20"/>
							</div>
							<form:hidden path="password"/>
							<form:hidden path="lock"/>
							<form:hidden path="permission"/>
							<c:if test="${btnStatus=='btnEdit'}">
							<div hidden="true">
								<label>Fullname</label>
								<form:input path="fullname" type="text" maxlength="60"/>
							</div>
							<div>
								<label>Fullname</label>
								<form:input path="fullname" disabled="true" type="text" maxlength="60"/>
							</div>
							<div hidden="true">
								<label>Birthday</label>
								<form:input path="birthday" type="date"/>
							</div>
							<div>
								<label>Birthday</label>
								<form:input path="birthday" disabled="true" type="date"/>
							</div>
							<div hidden="true">
								<label>Phonenumber</label>
								<form:input path="phonenumber" type="text" maxlength="10"/>
							</div>
							<div>
								<label>Phonenumber</label>
								<form:input path="phonenumber" disabled="true" type="text" maxlength="10"/>
							</div>
							<div hidden="true">
								<label>Nation</label>
								<form:input path="nation" type="text" maxlength="56"/>
							</div>
							<div>
								<label>Nation</label>
								<form:input path="nation" disabled="true" type="text" maxlength="56"/>
							</div>
							<div hidden="true">
								<label>Email</label>
								<form:input path="email" type="text" maxlength="254"/>
							</div>
							<div>
								<label>Email</label>
								<form:input path="email" disabled="true" type="text" maxlength="254"/>
							</div>
							</c:if>
							<c:if test="${btnStatus=='btnSave'}">
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
							</c:if>
							<div >
								<div style="margin-left: 2.5em">
								<c:if test="${btnStatus=='btnEdit'}">
								<button name="btnEdit">Chỉnh sửa thông tin</button>
								</c:if>
								<c:if test="${btnStatus=='btnSave'}">
								<button name="btnSave">Lưu thay đổi</button>
								</c:if>
									<p5 class="text-danger">${message}</p5>
								</div>
								<button onclick="location.href='http://localhost:8080/Spotify/user/info.htm'"
									type="button">Tải lại trang</button>
							</div>
	</form:form>
</body>
</html>