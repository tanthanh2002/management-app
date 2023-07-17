<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sj" uri="/struts-jquery-tags" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/axios/1.4.0/axios.min.js"
            integrity="sha512-uMtXmF28A2Ab/JJO2t/vYhlaa/3ahUOgj1Zf27M5rOo8/+fcTUVH0/E0ll68njmjrLqOBjXM3V9NiPFL5ywWPQ=="
            crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    <script src="../js/index.js"></script>
    <script src="../js/common.js"></script>
    <link rel="stylesheet" href="../css/styles.css">
    <title>Product management</title>
</head>
<body onload="isLogin()">

<!-- Your HTML code here -->
<s:include value="header.jsp"/>
<div class="container-fluid">
    <div class="fs-1 fw-bold border-bottom border-primary border-3 mb-3">PRODUCT</div>
    <div class="row mb-4">
        <div class="col-sm ml-1 mr-1">
            <label class="form-label">Tên</label>
            <input type="text" class="form-control" id="search-productname" placeholder="Nhập họ tên">
        </div>
        <div class="col-sm ml-1 mr-1">
            <label class="form-label">Trạng thái</label>
            <select class="form-control" id="search-status">
                <option value="-1" disabled selected hidden>Chọn trạng thái</option>
                <option value="1">Còn bán</option>
                <option value="0">Ngừng bán</option>
            </select>
        </div>
        <div class="col-sm ml-1 mr-1">
            <label class="form-label">Giá từ</label>
            <input type="number" class="form-control" min="0" id="pricefrom" placeholder="từ giá">
        </div>
        <div class="col-sm ml-1 mr-1">
            <label class="form-label">Đến</label>
            <input type="number" class="form-control" min="0" id="priceto" placeholder="đến giá">
        </div>
    </div>

    <div class="row">
        <div class="col-sm-3">
            <a href="/product_detail" type="button" class="btn btn-primary"><i class="bi bi-person-add"></i><span
                    class="px-4">Thêm mới</span></a>
        </div>
        <div class="col-sm-3 offset-3">
            <a href="" type="button" id="btn-search" class="btn btn-primary"><i class="bi bi-search"></i><span
                    class="px-4">Tìm kiếm</span></a>
        </div>
        <div class="col-sm-3">
            <a href="/product_execute" type="button" class="btn btn-success"><i class="bi bi-x-lg"></i><span
                    class="px-4">Xoá tìm</span></a>
        </div>
    </div>

    <div class="row my-5">
        <nav aria-label="Page navigation example" class="d-flex justify-content-center">
            <ul class="pagination">
                <li class="page-item">
                    <s:a class="page-link" href="/product_execute?page=%{page - 1 >= 0 ? page - 1 : 0}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </s:a>
                </li>
                <s:iterator value="pages">
                    <s:if test="%{top == page}">
                        <li class="page-item active"><a class="page-link" href="/product_execute?page=<s:property/>"><s:property/></a></li>
                    </s:if>
                    <s:else>
                        <li class="page-item"><a class="page-link" href="/product_execute?page=<s:property/>"><s:property/></a></li>
                    </s:else>
                </s:iterator>
                <li class="page-item">
                    <s:a class="page-link" href="/product_execute?page=%{page + 1}"  aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </s:a>
                </li>
            </ul>
        </nav>
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
                    <td><s:property value="description"/></td>
                    <td>$<s:property value="productPrice"/></td>
                    <s:if test="isSales == 1">
                        <td class="text-success">Đang bán</td>
                    </s:if>
                    <s:else>
                        <td class="text-danger">Ngừng bán</td>
                    </s:else>
                    <td>
                        <a href="/product_detail?productId=<s:property value="productId"/>" type="button" class="btn btn-success"><i class="bi bi-pencil-square"></i></a>
                        <a onclick="deleteProduct(<s:property value="productId"/>)" type="button"
                           class="btn btn-danger"><i class="bi bi-trash3"></i></a>
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
                    <s:a class="page-link" href="/product_execute?page=%{page - 1 >= 0 ? page - 1 : 0}" aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </s:a>
                </li>
                <s:iterator value="pages">
                    <s:if test="%{top == page}">
                        <li class="page-item active"><a class="page-link" href="/product_execute?page=<s:property/>"><s:property/></a></li>
                    </s:if>
                    <s:else>
                        <li class="page-item"><a class="page-link" href="/product_execute?page=<s:property/>"><s:property/></a></li>
                    </s:else>
                </s:iterator>
                <li class="page-item">
                    <s:a class="page-link" href="/product_execute?page=%{page + 1}"  aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </s:a>
                </li>
            </ul>
        </nav>
    </div>
</div>

<div class="modal" id="modal_delete" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Xoá sản phẩm</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <p>Bạn có muốn xoá sản phẩm này không?</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button href="" type="button" id="confirm_delete" class="btn btn-danger">Xoá</button>
            </div>
        </div>
    </div>
</div>


<script>
    let btnSearch = document.getElementById('btn-search');
    btnSearch.onclick = function () {
        let productName = document.getElementById('search-productname').value;
        let priceFrom = document.getElementById('pricefrom').value;
        let priceTo = document.getElementById('priceto').value;
        let isSales = document.getElementById('search-status').value;
        var url = '/product_search.action?productName=' + productName + '&isSales=' + isSales + '&priceFrom=' + priceFrom + '&priceTo=' + priceTo;
        btnSearch.href = url;
        btnSearch.click();
    };

    function deleteProduct(productId) {
        var myModal = new bootstrap.Modal(document.getElementById('modal_delete'), {
            keyboard: false
        })
        myModal.show();
        var btnDelete = document.getElementById("confirm_delete");
        var url = "/product_delete.action?productId=" + productId;
        btnDelete.onclick = function (productId) {
            axios.get(url)
                .then(function (response) {
                    myModal.hide();
                    alert("Xoá sản phẩm thành công!", 'alert-success');
                    window.location.href = '/product_execute';
                    console.log(response.status);
                })
                .catch(function (error) {
                    alert("Xoá sản phẩm thất bại!", 'alert-danger');
                });
        }
    }
</script>
</body>
</html>