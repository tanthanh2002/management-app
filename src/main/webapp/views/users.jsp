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
    <%--  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">--%>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Include Bootstrap Icons CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <!-- Include Bootstrap Jquery -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

    <!-- Include Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="../js/index.js"></script>
    <script src="../js/common.js"></script>
    <link rel="stylesheet" href="../css/styles.css">
    <title>User management</title>
</head>
<body>

<!-- Your HTML code here -->
<s:include value="header.jsp"/>

<div class="container-fluid">
    <div class="fs-1 fw-bold border-bottom border-primary border-3 mb-3">USER</div>
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
            <label for="search-group" class="form-label">Nhóm</label>
            <select class="form-control" id="search-group">
                <option value="" disabled selected hidden>Chọn nhóm</option>
                <s:iterator value="groupRoles">
                    <option value="<s:property/>"><s:property/></option>
                </s:iterator>
            </select>
        </div>
        <div class="col-sm ml-1 mr-1">
            <label for="search-status" class="form-label">Trạng thái</label>
            <select class="form-control" id="search-status">
                <option value="-1" disabled selected hidden>Chọn trạng thái</option>
                <option value="1">Đang hoạt động</option>
                <option value="0">Tạm khoá</option>
            </select>
        </div>
    </div>

    <div class="row">
        <div class="col-sm-3">
            <a href="#" type="button" onclick="showcreateUser()" class="btn btn-primary"><i
                    class="bi bi-person-add"></i><span class="px-4">Thêm mới</span></a>
        </div>
        <div class="col-sm-3 offset-3">
            <a href="" type="button" id="btn-search" class="btn btn-primary"><i class="bi bi-search"></i><span
                    class="px-4">Tìm kiếm</span></a>
        </div>
        <div class="col-sm-3">
            <a href="/user_execute.action" type="button" class="btn btn-success"><i class="bi bi-x-lg"></i><span
                    class="px-4">Xoá tìm</span></a>
        </div>
    </div>

    <div class="row my-5">
        <nav aria-label="Page navigation example" class="d-flex justify-content-center">
            <ul class="pagination">
                <li class="page-item">
                    <s:a class="page-link" href="/user_execute?page=%{page - 1 >= 0 ? page - 1 : 0}"
                         aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </s:a>
                </li>
                <s:iterator value="pages">
                    <s:if test="%{top == page}">
                        <li class="page-item active"><a class="page-link"
                                                        onclick="pagination(<s:property/>)"><s:property/></a></li>
                    </s:if>
                    <s:else>
                        <li class="page-item"><a class="page-link"
                                                 onclick="pagination(<s:property/>)"><s:property/></a></li>
                    </s:else>
                </s:iterator>
                <li class="page-item">
                    <s:a class="page-link" href="/user_execute?page=%{page + 1}" aria-label="Next">
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
                <th scope="col" class="col">Họ tên</th>
                <th scope="col" class="col">Email</th>
                <th scope="col" class="col">Nhóm</th>
                <th scope="col" class="col">Trạng thái</th>
                <th scope="col" class="col"></th>
            </tr>
            </thead>
            <tbody>
            <s:iterator value="users" status="rowStatus">
                <tr>
                    <th scope="row"><s:property value="%{#rowStatus.count + (page-1)*10}"/></th>
                    <td><s:property value="name"/></td>
                    <td><s:property value="email"/></td>
                    <td><s:property value="groupRole"/></td>
                    <s:if test="isActive == 1">
                        <td class="text-success">Đang hoạt động</td>
                    </s:if>
                    <s:else>
                        <td class="text-danger">Tạm khoá</td>
                    </s:else>
                    <td>
                        <a href="#"
                           onclick="showModelEdit(<s:property value="id"/>,'<s:property value="name"/>','<s:property
                                   value="email"/>','<s:property value="groupRole"/>')" type="button"
                           class="btn btn-success"><i class="bi bi-pencil-square"></i></a>
                        <a href="/user_delete.action?id=<s:property value = "id"/>" type="button"
                           class="btn btn-danger"><i class="bi bi-trash3 btn-delete"></i></a>
                        <a href="/user_changelock.action?id=<s:property value = "id"/>" type="button"
                           class="btn btn-secondary"><i class="bi bi-person-fill-lock btn-lock"></i></a>
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
                    <s:a class="page-link" href="/user_execute?page=%{page - 1 >= 0 ? page - 1 : 0}"
                         aria-label="Previous">
                        <span aria-hidden="true">&laquo;</span>
                    </s:a>
                </li>
                <s:iterator value="pages">
                    <s:if test="%{top == page}">
                        <li class="page-item active"><a class="page-link"
                                                        onclick="pagination(<s:property/>)"><s:property/></a></li>
                    </s:if>
                    <s:else>
                        <li class="page-item"><a class="page-link" onclick="pagination(<s:property/>)"><s:property/></a>
                        </li>
                    </s:else>
                </s:iterator>
                <li class="page-item">
                    <s:a class="page-link" href="/user_execute?page=%{page + 1}" aria-label="Next">
                        <span aria-hidden="true">&raquo;</span>
                    </s:a>
                </li>
            </ul>
        </nav>
    </div>
</div>

