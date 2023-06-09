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
<title>Document</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link rel="stylesheet"
	href="https://use.fontawesome.com/releases/v5.7.2/css/all.css"
	integrity="sha384-fnmOCqbTlWIlj8LyTjo7mOUStjsKC4pOpQbqyi7RrhN7udi9RwhKkMHpvLbHG9Sr"
	crossorigin="anonymous">
<link rel="stylesheet" href="./resources/audience/home/index.css" />
<link rel="stylesheet" href="./resources/audience/home/player.css" />
<link rel="stylesheet"
	href="path/to/font-awesome/css/font-awesome.min.css">
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
					<li class="nav-link"><a href="/SpotifyWeb/audience/search.htm"> <i
							class='fa fa-search icon' aria-hidden="true"></i> <span
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
							<form action="/SpotifyWeb/audience/showLoveSongs.htm">
								<div class="item text-center" id="lovesongs" >
									<img
										src="https://cdn1.iconfinder.com/data/icons/multimedia-sound-1/32/Add_category-_playlist-256.png" />
									<h4>Love songs</h4>
									<button class="btn btn-dark" type="submit">Open</button>
								</div>
							</form>

							<c:forEach items="${playlists}" var="playlist" varStatus="status">
								<form
									action="/SpotifyWeb/audience/show1Playlist.htm" method="get"
									role="button">
									<div class="item">
										<img
											src="https://cdn1.iconfinder.com/data/icons/multimedia-sound-1/32/Add_category-_playlist-256.png" />
										<input name="namePlaylist" value="${playlist.name}" hidden>
										<h4>${playlist.name}</h4>
										<input name="idPlaylist" value="${playlist.id_playlist }"
											hidden>
										<button class="btn btn-dark" type="submit">Open</button>
									</div>
								</form>
							</c:forEach>
						</div>
					</div>

			</div>
	</nav>


	<div class="main-wrapper">
		<div class="main-content custom-scroll">
			<div class="header-main">
				<div class="logo">
					<a href="#"> <img
						src="https://storage.googleapis.com/pr-newsroom-wp/1/2018/11/Spotify_Logo_CMYK_Green.png"
						alt="Logo" />
					</a>
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
						<li class=""><a href="#"> <i class='bx bx-log-out icon'></i>
								<span class="">Logout</span>
						</a></li>
					</ul>
				</div>
			</div>
			<div class="home">
				<div class="spotify-playlists">
					<h2>Genre</h2>
					<div class="list">
						<c:forEach items="${genres}" var="genre">
							<form action="/SpotifyWeb/audience/genre.htm" method="post">
							<div class="item text-center">
								<img src="" />
								<h2>${genre.type}</h2>
								<input name="nameGenre" value="${genre.type}" hidden>
								<button class="btn btn-dark" type="submit">Open</button>
							</div>
							</form>
						</c:forEach>
					</div>
				</div>
				<div class="spotify-playlists">
					<h2>Artirst</h2>
					<div class="list">
						<c:forEach items="${artists}" var="artist">
							<form action="/SpotifyWeb/audience/artist.htm" method="post">
							<div class="item text-center">
								<img src="" />
								<h4>${artist.fullname}</h4>
								<input name="fullnameArtist" value="${artist.fullname}" hidden>
								<input name="idArtist" value="${artist.username}" hidden>
								<button class="btn btn-dark" type="submit">Open</button>
							</div>
							</form>
						</c:forEach>
					</div>
				</div>
				<div class="spotify-playlists">
					<h2>Old Songs</h2>
					<form action="/SpotifyWeb/audience/oldSongs.htm" method="post">
					<div class="list">
						<div class="item text-center">
							<img src="" />
							<h4>Today's Top Hits</h4>
							<button class="btn btn-dark" type="submit">Open</button>
						</div>
					</div>
					</form>
				</div>
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
	<script src="./resources/audience/home/test.js" />
</body>
</html>


1
