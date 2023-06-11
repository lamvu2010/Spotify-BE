<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<base href="${pageContext.servletContext.contextPath }/">
<link href="${pageContext.request.contextPath}/Pages/Common/style.css" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
	integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr"
	crossorigin="anonymous">
<link rel="stylesheet" href="./resources/audience/lib/library.css" />
<link rel="stylesheet" href="./resources/audience/lib/index.css" />
<link rel="stylesheet" href="./resources/audience/lib/player.css" />
<link rel="stylesheet"
	href="path/to/font-awesome/css/font-awesome.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<link
	href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.8.14/themes/base/jquery-ui.css"
	rel="stylesheet" />
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>

<title>Document</title>

<script>
	$(window).on('load', function() {

		var id_playlist = localStorage.getItem("valueButton");
		var id = $(document).find(".idPlaylist_deleteTrack");
		id.val(id_playlist);
	})

	$(document).on('click', ".btn-open-playlist", function(e) {
		localStorage.setItem("valueButton", $(this).val());
	})
</script>
</head>
<body class="dark">

	<div class="container">
		<nav class="sidebar">
			<header>
				<ul class="menu-links card-box general">
					<li class="nav-link"><a href="/SpotifyWeb/audience/home.htm">
							<i class='fa fa-home icon' aria-hidden="true"></i> <span
							class="text nav-text">Home</span>
					</a></li>
					<li class="nav-link"><a href="/SpotifyWeb/audience/search.htm">
							<i class='fa fa-search icon' aria-hidden="true"></i> <span
							class="text nav-text">Search</span>
					</a></li>
				</ul>
			</header>
			<div class="menu-bar">
				<ul class="menu-links card-box">
					<li class="nav-link"><a
						href="/SpotifyWeb/audience/library.htm"> <i
							class='fa fa-list icon' aria-hidden="true"></i> <span
							class="text nav-text">Library</span>
					</a>
						<div class="features">
							<i class="fa fa-plus icon" role="button" data-bs-toggle="modal"
								data-bs-target="#exampleModal"></i> <i
								class='fa fa-chevron-left icon toggle'></i>
						</div></li>
				</ul>
				<div class="spotify-playlists custom-scroll">
					<div class="list grid-lib">
						<form action="/SpotifyWeb/audience/library.htm" method="get">
							<div class="item text-center" id="lovesongs">
								<img
									src="https://cdn1.iconfinder.com/data/icons/multimedia-sound-1/32/Add_category-_playlist-256.png" />
								<h4>Love songs</h4>
								<button class="btn btn-dark" type="submit">Open</button>
							</div>
						</form>
						<c:forEach items="${playlists}" var="playlist" varStatus="status">

							<div class="item text-center">
								<form action="/SpotifyWeb/audience/show1Playlist.htm"
									method="get">
									<img
										src="https://cdn1.iconfinder.com/data/icons/multimedia-sound-1/32/Add_category-_playlist-256.png" />
									<div>
										<input name="namePlaylist" value="${playlist.name}" hidden>
										<h4>${playlist.name}</h4>
										<input name="idPlaylist" value="${playlist.id_playlist}"
											hidden>
										<button class="btn btn-dark btn-open-playlist" type="submit"
											value="${playlist.id_playlist}">Open</button>
									</div>
								</form>
								<br>
								<form action="/SpotifyWeb/audience/deletePlaylist.htm"
									method='post'>
									<button name="idPlaylist_delete" class="btn btn-dark"
										type="submit" value="${playlist.id_playlist}">Delete</button>
								</form>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</nav>

		<div class="main-wrapper">
			<div class="main-content custom-scroll">
				<div class="header-main">
					<div class="logo">

						<img
							src="https://storage.googleapis.com/pr-newsroom-wp/1/2018/11/Spotify_Logo_CMYK_Green.png"
							alt="Logo" />

					</div>
					<div class="dropdown user-info">
						<button class="btn rounded-circle" type="button"
							id="dropdownMenuButton1" data-bs-toggle="dropdown"
							aria-expanded="false">
							<i class="fa fa-user" aria-hidden="true"></i>
						</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
							<li class="mode"><span class="mode-text">Dark mode</span>
								<div class="toggle-switch">
									<span class="switch"></span>
								</div></li>
								<li><a href="/SpotifyWeb/audience/info.htm">Profile</a></li>
								<li><a href="/SpotifyWeb/audience/changePassword.htm"> Change Password</a></li>
							<li class=""><a href="/SpotifyWeb/home/login.htm"> <i
									class='bx bx-log-out icon'></i> <span class="">Logout</span>
							</a></li>
							
						</ul>
					</div>
				</div>
				<div class="library">
					<div id="container lib-details">
						<div class="row">
							<div class="col-3">
								<img class="cover" src="./resources/img/OIP.jpg" />
							</div>
							<div class="col-sm">
								<div class="row">
									<div class="col-8 text">
										<h5>${title}</h5>
									</div>
								</div>
								<div class="row">
									<div class="col-8 text playlist-name">
										<h3>${namePlaylist}</h3>
									</div>
								</div>
							</div>
						</div>
					</div>
					<table class="table table-lib">
						<thead>
							<tr>
								<th>Title</th>
								<th>Time</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${playlistShow}" var="track">
								<tr>
									<td><h5>${track.name}</h5></td>
									<td><audio id="player" controls>
											<source src="data:audio/mp3;base64,${track.path}">
										</audio></td>
									<c:if test = "${type == 'private'}">
										<td><form action="/SpotifyWeb/audience/deleteTrack.htm"
												method="post">
												<input name="idPlaylist" class="idPlaylist_deleteTrack"
													hidden>

												<button type="submit" name="idTrack"
													class="btn-delete-track" value="${track.id_track }">Xóa</button>

											</form></td>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<script type="text/javascript"
						src="./resources/audience/lib/library.js"></script>
				</div>
			</div>
		</div>
	</div>
	<!-- Modal -->
	<form action="/SpotifyWeb/audience/addPlaylist.htm" method='post'>
		<div class="modal fade" id="exampleModal" tabindex="-1"
			aria-labelledby="exampleModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="exampleModalLabel">Add Playlist</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">
						<label name="namePlaylist">Name of playlist</label> <input
							name="namePlaylist" type="text">
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
						<button type="submit" class="btn btn-primary">Add</button>
					</div>
				</div>
			</div>
		</div>
	</form>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>
	<script src="./resources/audience/lib/test.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</body>
</html>

