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
   	<!-- <link rel="stylesheet" href="../Pages/Common/style.css"> -->
   	
    
    <title>Artist Page</title>
    <base href ="${pageContext.servletContext.contextPath}/">
    <link href="${pageContext.request.contextPath}/Pages/Common/style.css" rel="stylesheet">
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
                <button class="btn-spotify" onclick="showCreateAlbum()">Add album</button>
                <button onclick="location.href='/SpotifyWeb/artist/index.htm'"
									type="button" class="btn-spotify">Refresh</button>
                <!-- Page Title -->
                <div class="d-flex justify-content-between align-items-center mb-3"></div>
                <!-- Page Body -->
                <div class="row d-flex justify-content-center">
                <div class="col-10">

                    <!-- Form sign up account -->
                    <form:form modelAttribute="album" action="/SpotifyWeb/artist/index.htm" method="POST" enctype="multipart/form-data" class="signup-form row d-none" id="signup-form">
                    	<form:hidden path="id_playlist"/>
						<form:hidden path="createdDate"/>
						<form:hidden path="status"/>
						<form:hidden path="user.username"/>
						<form:hidden path="image"/>
						
						
                        <div class="d-flex justify-content-center align-items-end gx-3 role-inputs mb-4">
                            <div class="px-4">
                                <form:radiobutton path="isPublic" value="True" id="public" ></form:radiobutton>
                                            <label for="public" class="fw-bold">Public</label>
                            </div>
                            <div class="px-4">
                                <form:radiobutton path="isPublic" value="False" id="private" ></form:radiobutton>
                                            <label for="private" class="fw-bold">Private</label>
                            </div>
                            <form:errors path="isPublic" class="text-danger"/>
                        </div>

                        <label class="ps-0 mb-1 fw-bold" for="name">What is Album's name?</label> 
                        <form:input path="name" id="name" type="text" maxlength="50"  placeholder="Enter album name" class="form-control mb-4"/>
						<form:errors path="name" class="text-danger"/>
                        
                        <label class="ps-0 mb-1 fw-bold" for="image">What's Album's photo?</label>
                        <input type="file" name="photo">
                        <form:errors path="image" class="text-danger"/>
                                    
						<button name="${btnStatus}" class="btn-spotify mt-4 mb-5">Confirm</button>
                        
						</form:form>
						
				<h5 class="text-danger">${message}</h5>
				
                <!-- Track -->
                <div class="row">
                    <button class="bg-dark text-white py-3 my-3 fw-bold" id="btnTrackTitle"
                        onclick="controlTrackTable()">
                        Tracks
                        <i class="fa-solid fa-caret-down"></i>
                    </button>
                    <!-- Track list -->
                    <table class="table" id="trackTable">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Artist</th>
								<th>Music</th>
								<th>UploadDate</th>
								<th>Like</th>
								<th>Genre</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="track" items="${trackList}">
									<tr>
										<td>${track.name}</td>
										<td>
										<c:forEach var="information" items="${track.informationTracks}">
										${information.artist.fullname}
										</c:forEach>
										</td>
										<td>
											<audio controls style="height: 25px;">
											<source src="data:audio/mp3;base64,${track.path}">
											</audio>
										</td>
										
										<td>${track.uploadDate}</td>
										<td>${track.like}</td>
										<td>${track.genre.type}</td>
										<td class="d-flex justify-content-between actionCol" data-lock="${!track.isPublic}">
		                                    <a href="/SpotifyWeb/artist/index/track/${track.id_track}.htm?linkEdit" class="lockAction">
	                                            <i class="fa-solid fa-lock-open"></i>
	                                            <i class="fa-solid fa-lock" style="color: #520000;"></i>
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
                        Albums
                        <i class="fa-solid fa-caret-down"></i>
                    </button>
                    <!-- Album list -->
                    <table class="table" id="albumTable">
                        <thead>
                            <tr>
                                <th>Album Name</th>
								<th>CreatedDate</th>
								<th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                       			<c:forEach var="album" items="${albumList}">
									<tr>
										<td>${album.name}</td>
										<td>${album.createdDate}</td>
										<td class="d-flex justify-content-between actionCol" data-lock="${!album.isPublic}">
		                                    <a href="/SpotifyWeb/artist/index/album/${album.id_playlist}.htm?linkEdit" class="lockAction">
	                                            <i class="fa-solid fa-lock-open"></i>
	                                            <i class="fa-solid fa-lock" style="color: #520000;"></i>
                                        	</a>
		                                    <a href="/SpotifyWeb/artist/index/album/${album.id_playlist}.htm?linkDelete" class="text-decoration-none">
		                                        <i class="fa-solid fa-xmark text-danger fs-3 fw-bolder hover-scale"></i>
		                                    </a>
		                                    <a href="/SpotifyWeb/artist/index/album/${album.id_playlist}.htm?linkShowAlbum" class="text-decoration-none" title="Xem danh sách">
		                                        <i class="fa-solid fa-list-check text-black mx-4 fs-3 fw-bolder hover-scale"></i>
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
        var actionCols = document.querySelectorAll("table tbody .actionCol")
        for(var i = 0;i<actionCols.length; i++){
            if(actionCols[i].getAttribute("data-lock") == "true"){
                actionCols[i].querySelector(".fa-lock-open").classList.add("d-none")
            }
            else actionCols[i].querySelector(".fa-lock").classList.add("d-none")
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