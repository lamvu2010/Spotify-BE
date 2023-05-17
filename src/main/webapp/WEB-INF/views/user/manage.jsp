<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>User Manager</title>
<base href ="${pageContext.servletContext.contextPath }/">
<style>
	table{
		border-collapse:collapse;
		width:100%;
	}
	th,td{
		line-height: 25px;
		border:1px solid black;
		padding:5px;
	}
	th{
		background-color:green;
	}
</style>
</head>
<body>
<div>
			<form:form modelAttribute="user" action="/SpotifyWeb/user/list.htm" method="POST">
							<div>
								<label>Username</label>
								<form:input path="username" type="text" maxlength="20"/>
								<p>
									<form:errors path="username" />
								</p>
							</div>
							<form:hidden path="password"/>
							<div>
								<label>Full name</label>
								<form:input path="fullname" type="text" maxlength="60"/>
								<p >
									<form:errors path="fullname" />
								</p>
							</div>
							<div>
							<label>Birthday</label>
							<form:input path="birthday" type="date"
								data-date-format="yyyy-MM-dd" name="NGAYSINH" min="1800-01-01"
							/>
							<p>
									<form:errors path="birthday" />
								</p>
							</div>
							<div>
								<label>Phonenumber</label>
								<form:input path="phonenumber" type="text" maxlength="10"/>
								<p>
									<form:errors path="phonenumber" />
								</p>
							</div>
							<div>
								<label>Email</label>
								<form:input path="email" type="text" maxlength="254"/>
								<p>
									<form:errors path="email" />
								</p>
							</div>
							<div>
								<label>Nation</label>
								<form:input path="nation" type="text" maxlength="56"/>
								<p >
									<form:errors path="nation" />
								</p>
							</div>
							<div>
								<label>Permission</label><br>
								<form:radiobutton path="permission" value="Admin" label="Admin"></form:radiobutton>
								<form:radiobutton path="permission" value="Artist" label="Artist"></form:radiobutton>
								<form:radiobutton path="permission" value="Audience" label="Audience"></form:radiobutton>
								<p>
									<form:errors path="permission" />
								</p>
							</div>
							<div>
								<label >Status</label><br>
								<form:radiobutton path="lock" value="False"
									label="Unlock" />
								<br>
								<form:radiobutton path="lock" value="True"
									label="lock" />
							</div>
							<div><button name="btnAdd">Thêm</button></div>
							<div >
							<p>${message}</p>
							<button onclick="location.href='http://localhost:8080/SpotifyWeb/user/list.htm'"
									type="button">Tải lại trang</button>
							</div>
	</form:form>
</div>
<div >
<form:form method="POST">
					<div>
						UserList
					</div>
					<div >
						<table >
							<thead>
								<tr>
									<th>Username</th>
									<th>Fullname</th>
									<th>Birthday</th>
									<th>Phonenumber</th>
									<th>Nation</th>
									<th>Email</th>
									<th>Lock</th>
									<th>Permission</th>
									<th>Lock/ Unclock</th>
									<th>Delete</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="user" items="${userList}">
									<tr>
										<td>${user.username}</td>
										<td>${user.fullname}</td>
										<td>${user.birthday}</td>
										<td>${user.phonenumber}</td>
										<td>${user.nation}</td>
										<td>${user.email}</td>
										<td>${user.lock}</td>
										<td>${user.permission}</td>
										<td><a href="/SpotifyWeb/user/list/${user.username}.htm?linkEdit"
											>lock/ unlock</a>
										</td>
										<td><a href="/SpotifyWeb/user/list/${user.username}.htm?linkDelete"
											>delete</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					</form:form>
				</div>
</body>
</html>