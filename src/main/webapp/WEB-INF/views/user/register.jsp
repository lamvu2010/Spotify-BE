<%@page pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        form label{
            font-weight: bold;
            font-size: 14px;
        }
        form .btn-submit{
            background-color: #1ed760;
            border-radius: 30px;
            border: none;
            font-weight: bold;
            font-size: 18px;
        }

        form .form-footer .Login-link{
            color: #1ed760;
        }
    </style>
	<base href ="${pageContext.servletContext.contextPath}/">
    <title>Spotify Sign up</title>
</head>
<body>
        <div class="container-fluid">
            <div class="row-cols-1 d-flex justify-content-center">
                <div class="col-md-5 col-lg-4 col-xl-4 col-8">
                    <div class="row text-center">
                        <p style="font-weight: bold; font-size: 36px;"><i class="fa-brands fa-spotify me-2"></i>Spotify</p>
                        <p style="font-weight: 600; font-size: 24px;">Sign up for free listening</p>
                        <hr>
                    </div>
                    <form:form class="signup-form row" modelAttribute="user" action="/SpotifyWeb/user/register/form.htm" method="POST">
                    
                        <label class="ps-0 mb-1" for="username">Create your username</label> 
                        
                        <form:input path="username" type="text" id="username" maxlength="20" placeholder="Enter your username" class="form-control mb-4"/>
            			<form:errors path="username" />
						
                        <label class="ps-0 mb-1 " for="password">Give a password</label> 
                        <form:input path="password" maxlength="20" type="password" id="password" placeholder="Enter your password" class="form-control mb-4"/>
            			<form:errors path="password" />
						
                        <label class="ps-0 mb-1 " for="repeatpass">Confirm your password</label> 
                        <input type="password" id="repeatpass" name="repeatpass" value="${repeatpass}" maxlength="20" placeholder="Confirm your password" class="form-control mb-4">
            
                        <label class="ps-0 mb-1 " for="email">What's your email</label> 
                        <form:input path="email" type="text" maxlength="254" id="email" placeholder="Enter your email" class="form-control mb-4"/>
						<form:errors path="email" />
						
                        <label class="ps-0 mb-1 " for="fullname">What's your name</label> 
                        <form:input path="fullname" type="text" maxlength="60" id="fullname" placeholder="Enter your fullname" class="form-control mb-4"/>
						<form:errors path="fullname" />
						
						<label class="ps-0 mb-1 " for="phone">What's your phone</label> 
                        <form:input path="phonenumber" type="text" maxlength="10" id="phonenumber" placeholder="Enter your phone" class="form-control mb-4"/>
						<form:errors path="phonenumber" />
						
						
                        <label for="" class="ps-0">When's your birthday?</label>
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
                                <input name="year" value="${year}" type="text" id="year" required class="form-control" placeholder="YYYY" maxlength="4" inputmode="numeric" required pattern="(([0-9][0-9][0-9][0-9]))">
                            </div>
                            <form:errors path="birthday"/>
                        </div>
						
						
                        <label for="nation" class="ps-0 mb-1">What's your nation?</label>
                       
                        <form:select path="nation" id="nation" class="form-select">
							<form:option value="" label="Nation" />
							<c:forEach var="nation" items="${nations}">
								<form:option value="${nation}">${nation}</form:option>
							</c:forEach>
						</form:select>
                        <form:errors path="nation"/>
                        
						
                        <div class="form-footer d-flex align-items-center flex-column mt-3">
                            <button type="submit" class="btn-submit px-5 py-3">Sign up</button>
                            <p>You have an account? <a href="http://localhost:8080/SpotifyWeb/home/login.htm" class="Login-link">Login</a></p>
                        </div>
                        <p5 class="text-danger">${message}</p5>
                        <script>
                        	var selectMonth = document.getElementById("month");
	                     	selectMonth.addEventListener("change", function() {
	                       		localStorage.setItem("selectedMonth", selectMonth.value);
	                     	});
	                     	if (localStorage.getItem("selectedMonth")) {
	                       		selectMonth.value = localStorage.getItem("selectedMonth");
	                     	}
                        </script>
                    </form:form>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        </div>
</body>
</html>