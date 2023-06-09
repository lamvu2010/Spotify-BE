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

    <style>
        .role-inputs input:checked+label {
            color: #1ed760;
            scale: 1.5;
            transition: all 0.2s ease;
            text-decoration: underline;
        }

        .role-inputs label:hover {
            cursor: pointer;
            color: #1ed75fa0;
            scale: 1.1;
            transition: all 0.2s ease;
        }
    </style>
    <title>Create Account</title>
</head>

<body>
    <div class="container-fluid p-0">
        <div class="row-cols-2 d-flex justify-content-center">
            <!-- Dashboard Here -->
            <div class="col-2 d-none d-md-block dashboard">
                <div class="row dashboard-header">
                    <i class="fa-brands fa-spotify"></i>
                </div>
                <div class="row dashboard-item">
                    <a href="./home.html" class="">
                        <i class="fa-solid fa-house"></i>
                        Home
                    </a>
                </div>
                <div class="row dashboard-item">
                    <a href="./manageGenre.html" class="">
                        <i class="fa-sharp fa-solid fa-shapes"></i>
                        Genres
                    </a>
                </div>
                <div class="row dashboard-item">
                    <a href="./managePendingTracks.html" class="">
                        <i class="fa-solid fa-music"></i>
                        Track
                    </a>
                </div>
                <div class="row dashboard-item">
                    <a href="./createAccount.html" >
                        <i class="fa-solid fa-address-card"></i>
                        Account
                    </a>
                </div>
            </div>
            <!-- Accounts Page Here -->
            <div class="col-10 bg-white pt-4 px-5 overflow-auto" style="height: 100vh;">
                <!-- Top Bar -->
                <div class="topBar d-flex justify-content-between fs-2">
                    <button class="btn-spotify" onclick="showCreateAccount()">Add account</button>
                    <div class="d-flex">
                        <div class="Annouce me-3 justify-content-end">
                            <i class="fa-solid fa-bell"></i>
                        </div>
                        <div class="avatar justify-content-end">
                            <i class="fa-sharp fa-solid fa-circle-user"></i>
                            <ul class="dropdown-menu">
                                <li><a href="">Account</a></li>
                                <li><a href="">Profile</a></li>
                                <li><a href="">Setting</a></li>
                                <hr class="text-white" />
                                <li><a href="">Log out</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
                <!-- Page Tilte -->
                <div class="d-flex justify-content-between align-items-center mb-3">

                </div>
                <!-- Page Body -->
                <div class="row d-flex justify-content-center">

                    <!-- Form sign up account -->
                    <form:form modelAttribute="user" action="/SpotifyWeb/user/list.htm" method="POST"  class="signup-form row d-none" id="signup-form">
                        <div class="d-flex justify-content-center align-items-end gx-3 role-inputs mb-4">
                            <div class="px-4">
                                <form:radiobutton path="permission" id="adminRole" value="Admin" style="display: none;" ></form:radiobutton>
                                            <label for="adminRole" class="fw-bold">Admin</label>
                            </div>
                            <div class="px-4">
                                <form:radiobutton path="permission" id="artistRole" value="Artist" style="display: none;"></form:radiobutton>
                                            <label for="artistRole" class="fw-bold">Artist</label>
                            </div>
                            <div class="px-4">
                                <form:radiobutton path="permission" id="audienceRole" value="Audience" style="display: none;"></form:radiobutton>
                                            <label for="audienceRole" class="fw-bold">Audience</label>
                            </div>
                            <form:errors path="permission" class="text-danger"/>
                        </div>

                        <label class="ps-0 mb-1 fw-bold" for="username">Make username</label> 
                                    <form:input path="username" id="username" type="text" maxlength="20"  placeholder="Enter your username" class="form-control mb-4"/>
									<form:errors path="username" class="text-danger"/>
									
									<form:hidden path="password"/>
                        
                                    <label class="ps-0 mb-1 fw-bold" for="email">What's the email?</label>
                                    <form:input path="email" id="email" type="text" maxlength="254" placeholder="Enter your email" class="form-control mb-4"/>
									<form:errors path="email" class="text-danger"/>
									
									<label class="ps-0 mb-1 fw-bold" for="phonenumber">What's the phonenumber?</label>
									<form:input path="phonenumber" id="" type="text" maxlength="10" placeholder="Enter your phone" class="form-control mb-4"/>
									<form:errors path="phonenumber" class="text-danger"/>
            
                                    <label class="ps-0 mb-1 fw-bold" for="fullname">Give a name</label> 
                                    <form:input path="fullname" id="fullname" type="text" maxlength="60" placeholder="Enter your fullname" class="form-control mb-4"/>
									<form:errors path="fullname" class="text-danger"/>

                             <label for="" class="ps-0 fw-bold">When's birthday?</label>
                               <div class="row px-0 mb-4">
                                        <div class="col-3">
                                            <label for="day" style="font-weight: normal;">Day</label>
                                            <input name="day" value="${day}" type="text" id="day" class="form-control" placeholder="DD" maxlength="2" inputmode="numeric" required pattern="((0[1-9]|[1-2][0-9]|3[0-1]))">
                                        </div>
                                        <div class="col-6">
                                            <label for="month" style="font-weight: normal;">Month</label>
                                            <select name="month" id="month" required class="form-select">
                                                <option value selected disabled>Month</option>
                                                <option value="1">January</option>
                                                <option value="2">February</option>
                                                <option value="3">March</option>
                                                <option value="4">April</option>
                                                <option value="5">May</option>
                                                <option value="6">June</option>
                                                <option value="7">July</option>
                                                <option value="8">August</option>
                                                <option value="9">September</option>
                                                <option value="10">October</option>
                                                <option value="11">November</option>
                                                <option value="12">December</option>
                                            </select>
                                        </div>
                                        <div class="col-3">
                                            <label for="year" style="font-weight: normal;">Year</label>
                                            <input name="year" value="${year}" type="text" id="year" required class="form-control" placeholder="YYYY" maxlength="4" inputmode="numeric">
                                        </div>
                                    </div>
                                    <form:errors path="birthday" class="text-danger"/>
	
                                    <label for="nation" class="ps-0 mb-1 fw-bold">Give the nation?</label>
                                    <form:select path="nation" id="nation" class="form-select">
										<form:option value="" label="Nation" />
										<c:forEach var="nation" items="${nations}">
											<form:option value="${nation}">${nation}</form:option>
										</c:forEach>
									</form:select>
			                        <form:errors path="nation" class="text-danger"/>
			                        
			                        <label class="ps-0 mb-1 fw-bold">Status</label>
			                        <div class="px-4">
										<form:radiobutton path="lock" id="Unlock" value="False"></form:radiobutton>
											<label for="Unlock" class="fw-bold">Unlock</label>
									</div>
									<div class="px-4">
										<form:radiobutton path="lock" id="Lock" value="True"></form:radiobutton>
											<label for="Lock" class="fw-bold">Lock</label>
									</div>
			                        
                                     <button name="btnAdd" class="btn-spotify mt-4 mb-5">Sign up</button>
                                    
                                    <button onclick="location.href='http://localhost:8080/SpotifyWeb/user/list.htm'"
									type="button" class="btn-spotify mt-4 mb-5">Refresh</button>
                    <script>
                    //Tạo một biến javascript để lưu trữ giá trị của month
		          		  var month = ${month};
		          	// Lấy phần tử select bằng id
		          	  var select = document.getElementById("month");
		          	// Thiết lập giá trị option bằng với giá trị của month
		          	  select.value = month;
                    </script>                
                    </form:form>
                    
                    <h5>${message}</h5>
                    <!-- Account tables -->
                        <!-- Artist -->
                        <button class="bg-dark text-white fw-bold text-center p-3 w-100 btnTitle my-3"
                            style="border-radius: 25px;">
                            <i class="fa-solid fa-user-tie me-1"></i>
                            Artist</button>
                        <table class="table" id="tableArtist">
                            <thead>
                                <tr>
                                    <th>Username</th>
                                    <th>Birthday</th>
                                    <th>Phonenumber</th>
                                    <th>Nation</th>
                                    <th>Email</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="user" items="${artistList}">
                                <tr>
                                    <td data-fullname="${user.fullname}">
                                        <a href="#" class="text-decoration-none text-black">${user.username}</a>
                                    </td>
                                    <td>${user.birthday}</td>
                                    <td>${user.phonenumber}</td>
                                    <td>${user.nation}</td>
                                    <td>${user.email}</td>
                                    <td class="d-flex justify-content-between actionCol" data-lock="${user.lock}">
                                        <a href="/SpotifyWeb/user/list/${user.username}.htm?linkEdit"
                                            class="lockAction">
                                            <i class="fa-solid fa-lock-open"></i>
                                            <i class="fa-solid fa-lock" style="color: #520000;"></i>
                                        </a>
                                        <a href="/SpotifyWeb/user/list/${user.username}.htm?linkDelete">
                                            <i class="fa-solid fa-trash" style="color: #ff3333;"></i>
                                        </a>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <!-- Admin -->
                        <button class="bg-dark text-white fw-bold text-center p-3 w-100 btnTitle my-3"
                            style="border-radius: 25px;">
                            <i class="fa-solid fa-user-secret m-1"></i>
                            Admin
                        </button>
                        <table class="table" id="tableAdmin">
                            <thead>
                                <tr>
                                    <th>Username</th>
                                    <th>Birthday</th>
                                    <th>Phonenumber</th>
                                    <th>Nation</th>
                                    <th>Email</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="user" items="${adminList}">
                                <tr>
                                    <td data-fullname="${user.fullname}">
                                        <a href="#" class="text-decoration-none text-black">${user.username}</a>
                                    </td>
                                    <td>${user.birthday}</td>
                                    <td>${user.phonenumber}</td>
                                    <td>${user.nation}</td>
                                    <td>${user.email}</td>
                                    <td class="d-flex justify-content-between actionCol" data-lock="${user.lock}">
                                        <a href="/SpotifyWeb/user/list/${user.username}.htm?linkEdit"
                                            class="lockAction">
                                            <i class="fa-solid fa-lock-open"></i>
                                            <i class="fa-solid fa-lock" style="color: #520000;"></i>
                                        </a>
                                        <a href="/SpotifyWeb/user/list/${user.username}.htm?linkDelete">
                                            <i class="fa-solid fa-trash" style="color: #ff3333;"></i>
                                        </a>
                                    </td>
                                </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <!-- Audience -->
                        <button class="bg-dark text-white fw-bold text-center p-3 w-100 btnTitle my-3"
                            style="border-radius: 25px;">
                            <i class="fa-sharp fa-solid fa-users me-1"></i>
                            Audience
                        </button>
                        <table class="table" id="tableAudience">
                            <thead>
                                <tr>
                                    <th>Username</th>
                                    <th>Birthday</th>
                                    <th>Phonenumber</th>
                                    <th>Nation</th>
                                    <th>Email</th>
                                    <th>Action</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="user" items="${audienceList}">
                                <tr>
                                    <td data-fullname="${user.fullname}">
                                        <a href="#" class="text-decoration-none text-black">${user.username}</a>
                                    </td>
                                    <td>${user.birthday}</td>
                                    <td>${user.phonenumber}</td>
                                    <td>${user.nation}</td>
                                    <td>${user.email}</td>
                                    <td class="d-flex justify-content-between actionCol" data-lock="${user.lock}">
                                        <a href="/SpotifyWeb/user/list/${user.username}.htm?linkEdit"
                                            class="lockAction">
                                            <i class="fa-solid fa-lock-open"></i>
                                            <i class="fa-solid fa-lock" style="color: #520000;"></i>
                                        </a>
                                        <a href="/SpotifyWeb/user/list/${user.username}.htm?linkDelete">
                                            <i class="fa-solid fa-trash" style="color: #ff3333;"></i>
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


    <!-- <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script> -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.datatables.net/1.13.4/js/jquery.dataTables.js"></script>

    <script>
	
        $(document).ready(function () {
            $('#tableArtist').DataTable();
            $('#tableAdmin').DataTable();
            $("#tableAudience").DataTable();
        });
        function showCreateAccount() {
            var modal = document.getElementById("signup-form")
            if (modal.classList.contains("d-none")) {
                modal.classList.remove("d-none")
            }
            else modal.classList.add("d-none")
        }
        var btnTitles = document.getElementsByClassName("btnTitle")
        for (var i = 0; i < btnTitles.length; i++) {
            btnTitles[i].addEventListener("click", function () {
                var table = this.nextElementSibling;
                if (table.classList.contains("d-none")) {
                    table.classList.remove("d-none");
                }
                else table.classList.add("d-none")
            })
        }

        var actionCols = document.querySelectorAll("table tbody .actionCol")
        for(var i = 0;i<actionCols.length; i++){
            if(actionCols[i].getAttribute("data-lock") == "true"){
                actionCols[i].querySelector(".fa-lock-open").classList.add("d-none")
            }
            else actionCols[i].querySelector(".fa-lock").classList.add("d-none")
        }
    </script>
</body>

</html>