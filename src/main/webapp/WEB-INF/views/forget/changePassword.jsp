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
                        <p style="font-weight: 600; font-size: 24px;">Change your old password</p>
                        <hr>
                    </div>
                    <form action="/SpotifyWeb/forget/requestEmail.htm" method="POST" class="signup-form row">
                    	<div>
								<label class="ps-0 mb-1">Username: </label>
								${username}
							</div>
							<div>
								<label class="ps-0 mb-1">New password</label>
								<input name="password1" type="password" maxlength="20" class="form-control mb-4"/>
							</div>
							<div>
								<label class="ps-0 mb-1">Confirm password</label>
								<input name="password2" type="password" maxlength="20" class="form-control mb-4"/>
							</div>
							<div >
								
									<button name="supply" class="btn-spotify">Confirm </button>
									
								<button onclick="location.href='/SpotifyWeb/home/login.htm'"
									type="button" class="btn-spotify">Return</button>
									<p>${message}</p>
							</div>
                    </form>
                </div>
            </div>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        </div>
</body>
</html>