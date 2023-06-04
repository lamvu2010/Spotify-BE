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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <link rel="stylesheet" href="../Pages/Common/style.css">
    <style>
        .role-inputs input:checked+label{
            color: #1ed760;
            scale: 1.5;
            transition: all 0.2s ease;
            text-decoration: underline;
        }
        .role-inputs label:hover{
            cursor: pointer;
            color: #1ed75fa0;
            scale: 1.1;
            transition: all 0.2s ease;
        }

    </style>
    <title>Create Account</title>
</head>
<body>
    <div class="container-fluid" style="background-color: #1C263C;">
        <div class="row d-flex justify-content-center">
            <div class="col-11">
                <div class="row">
                    <!-- Dashboard Here -->
                    <div class="col-3 d-none d-md-block dashboard">
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
                          <a href="./createAccount.html" class="text-white">
                              <i class="fa-solid fa-music"></i>
                              Account
                          </a>
                        </div>
                    </div>
                    <!-- Tracks Page Here -->
                    <div class="col-12 col-md-9 bg-white pt-4 px-5 overflow-auto">
                      <!-- Top Bar -->
                      <div class="topBar d-flex justify-content-end fs-2">
                            <div class="Annouce me-3">
                              <i class="fa-solid fa-bell"></i>
                            </div>
                            <div class="avatar">
                                <i class="fa-sharp fa-solid fa-circle-user"></i>
                                <ul class="dropdown-menu">
                                    <li><a href="">Account</a></li>
                                    <li><a href="">Profile</a></li>
                                    <li><a href="">Setting</a></li>
                                    <hr class="text-white"/>
                                    <li><a href="">Log out</a></li>
                                </ul>
                            </div>
                        </div>
                        <!-- Page Tilte -->
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            
                        </div>
                        <div class="row d-flex justify-content-center">
                            <div class="col-10">
                            	<form:form modelAttribute="user" action="/SpotifyWeb/user/list.htm" method="POST" class="signup-form row">
                                
                                    <div class="d-flex justify-content-around align-items-center gx-3 role-inputs mb-4">
                                        <div class="row text-center fw-bold fs-3">
                                            <p>Create account for</p>
                                        </div>
                                            <form:radiobutton path="permission" id="adminRole" value="Admin" style="display: none;" ></form:radiobutton>
                                            <label for="adminRole" class="fw-bold">Admin</label>
                                  
                                            <form:radiobutton path="permission" id="artistRole" value="Artist" style="display: none;"></form:radiobutton>
                                            <label for="artistRole" class="fw-bold">Artist</label>
                                        
                                            <form:radiobutton path="permission" id="audienceRole" value="Audience" style="display: none;"></form:radiobutton>
                                            <label for="audienceRole" class="fw-bold">Audience</label>
                                    		<form:errors path="permission" />
                                    </div>
            
                                    <label class="ps-0 mb-1 fw-bold" for="username">Make username</label> 
                                    <form:input path="username" id="username" type="text" maxlength="20"  placeholder="Enter your username" class="form-control mb-4"/>
									<form:errors path="username" />
									
									<form:hidden path="password"/>
                        
                                    <label class="ps-0 mb-1 fw-bold" for="email">What's the email?</label>
                                    <form:input path="email" id="email" type="text" maxlength="254" placeholder="Enter your email" class="form-control mb-4"/>
									<form:errors path="email" />
									
									<label class="ps-0 mb-1 fw-bold" for="phonenumber">What's the phonenumber?</label>
									<form:input path="phonenumber" id="" type="text" maxlength="10" placeholder="Enter your phone" class="form-control mb-4"/>
									<form:errors path="phonenumber" />
            
                                    <label class="ps-0 mb-1 fw-bold" for="fullname">Give a name</label> 
                                    <form:input path="fullname" id="fullname" type="text" maxlength="60" placeholder="Enter your fullname" class="form-control mb-4"/>
									<form:errors path="fullname" />
            
                                    <label for="" class="ps-0 fw-bold">When's birthday?</label>
                                    <div class="row px-0 mb-4">
                                        <div class="col-3">
                                            <label for="day" style="font-weight: normal;">Day</label>
                                            <input name="day" value="${day}" type="text" id="day" class="form-control" placeholder="DD" maxlength="2" inputmode="numeric" required pattern="((0[1-9]|[1-2][0-9]|3[0-1]))">
                                        </div>
                                        <div class="col-6">
                                            <label for="month" style="font-weight: normal;">Month</label>
                                            <select name="month" id="month" required class="form-select">
                                                <option value selected disabled >Month</option>
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
                                            <label for="year" style="font-weight: normal;" >Year</label>
                                            <input name="year" value="${year}" type="text" id="year" required class="form-control" placeholder="YYYY" maxlength="4" inputmode="numeric">
                                        </div>
                                        <form:errors path="birthday" />
                                    </div>
                                    
            
                                    <label for="nation" class="ps-0 mb-1 fw-bold">Give the nation?</label>
                                    <form:select path="nation" id="nation" class="form-select">
										<form:option value="" label="Nation" />
										<c:forEach var="nation" items="${nations}">
											<form:option value="${nation}">${nation}</form:option>
										</c:forEach>
									</form:select>
			                        <form:errors path="nation"/>
                                    
                                    <div>
									<label >Status</label><br>
										<form:radiobutton path="lock" value="False"
											label="Unlock" />
										<br>
										<form:radiobutton path="lock" value="True"
											label="lock" />
									</div>
                                    
                                    <button name="btnAdd" class="btn-spotify mt-4 mb-5">Sign up</button>
                                    ${message}
                                    <br/>
                                    <button onclick="location.href='http://localhost:8080/SpotifyWeb/user/list.htm'"
									type="button" class="btn-spotify mt-4 mb-5">Tải lại trang</button>
                                    
                                </form:form>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <div >
					<form:form method="POST">
					<div>
						UserList
					</div>
					<div >
						<table >
							<thead>
								<tr>
									<th>Username</th>
									<th>Fullname</th>
									<th>Birthday</th>
									<th>Phonenumber</th>
									<th>Nation</th>
									<th>Email</th>
									<th>Lock</th>
									<th>Permission</th>
									<th>Lock/ Unclock</th>
									<th>Delete</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="user" items="${userList}">
									<tr>
										<td>${user.username}</td>
										<td>${user.fullname}</td>
										<td>${user.birthday}</td>
										<td>${user.phonenumber}</td>
										<td>${user.nation}</td>
										<td>${user.email}</td>
										<td>${user.lock}</td>
										<td>${user.permission}</td>
										<td><a href="/SpotifyWeb/user/list/${user.username}.htm?linkEdit"
											>lock/ unlock</a>
										</td>
										<td><a href="/SpotifyWeb/user/list/${user.username}.htm?linkDelete"
											>delete</a>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					</form:form>
	</div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script>
 	// Tạo một biến javascript để lưu trữ giá trị của month
	  var month = ${month};
	// Lấy phần tử select bằng id
	  var select = document.getElementById("month");
	// Thiết lập giá trị option bằng với giá trị của month
	  select.value = month;
</script>
</body>
</html>

