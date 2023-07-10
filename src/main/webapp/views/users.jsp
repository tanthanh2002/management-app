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
  <title>User management</title>
</head>
<body>
  
  <!-- Your HTML code here -->
    <s:include value = "header.jsp"/>

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
                    <option value="Admin">Admin</option>
                    <option value="Editor">Editor</option>
                    <option value="Reviewer">Reviewer</option>
                </select>
            </div>
            <div class="col-sm ml-1 mr-1">
                <label for="search-status" class="form-label">Trạng thái</label>
                <select class="form-control" id="search-status">
                    <option value="" disabled selected hidden>Chọn trạng thái</option>
                    <option value="1">Đang hoạt động</option>
                    <option value="0">Tạm khoá</option>
                </select>
            </div>
        </div>

        <div class="row">
            <div class="col-sm-3">
                <a href="" type="submit" class="btn btn-primary"><i class="bi bi-person-add"></i><span class="px-4">Thêm mới</span></a>
            </div>
            <div class="col-sm-3 offset-3">
                <a href="" type="submit" id="btn-search" class="btn btn-primary"><i class="bi bi-search"></i><span class="px-4">Tìm kiếm</span></a>
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
                    <th scope="col" class="col">Họ tên</th>
                    <th scope="col" class="col">Email</th>
                    <th scope="col" class="col">Nhóm</th>
                    <th scope="col" class="col">Trạng thái</th>
                    <th scope="col" class="col"></th>
                  </tr>
                </thead>
                <tbody>
                    <s:iterator value = "users">
                        <tr>
                            <th scope="row"><s:property value = "id"/> </th>
                            <td><s:property value = "name"/> </td>
                            <td><s:property value = "email"/> </td>
                            <td><s:property value = "groupRole"/> </td>
                            <s:if test="isActive == 1">
                                <td class="text-success">Đang hoạt động</td>
                            </s:if>
                            <s:else>
                                <td class="text-danger">Tạm khoá</td>
                            </s:else>
                            <td>
                                <a href="" type="button" class="btn btn-success"><i class="bi bi-pencil-square"></i></a>
                                <a href="/delete.action?id=<s:property value = "id"/>" type="button" class="btn btn-danger"><i class="bi bi-trash3"></i></a>
                                <a href="/lock.action?id=<s:property value = "id"/>" type="button" class="btn btn-secondary"><i class="bi bi-person-fill-lock"></i></a>
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

  <div class="modal fade" id="modaluser" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog">
          <div class="modal-content">
              <div class="modal-header">
                  <h5 class="modal-title" id="exampleModalLabel">Thêm/Chỉnh sửa user</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>
              <div class="modal-body">
                  <form action="edit" class="needs-validation" novalidate autocomplete="off">
                      <div class="mb-3">
                          <label for="modal-username" class="col-form-label">Họ tên</label>
                          <input type="text" class="form-control" id="modal-username" required>
                          <div class="invalid-feedback">
                              Không được để trống!
                          </div>
                      </div>
                      <div class="mb-3">
                          <label class="col-form-label">Email</label>
                          <input type="text" class="form-control" required>
                          <div class="invalid-feedback">
                              Không được để trống!
                          </div>
                      </div>
                      <div class="mb-3">
                          <label for="modal-password" class="col-form-label">Mật khẩu</label>
                          <input type="text" class="form-control" id="modal-password">
                      </div>
                      <div class="mb-3">
                          <label for="modal-cpassword" class="col-form-label">Xác nhận mật khẩu</label>
                          <input type="text" class="form-control" id="modal-cpassword">
                      </div>
                      <div class="mb-3">
                          <label for="modal-group" class="col-form-label">Nhóm</label>
                          <select class="form-control" id="modal-group" required>
                              <option value="" disabled selected hidden>Chọn nhóm</option>
                              <option value="Admin">Admin</option>
                              <option value="Editor">Editor</option>
                              <option value="Reviewer">Reviewer</option>
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


  <!-- Include Bootstrap JS -->
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
  <script src="../js/index.js"></script>
  <script>
    function showModel(){
        var myModal = new bootstrap.Modal(document.getElementById('modaluser'), {
            keyboard: false
        })
        myModal.show();
    }

    function deleteUser(id) {
        // Gửi yêu cầu xoá đến server bằng AJAX
        $.ajax({
            url: 'deleteData.action?id=' + id + '&name=' + name + '&email=' + email,
            type: 'GET',
            success: function() {
                // Cập nhật lại bảng trên trang web
                location.reload();
            }
        });
    }


    let btnSearch = document.getElementById('btn-search');
    btnSearch.onclick = function (){
        let name = document.getElementById('search-username').value;
        let email = document.getElementById('search-email').value;
        var url = '/search.action?name=' + name + '&email=' + email;
        btnSearch.href =url;
        btnSearch.click();
    }

  </script>
</body>
</html>