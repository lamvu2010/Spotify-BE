<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!doctype html>
<html lang="en">
  <head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <link rel="stylesheet" href="../Common/style.css" />
    <title>Login - Spotify</title>
    <base href ="${pageContext.servletContext.contextPath }/">
  </head>
  <body>
    <div class="px-4 py-5 px-md-5 text-lg-start" style="background-color: white">
    <div class="container"> 
        <div class="row">
          <div class="col d-flex justify-content-center">
            <h1>Spotify</h1>
            <hr />
          </div>  
        </div>
        <div class="row">
            <div class="col-sm-12 d-flex justify-content-center">
                <form action="/Spotify/home/login.htm" method="POST">
                    <div class="form-outline mb-4">
                        <label>Username</label>
                        <input name="username" type="text" maxlength="20" id="form2Example1" class="form-control" />
                    </div>
              
                    <div class="form-outline mb-4">
                        <label class="form-label" for="form2Example2">Password</label>
                      <input name="password" type="password" maxlength="20" id="form2Example2" class="form-control" />
                    </div>
            
                    <div class="row mb-4">
                      <div class="col d-flex justify-content-center">
                        <div class="form-check">
                          <input class="form-check-input" type="checkbox" value="" id="form2Example31" checked />
                          <label class="form-check-label" for="form2Example31"> Remember me </label>
                        </div>
                      </div>
              
                      <div class="col">
                        <a href="http://localhost:8080/Spotify/forget/requestEmail.htm">Forgot password?</a>
                      </div>
                    </div>
              
                    <button 
                        class="btn btn-primary btn-block mb-4 w-100 base-bnt" 
                        style="
                            background-color: #1ed760; 
                            color: #000;
                        "
                    >
                        Sign in
                    </button>
              		 <p >${message}</p>
                    <div class="text-center">
                      
                      <p>Not a member?</p>
                      <button 
                        type="button" 
                        class="btn btn-primary btn-block mb-4 w-100 base-bnt" 
                        style="
                            background-color: #fff; 
                            color: #878787;
                            border: 1px solid #878787;
                        "
                        onclick="location.href='http://localhost:8080/Spotify/user/register/form.htm'"
									type="button"
                    >
                        Sign up
                    </button>
                    
                    <button type="button" 
                        class="btn btn-primary btn-block mb-4 w-100 base-bnt" 
                        style="
                            background-color: #fff; 
                            color: #878787;
                            border: 1px solid #878787;
                        " onclick="location.href='http://localhost:8080/Spotify/home/login.htm'"
									type="button">Tải lại trang</button>
                    </div>
                </form>
            </div>  
          </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  </body>
</html>