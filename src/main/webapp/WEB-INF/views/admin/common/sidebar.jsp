<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<nav class="sidebar sidebar-offcanvas" id="sidebar">
    <ul class="nav">
        <!-- Profile -->
        <li class="nav-item">
            <div class="d-flex sidebar-profile">
                <div class="sidebar-profile-image">
                    <img src="images/faces/face29.jpg" alt="image" />
                    <span class="sidebar-status-indicator"></span>
                </div>
                <div class="sidebar-profile-name">
                    <p class="sidebar-name">Anh Vũ</p>
                    <p class="sidebar-designation">Welcome To HomePage</p>
                </div>
            </div>
            <p class="sidebar-menu-title">Overviews</p>
        </li>

        <!-- Dashboard -->
        <li class="nav-item">
            <button class="nav-link btn btn-link w-100 text-left" type="button" onclick="location.href='/admin'">
                <i class="typcn typcn-device-desktop menu-icon"></i>
                <span class="menu-title">Dashboard</span>
                <i class="typcn typcn-chevron-right menu-arrow"></i>
            </button>
        </li>

        <p class="sidebar-menu-title">Website Management</p>

        <!-- User -->
        <li class="nav-item">
            <button class="nav-link btn btn-link w-100 text-left" type="button" onclick="location.href='/admin/user'">
                <i class="typcn typcn-user-add-outline menu-icon"></i>
                <span class="menu-title">User</span>
                <i class="typcn typcn-chevron-right menu-arrow"></i>
            </button>
        </li>

        <!-- Product -->
        <li class="nav-item">
            <button class="nav-link btn btn-link w-100 text-left" type="button"
                onclick="location.href='/admin/product'">
                <i class="typcn typcn-briefcase menu-icon"></i>
                <span class="menu-title">Product</span>
                <i class="typcn typcn-chevron-right menu-arrow"></i>
            </button>
        </li>

        <!-- Event -->
        <li class="nav-item">
            <button class="nav-link btn btn-link w-100 text-left" type="button" onclick="location.href='/admin/event'">
                <i class="typcn typcn-film menu-icon"></i>
                <span class="menu-title">Event</span>
                <i class="menu-arrow"></i>
            </button>
        </li>

        <!-- Customer -->
        <li class="nav-item">
            <button class="nav-link btn btn-link w-100 text-left" type="button"
                onclick="location.href='/admin/customer'">
                <i class="typcn typcn-chart-pie-outline menu-icon"></i>
                <span class="menu-title">Customer</span>
                <i class="menu-arrow"></i>
            </button>
        </li>

        <!-- Order -->
        <li class="nav-item">
            <button class="nav-link btn btn-link w-100 text-left" type="button" onclick="location.href='/admin/order'">
                <i class="typcn typcn-th-small-outline menu-icon"></i>
                <span class="menu-title">Order</span>
                <i class="menu-arrow"></i>
            </button>
        </li>

        <!-- Brand -->
        <li class="nav-item">
            <button class="nav-link btn btn-link w-100 text-left" type="button" data-toggle="collapse"
                data-target="#brandMenu" aria-expanded="false" aria-controls="brandMenu">
                <i class="typcn typcn-compass menu-icon"></i>
                <span class="menu-title">Brand</span>
                <i class="menu-arrow"></i>
            </button>
        </li>
    </ul>
</nav>