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
    <link rel="stylesheet" href="../Pages/Common/style.css">
    <title>Artist Page</title>
</head>

<body>
    <div class="container-fluid p-0">
        <div class="row-cols-2 d-flex justify-content-center" style="height: 100vh;">
            <!-- Dashboard Here -->
            <%@ include file="/header/artist.jsp"%>
            <!-- Tracks Page Here -->
            <div class="col-10 bg-white pt-4 px-5 overflow-auto" style="height: 100vh;">
                <!-- Top Bar -->
                
                <%@ include file="/header/account.jsp"%>
                <!-- Page Title -->
                <div class="d-flex justify-content-between align-items-center mb-3"></div>
                <!-- Page Body -->
                <div class="row d-flex justify-content-center">
                <h1 class="text-success">Welcome, Artist</h1>
                <h2>Today, There are ${follow} people follow you</h2>

                </div>
            </div>
        </div>
    </div>
</body>

</html>