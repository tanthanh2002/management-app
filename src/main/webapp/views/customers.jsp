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

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/index.js"></script>
    <script src="../js/common.js"></script>
    <link rel="stylesheet" href="../css/styles.css">

    <title>Customer management</title>
</head>
<body>

<!-- Your HTML code here -->

<s:include value="header.jsp"/>

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
            <label class="form-label">Nhóm</label>
            <select class="form-control" id="customer-group">
                <option value="ALL" disabled selected hidden>Chọn nhóm</option>
                <option value="GLOBAL">GLOBAL</option>
                <option value="GLOCAL">GLOCAL</option>
                <option value="MARKETING">MARKETING</option>
                <option value="DESIGN">DESIGN</option>
                <option value="DATA">DATA</option>
            </select>
        </div>
        <div class="col-sm ml-1 mr-1">
            <label class="form-label">Trạng thái</label>
            <select class="form-control" id="customer-status">
                <option value="-1" disabled selected hidden>Chọn trạng thái</option>
                <option value="1">Đang hoạt động</option>
                <option value="0">Bị khoá</option>
            </select>
        </div>
        <div class="col-sm ml-1 mr-1">
            <label for="customer-address" class="form-label">Địa chỉ</label>
            <input type="text" class="form-control" id="customer-address" placeholder="Nhập địa chỉ">
        </div>
    </div>

    <div class="row">
        <s:if test="#session.role == 'Admin'">
            <div class="col-sm-2">
                <a onclick="showModel()" type="button" class="btn btn-primary"><i class="bi bi-person-add"></i><span
                        class="px-2">Thêm mới</span></a>
            </div>
            <div class="col-sm-2 ">
                <a id="btn-import" type="button" class="btn btn-primary mb-3"><i
                        class="bi bi-upload"></i><span class="px-2">Import</span></a>
                <input type="file" name="file-csv"
                       accept=".csv" class="form-control"
                       id="fileCsv"/>
            </div>
            <div class="col-sm-2 ">
                <a id="btn-export" type="button" class="btn btn-primary"><i class="bi bi-download"></i><span
                        class="px-2">Export</span></a>
            </div>
        </s:if>

        <div class="col-sm-2 ">
            <a type="button" id="btn-search-customer" class="btn btn-primary"><i class="bi bi-search"></i><span
                    class="px-2">Tìm kiếm</span></a>
        </div>
        <div class="col-sm-2">
            <a href="/customer_execute" type="button" class="btn btn-success"><i class="bi bi-x-lg"></i><span
                    class="px-2">Xoá tìm</span></a>
        </div>
    </div>

    <div class="row my-5">
        <nav aria-label="Page navigation example" class="d-flex justify-content-center">
            <ul class="pagination">
                <li class="page-item">
                    <s:a class="page-link" href="/customer_execute?page=%{page - 1 >= 0 ? page - 1 : 0}"
                         aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </s:a>
                </li>
                <s:iterator value="pages">
                    <s:if test="%{top == page}">
                        <li class="page-item active"><a class="page-link"
                                                        onclick="pagination(<s:property/>)"><s:property/></a>
                        </li>
                    </s:if>
                    <s:else>
                        <li class="page-item"><a class="page-link"
                                                 onclick="pagination(<s:property/>)"><s:property/></a></li>
                    </s:else>
                </s:iterator>
                <li class="page-item">
                    <s:a class="page-link" href="/customer_execute?page=%{page + 1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </s:a>
                </li>
            </ul>
        </nav>
    </div>
    <div class="row text-end px-5" readonly>
        <div class="col-12"><s:property value="start"/> ~ <s:property value="finish"/> trong tổng số <p class="d-inline-block fw-bold"><s:property value="totalRecord"/></p></div>
    </div>
    <div class="row my-5 px-5">
        <table class="table table-hover">
            <thead>
            <tr>
                <th scope="col" class="col">#</th>
                <th scope="col" class="col">Mã</th>
                <th scope="col" class="col">Họ tên</th>
                <th scope="col" class="col">Email</th>
                <th scope="col" class="col">Địa chỉ</th>
                <th scope="col" class="col">Điện thoại</th>
                <th scope="col" class="col">Tình trạng</th>
                <th scope="col" class="col">Nhóm</th>
                <th scope="col" class="col"></th>
            </tr>
            </thead>
            <tbody>
            <s:iterator value="customers" status="rowStatus">
                <tr>
                    <th scope="row"><s:property value="%{#rowStatus.count + (page-1)*10}" /></th>
                    <td style="display: none"><s:property value="customerId"/></td>
                    <td><s:property value="customerCode"/></td>
                    <td><s:property value="customerName"/></td>
                    <td><s:property value="email"/></td>
                    <td><s:property value="address"/></td>
                    <td><s:property value="telNum"/></td>
                    <s:if test="isActive == 1">
                        <td class="text-success" readonly>Đang hoạt động</td>
                    </s:if>
                    <s:elseif test="isActive == 2">
                        <td class="text-warning" readonly>Được cấp thiết bị</td>
                    </s:elseif>
                    <s:else>
                        <td class="text-danger" readonly>Bị khoá</td>
                    </s:else>
                    <td><s:property value="groupName"/></td>
                    <td>
                        <s:if test="#session.role == 'Admin' || #session.role == 'Editor'">
                            <a type="button" onclick=editRow(this) class="btn btn-success btn-edit"><i
                                    class="bi bi-pencil-square"></i></a>
                            <a type="button" onclick=saveRow(this) style="display: none;"
                               class="btn btn-primary btn-save"><i class="bi bi-save"></i></a>
                        </s:if>
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
                    <s:a class="page-link" href="/customer_execute?page=%{page - 1 >= 0 ? page - 1 : 0}"
                         aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </s:a>
                </li>
                <s:iterator value="pages">
                    <s:if test="%{top == page}">
                        <li class="page-item active"><a class="page-link"
                                                        onclick="pagination(<s:property/>)"><s:property/></a>
                        </li>
                    </s:if>
                    <s:else>
                        <li class="page-item"><a class="page-link"
                                                 onclick="pagination(<s:property/>)"><s:property/></a></li>
                    </s:else>
                </s:iterator>
                <li class="page-item">
                    <s:a class="page-link" href="/customer_execute?page=%{page + 1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </s:a>
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
                    </div>
                    <div class="mb-3">
                        <label for="modalcustomer-email" class="col-form-label">Email</label>
                        <input type="email" class="form-control" id="modalcustomer-email" required>
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
                        <input type="text" class="form-control" name="" id="modalcustomer-address">
                    </div>
                    <div class="mb-3">
                        <label for="modalcustomer-isActive" class="col-form-label">Trạng thái</label>
                        <select class="form-control" id="modalcustomer-isActive">
                            <option value="-1" disabled selected hidden>Chọn trạng thái</option>
                            <option value="1">Đang hoạt động</option>
                            <option value="0">Bị khoá</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Nhóm</label>
                        <select class="form-control" id="modalcustomer-group">
                            <option value="GLOBAL" disabled selected hidden>Chọn nhóm</option>
                            <option value="GLOBAL">GLOBAL</option>
                            <option value="GLOCAL">GLOCAL</option>
                            <option value="MARKETING">MARKETING</option>
                            <option value="DESIGN">DESIGN</option>
                            <option value="DATA">DATA</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="submit" id="save-customer" class="btn btn-primary">Lưu</button>
            </div>
        </div>
    </div>
