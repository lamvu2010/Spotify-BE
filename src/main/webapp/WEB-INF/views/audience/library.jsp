<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Track List</title>
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
<div >
<h1>${message}</h1>
				<form:form method="POST">
					<div>
						Library
					</div>
					<div >
						<table >
							<thead>
								<tr>
									<th>Name</th>
									<th>Created Date</th>
									<th>Image</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="playlist" items="${playlists}">
									<tr>
										<td>${playlist.name}</td>
										<td>${playlist.createdDate}</td>
										<td>${playlist.image}</td>
										<td><a href ="/SpotifyWeb/audience/library/${playlist.id_playlist}.htm?linkEdit"><button type ="button"> Show tracks</button></a></td>
										<td><a href ="/SpotifyWeb/audience/library/${playlist.id_playlist}.htm?linkDelete"><button type = "button">DeletePlaylist</button></a></td>
									</tr>
									<tr><a href="/SpotifyWeb/audience/library/addPlaylist.htm"><button type="button">ADD</button></a></tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					</form:form>
				</div>
</body>
</html>