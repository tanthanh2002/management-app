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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"
            integrity="sha512-uMtXmF28A2Ab/JJO2t/vYhlaa/3ahUOgj1Zf27M5rOo8/+fcTUVH0/E0ll68njmjrLqOBjXM3V9NiPFL5ywWPQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="../js/validator.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/index.js"></script>
    <script src="../js/common.js"></script>
    <link rel="stylesheet" href="../css/styles.css">
  <title>Customer management</title>
</head>
<body>
  
  <!-- Your HTML code here -->
  <s:include value = "header.jsp"/>

  <div class="container-fluid" id="product-detail">
      <div class="fs-1 fw-bold border-bottom border-primary border-3 mb-3 ">PRODUCT DETAIL</div>
      <form action="product_save" method="post" id="product-detail-form">
          <div class="row">
              <div class="col-6">
                  <div class="row my-4">
                      <div class="col-6 text-center">
                          Mã sản phẩm
                      </div>
                      <div class="col-6">
                          <input type="text" class="form-control" name="productId" id="product-id" value="<s:property value="product.productId"/>" placeholder="Mã sản phẩm" disabled>
                          <span class="form-message p-1"></span>
                      </div>
                  </div>
                  <div class="row my-4">
                      <div class="col-6 text-center">
                          Tên sản phẩm
                      </div>
                      <div class="col-6">
                          <input type="text" class="form-control" name="productName" id="product-name" value="<s:property value="product.productName"/>" placeholder="Tên sản phẩm" required>
                          <span class="form-message p-1"></span>
                      </div>
                  </div>
                  <div class="row my-4">
                      <div class="col-6 text-center">
                          Giá bán
                      </div>
                      <div class="col-6">
                          <input type="number" class="form-control" name="productPrice" value="<s:property value="product.productPrice"/>" id="product-price" placeholder="Giá bán" required>
                          <span class="form-message p-1"></span>
                      </div>
                  </div>
                  <div class="row my-4">
                      <div class="col-6 text-center">
                          Trạng thái
                      </div>
                      <div class="col-6">
                          <select class="form-control" id="isSales">
                              <option value="<s:property value="product.isSales"/>" disabled selected hidden>Chọn trạng thái</option>
                              <option value="1">Còn bán</option>
                              <option value="0">Ngừng bán</option>
                          </select>
                      </div>
                  </div>
                  <div class="row my-4">
                      <div class="col-6 text-center">
                          Mô tả
                      </div>
                      <div class="col-6">
                          <input type="text-area" class="form-control" name="description" value="<s:property value="product.description"/>" id="description" placeholder="Mô tả" required>
                          <span class="form-message p-1"></span>
                      </div>
                  </div>
              </div>
              <div class="col">
                  <div class="row mb-5 d-flex justify-content-center">
                      <img style="max-height: 400px; max-width: 500px; object-fit: cover" id="image" src="../images/default.jpg" alt="">
                  </div>
                  <div class="row mb-3">
                      <div class="btn-group" role="group" aria-label="Basic example">
                          <div class="col-6 mr-2"><input type="file" name="image" onchange="chooseFile(this)" accept="image/jpeg, image/png" class="form-control" id="customFile" /></div>
                          <div class="col-6 mx-2"><button type="button" onclick="clearFileInput()" class="btn btn-danger col-10">Xoá file</button></div>
<%--                          <div class="col-3"><input type="text" name="file-name" class="form-control col-11" placeholder="tên tệp" required></div>--%>
                      </div>
                  </div>

                  <div class="row mt-5">
                      <div class="btn-group" role="group" aria-label="Basic example">
                          <div class="col-3 offset-3"><button type="button" class="btn btn-secondary col-10">Huỷ</button></div>
                          <div class="col-3"><button type="button" onclick="save()" class="btn btn-primary col-10">Lưu</button></div>
                      </div>
                  </div>
              </div>
          </div>
      </form>

  </div>


  <!-- <button id="testmodal" class="btn btn-primary">Modal</button> -->
  <!-- Include Bootstrap JS -->

  <script>
      function chooseFile(fileInput){
        if(fileInput.files && fileInput.files[0]){
            var reader = new FileReader();

            reader.onload = function (e){
                $('#image').attr('src',e.target.result);
            }
            reader.readAsDataURL(fileInput.files[0]);
        }
      }

      function clearFileInput() {
          document.getElementById("customFile").value = "";
          document.getElementById("image").src = "../images/default.jpg";
      }

      Validator({
          form: '#product-detail-form',
          rules: [
              Validator.isRequired('#product-name'),
              Validator.isRequired('#product-price'),
              Validator.isRequired('#description')
          ]
      })

      function save(){

          let productId = document.getElementById('product-id').value;
          let productName = document.getElementById('product-name').value;
          let productPrice = document.getElementById('product-price').value;
          let description = document.getElementById('description').value;
          let image  = document.getElementById('customFile');
          let isSales = document.getElementById('isSales').value;

          if(parseFloat(productPrice) < 0){
              alert("Giá tiền phải lớn hơn 0");
              return;
          }

          const formData = new FormData();
          formData.append('productId', productId);
          formData.append('productName', productName);
          formData.append('productPrice', productPrice);
          formData.append('description', description);
          formData.append('image', image.files[0]);
          formData.append('isSales',isSales);

          axios.post('/product_save', formData)
              .then(function (response) {
                  // console.log(response.data);
                  console.log(response.status);
                  window.location.href = '/product_execute';
                  alert("Cập nhật thành công!");
              })
              .catch(function (error) {
                  console.log(error);
                  alert("Cập nhật thất bại thành công!");
              });
      }
  </script>
</body>
</html>