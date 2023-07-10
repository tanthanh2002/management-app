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
    <div class="fs-1 fw-bold border-bottom border-primary border-3 mb-3">CUSTOMER</div>
    <div class="row mb-4">
        <div class="col-sm ml-1 mr-1">
            <label for="customer-name" class="form-label">Tên</label>
            <input type="text" class="form-control" id="customer-name" placeholder="Nhập họ tên">
        </div>
        <div class="col-sm ml-1 mr-1">
            <label for="customer-email" class="form-label">Email</label>
            <input type="text" class="form-control" id="customer-email" placeholder="Nhập email">
        </div>
        <div class="col-sm ml-1 mr-1">
            <label for="customer-group" class="form-label">Nhóm</label>
            <select class="form-control" id="customer-group">
                <option value="" disabled selected hidden>Chọn nhóm</option>
                <option value="Admin">Admin</option>
                <option value="Editor">Editor</option>
                <option value="Reviewer">Reviewer</option>
            </select>
        </div>
        <div class="col-sm ml-1 mr-1">
          <label for="customer-address" class="form-label">Địa chỉ</label>
          <input type="text" class="form-control" id="customer-address" placeholder="Nhập địa chỉ">
      </div>
    </div>

    <div class="row">
        <div class="col-sm-2">
            <a href="" type="submit" class="btn btn-primary"><i class="bi bi-person-add"></i><span class="px-2">Thêm mới</span></a>
        </div>
        <div class="col-sm-2 ">
          <a href="" type="submit" class="btn btn-primary"><i class="bi bi-upload"></i><span class="px-2">Import</span></a>
       </div>
        <div class="col-sm-2 ">
          <a href="" type="submit" class="btn btn-primary"><i class="bi bi-download"></i><span class="px-2">Export</span></a>
        </div>
        <div class="col-sm-2 ">
            <a href="" type="submit" class="btn btn-primary"><i class="bi bi-search"></i><span class="px-2">Tìm kiếm</span></a>
        </div>
        <div class="col-sm-2">
            <a href="" type="submit" class="btn btn-success"><i class="bi bi-x-lg"></i><span class="px-2">Xoá tìm</span></a>
        </div>
    </div>


    
    <div class="row my-5 px-5">
        <table class="table table-hover">
            <thead>
              <tr>
                <th scope="col" class="col">#</th>
                <th scope="col" class="col">Họ tên</th>
                <th scope="col" class="col">Email</th>
                <th scope="col" class="col">Địa chỉ</th>
                <th scope="col" class="col">Điện thoại</th>
                <th scope="col" class="col"></th>
              </tr>
            </thead>
            <tbody>
              <s:iterator value = "customers">
                  <tr>
                      <th scope="row"> <s:property value="customerId"/> </th>
                      <td> <s:property value="customerName"/></td>
                      <td> <s:property value="email"/></td>
                      <td> <s:property value="address"/></td>
                      <td><s:property value="telNum"/></td>
                      <td>
                          <a href="" type="submit" class="btn btn-success"><i class="bi bi-pencil-square"></i></a>
                      </td>
                  </tr>
              </s:iterator>
              
            </tbody>
          </table>
    </div>
    <div class="row my-5">
        <nav aria-label="Page navigation example" class="d-flex justify-content-center">
            <ul class="pagination">
              <li class="page-item">
                <a class="page-link" href="#" aria-label="Previous">
                  <span aria-hidden="true">&laquo;</span>
                </a>
              </li>
              <li class="page-item"><a class="page-link" href="#">1</a></li>
              <li class="page-item"><a class="page-link" href="#">2</a></li>
              <li class="page-item"><a class="page-link" href="#">3</a></li>
              <li class="page-item"><a class="page-link" href="#">4</a></li>
              <li class="page-item active"><a class="page-link" href="#">5</a></li>
              <li class="page-item"><a class="page-link" href="#">6</a></li>
              <li class="page-item"><a class="page-link" href="#">7</a></li>
              <li class="page-item"><a class="page-link" href="#">8</a></li>
              <li class="page-item"><a class="page-link" href="#">9</a></li>
              <li class="page-item">
                <a class="page-link" href="#" aria-label="Next">
                  <span aria-hidden="true">&raquo;</span>
                </a>
              </li>
            </ul>
          </nav>
    </div>
</div>

<div class="modal fade" id="modalcustomer" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Thêm/Chỉnh sửa user</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form action="" class="needs-validation" novalidate autocomplete="off">
          <div class="mb-3">
            <label for="modalcustomer-username" class="col-form-label">Họ tên</label>
            <input type="text" class="form-control" id="modalcustomer-username" required>
            <div class="valid-feedback">
              Looks good!
            </div>
          </div>
          <div class="mb-3">
            <label for="modalcustomer-email" class="col-form-label">Email</label>
            <input type="text" class="form-control" id="modalcustomer-email" required>
            <div class="valid-feedback">
              Looks good!
            </div>
          </div>
          <div class="mb-3">
            <label for="modalcustomer-tel" class="col-form-label">Số điện thoại</label>
            <input type="text" class="form-control" id="modalcustomer-tel">
          </div>
          <div class="mb-3">
            <label for="modalcustomer-address" class="col-form-label">Địa chỉ</label>
            <input type="text" class="form-control" id="modalcustomer-address">
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
        <button type="button" class="btn btn-primary">Lưu</button>
      </div>
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