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
<s:include value="header.jsp"/>

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
                        <input type="text" class="form-control" name="productId" id="product-id"
                               value="<s:property value="product.productId"/>" placeholder="Mã sản phẩm" disabled>
                        <span class="form-message p-1"></span>
                    </div>
                </div>
                <div class="row my-4">
                    <div class="col-6 text-center">
                        Tên sản phẩm
                    </div>
                    <div class="col-6">
                        <input type="text" class="form-control" name="productName" id="product-name"
                               value="<s:property value="product.productName"/>" placeholder="Tên sản phẩm" required>
                        <span class="form-message p-1"></span>
                    </div>
                </div>
                <div class="row my-4">
                    <div class="col-6 text-center">
                        Giá bán
                    </div>
                    <div class="col-6">
                        <input type="number" class="form-control" name="productPrice"
                               value="<s:property value="product.productPrice"/>" id="product-price"
                               placeholder="Giá bán" required>
                        <span class="form-message p-1"></span>
                    </div>
                </div>
                <div class="row my-4">
                    <div class="col-6 text-center">
                        Trạng thái
                    </div>
                    <div class="col-6">
                        <select class="form-control" id="isSales">
                            <option value="<s:property value="product.isSales"/>" disabled selected hidden>Chọn trạng
                                thái
                            </option>
                            <option value="1">Còn bán</option>
                            <option value="0">Ngừng bán</option>
                        </select>
                    </div>
                </div>
                <div class="row my-4">
                    <div class="col-6 text-center">
                        Loại
                    </div>
                    <div class="col-6">
                        <select class="form-control" id="isContainer">
                            <s:if test="product.isContainer == 1">
                                <option value="<s:property value="1"/>" disabled selected hidden>Bộ</option>
                            </s:if>
                            <s:else>
                                <option value="<s:property value="0"/>" disabled selected hidden>Linh kiện</option>
                            </s:else>
                            <option value="<s:property value="1"/>">Bộ</option>
                            <option value="<s:property value="0"/>">Linh kiện</option>
                        </select>
                    </div>
                </div>
                <div class="row my-4">
                    <div class="col-6 text-center">
                        Khách hàng
                    </div>
                    <div class="col-6">
                        <select class="form-control" id="customer_id">
                            <option value="-1" disabled selected hidden>Chọn khách hàng</option>
                            <option value="-2" >Không có</option>
                            <s:iterator value="customers">
                                    <option value="<s:property value="customerId"/>"><s:property
                                            value="customerName"/></option>
                            </s:iterator>
                        </select>
                    </div>
                </div>
                <div class="row my-4">
                    <div class="col-6 text-center">
                        Mô tả
                    </div>
                    <div class="col-6">
                        <input type="text-area" class="form-control" name="description"
                               value="<s:property value="product.description"/>" id="description" placeholder="Mô tả"
                               required>
                        <span class="form-message p-1"></span>
                    </div>
                </div>
                <div class="row my-4">
                    <div class="col-6 text-center">
                        Linh kiện
                    </div>
                    <div class="col-6">
                        <ul class="list-group" id="component-list">
                            <s:iterator var="p" value="productDetails">
                                <li class="my-2" style="display:flex; align-items:center;">
                                    <select class="form-control">
                                        <s:iterator value="components">
                                            <s:if test="isContainer == 0">
                                                <s:if test=" #p.productComponent == productId">
                                                    <option value="<s:property value="productId"/>" disabled selected hidden><s:property
                                                            value="productName"/></option>
                                                </s:if>
                                                <s:else>
                                                    <option value="<s:property value="productId"/>"><s:property
                                                            value="productName"/></option>
                                                </s:else>
                                            </s:if>
                                        </s:iterator>
                                    </select>
                                    <input class="form-control mx-3" value="<s:property value="#p.qty"/>" type="number" placeholder="số lượng">
                                    <a type="button" onclick="deleteParent(this)" class="btn btn-danger">X</a>
                                </li>
                            </s:iterator>
                        </ul>
                        <a type="button" onclick="extendComponent()" class="btn btn-info my-5">Thêm thành phần
                        </a>
                    </div>
                </div>

            </div>
            <div class="col">
                <div class="row mb-5 d-flex justify-content-center">
                    <img style="max-height: 400px; max-width: 500px; object-fit: cover" id="image"
                         src="../images/default.jpg" alt="">
                </div>
                <div class="row mb-3">
                    <div class="btn-group" role="group" aria-label="Basic example">
                        <div class="col-6 mr-2"><input type="file" name="image" onchange="chooseFile(this)"
                                                       accept="image/jpeg, image/png" class="form-control"
                                                       id="customFile"/></div>
                        <div class="col-6 mx-2">
                            <button type="button" onclick="clearFileInput()" class="btn btn-danger col-10">Xoá file
                            </button>
                        </div>
                        <%--                          <div class="col-3"><input type="text" name="file-name" class="form-control col-11" placeholder="tên tệp" required></div>--%>
                    </div>
                </div>

                <div class="row mt-5">
                    <div class="btn-group" role="group" aria-label="Basic example">
                        <div class="col-3 offset-3">
                            <button type="button" class="btn btn-secondary col-10">Huỷ</button>
                        </div>
                        <div class="col-3">
                            <button type="button" onclick="save()" class="btn btn-primary col-10">Lưu</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>

