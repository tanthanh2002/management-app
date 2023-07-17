<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>

    <!-- Include Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
    <!-- Include Bootstrap Icons CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- Include Bootstrap Jquery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"
            integrity="sha512-uMtXmF28A2Ab/JJO2t/vYhlaa/3ahUOgj1Zf27M5rOo8/+fcTUVH0/E0ll68njmjrLqOBjXM3V9NiPFL5ywWPQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="./js/index.js"></script>
    <script src="js/common.js"></script>
    <link rel="stylesheet" href="../css/styles.css">

    </style>
</head>
<body >

<div style="margin-top: 250px" class="container">
    <div class="row">
        <div class="col-6 m-auto">
            <div class="card border-primary shadow p-5">
                <h2 class="text-primary text-center m-3">Đăng nhập</h2>
                <form class="needs-validation">
                    <div class="form-outline mb-4 form-group">
                        <input type="email" name="email" id="email" class="form-control  my-1" placeholder="email"
                               required>
                    </div>

                    <div class="form-outline mb-4 form-group ">
                        <input type="password" name="password" id="password" class="form-control my-1"
                               placeholder="password" required>
                    </div>

                    <div class="row d-flex justify-content-around">
                        <div class="form-check col-md-5">
                            <input class="form-check-input" type="checkbox" value="" id="isRemember" checked/>
                            <label class="form-check-label" for="isRemember"> Remember me </label>
                        </div>
                        <div class="col-md-5 text-end">
                            <a href="#" class="text-primary text-decoration-none ">Forgot password?</a>
                        </div>
                    </div>
                    <a type="button" id="btn-login" class="btn btn-primary col-12 mt-4">Login</a>
                </form>
            </div>
            <div class="alert alert-primary" id="customAlert" role="alert">
                A simple primary alert—check it out!
            </div>
        </div>
    </div>
</div>

<script>

    document.getElementById('btn-login').onclick = function () {
        let email = document.getElementById('email').value;
        let password = document.getElementById('password').value;
        let isRemember = document.getElementById('isRemember');

        const formData = new FormData();
        formData.append('email', email);
        formData.append('password', password);


        const curUser = getCookie("curUser");

        if(curUser){
            window.location.href = "/user_execute";
            return;
        }else{
            axios.post('/login', formData)
                .then(function (response) {
                    customAlert("Đăng nhập thành công!", 'alert-success');
                    if (isRemember.checked) {
                        setCookie("curUser",email,1);
                    }
                    window.location.href = "/user_execute";
                    console.log(response.status);
                })
                .catch(function (error) {
                    customAlert("Đăng nhập thất bại!", 'alert-danger');
                });
        }


    }

</script>
</body>
</html>