<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="chrome=1" />
<title>Submit Track</title>
<base href ="${pageContext.servletContext.contextPath }/">
</head>
<body>

<form:form modelAttribute="track" action="/Spotify/track/submit.htm" method="POST" enctype="multipart/form-data">
							<form:hidden path="id_track"/>
							<form:hidden path="uploadDate"/>
							<form:hidden path="like"/>
							<form:hidden path="status"/>
							<form:hidden path="user.username"/>
							<form:hidden path="path"/>
							<form:hidden path="image"/>
							<div>
								<label>Name</label>
								<form:input path="name" type="text" maxlength="50"/>
								<p style="color: red; font-style: oblique">
									<form:errors path="name" />
								</p>
							</div>
							<div>
								<label>File Music</label>
								
								<!-- <script>
								var fileInput=document.getElementById("fileInput");
								fileInput.addEventListener("change",function(){
									var file=fileInput.files[0];
									var reader=new FileReader();
									reader.addEventListener("load",function(){
										var base64=reader.result;
										var music = document.getElementById("music");
										music.value=base64;
										var audio=new Audio();
										audio.src=base64;
										audio.play();
									});
									reader.readAsDataURL(file);
								});
								</script> -->
								<c:if test="${btnStatus=='btnSubmit'}">
								<p style="color: red; font-style: oblique">
									<form:errors path="path" />
								</p>
								<input type="file" id="fileInput" accept="audio/*">
								<button onclick="playSound()" disabled>Start</button>
								<button onclick="stopSound()" disabled>Stop</button>
								<div>
								<textarea id="mp3String" cols="100" rows="10">
								</textarea>
								</div>
								<!-- <input type="file" id="fileInput"/> -->
								<input type="hidden" name="music" id="music"/>
								</c:if>
								<c:if test="${btnStatus=='btnConfirm'}">
								<audio controls>
								 <source src="data:audio/mp3;base64,${track.path}">
								 </audio>
								 </c:if>
								 
							</div>
							<div>
								<label>Genre</label>
								<form:select path="genre.id_genre" items="${genreList}" 
								itemValue="id_genre" itemLabel="type"  />
								<p style="color: red; font-style: oblique">
									<form:errors path="genre.id_genre" />
								</p>
							</div>
							<div>
								<label>Image</label>
								<c:if test="${btnStatus=='btnSubmit'}">
								<input type="file" name="photo">
								
								<p style="color: red; font-style: oblique">
									<form:errors path="image" />
								</p>
								</c:if>
								<c:if test="${btnStatus=='btnConfirm'}">
								<c:if test="${track.image!=null}">
								<img width="31" height="31"
													src="<c:url value='/resources/img/track/${track.image}'/>" />
													</c:if></c:if>
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
								<c:if test="${btnStatus=='btnSubmit'}">
									<button name="btnSubmit" id="btnSubmit" type="submit">Submit</button>
								</c:if>
								<c:if test="${btnStatus=='btnConfirm'}">
									<button name="btnConfirm">Confirm</button>
								</c:if>
									<p5 class="text-danger">${message}</p5>
								</div>
								<button onclick="location.href='http://localhost:8080/Spotify/track/submit.htm'"
									type="button">Tải lại trang</button>
							</div>
							
<script>
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
    document.getElementById("mp3String").value=base64String;
    document.getElementById("music").value=base64String;
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
	</form:form>
</body>
</html>