</div>


<!-- <button id="testmodal" class="btn btn-primary">Modal</button> -->
<!-- Include Bootstrap JS -->

<script>

    function showModel() {
        var myModal = new bootstrap.Modal(document.getElementById('modalcustomer'), {
            keyboard: false
        })
        myModal.show();
    }

    document.getElementById('save-customer').addEventListener('click', function (event) {

        let customerName = document.getElementById('modalcustomer-username');
        let customerEmail = document.getElementById('modalcustomer-email');
        let customerTel = document.getElementById('modalcustomer-tel');
        let customerAddress = document.getElementById('modalcustomer-address');
        let customerStatus = document.getElementById('modalcustomer-isActive');
        let customerGroup = document.getElementById('modalcustomer-group');

        var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;

        if (customerName.value.trim() === '' || customerAddress.value.trim() === '' || customerTel.value.trim() === '') {
            event.preventDefault();
            alert("Dữ liệu không hợp lệ. Không được để trống!");
            return;
        }

        if (!regex.test(customerEmail.value)) {
            event.preventDefault();
            alert("Email không đúng định dạng!");
            return;
        }

        const formData = new FormData();
        formData.append('customerName', customerName.value);
        formData.append('customerEmail', customerEmail.value);
        formData.append('customerAddress', customerTel.value);
        formData.append('customerTel', customerAddress.value);
        formData.append('isActive', customerStatus.value == -1 ? 1 : customerStatus.value);
        formData.append('groupName',customerGroup.value);


        let confirmInsert = confirm("Bạn có muốn thêm khách hàng không?");

        if (confirmInsert) {
            axios.post('/customer_insert', formData)
                .then(function (response) {
                    // console.log(response.data);
                    alert("thêm khách hàng thành công!");
                    console.log(response.status);
                    setTimeout(location.reload(), 100);
                })
                .catch(function (error) {
                    console.log(error);
                    alert("thêm khách hàng thất bại! email đã được sữ dụng");
                    setTimeout(location.reload(), 100);
                });
        } else {
            setTimeout(location.reload(), 100);
        }


    })

    function editRow(button) {

        // button.classList.remove("btn-success");
        // button.classList.add("btn-primary");

        var row = button.closest("tr");
        row.classList.add('border-info');
        row.classList.add('border-4');
        var nameCell = row.cells[3];
        var emailCell = row.cells[4];
        var addressCell = row.cells[5];
        var telCell = row.cells[6];

        nameCell.contentEditable = true;
        emailCell.contentEditable = true;
        addressCell.contentEditable = true;
        telCell.contentEditable = true;

        row.querySelector(".btn-save").style.display = 'inline-block';
        row.querySelector(".btn-edit").style.display = 'none';

    }

    function saveRow(button) {
        // button.classList.remove("btn-primary");
        // button.classList.add("btn-success");

        var row = button.closest("tr");
        var idCell = row.cells[1];
        var codeCell = row.cells[2];
        var nameCell = row.cells[3];
        var emailCell = row.cells[4];
        var addressCell = row.cells[5];
        var telCell = row.cells[6];
        var groupCell = row.cells[8];


        let confirmSave = confirm("Bạn có chắc chắn chỉnh sửa thông tin khách hàng không?");

        if (confirmSave) {
            if (idCell.textContent && nameCell.textContent && emailCell.textContent && addressCell.textContent && telCell.textContent) {
                const formData = new FormData();
                formData.append('customerId', parseInt(idCell.innerText));
                formData.append('customerName', nameCell.textContent);
                formData.append('customerEmail', emailCell.textContent);
                formData.append('customerAddress', addressCell.textContent);
                formData.append('customerTel', telCell.textContent);
                formData.append('groupName',groupCell.textContent);
                formData.append('customerCode', codeCell.textContent);

                var regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
                console.log(emailCell.textContent);
                if(regex.test(emailCell.textContent)){
                    axios.post('/customer_edit', formData)
                        .then(function (response) {
                            console.log(response.status);
                            alert('Sửa thông tin khách hàng thành công');
                        })
                        .catch(function (error) {
                            console.log(error.status);
                            alert('Sửa thông tin khách hàng thất bại! Email đã tồn tại.');
                            setTimeout(location.reload(), 100);
                        });
                }else {
                    alert('Sửa thông tin khách hàng thất bại! Email không hợp lệ.');
                    setTimeout(location.reload(), 100);
                }
            } else {
                alert('Sửa thông tin khách hàng thất bại! Thông tin không hợp lệ.');
                setTimeout(location.reload(), 2000);
            }
            ;
        } else {
            setTimeout(location.reload(), 100);
        }

        nameCell.contentEditable = false;
        emailCell.contentEditable = false;
        addressCell.contentEditable = false;
        telCell.contentEditable = false;
        row.classList.remove('border-info');
        row.classList.remove('border-4');
        row.querySelector(".btn-save").style.display = 'none';
        row.querySelector(".btn-edit").style.display = 'inline-block';
    }

    let btnExport = document.getElementById('btn-export');
    if(btnExport != null){
        btnExport.onclick = function () {
            axios.get('/customer_export')
                .then(function (response) {
                    customAlert("Export dữ liệu khách hàng thành công!", 'alert-success');
                    console.log(response.status);
                })
                .catch(function (error) {
                    customAlert("Export dữ liệu khách hàng thất bại!", 'alert-danger');
                });
        }
    }

    let btnImport = document.getElementById('btn-import');
    if(btnImport != null){
        btnImport.onclick = function () {
            let fileCsv = document.getElementById('fileCsv');
            const data = new FormData();

            if(fileCsv.files[0] == undefined){
                alert("vui lòng chọn file");
                return;
            }
            data.append('fileCsv',fileCsv.files[0])
            axios.post('/customer_importCustomer',data)
                .then(function (response) {
                    alert("thêm dữ liệu thành công");
                    window.location.href = '/customer_execute';
                    console.log(response.status);
                })
                .catch(function (error) {
                    alert("Import dữ liệu khách hàng không hoàn thành!");
                });
        }
    }

    let btnSearch = document.getElementById('btn-search-customer');
    if(btnSearch != null){
        btnSearch.onclick = function () {
            let name = document.getElementById('customer-name').value;
            let email = document.getElementById('customer-email').value;
            let status = document.getElementById('customer-status').value;
            let address = document.getElementById('customer-address').value;
            let groupName = document.getElementById('customer-group').value;
            var url = '/customer_search.action?customerName=' + name + '&customerEmail=' + email + '&isActive=' + status + '&customerAddress=' + address +'&groupName=' + groupName;
            btnSearch.href = url;
            btnSearch.click();
        }
    }


    function pagination(page) {
        var currentPath = window.location.href;
        var newPath = "";
        if (currentPath.includes("page=")) {
            currentPath = currentPath.substring(0, currentPath.indexOf("page=") - 1);
        }
        newPath = currentPath;
        if(newPath.includes('?')){
            newPath = newPath + ("&page=" + page);
        }else {
            newPath = newPath + ("?page=" + page);
        }

        window.location.href = newPath;
        console.log(newPath);
    }
</script>
</body>
</html>