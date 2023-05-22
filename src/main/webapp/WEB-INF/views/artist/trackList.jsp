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
						TrackList
					</div>
					<div >
						<table >
							<thead>
								<tr>
									<th>Name</th>
									<th>Music</th>
									<th>UploadDate</th>
									<th>Like</th>
									<th>Genre</th>
									<th>Display</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="track" items="${trackList}">
									<tr>
										<td>${track.name}</td>
										<td>
											<audio controls>
											<source src="data:audio/mp3;base64,${track.path}">
											</audio>
										</td>
										<%-- <td>
										<c:forEach var="information" items="${track.informationTracks}">
										${information.artist.fullname}
										</c:forEach>
										</td> --%>
										<td>${track.uploadDate}</td>
										<td>${track.like}</td>
										<td>${track.genre.type}</td>
										<td><a href="/SpotifyWeb/artist/trackList/${track.id_track}.htm?linkEdit"
											>${track.isPublic}</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					</form:form>
				</div>
</body>
</html>