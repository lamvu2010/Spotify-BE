<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f" %>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.2.0/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">

    <script defer src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script defer src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>
    <base href ="${pageContext.servletContext.contextPath}/">
    <link href="${pageContext.request.contextPath}/Pages/Common/style.css" rel="stylesheet">
    <title>Artist Page</title>
</head>

<body>
    <div class="container-fluid p-0">
        <div class="row-cols-2 d-flex justify-content-center" style="height: 100vh;">
            <!-- Dashboard Here -->
            <%@ include file="/header/artist.jsp"%>
            <!-- Tracks Page Here -->
            <div class="col-10 bg-white pt-4 px-5 overflow-auto" style="height: 100vh;">
                <!-- Top Bar -->
                
                <%@ include file="/header/account.jsp"%>
                <button onclick="location.href='/SpotifyWeb/artist/index.htm'"
									type="button" class="btn-spotify">Return</button>
					<button onclick="location.href='/SpotifyWeb/artist/index/album/${id_playlist}.htm?linkShowAlbum'"
									type="button" class="btn-spotify">Refresh</button>
                <!-- Page Title -->
                <div class="d-flex justify-content-between align-items-center mb-3"></div>
                <!-- Page Body -->
                <div class="row d-flex justify-content-center">
				<h1 class="text-success">${name}</h1>
				<h3 class="text-danger">${message}</h3>
				
                <!-- Track -->
                <div class="row">
                    <button class="bg-dark text-white py-3 my-3 fw-bold" id="btnTrackTitle"
                        onclick="controlTrackTable()">
                        Album
                        <i class="fa-solid fa-caret-down"></i>
                    </button>
                    <!-- Track list -->
                    <table class="table" id="trackTable">
                        <thead>
                            <tr>
                                <th>Name</th>
								<th>Music</th>
								<th>UploadDate</th>
								<th>Like</th>
								<th>Genre</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="track" items="${trackAlbum}">
									<tr>
										<td>${track.name}</td>
										<td>
											<audio controls style="height: 25px;">
											<source src="data:audio/mp3;base64,${track.path}">
											</audio>
										</td>
										<td>${track.uploadDate}</td>
										<td>${track.like}</td>
										<td>${track.genre.type}</td>
										<td>
		                                    <a href="/SpotifyWeb/artist/index/album/${id_playlist}/${track.id_track}.htm?linkDown" class="text-decoration-none">
		                                        <i class="fa-solid fa-xmark text-danger fs-3 fw-bolder hover-scale"></i>
		                                    </a>
                                        </td>
                                    </tr>
							</c:forEach>
                        </tbody>
                    </table>
                </div>
                <!-- Album -->
                <div class="row">
                    <button class="bg-dark text-white py-3 my-3 fw-bold" id="btnAlbumTitle"
                        onclick="controlAlbumTable()">
                        Tracks NOT IN ALBUM
                        <i class="fa-solid fa-caret-down"></i>
                    </button>
                    <!-- Album list -->
                    <table class="table" id="albumTable">
                        <thead>
                            <tr>
                                <th>Name</th>
								<th>Music</th>
								<th>UploadDate</th>
								<th>Like</th>
								<th>Genre</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                       			<c:forEach var="track" items="${notTrackAlbum}">
									<tr>
										<td>${track.name}</td>
										<td>
											<audio controls style="height: 25px;">
											<source src="data:audio/mp3;base64,${track.path}">
											</audio>
										</td>
										<td>${track.uploadDate}</td>
										<td>${track.like}</td>
										<td>${track.genre.type}</td>
										<td>
		                                    <a href="/SpotifyWeb/artist/index/album/${id_playlist}/${track.id_track}.htm?linkUp" class="text-decoration-none">
		                                        <i class="fa-solid fa-check spotify-color mx-4 fs-3 hover-scale"></i>
		                                    </a>
                                        </td>
                                    </tr>
								</c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
    </div>

    </div>


    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
    <script>
        $(document).ready(function () {
            $('#trackTable').DataTable();
            $('#albumTable').DataTable();
        });
        function controlTrackTable() {
            var table = document.getElementById("trackTable_wrapper")
            if(table.classList.contains("d-none")){
                table.classList.remove("d-none")
            } else table.classList.add("d-none")
        }
        function controlAlbumTable(){
            var table = document.getElementById("albumTable_wrapper")
            if(table.classList.contains("d-none")){
                table.classList.remove("d-none")
            } else table.classList.add("d-none")
        }
        function showCreateAlbum() {
            var modal = document.getElementById("signup-form")
            if (modal.classList.contains("d-none")) {
                modal.classList.remove("d-none")
            }
            else modal.classList.add("d-none")
        }
        
    </script>
</body>

</html>