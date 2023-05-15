<%@ page pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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
        .btn-spotify{
            background-color: #1ed760;
            padding: 0.7rem 2rem;
            border-radius: 16px;
            margin-top: 16px;
            font-weight: 700;
            border: none;
            transition: all 0.1s ease;
        }
        .btn-spotify:hover{
            scale: 1.04;
        }
        
    </style>
    <title>Change Pass</title>
</head>
<body>
    <div style="width: 100vw; height: 100vh;" class="">
        <button class="bg-primary p-1 m-3" data-bs-toggle="modal" data-bs-target="#changePass" >Open</button>
        <div class="modal" id="changePass">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="p-2 d-flex flex-column justify-content-center align-items-center">
                        <h1><i class="fa-brands fa-spotify"></i> Change password</h1>
                        <div style="background-color: #1ed760; height: 2px; width: 50%;"></div>
                    </div>
    
                    <div class="modal-body">
					<form action="/Spotify/user/changePassword.htm" method="POST">
							<label for="oldPass" class="form-label fw-bold">Your old password</label>
							<input name="oldPassword" value="${oldPassword}" type="password" maxlength="20"
							class="form-control mb-3" id="oldPass" required/>
							
							<label for="newPass" class="form-label fw-bold">Your new password</label>
							<input name="password1" value="${password1}" type="password" maxlength="20"
							class="form-control mb-3" id="newPass" required/>
							
							<label for="confirmPass" class="form-label fw-bold" >Confirm your password</label>
							<input name="password2" value="${password2}" type="password" maxlength="20"
							class="form-control mb-3" id="confirmPass" required/>
							
							
							<div class="d-flex justify-content-center align-items-center">
									<button class="submit btn-spotify">Xác nhận</button>
									
									
								<button onclick="location.href='http://localhost:8080/Spotify/home/login.htm'"
									type="button" class="submit btn-spotify">Về trang chủ</button>
							</div>
	</form>
	</div>
                </div>
            </div>
        </div>
        <p5 class="text-danger">${message}</p5> 
    </div>
    

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>
</html>