</div>


<!-- <button id="testmodal" class="btn btn-primary">Modal</button> -->
<!-- Include Bootstrap JS -->

<script>
    function chooseFile(fileInput) {
        if (fileInput.files && fileInput.files[0]) {
            var reader = new FileReader();

            reader.onload = function (e) {
                $('#image').attr('src', e.target.result);
            }
            reader.readAsDataURL(fileInput.files[0]);
        }
    }

    function clearFileInput() {
        document.getElementById("customFile").value = "";
        document.getElementById("image").src = "../images/default.jpg";
    }

    function getListComponent() {
        let ul = document.getElementById('component-list');
        let components = [];
        let flag = 0;
        ul.querySelectorAll('li').forEach(li => {
            let select = li.querySelector('select').value;
            let input = li.querySelector('input').value;

            if(input < 0){
                flag = 1;
            }

            components.push(select+":"+input);
        });


        if(flag == 1){
            alert("Số lượng không được nhỏ hơn 1");
            return [];
        }

        return components
    }

    Validator({
        form: '#product-detail-form',
        rules: [
            Validator.isRequired('#product-name'),
            Validator.isRequired('#product-price'),
            Validator.isRequired('#description')
        ]
    })

    function save() {

        let productId = document.getElementById('product-id').value;
        let productName = document.getElementById('product-name').value;
        let productPrice = document.getElementById('product-price').value;
        let description = document.getElementById('description').value;
        let image = document.getElementById('customFile');
        let isSales = document.getElementById('isSales').value;
        let customerId = document.getElementById('customer_id').value;
        let isContainer = document.getElementById('isContainer').value;

        if (!isSales) {
            isSales = 1;
        }

        if (productName.trim() === '' || description.trim() === '') {
            alert("vui lòng điền đủ thông tin");
            return;
        }


        if (parseFloat(productPrice) < 0) {
            alert("Giá tiền phải lớn hơn 0");
            return;
        }

        const formData = new FormData();
        formData.append('productId', productId);
        formData.append('productName', productName);
        formData.append('productPrice', productPrice);
        formData.append('description', description);
        formData.append('image', image.files[0]);
        formData.append('isSales', isSales);
        formData.append('customerId', customerId);
        formData.append('components', getListComponent().join(';'));
        formData.append('isContainer', isContainer);

        // if(formData.get('components').length === 0){
        //     console.log("huỷ");
        //     return;
        // }

        let confirmSave = confirm("Xác nhận thay đổi?");

        if (confirmSave) {
            axios.post('/product_save', formData)
                .then(function (response) {
                    // console.log(response.data);
                    console.log(response.status);
                    window.location.href = '/product_execute';
                    alert("thành công!");
                })
                .catch(function (error) {
                    console.log(error);
                    alert("thất bại!");
                });
        } else {

        }
    }

    function deleteParent(button){
        let parent = button.parentNode;
        parent.parentNode.removeChild(parent);
    }

    function extendComponent() {
        let list = document.getElementById('component-list');

        let li = document.createElement('li');
        li.classList.add('my-2')
        li.style = "display:flex; align-items:center;";
        li.innerHTML = `
                        <select class="form-control" id="component">
                            <option value="" disabled selected hidden>Chọn linh kiện</option>
                            <s:iterator value="components">
                                <s:if test="isContainer == 0">
                                    <option value="<s:property value="productId"/>"><s:property
                                            value="productName"/></option>
                                </s:if>
                            </s:iterator>
                        </select>
                        <input class="form-control mx-3" type="number" placeholder="số lượng">
                        <a type="button" onclick="deleteParent(this)" class="btn btn-danger">X</a>`
        list.appendChild(li);
    }
</script>
</body>
</html>