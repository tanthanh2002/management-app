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
  <!-- Include Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    <link rel="stylesheet" href="../css/styles.css">
  <title>Product management</title>
</head>
<body>
  
  <!-- Your HTML code here -->
  <s:include value = "header.jsp"/>
  <div class="container-fluid">
    <div class="fs-1 fw-bold border-bottom border-primary border-3 mb-3">PRODUCT</div>
    <div class="row mb-4">
        <div class="col-sm ml-1 mr-1">
            <label for="search-username" class="form-label">Tên</label>
            <input type="text" class="form-control" id="search-username" placeholder="Nhập họ tên">
        </div>
        <div class="col-sm ml-1 mr-1">
            <label for="search-email" class="form-label">Email</label>
            <input type="text" class="form-control" id="search-email" placeholder="Nhập email">
        </div>
        <div class="col-sm ml-1 mr-1">
          <label for="search-email" class="form-label">Giá từ</label>
          <input type="number" class="form-control" id="pricefrom" placeholder="">
        </div>
        <div class="col-sm ml-1 mr-1">
          <label for="search-email" class="form-label">Đến</label>
          <input type="number" class="form-control" id="priceto">
        </div>
    </div>

    <div class="row">
        <div class="col-sm-3">
            <a href="" type="submit" class="btn btn-primary"><i class="bi bi-person-add"></i><span class="px-4">Thêm mới</span></a>
        </div>
        <div class="col-sm-3 offset-3">
            <a href="" type="submit" class="btn btn-primary"><i class="bi bi-search"></i><span class="px-4">Tìm kiếm</span></a>
        </div>
        <div class="col-sm-3">
            <a href="" type="submit" class="btn btn-success"><i class="bi bi-x-lg"></i><span class="px-4">Xoá tìm</span></a>
        </div>
    </div>


    
    <div class="row my-5 px-5">
        <table class="table table-hover">
            <thead>
              <tr>
                <th scope="col" class="col">#</th>
                <th scope="col" class="col">Tên sản phẩm</th>
                <th scope="col" class="col">Mô tả</th>
                <th scope="col" class="col">Giá</th>
                <th scope="col" class="col">Tình trạng</th>
                <th scope="col" class="col"></th>
              </tr>
            </thead>
            <tbody>
            <s:iterator value="products">
                <tr>
                    <th scope="row"><s:property value="productId"/></th>
                    <td><s:property value="productName"/></td>
                    <td><s:property value="productId"/></td>
                    <td>$<s:property value="productPrice"/></td>
                    <s:if test="isSales == 1">
                        <td class="text-success">Đang bán</td>
                    </s:if>
                    <s:else>
                        <td class="text-danger">Ngừng bán</td>
                    </s:else>
                    <td>
                        <a href="" type="submit" class="btn btn-success"><i class="bi bi-pencil-square"></i></a>
                        <a href="" type="submit" class="btn btn-danger"><i class="bi bi-trash3"></i></a>
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





</body>
</html>