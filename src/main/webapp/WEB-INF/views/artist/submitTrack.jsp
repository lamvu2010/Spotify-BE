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

    <!-- Fontawesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
        integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
        crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- Boostrap -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <!-- <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"> -->
    <!-- DataTable file -->
    <link rel="stylesheet" href="https://cdn.datatables.net/1.13.4/css/dataTables.bootstrap5.min.css">
    <script defer src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.min.js"></script>
    <script defer src="https://cdn.datatables.net/1.13.4/js/dataTables.bootstrap5.min.js"></script>

    <!-- Css -->
    <base href ="${pageContext.servletContext.contextPath}/">
    <link href="${pageContext.request.contextPath}/Pages/Common/style.css" rel="stylesheet">
    <title>Artist Page</title>
</head>

<body>
    <div class="container-fluid p-0">
        <div class="row-cols-2 d-flex">
            
			<%@  include file="/header/artist.jsp" %>
            <div class="col-10 px-5 p-5 overflow-auto" style="height: 100vh;">
                <div class="row d-flex flex-column align-items-center">
                <%@ include file="/header/account.jsp"%>
                    <button onclick="location.href='/SpotifyWeb/artist/submitTrack.htm'" class="btn-spotify col-3 mb-3">Refresh</button>
                    <h3 class="text-danger text-center">${message}</h3>
                </div>
                <form:form modelAttribute="track" action="/SpotifyWeb/artist/submitTrack.htm" method="POST" enctype="multipart/form-data" class="row form">
                	<form:hidden path="id_track"/>
					<form:hidden path="uploadDate"/>
					<form:hidden path="like"/>
					<form:hidden path="status"/>
					<form:hidden path="path"/>
					<form:hidden path="image"/>
                    <!-- Buttons -->
                    <div class="d-flex justify-content-center">
                        <c:if test="${btnStatus=='btnSubmit'}">
								<button name="btnSubmit" id="btnSubmit" type="submit" class="btn-spotify">Submit</button>
							</c:if>
							<c:if test="${btnStatus=='btnConfirm'}">
								<button name="btnConfirm" class="btn-spotify">Confirm</button>
							</c:if>
                    </div>
                    <!-- isPublic input -->
                    <div class="d-flex justify-content-center mt-2">
                        <div class="mx-3">
                            <form:radiobutton path="isPublic" value="True" id="radioPublic"></form:radiobutton>
                            <label for="radioPublic">Public</label>
                        </div>
                        <div class="mx-3">
                            <form:radiobutton path="isPublic" value="False" id="radioPrivate" ></form:radiobutton>
                            <label for="radioPrivate">Private</label>
                        </div>
                        <form:errors path="isPublic" class="text-danger"/>
                    </div>
                    <label class="ps-0 mb-1 fw-bold" for="username">What is Track's name?</label> 
                        <form:input path="name" id="name" type="text" maxlength="50"  placeholder="Enter track name" class="form-control mb-4"/>
						<form:errors path="name" class="text-danger"/>
						
					
                    <c:if test="${btnStatus=='btnSubmit'}">
                    <h5 class="text-danger">Please add other artists before choose photo or track</h5>
	                        <label class="form-label fw-bold" for="image">Choose a photo for track</label>
	                        <input type="file" name="photo" class="form-control">
	                        <form:errors path="image" class="text-danger"/>
                     </c:if>
                        
                    <c:if test="${btnStatus=='btnConfirm'}">
							<c:if test="${track.image!=null}">
							<label class="form-label fw-bold" for="image">This is track's photo</label>
							<div>
							<img width="100" height="100" src="${pageContext.servletContext.contextPath}/resources/img/track/${track.image}"/></div>
							</c:if>
					</c:if>
					
					
					<c:if test="${btnStatus=='btnSubmit'}">
					<label for="music" class="form-label fw-bold">Upload your music</label>
					<div class="d-flex justify-content-between w-100 p-0">
                        <input type="file" id="fileInput" accept="audio/*" class="form-control ms-0">
                    </div>
							<form:errors path="path" class="text-danger"/>
							<div>
								<textarea id="mp3String" cols="100" rows="2">
								</textarea>
							</div>
									
							<input type="hidden" name="music" id="music"/>
					</c:if>
					<c:if test="${btnStatus=='btnConfirm'}">
					<label for="music" class="form-label fw-bold">This is your track</label>
						<div class="d-flex justify-content-between w-100 p-0">
                        	
                        	<audio src="data:audio/mp3;base64,${track.path}" controls style="height: 36px; width: 100%;" class="ms-4"></audio>
                    	</div>
					</c:if>
                    
                    <label for="genre" class="form-label fw-bold">Choose track's genre</label>
                    <form:select path="genre.id_genre" items="${genreList}" 
							itemValue="id_genre" itemLabel="type"  class="form-select"/>
					<form:errors path="genre.id_genre" class="text-danger"/>

                    <!-- Table Current Track Artists -->
                    <form>
                    <div class="w-100 btn-spotify text-center py-2 my-3">Current Track Artist</div>
                    <table class="table" id="currentArtistTable">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Fullname</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="artist" items="${artistList}">
                                <tr>
                                    <td>${artist.username}</td>
                                    <td>${artist.fullname}</td>
                                    <c:if test="${btnStatus=='btnSubmit'}">
                                    <td>
                                        <button onclick="location.href='/SpotifyWeb/artist/submitTrack/${artist.username}.htm?linkDelete'" class="moveRow" style="border: none; background: none;">
                                            <i class="fa-solid fa-xmark text-danger fs-3 fw-bolder hover-scale"></i>
                                        </button>
                                    </td>
                                    </c:if>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <c:if test="${btnStatus=='btnSubmit'}">
                    <!-- Tabel Artists -->
                    <div class="w-100 bg-info text-center py-2 my-3 fw-bold">Artists</div>
                    <table class="table" id="artistTable">
                        <thead>
                            <tr>
                                <th>Username</th>
                                <th>Fullname</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="artist" items="${artists}">
                                <tr>
                                    <td>${artist.username}</td>
                                    <td>${artist.fullname}</td>
                                    <td>
                                        <button onclick="location.href='/SpotifyWeb/artist/submitTrack/${artist.username}.htm?linkAdd'" class="moveRow" style="border: none; background: none;">
                                            <i class="fa-sharp fa-solid fa-user-plus"></i>
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    </c:if>
                    </form>
                </form:form>
            </div>
        




    </div>





    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>
    <script>
        $(document).ready(function () {
            // $('#currentArtistTable').DataTable();
            $('#artistTable').DataTable();
            $('#artistTable').on('click', '.moveRow', function () {
                const rowToMove = $(this).closest('tr'); // Tìm hàng cha gần nhất (closest) của button đã nhấp và lưu trữ nó
                rowToMove.remove(); // Xóa hàng đó khỏi table 2

                // Tạo một hàng mới và thêm vào table 1 với các giá trị đã được sao chép từ hàng cũ
                const newRow = $('<tr>').append(rowToMove.children().clone());
                $('#currentArtistTable tbody').append(newRow);
            });
            $('#currentArtistTable').on('click', '.moveRow', function () {
                const rowToMove = $(this).closest('tr');
                rowToMove.remove(); 

                const newRow = $('<tr>').append(rowToMove.children().clone());
                $('#artistTable tbody').append(newRow);
            });
        });

        function showCreateAlbum() {
            var modal = document.getElementById("signup-form")
            if (modal.classList.contains("d-none")) {
                modal.classList.remove("d-none")
            }
            else modal.classList.add("d-none")
        }
        var context = new AudioContext();
        var source = null;
        var audioBuffer = null;

        var bufferToBase64 = function (buffer) {
            var bytes = new Uint8Array(buffer);
            var len = buffer.byteLength;
            var binary = "";
            for (var i = 0; i < len; i++) {
                binary += String.fromCharCode(bytes[i]);
            }
            return window.btoa(binary);
        };

        var base64ToBuffer = function (buffer) {
            var binary = window.atob(buffer);
            var buffer = new ArrayBuffer(binary.length);
            var bytes = new Uint8Array(buffer);
            for (var i = 0; i < buffer.byteLength; i++) {
                bytes[i] = binary.charCodeAt(i) & 0xFF;
            }
            return buffer;
        };

        function stopSound() {
            if (source) {
                source.stop(0);
            }
        }

        function playSound() {
            source = context.createBufferSource();
            source.buffer = audioBuffer;
            source.loop = false;
            source.connect(context.destination);
            source.start(0);
        }


        function initSound(arrayBuffer) {
            var base64String = bufferToBase64(arrayBuffer);
            var audioFromString = base64ToBuffer(base64String);
            document.getElementById("mp3String").value = base64String;
            document.getElementById("music").value = base64String;
            context.decodeAudioData(audioFromString, function (buffer) {
                audioBuffer = buffer;
                var buttons = document.querySelectorAll('button');
                buttons[0].disabled = false;
                buttons[1].disabled = false;
            }, function (e) {
                console.log('Error decoding file', e);
            });
        }

        var fileInput = document.getElementById("fileInput");
        fileInput.addEventListener('change', function (e) {
            var reader = new FileReader();
            reader.onload = function (e) {
                initSound(this.result);
            };
            reader.readAsArrayBuffer(this.files[0]);
        }, false);


        function loadSoundFile(url) {
            var xhr = new XMLHttpRequest();
            xhr.open('GET', url, true);
            xhr.responseType = 'arraybuffer';
            xhr.onload = function (e) {
                initSound(this.response);
            };
            xhr.send();
        }
    </script>
</body>

</html>