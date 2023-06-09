<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
    <link href="${pageContext.request.contextPath}/Pages/Common/style.css" rel="stylesheet">

    <title>Spotify: Forget password</title>
</head>
<body>
        <div class="container-fluid">
            <div class="row-cols-1 d-flex justify-content-center">
                <div class="col-md-5 col-lg-4 col-xl-4 col-8">
                    <div class="row text-center">
                        <p style="font-weight: bold; font-size: 36px;"><i class="fa-brands fa-spotify me-2"></i>Spotify</p>
                        <p style="font-weight: 600; font-size: 24px;">Please provide for me your email</p>
                        <hr>
                    </div>
                    <form action="/SpotifyWeb/forget/requestEmail.htm" method="POST" class="signup-form row">
                    	
                    	<c:if test="${btnStatus=='sendEmail'}">
							<div>
								<label class="ps-0 mb-1" for="email">What's your email?</label> 
								<input name="email" type="text" maxlength="254" class="form-control mb-4"/>
							</div>
						</c:if>
						<c:if test="${btnStatus=='confirm'}">
							<div>
								<label>Email: </label>
								${email}
							</div>
							<div>
								<label class="ps-0 mb-1">Verify code</label>
								<input name="code" type="text" maxlength="8" class="form-control mb-4"/>
							</div>
						</c:if>
							<div class="p-2 d-flex flex-column justify-content-center align-items-center">
								<div style="margin-left: 2.5em">
								<button onclick="location.href='/SpotifyWeb/forget/requestEmail.htm'"
									type="button" class="btn-spotify">Refresh</button>
							
								<c:if test="${btnStatus=='sendEmail'}">
									<button name="${btnStatus}" class="btn-spotify">Send email</button>
								</c:if>
								<c:if test="${btnStatus=='confirm'}">
									<button name="${btnStatus}" class="btn-spotify">Confirm </button>
								</c:if>
									<p class="text-danger">${message}</p>
								</div>
							</div>
                    </form>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        </div>
</body>
</html>