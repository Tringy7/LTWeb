<div class="main-panel">
    <div class="tab-content">

        <!-- Tab Tài khoản -->
        <div class="tab-pane fade show active" id="account" role="tabpanel">
            <div class="card p-3">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">Quản lý Tài khoản</h4>
                    <button class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#accountModal"
                        onclick="openAddAccount()">
                        <i class="typcn typcn-plus"></i> Thêm tài khoản
                    </button>
                </div>
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Tên tài khoản</th>
                            <th>Email</th>
                            <th>Loại người dùng</th>
                            <th class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody id="accountTable">
                        <tr>
                            <td>1</td>
                            <td>Nguyễn Văn A</td>
                            <td>vana@example.com</td>
                            <td><span class="badge bg-danger">Quản trị</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-primary" onclick="openEditAccount(this)">Sửa</button>
                                <button class="btn btn-sm btn-danger" onclick="deleteAccount(this)">Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Trần Thị B</td>
                            <td>thib@example.com</td>
                            <td><span class="badge bg-info">Nhân viên</span></td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-primary" onclick="openEditAccount(this)">Sửa</button>
                                <button class="btn btn-sm btn-danger" onclick="deleteAccount(this)">Xóa</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Tab Khách hàng -->
        <div class="tab-pane fade" id="customer" role="tabpanel">
            <div class="card p-3">
                <div class="d-flex justify-content-between align-items-center mb-3">
                    <h4 class="mb-0">Quản lý Khách hàng</h4>
                    <button class="btn btn-sm btn-success" data-bs-toggle="modal" data-bs-target="#customerModal"
                        onclick="openAddCustomer()">
                        <i class="typcn typcn-plus"></i> Thêm khách hàng
                    </button>
                </div>
                <table class="table table-hover align-middle">
                    <thead class="table-light">
                        <tr>
                            <th>ID</th>
                            <th>Tên khách hàng</th>
                            <th>Email</th>
                            <th>Số điện thoại</th>
                            <th class="text-center">Hành động</th>
                        </tr>
                    </thead>
                    <tbody id="customerTable">
                        <tr>
                            <td>1</td>
                            <td>Lê Văn C</td>
                            <td>vanc@example.com</td>
                            <td>0912345678</td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-primary" onclick="openEditCustomer(this)">Sửa</button>
                                <button class="btn btn-sm btn-danger" onclick="deleteCustomer(this)">Xóa</button>
                            </td>
                        </tr>
                        <tr>
                            <td>2</td>
                            <td>Phạm Thị D</td>
                            <td>thid@example.com</td>
                            <td>0987654321</td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-primary" onclick="openEditCustomer(this)">Sửa</button>
                                <button class="btn btn-sm btn-danger" onclick="deleteCustomer(this)">Xóa</button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>