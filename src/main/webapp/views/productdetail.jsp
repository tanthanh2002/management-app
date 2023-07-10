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
  <title>Customer management</title>
</head>
<body>
  
  <!-- Your HTML code here -->
  <s:include value = "header.jsp"/>

  <div class="container-fluid">
    <div class="fs-1 fw-bold border-bottom border-primary border-3 mb-3">PRODUCT DETAIL</div>
    <div class="col-md-6">
        <form action="">
            <div class="row my-4">
                <div class="col-6 text-center">
                    Tên sản phẩm
                </div>
                <div class="col-6">
                    <input type="text" class="form-control" id="customer-email" placeholder="Tên sản phẩm">
                </div>
            </div>
            <div class="row my-4">
                <div class="col-6 text-center">
                    Giá bán
                </div>
                <div class="col-6">
                    <input type="text" class="form-control" id="customer-email" placeholder="Giá bán">
                </div>
            </div>
            <div class="row my-4">
                <div class="col-6 text-center">
                    Mô tả
                </div>
                <div class="col-6">
                    <input type="text-area" class="form-control" id="customer-email" placeholder="Mô tả">
                </div>
            </div>
            

        </form>
    </div>
    <div class="col-md-6">
        <div class="row"></div>
        <div class="row">
            upload
        </div>
    </div>
  </div>


 <!-- <button id="testmodal" class="btn btn-primary">Modal</button> -->
  <!-- Include Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
  <script>
    
  </script>
</body>
</html>