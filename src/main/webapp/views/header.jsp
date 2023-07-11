<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
    <!-- Include Bootstrap Icons CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- Include Bootstrap Jquery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <link rel="stylesheet" href="../css/styles.css">
    <title>header</title>
</head>
<body>

<!-- Your HTML code here -->
<section id="navbar" class="mb-5">
    <nav class="navbar navbar-expand-lg navbar navbar-dark bg-primary">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">RiverCrane</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse justify-content-between" id="navbarNavDropdown">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="/user_execute">User</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/customer_execute">Customer</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="/product_execute">Product</a>
                    </li>
                </ul>
                <div class="navbar-text d-flex">
                    <div class="col-5 me-4 fs-5" id="header-username">username</div>
                    <a href="" class="col-5 ps-3 d-flex justify-content-center align-items-center"><i class="fs-5 bi bi-person m-auto"></i></a>
                </div>
            </div>
            <div class="alert alert-primary" id="customAlert" role="alert">
                A simple primary alert—check it out!
            </div>
        </div>
    </nav>
</section>
<!-- <button id="testmodal" class="btn btn-primary">Modal</button> -->
<!-- Include Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<script>

</script>
</body>
</html>