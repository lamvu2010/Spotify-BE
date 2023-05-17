<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Album List</title>
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
<form:form modelAttribute="album" action="/SpotifyWeb/artist/albumList.htm" method="POST" enctype="multipart/form-data">
							<form:hidden path="id_playlist"/>
							<form:hidden path="createdDate"/>
							<form:hidden path="status"/>
							<form:hidden path="user.username"/>
							<form:hidden path="image"/>
							<div>
								<label>Name</label>
								<form:input path="name" type="text" maxlength="50"/>
								<p style="color: red; font-style: oblique">
									<form:errors path="name" />
								</p>
							</div>
							<div>
								<label>Image</label>
								<input type="file" name="photo">
								
								<p style="color: red; font-style: oblique">
									<form:errors path="image" />
								</p>
							</div>
							
							<div>
								<label>Public/ Private</label><br>
								<form:radiobutton path="isPublic" value="True" label="Public"></form:radiobutton>
								<form:radiobutton path="isPublic" value="False" label="Private"></form:radiobutton>
								<p>
									<form:errors path="isPublic" />
								</p>
							</div>
							<div >
								<div style="margin-left: 2.5em">
									<button name="${btnStatus}">Confirm</button>
									<p5 class="text-danger">${message}</p5>
								</div>
								<button onclick="location.href='http://localhost:8080/SpotifyWeb/artist/albumList.htm'"
									type="button">Tải lại trang</button>
							</div>
</form:form>
<div >
				<form:form method="POST">
					<div>
						AlbumList
					</div>
					<div >
						<table >
							<thead>
								<tr>
									<th>Name</th>
									<th>CreatedDate</th>
									<th>Show Album</th>
									<th>Display</th>
									<th>Delete</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="album" items="${albumList}">
									<tr>
										<td>${album.name}</td>
										<td>${album.createdDate}</td>
										<td><a href="/SpotifyWeb/artist/albumList/${album.id_playlist}.htm?linkShowAlbum"
											>Show</a></td>
										<td><a href="/SpotifyWeb/artist/albumList/${album.id_playlist}.htm?linkEdit"
											>${album.isPublic}</a></td>
											<td><a href="/SpotifyWeb/artist/albumList/${album.id_playlist}.htm?linkDelete"
											>Delete</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					</form:form>
				</div>
</body>
</html>