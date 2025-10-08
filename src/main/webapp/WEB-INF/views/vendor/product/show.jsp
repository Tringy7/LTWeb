<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<div class="main-panel">
    <div class="content-wrapper">
        <div class="row">
            <div class="col-lg-12 grid-margin stretch-card">
                <div class="card">
                    <div class="card-body">
                        <div
                            style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 10px; gap: 15px;">
                            <!-- Tiêu đề -->
                            <div>
                                <h4 class="card-title" style="margin: 0;">Product table</h4>
                            </div>

                            <!-- Nút thêm sản phẩm -->
                            <button type="button" class="btn btn-inverse-success btn-fw" data-toggle="modal"
                                data-target="#addProductModal">
                                Thêm sản phẩm
                            </button>
                        </div>


                        <div class="table-responsive pt-3">
                            <table class="table table-bordered">
                                <thead>
                                    <tr>
                                        <th>
                                            ID
                                        </th>
                                        <th>
                                            Image
                                        </th>
                                        <th>
                                            Name
                                        </th>
                                        <th>
                                            Price
                                        </th>
                                        <th>
                                            Brand
                                        </th>
                                        <th>
                                            Action
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td>
                                            1
                                        </td>
                                        <td>
                                            <img src="../../images/fashion/ao1.jpeg" alt="image"
                                                style="width: 130px; height: 100%; object-fit: cover; display: block;">
                                        </td>
                                        <td>
                                            Seasonal Long Sleeve Boxy Tee
                                        </td>
                                        <td>
                                            600.000 VND
                                        </td>
                                        <td>
                                            Levents
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-inverse-secondary btn-fw"
                                                data-toggle="modal" data-target="#productDetailModal">Chi tiết</button>
                                            <button type="button" class="btn btn-inverse-warning btn-fw"
                                                data-toggle="modal" data-target="#editProductModal">Chỉnh sửa</button>
                                            <button type="button" class="btn btn-inverse-danger btn-fw"
                                                data-toggle="modal" data-target="#deleteProductModal">Xóa</button>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            2
                                        </td>
                                        <td>
                                            <img src="../../images/fashion/ao2.jpg" alt="image"
                                                style="width: 130px; height: 100%; object-fit: cover; display: block;">
                                        </td>
                                        <td>
                                            ANTISOCIAL BOXY TEE
                                        </td>
                                        <td>
                                            400.000 VND
                                        </td>
                                        <td>
                                            BAD HABITS
                                        </td>
                                        <td>
                                            <button type="button" class="btn btn-inverse-secondary btn-fw"
                                                data-toggle="modal" data-target="#productDetailModal">Chi tiết</button>
                                            <button type="button" class="btn btn-inverse-warning btn-fw"
                                                data-toggle="modal" data-target="#editProductModal">Chỉnh sửa</button>
                                            <button type="button" class="btn btn-inverse-danger btn-fw"
                                                data-toggle="modal" data-target="#deleteProductModal">Xóa</button>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal Bảng size-->
    <div class="modal fade" id="productDetailModal" tabindex="-1" role="dialog"
        aria-labelledby="productDetailModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <!-- Xóa modal-sm để không bị ép nhỏ -->
            <div class="modal-content" style="min-width: 562px;">
                <div class="modal-header">
                    <h5 class="modal-title" id="productDetailModalLabel">Chi tiết sản phẩm</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Đóng">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body d-flex justify-content-center">
                    <!-- Bảng size căn giữa -->
                    <div class="table-responsive" style="max-width: 500px;">
                        <table class="table table-bordered text-center mb-0">
                            <thead class="thead-light">
                                <tr>
                                    <th>Size</th>
                                    <th>Số lượng</th>
                                    <th>Màu sắc</th>
                                    <th>Số lượng bán</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>S</td>
                                    <td>20</td>
                                    <td>Đen</td>
                                    <td>15</td>
                                </tr>
                                <tr>
                                    <td>M</td>
                                    <td>30</td>
                                    <td>Trắng</td>
                                    <td>22</td>
                                </tr>
                                <tr>
                                    <td>L</td>
                                    <td>25</td>
                                    <td>Xanh</td>
                                    <td>18</td>
                                </tr>
                                <tr>
                                    <td>XL</td>
                                    <td>10</td>
                                    <td>Đỏ</td>
                                    <td>8</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal thêm sản phẩm -->
    <div class="modal fade" id="addProductModal" tabindex="-1" role="dialog" aria-labelledby="addProductModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <!-- modal-lg để to hơn -->
            <div class="modal-content" style="width: 700px; margin: auto;">
                <div class="modal-header">
                    <h5 class="modal-title" id="addProductModalLabel">Thêm sản phẩm mới</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Đóng">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>

                <form>
                    <div class="modal-body d-flex justify-content-center">
                        <div class="card-body" style="max-width: 650px; width: 100%;">
                            <div class="form-group">
                                <label for="productName">Name</label>
                                <input type="text" class="form-control" id="productName"
                                    placeholder="Nhập tên sản phẩm">
                            </div>

                            <div class="form-group">
                                <label for="productImage">Image</label>
                                <input type="file" class="form-control-file" id="productImage">
                            </div>

                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label for="editProductBrand">Brand</label>
                                    <input type="text" class="form-control" id="editProductBrand" value="">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="editProductColor">Color</label>
                                    <select class="form-control" id="editProductColor" style="height:45px;">
                                        <option>Chọn màu</option>
                                        <option>Đỏ</option>
                                        <option>Xanh</option>
                                        <option>Đen</option>
                                        <option>Trắng</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label for="productPrice">Price (VND)</label>
                                    <input type="number" class="form-control" id="productPrice"
                                        placeholder="Nhập giá sản phẩm">
                                </div>
                            </div>

                            <!-- Size + Quantity theo hàng ngang -->
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label>Size &amp; Quantity</label>
                                    <div class="d-flex flex-wrap gap-4">
                                        <div class="d-flex align-items-center mr-4">
                                            <span class="mr-2 font-weight-bold">S</span>
                                            <input type="number" class="form-control text-center" style="width: 100px;"
                                                placeholder="SL">
                                        </div>
                                        <div class="d-flex align-items-center mr-4">
                                            <span class="mr-2 font-weight-bold">M</span>
                                            <input type="number" class="form-control text-center" style="width: 100px;"
                                                placeholder="SL">
                                        </div>
                                        <div class="d-flex align-items-center mr-4">
                                            <span class="mr-2 font-weight-bold">L</span>
                                            <input type="number" class="form-control text-center" style="width: 100px;"
                                                placeholder="SL">
                                        </div>
                                        <div class="d-flex align-items-center mr-4">
                                            <span class="mr-2 font-weight-bold">XL</span>
                                            <input type="number" class="form-control text-center" style="width: 100px;"
                                                placeholder="SL">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="modal-footer d-flex justify-content-center">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-success">Lưu sản phẩm</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Modal Chỉnh sửa sản phẩm -->
    <div class="modal fade" id="editProductModal" tabindex="-1" role="dialog" aria-labelledby="editProductModalLabel"
        aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <!-- modal-lg để to hơn -->
            <div class="modal-content" style="width: 700px; margin: auto;">
                <div class="modal-header">
                    <h5 class="modal-title" id="editProductModalLabel">Chỉnh sửa sản phẩm</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Đóng">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>

                <form>
                    <div class="modal-body d-flex justify-content-center">
                        <div class="card-body" style="max-width: 650px; width: 100%;">

                            <div class="form-group">
                                <label for="editProductName">Name</label>
                                <input type="text" class="form-control" id="editProductName"
                                    value="Seasonal Long Sleeve Boxy Tee">
                            </div>

                            <div class="form-group">
                                <label for="editProductImage">Image</label>
                                <input type="file" class="form-control-file" id="editProductImage">
                            </div>

                            <div class="row">
                                <div class="form-group col-md-6">
                                    <label for="editProductBrand">Brand</label>
                                    <input type="text" class="form-control" id="editProductBrand" value="Levents">
                                </div>
                                <div class="form-group col-md-6">
                                    <label for="editProductColor">Color</label>
                                    <select class="form-control" id="editProductColor" style="height:45px;">
                                        <option>Chọn màu</option>
                                        <option>Đỏ</option>
                                        <option>Xanh</option>
                                        <option selected="">Đen</option>
                                        <option>Trắng</option>
                                    </select>
                                </div>
                            </div>

                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label for="editProductPrice">Price (VND)</label>
                                    <input type="number" class="form-control" id="editProductPrice" value="600000">
                                </div>
                            </div>

                            <!-- Size + Quantity theo hàng ngang -->
                            <div class="row">
                                <div class="form-group col-md-12">
                                    <label>Size &amp; Quantity</label>
                                    <div class="d-flex flex-wrap gap-4">
                                        <div class="d-flex align-items-center mr-4">
                                            <span class="mr-2 font-weight-bold">S</span>
                                            <input type="number" class="form-control text-center" style="width: 100px;"
                                                value="5">
                                        </div>
                                        <div class="d-flex align-items-center mr-4">
                                            <span class="mr-2 font-weight-bold">M</span>
                                            <input type="number" class="form-control text-center" style="width: 100px;"
                                                value="7">
                                        </div>
                                        <div class="d-flex align-items-center mr-4">
                                            <span class="mr-2 font-weight-bold">L</span>
                                            <input type="number" class="form-control text-center" style="width: 100px;"
                                                value="4">
                                        </div>
                                        <div class="d-flex align-items-center mr-4">
                                            <span class="mr-2 font-weight-bold">XL</span>
                                            <input type="number" class="form-control text-center" style="width: 100px;"
                                                value="4">
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <div class="modal-footer d-flex justify-content-center">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                        <button type="submit" class="btn btn-warning">Cập nhật</button>
                    </div>
                </form>
            </div>
        </div>
    </div>


    <!-- Modal Xóa sản phẩm -->
    <div class="modal fade" id="deleteProductModal" tabindex="-1" role="dialog"
        aria-labelledby="deleteProductModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content" style="width: auto; min-width: 562px; margin: auto;">
                <div class="modal-header">
                    <h5 class="modal-title" id="deleteProductModalLabel">Xóa sản phẩm</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Đóng">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <p>Bạn có chắc chắn muốn xóa sản phẩm <strong>Seasonal Long Sleeve Boxy Tee</strong> không?</p>
                    <p class="text-danger">Hành động này không thể hoàn tác!</p>
                </div>
                <div class="modal-footer d-flex justify-content-center">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Hủy</button>
                    <button type="button" class="btn btn-danger">Xóa</button>
                </div>
            </div>
        </div>
    </div>

</div>