<div class="modal fade" id="modaluser" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Thêm/Chỉnh sửa user</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form action="user_update" id="modal-formuser" class="needs-validation" autocomplete="off">
                    <div class="mb-3">
                        <label for="modal-userid" class="col-form-label">id</label>
                        <input type="text" class="form-control" name="id" id="modal-userid" readonly>

                    </div>
                    <div class="mb-3">
                        <label for="modal-username" class="col-form-label">Họ tên</label>
                        <input type="text" class="form-control" name="name" id="modal-username" required>
                        <span class="form-message p-1"></span>
                    </div>
                    <div class="mb-3">
                        <label class="col-form-label">Email</label>
                        <input type="email" class="form-control" name="email" id="modal-email" required>
                        <span class="form-message p-1"></span>
                    </div>
                    <div class="mb-3">
                        <label for="modal-password" class="col-form-label">Mật khẩu</label>
                        <input type="password" class="form-control" name="password" id="modal-password">
                    </div>
                    <div class="mb-3">
                        <label for="modal-cpassword" class="col-form-label">Xác nhận mật khẩu</label>
                        <input type="password" class="form-control" id="modal-cpassword">
                    </div>
                    <div class="mb-3">
                        <label for="modal-group" class="col-form-label">Nhóm</label>
                        <select class="form-control" name="groupRole" id="modal-group" required>
                            <option value="" disabled selected hidden>Chọn nhóm</option>
                            <option value="Manager">Manager</option>
                            <option value="Editor">Editor</option>
                            <option value="Reviewer">Reviewer</option>
                            <option value="Admin">Admin</option>
                        </select>
                        <div class="invalid-feedback">
                            Hãy chọn nhóm.
                        </div>
                    </div>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                        <button type="submit" id="save-user" class="btn btn-primary">Lưu</button>
                    </div>
                </form>
            </div>

        </div>
    </div>
</div>

<script src="../js/validator.js"></script>

<script>

    Validator({
        form: '#modal-formuser',
        rules: [
            Validator.isRequired('#modal-username'),
            Validator.isEmail('#modal-email')
        ]
    })

    function showModel() {
        var myModal = new bootstrap.Modal(document.getElementById('modaluser'), {
            keyboard: false
        })
        myModal.show();
    }


    let btnSearch = document.getElementById('btn-search');
    btnSearch.onclick = function () {
        let name = document.getElementById('search-username').value;
        let email = document.getElementById('search-email').value;
        let groupRole = document.getElementById('search-group').value;
        let isActive = document.getElementById('search-status').value;
        var url = '/user_search.action?name=' + name + '&email=' + email + '&groupRole=' + groupRole + '&isActive=' + isActive;
        btnSearch.href = url;
        btnSearch.click();
    }

    function showModelEdit(id, name, email, groupRole) {
        document.getElementById('modal-userid').value = id;
        document.getElementById('modal-username').value = name;
        document.getElementById('modal-email').value = email;
        document.getElementById('modal-group').value = groupRole;
        document.getElementById('modal-password').disabled = true;
        document.getElementById('modal-cpassword').disabled = true;
        document.getElementById('modal-password').setAttribute("required", "false");
        document.getElementById('modal-cpassword').setAttribute("required", "false");
        showModel();
    }

    function showcreateUser() {
        document.getElementById('modal-password').disabled = false;
        document.getElementById('modal-cpassword').disabled = false;
        document.getElementById('modal-password').setAttribute("required", "true");
        document.getElementById('modal-cpassword').setAttribute("required", "true");
        showModel();
    }

    document.getElementById("save-user").addEventListener("click", function (event) {
        let btnPassword = document.getElementById('modal-password');
        let password = btnPassword.value;
        let confirmPassword = document.getElementById('modal-cpassword').value;
        let username = document.getElementById('modal-username').value;
        let email = document.getElementById('modal-email').value;

        if (username.trim() === '' || email.trim() === '')
        {
            event.preventDefault();
            alert('Vui lòng không để trống thông tin!');
            return;
        }

        let regex = /^(?=.*[a-zA-Z])(?=.*[0-9]).{6,}$/;

        if (!btnPassword.disabled) {
            console.log(btnPassword.disabled);
            if (!regex.test(password)) {
                event.preventDefault();
                alert("Mật khẩu phải lớn hơn 6 ký tự, gồm chữ và số");
                return;
            }

            if (password !== confirmPassword) {
                event.preventDefault(); // Chặn việc submit nếu input rỗng
                alert("mật khẩu xác nhận chưa trùng khớp");
                return;
            }
        }

    });


    // Lấy đối tượng nút xóa user
    var deleteButtons = document.querySelectorAll(".btn-delete");

    deleteButtons.forEach(function (button) {
        button.addEventListener("click", function (event) {
            var confirmDelete = confirm("Bạn có chắc chắn muốn xóa user này không?");

            // Kiểm tra xem người dùng đã chọn "OK" hay "Cancel"
            if (confirmDelete) {

            } else {
                event.preventDefault();
            }
        });
    })

    var lockButtons = document.querySelectorAll(".btn-lock");

    lockButtons.forEach(function (button) {
        button.addEventListener("click", function (event) {
            var confirmDelete = confirm("Bạn có chắc chắn muốn khoá/mở khoá user này không?");

            // Kiểm tra xem người dùng đã chọn "OK" hay "Cancel"
            if (confirmDelete) {

            } else {
                event.preventDefault();
            }
        });
    })


    function pagination(page) {
        var currentPath = window.location.href;
        var newPath = "";
        if (currentPath.includes("page=")) {
            currentPath = currentPath.substring(0, currentPath.indexOf("page=") - 1);
        }
        newPath = currentPath;
        if (newPath.includes('?')) {
            newPath = newPath + ("&page=" + page);
        } else {
            newPath = newPath + ("?page=" + page);
        }

        window.location.href = newPath;
        console.log(newPath);
    }
</script>
</body>
</html>