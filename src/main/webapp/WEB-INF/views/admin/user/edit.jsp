<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %> <%@ taglib
uri="http://www.springframework.org/tags/form" prefix="form" %>

<!-- Include CSS Files -->
<link rel="stylesheet" href="/admin/css/user-base.css" />
<link rel="stylesheet" href="/admin/css/user-forms.css" />

<style>
  .edit-header {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    color: white;
    padding: 25px;
    border-radius: 10px;
    margin-bottom: 30px;
    text-align: center;
  }

  .form-card {
    background: white;
    border-radius: 10px;
    padding: 30px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    border-left: 4px solid #28a745;
  }

  .form-group {
    margin-bottom: 20px;
  }

  .form-group label {
    font-weight: 600;
    color: #495057;
    margin-bottom: 8px;
    display: block;
  }

  .form-control {
    border-radius: 8px;
    border: 2px solid #e9ecef;
    padding: 12px 15px;
    transition: all 0.3s ease;
  }

  .form-control:focus {
    border-color: #28a745;
    box-shadow: 0 0 0 0.2rem rgba(40, 167, 69, 0.25);
  }

  .btn-submit {
    background: linear-gradient(135deg, #28a745 0%, #20c997 100%);
    border: none;
    border-radius: 25px;
    padding: 12px 40px;
    color: white;
    font-weight: 600;
    transition: all 0.3s ease;
  }

  .btn-submit:hover {
    transform: translateY(-2px);
    box-shadow: 0 4px 15px rgba(40, 167, 69, 0.3);
    color: white;
  }

  .btn-cancel {
    border-radius: 25px;
    padding: 12px 40px;
    font-weight: 600;
    transition: all 0.3s ease;
  }

  .required {
    color: #dc3545;
  }
</style>

<div class="main-panel">
  <div class="content-wrapper">
    <!-- Edit Header -->
    <div class="edit-header">
      <h3 class="mb-2">
        <i class="typcn typcn-edit mr-2"></i>
        Chỉnh sửa người dùng
      </h3>
      <p class="mb-0">Cập nhật thông tin chi tiết của người dùng</p>
    </div>

    <!-- Edit Form -->
    <div class="form-card">
      <form:form
        method="POST"
        action="/admin/user/edit/${userUpdateDTO.id}"
        modelAttribute="userUpdateDTO"
        cssClass="user-form"
        enctype="multipart/form-data"
      >
        <!-- Display validation errors from backend -->
        <c:if test="${not empty bindingResult and bindingResult.hasErrors()}">
          <div class="alert alert-danger">
            <h6>
              <i class="typcn typcn-warning mr-2"></i>Vui lòng kiểm tra lại
              thông tin:
            </h6>
            <ul class="mb-0">
              <c:forEach items="${bindingResult.allErrors}" var="error">
                <li>${error.defaultMessage}</li>
              </c:forEach>
            </ul>
          </div>
        </c:if>

        <div class="row">
          <div class="col-md-6">
            <div class="form-group">
              <label for="fullName">
                Họ và tên <span class="required">*</span>
              </label>
              <form:input
                path="fullName"
                cssClass="form-control"
                placeholder="Nhập họ và tên đầy đủ..."
                id="fullName"
                required="true"
              />
              <form:errors path="fullName" cssClass="text-danger small" />
            </div>

            <div class="form-group">
              <label for="email"> Email <span class="required">*</span> </label>
              <form:input
                path="email"
                type="email"
                cssClass="form-control"
                placeholder="example@email.com"
                id="email"
                required="true"
              />
              <form:errors path="email" cssClass="text-danger small" />
            </div>

            <div class="form-group">
              <label for="phone"> Số điện thoại </label>
              <form:input
                path="phone"
                cssClass="form-control"
                placeholder="0901234567"
                id="phone"
              />
            </div>
          </div>

          <div class="col-md-6">
            <div class="form-group">
              <label for="roleId">
                Vai trò <span class="required">*</span>
              </label>
              <form:select
                path="roleId"
                cssClass="form-control"
                id="roleId"
                required="true"
              >
                <form:option value="">-- Chọn vai trò --</form:option>
                <form:options
                  items="${roles}"
                  itemValue="id"
                  itemLabel="name"
                />
              </form:select>
              <form:errors path="roleId" cssClass="text-danger small" />
            </div>

            <div class="form-group">
              <label for="address"> Địa chỉ </label>
              <form:textarea
                path="address"
                cssClass="form-control"
                rows="3"
                placeholder="Nhập địa chỉ đầy đủ..."
                id="address"
              />
            </div>

            <div class="form-group">
              <label for="image"> Hình đại diện </label>
              <!-- Current image preview -->
              <c:if test="${not empty userUpdateDTO.image}">
                <div class="current-image mb-2">
                  <c:choose>
                    <c:when test="${userUpdateDTO.image.startsWith('/admin/images/user/')}">
                      <!-- New format: Full path already included -->
                      <img src="${userUpdateDTO.image}" alt="Ảnh hiện tại" 
                           style="width: 100px; height: 100px; object-fit: cover; border-radius: 50%; border: 2px solid #ddd;">
                    </c:when>
                    <c:otherwise>
                      <!-- Old format: Just filename, add path -->
                      <img src="/admin/images/user/${userUpdateDTO.image}" alt="Ảnh hiện tại" 
                           style="width: 100px; height: 100px; object-fit: cover; border-radius: 50%; border: 2px solid #ddd;">
                    </c:otherwise>
                  </c:choose>
                  <p class="small text-muted mt-1">Ảnh hiện tại</p>
                </div>
              </c:if>
              
              <!-- File upload input -->
              <input type="file" name="imageFile" id="imageFile" 
                     class="form-control-file mb-2" 
                     accept="image/*"
                     onchange="previewImage(this)">
              <form:errors path="imageFile" cssClass="text-danger small" />
              
              <!-- Image preview -->
              <div id="imagePreview" style="display: none;" class="mt-2">
                <img id="preview" alt="Xem trước" 
                     style="width: 100px; height: 100px; object-fit: cover; border-radius: 50%; border: 2px solid #28a745;">
                <p class="small text-success mt-1">Ảnh mới sẽ được cập nhật</p>
              </div>
              
              <small class="form-text text-muted">
                Chọn file ảnh từ máy tính (JPG, PNG, GIF). Tối đa 5MB.
              </small>
              
              <!-- Hidden field to keep existing image URL if no new file uploaded -->
              <form:hidden path="image" />
            </div>
          </div>
        </div>

        <!-- Submit Buttons -->
        <div class="text-center mt-4">
          <button type="submit" class="btn btn-submit mr-3">
            <i class="typcn typcn-tick mr-1"></i>
            Cập nhật người dùng
          </button>
          <a href="/admin/user" class="btn btn-outline-secondary btn-cancel">
            <i class="typcn typcn-times mr-1"></i>
            Hủy bỏ
          </a>
        </div>
      </form:form>
    </div>
  </div>
</div>

<!-- Include Base Scripts -->
<script src="/admin/vendors/js/vendor.bundle.base.js"></script>
<script src="/admin/js/off-canvas.js"></script>
<script src="/admin/js/hoverable-collapse.js"></script>
<script src="/admin/js/template.js"></script>
<script src="/admin/js/todolist.js"></script>

<!-- Image Preview Script -->
<script>
function previewImage(input) {
    const preview = document.getElementById('preview');
    const previewContainer = document.getElementById('imagePreview');
    
    if (input.files && input.files[0]) {
        const reader = new FileReader();
        
        reader.onload = function(e) {
            preview.src = e.target.result;
            previewContainer.style.display = 'block';
        };
        
        reader.readAsDataURL(input.files[0]);
    } else {
        previewContainer.style.display = 'none';
    }
}
</script>

<!-- Pure Spring Boot MVC - No client-side validation, all handled by backend -->
