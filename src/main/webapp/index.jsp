<%@ taglib prefix="s" uri="/struts-tags"%>
<%@ taglib prefix="sj" uri="/struts-jquery-tags"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
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

    <link rel="stylesheet" href="../css/styles.css">

    </style>
</head>
<body>

<div style="margin-top: 250px" class="container">
    <div class="row">
        <div class="col-6 m-auto">
            <div class="card border-primary shadow p-5">
                <h2 class="text-primary text-center m-3">Đăng nhập</h2>
                <form action="login" method="post">

                    <div class="form-outline mb-4">
                        <input type="email" name="email" id="email" class="form-control" placeholder="email">
                    </div>

                    <div class="form-outline mb-4">
                        <input type="password" name="password" id="password" class="form-control" placeholder="password">
                    </div>

                    <div class="row d-flex justify-content-around">
                        <div class="form-check col-md-5">
                            <input class="form-check-input" type="checkbox" value="" id="form2Example31" checked />
                            <label class="form-check-label" for="form2Example31"> Remember me </label>
                        </div>
                        <div class="col-md-5 text-end">
                            <a href="#" class="text-primary text-decoration-none ">Forgot password?</a>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary col-12 mt-4">Login</button>
                </form>
            </div>

        </div>
    </div>
</div>
<div class="alert alert-primary d-block" id="customAlert" role="alert">
    A simple primary alert—check it out!
</div>
<s:if test="hasActionErrors()">
    <script>
        alert(<s:actionerror/>)
    </script>
</s:if>
<script src="../js/index.js"></script>
<script>

</script>
</body>
</html>