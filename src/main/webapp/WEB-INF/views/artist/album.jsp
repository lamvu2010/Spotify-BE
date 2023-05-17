<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Album</title>
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
	<button onclick="location.href='http://localhost:8080/SpotifyWeb/artist/albumList.htm'"
									type="button">Return</button>
	<button onclick="location.href='http://localhost:8080/SpotifyWeb/artist/albumList/${id_playlist}.htm?linkShowAlbum'"
									type="button">Refresh</button>
<h1>${message}</h1>
					<div>
						${name} 
					</div>
					<input type="hidden" name="name"/>
					<input type="hidden" name="id_playlist"/>
				
				<div>Uploaded</div>
					<div >
						<table >
							<thead>
								<tr>
									<th>Name</th>
									<th>Music</th>
									<th>UploadDate</th>
									<th>Like</th>
									<th>Genre</th>
									<th>Down</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="track" items="${trackAlbum}">
									<tr>
										<td>${track.name}</td>
										<td>
											<audio controls>
											<source src="data:audio/mp3;base64,${track.path}">
											</audio>
										</td>
										<td>${track.uploadDate}</td>
										<td>${track.like}</td>
										<td>${track.genre.type}</td>
										<td><a href="/SpotifyWeb/artist/albumList/${id_playlist}/${track.id_track}.htm?linkDown"
											>Down</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					
					<div>Not Uploaded</div>
					<div >
						<table >
							<thead>
								<tr>
									<th>Name</th>
									<th>Music</th>
									<th>UploadDate</th>
									<th>Like</th>
									<th>Genre</th>
									<th>Up</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="track" items="${notTrackAlbum}">
									<tr>
										<td>${track.name}</td>
										<td>
											<audio controls>
											<source src="data:audio/mp3;base64,${track.path}">
											</audio>
										</td>
										<td>${track.uploadDate}</td>
										<td>${track.like}</td>
										<td>${track.genre.type}</td>
										<td><a href="/SpotifyWeb/artist/albumList/${id_playlist}/${track.id_track}.htm?linkUp"
											>Up</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
</body>
</html>