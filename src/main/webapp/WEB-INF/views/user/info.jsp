<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        .btn-spotify{
            background-color: #1ed760;
            padding: 0.5rem 2rem;
            border-radius: 24px;
            font-weight: 700;
            border: none;
            transition: all 0.1s ease;
        }

        .btn-spotify:hover{
            scale: 1.04;
        }
    </style>
    <title>User profile</title>
<base href ="${pageContext.servletContext.contextPath}/">
<link href="${pageContext.request.contextPath}/Pages/Common/style.css" rel="stylesheet">
</head>
<body>
    <div class="container-fluid p-0" style="background-color: #1C263C;">
                <div class="row">
                <!-- Dashboard -->
                <c:if test="${sessionScope.permission=='Artist'}">
            	<%@ include file="/header/artist.jsp"%>
	            </c:if>
	            <%-- <c:if test="${sessionScope.permission=='Admin'}">
	            	<%@ include file="/header/admin.jsp"%>
	            </c:if>
	            <c:if test="${sessionScope.permission=='Audience'}">
	            	<%@ include file="/header/audience.jsp"%>
	            </c:if> --%>
                    <!-- Page body -->
                    <div class="col-10 bg-white pt-4 px-5">
                    <%@ include file="/header/account.jsp"%>
                    <c:if test="${btnStatus=='btnEdit'}">
                    	<h1 class="mb-4">Profile</h1>
                    </c:if>
                    <c:if test="${btnStatus=='btnSave'}">
                    	<h1 class="mb-4">Edit profile</h1>
                    </c:if>
			<form:form modelAttribute="user" action="/SpotifyWeb/user/info.htm" method="POST">
										<div hidden="true">
											<label class="fw-bold">Username</label>
											<form:input path="username" type="text" maxlength="20" class="form-control mb-3"/>
										</div>
										<div>
											<label class="fw-bold">Username</label>
											<form:input path="username" disabled="true" type="text" maxlength="20" class="form-control mb-3"/>
										</div>
										<form:hidden path="password"/>
										<form:hidden path="lock"/>
										<form:hidden path="permission"/>
										<c:if test="${btnStatus=='btnEdit'}">
											<div hidden="true">
												<label class="fw-bold">Fullname</label>
												<form:input path="fullname" type="text" maxlength="60" class="form-control mb-3"/>
											</div>
											<div>
												<label class="fw-bold">Fullname</label>
												<form:input path="fullname" disabled="true" type="text" maxlength="60" class="form-control mb-3"/>
											</div>
											
											<div hidden="true">
												<label class="fw-bold">Phonenumber</label>
												<form:input path="phonenumber" type="text" maxlength="10" class="form-control mb-3"/>
											</div>
											<div>
												<label class="fw-bold">Phonenumber</label>
												<form:input path="phonenumber" disabled="true" type="text" maxlength="10" class="form-control mb-3"/>
											</div>
											
											<div hidden="true">
												<label class="fw-bold">Email</label>
												<form:input path="email" type="text" maxlength="254" class="form-control mb-3" />
											</div>
											<div>
												<label class="fw-bold">Email</label>
												<form:input path="email" disabled="true" type="text" maxlength="254" class="form-control mb-3" />
											</div>
											
											<label for="birthday" class="fw-bold">Birthday</label>
				                            <div class="row px-0 mb-4">
				                                <div class="col-3">
				                                    <input name="day" value="${day}" disabled="true" type="text" id="day" class="form-control" placeholder="DD" maxlength="2" inputmode="numeric" required pattern="((0[1-9]|[1-2][0-9]|3[0-1]))">
				                                </div>
				                                <div class="col-6">
				                                    <select name="month" disabled="true" id="month" required class="form-select">
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
				                                    <input name="year" value="${year}" disabled="true" type="text" id="year" required class="form-control" placeholder="YYYY" maxlength="4" inputmode="numeric">
				                                </div>
				                            </div>
											<form:errors path="birthday"/>
											<div hidden="true">
											<label for="nation" class="fw-bold">Nation</label>
				                            <form:select path="nation" id="nation" class="form-select mb-5">
												<form:option value="" label="Nation" />
												<c:forEach var="nation" items="${nations}">
													<form:option value="${nation}">${nation}</form:option>
												</c:forEach>
											</form:select>
											</div>
											<div>
												<label for="nation" class="fw-bold">Nation</label>
					                            <form:select disabled="true" path="nation" id="nation" class="form-select mb-5">
													<form:option value="" label="Nation" />
													<c:forEach var="nation" items="${nations}">
														<form:option value="${nation}">${nation}</form:option>
													</c:forEach>
												</form:select>
											</div>
										
											
										</c:if>
										
										
										
										<c:if test="${btnStatus=='btnSave'}">
											<div>
												<label class="fw-bold">Fullname</label>
												<form:input path="fullname" type="text" maxlength="60" class="form-control mb-3"/>
												<p style="color: red; font-style: oblique">
													<form:errors path="fullname" class="text-danger"/>
												</p>
											</div>
											
											<div>
												<label class="fw-bold">Phonenumber</label>
												<form:input path="phonenumber" type="text" maxlength="10" class="form-control mb-3" pattern="(0[1-9]*])"/>
												<p style="color: red; font-style: oblique">
													<form:errors path="phonenumber" class="text-danger"/>
												</p>
											</div>
											
											<div>
												<label class="fw-bold">Email</label>
												<form:input path="email" type="text" maxlength="254" class="form-control mb-3"/>
												<p style="color: red; font-style: oblique">
													<form:errors path="email" class="text-danger"/>
												</p>
											</div>
											
											<label for="birthday" class="fw-bold">Birthday</label>
				                            <div class="row px-0 mb-4">
				                                <div class="col-3">
				                                    <input name="day" value="${day}" type="text" id="day" class="form-control" placeholder="DD" maxlength="2" inputmode="numeric" required pattern="((0[1-9]|[1-2][0-9]|3[0-1]))">
				                                </div>
				                                <div class="col-6">
				                                    <select name="month" id="month" required class="form-select">
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
				                                    <input name="year" value="${year}" type="text" id="year" required class="form-control" placeholder="YYYY" maxlength="4" inputmode="numeric">
				                                </div>
				                            </div>
				    
				        
				                            <label for="nation" class="fw-bold">Nation</label>
				                            <form:select path="nation" id="nation" class="form-select mb-5">
												<form:option value="" label="Nation" />
												<c:forEach var="nation" items="${nations}">
													<form:option value="${nation}">${nation}</form:option>
												</c:forEach>
											</form:select>
											<form:errors path="nation" class="text-danger"/>
				                            <hr/>
										</c:if>
										<div >
											<div style="margin-left: 2.5em">
											<c:if test="${btnStatus=='btnEdit'}">
													<a href="http://localhost:8080/SpotifyWeb/user/info.htm" style="color: #656565; text-decoration: none;">Refresh</a>
					                                <button name="btnEdit" class="btn-spotify ms-4">Edit profile</button>
												
											</c:if>
											<c:if test="${btnStatus=='btnSave'}">
												<div class="d-flex justify-content-end align-items-center">
					                                <a href="http://localhost:8080/SpotifyWeb/user/info.htm" style="color: #656565; text-decoration: none;">Cancel</a>
					                                <button name="btnSave" class="btn-spotify ms-4">Save</button>
					                            </div>
											</c:if>
												<p5 class="text-danger">${message}</p5>
											</div>
										</div>
				</form:form>
				</div>
            </div> 
    </div>
    <script>
	  // Tạo một biến javascript để lưu trữ giá trị của month
	  var month = ${month};
	  // Lấy phần tử select bằng id
	  var select = document.getElementById("month");
	  // Thiết lập giá trị option bằng với giá trị của month
	  select.value = month;
	</script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>