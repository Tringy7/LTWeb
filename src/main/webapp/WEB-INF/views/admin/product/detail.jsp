<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <style>
                .table th {
                    white-space: nowrap;
                    vertical-align: middle;
                    text-align: center;
                }

                .table td {
                    vertical-align: middle;
                }

                .table td img {
                    width: 60px;
                    height: 60px;
                    object-fit: cover;
                    border-radius: 8px;
                }

                /* Cột Action */
                .table th:last-child,
                .table td:last-child {
                    text-align: center;
                }

                /* Nhóm nút */
                .btn-group .btn {
                    border-radius: 0;
                    padding: 4px 10px;
                }

                .btn-group .btn:first-child {
                    border-top-left-radius: 6px;
                    border-bottom-left-radius: 6px;
                }

                .btn-group .btn:last-child {
                    border-top-right-radius: 6px;
                    border-bottom-right-radius: 6px;
                }

                /* Outline style — giống nút Refresh */
                .btn-outline-view {
                    border: 1px solid #007bff;
                    color: #007bff;
                    background-color: transparent;
                }

                .btn-outline-view:hover {
                    background-color: #007bff;
                    color: #fff;
                }

                .btn-outline-edit {
                    border: 1px solid #ffc107;
                    color: #ffc107;
                    background-color: transparent;
                }

                .btn-outline-edit:hover {
                    background-color: #ffc107;
                    color: #fff;
                }

                .btn-outline-delete {
                    border: 1px solid #dc3545;
                    color: #dc3545;
                    background-color: transparent;
                }

                .btn-outline-delete:hover {
                    background-color: #dc3545;
                    color: #fff;
                }

                /* Hiệu ứng mượt */
                .btn:hover {
                    transition: all 0.25s ease;
                }
            </style>
            <div class="main-panel">
                <div class="content-wrapper">
                    <div class="row align-items-center mb-4">
                        <div class="col-6">
                            <h2 class="mb-0">Product</h2>
                        </div>
                        <div class="col-6 text-right">
                            <button type="button" class="btn btn-outline-success btn-sm mx-1">
                                <i class="fa-solid fa-plus mr-1"></i> <span>Thêm sản phẩm</span>
                            </button>
                        </div>
                    </div>


                    <div class="row">
                        <div class="col-lg-12 grid-margin stretch-card">
                            <div class="card">
                                <div class="card-body">
                                    <table class="table table-bordered table-hover">
                                        <thead class="thead-light">
                                            <tr>
                                                <th>Hình ảnh</th>
                                                <th>Tên sản phẩm</th>
                                                <th>Thương hiệu</th>
                                                <th>Màu sắc</th>
                                                <th>Danh mục</th>
                                                <th>Giá (vnd)</th>
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td><img src="images/hoodie1.jpg" alt="Hoodie"></td>
                                                <td>Áo Hoodie Streetwear</td>
                                                <td>UrbanStyle</td>
                                                <td>Đen</td>
                                                <td>Hoodie</td>
                                                <td>450,000</td>
                                                <td>
                                                    <div class="btn-group">
                                                        <button class="btn btn-sm btn-outline-view"><i
                                                                class="typcn typcn-eye"></i>
                                                            Xem</button>
                                                        <button class="btn btn-sm btn-outline-edit"><i
                                                                class="typcn typcn-edit"></i>
                                                            Sửa</button>
                                                        <button class="btn btn-sm btn-outline-delete"><i
                                                                class="typcn typcn-trash"></i> Xóa</button>
                                                    </div>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td><img src="images/jeans1.jpg" alt="Jeans"></td>
                                                <td>Quần Jeans Unisex</td>
                                                <td>UrbanStyle</td>
                                                <td>Xanh đậm</td>
                                                <td>Quần</td>
                                                <td>600,000</td>
                                                <td>
                                                    <div class="btn-group">
                                                        <button class="btn btn-sm btn-outline-view"><i
                                                                class="typcn typcn-eye"></i>
                                                            Xem</button>
                                                        <button class="btn btn-sm btn-outline-edit"><i
                                                                class="typcn typcn-edit"></i>
                                                            Sửa</button>
                                                        <button class="btn btn-sm btn-outline-delete"><i
                                                                class="typcn typcn-trash"></i> Xóa</button>
                                                    </div>
                                                </td>
                                            </tr>

                                            <tr>
                                                <td><img src="images/dress1.jpg" alt="Dress"></td>
                                                <td>Đầm Dạ Hội Cao Cấp</td>
                                                <td>ElegantLady</td>
                                                <td>Đỏ</td>
                                                <td>Váy</td>
                                                <td>1,200,000</td>
                                                <td>
                                                    <div class="btn-group">
                                                        <button class="btn btn-sm btn-outline-view"><i
                                                                class="typcn typcn-eye"></i>
                                                            Xem</button>
                                                        <button class="btn btn-sm btn-outline-edit"><i
                                                                class="typcn typcn-edit"></i>
                                                            Sửa</button>
                                                        <button class="btn btn-sm btn-outline-delete"><i
                                                                class="typcn typcn-trash"></i> Xóa</button>
                                                    </div>
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