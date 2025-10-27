<<<<<<< HEAD
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
      <nav class="sidebar sidebar-offcanvas" id="sidebar">
        <ul class="nav">
          <!-- Profile -->
          <li class="nav-item">
            <div class="d-flex sidebar-profile">
              <div class="sidebar-profile-image">
                <c:choose>
                  <c:when test="${not empty acc.image}">
                    <img src="/admin/images/user/${acc.image}" alt="image" />
                  </c:when>
                </c:choose>
                <span class="sidebar-status-indicator"></span>
              </div>
              <div class="sidebar-profile-name">
                <p class="sidebar-name">
                  <c:choose>
                    <c:when test="${not empty acc}">
                      ${acc.fullName}
                    </c:when>
                  </c:choose>
                </p>
                <p class="sidebar-designation">
                  <c:choose>
                    <c:when test="${not empty acc and not empty acc.role}">
                      ${acc.role.name}
                    </c:when>
                  </c:choose>
                </p>
              </div>
            </div>
            <p class="sidebar-menu-title">Overviews</p>
          </li>
=======
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> <%@ taglib
uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<nav class="sidebar sidebar-offcanvas" id="sidebar">
  <ul class="nav">
    <!-- Profile -->
    <li class="nav-item">
      <div class="d-flex sidebar-profile">
        <div class="sidebar-profile-image">
          <img src="/admin/images/faces/anh3.jpg" alt="image" />
          <span class="sidebar-status-indicator"></span>
        </div>
        <div class="sidebar-profile-name">
          <p class="sidebar-name">Anh Vũ</p>
          <p class="sidebar-designation">Welcome To HomePage</p>
        </div>
      </div>
      <p class="sidebar-menu-title">Overviews</p>
    </li>
>>>>>>> anhvuDev

          <!-- Dashboard -->
          <li class="nav-item">
            <button class="nav-link btn btn-link w-100 text-left" type="button"
              onclick="location.href='/admin/dashboard '">
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

<<<<<<< HEAD
          <!-- Event
          <li class="nav-item">
            <button class="nav-link btn btn-link w-100 text-left" type="button" onclick="location.href='/admin/event'">
              <i class="typcn typcn-film menu-icon"></i>
              <span class="menu-title">Event</span>
              <i class="menu-arrow"></i>
            </button>
          </li> -->

          <!-- Order -->
          <li class="nav-item">
            <button class="nav-link btn btn-link w-100 text-left" type="button" onclick="location.href='/admin/order'">
              <i class="typcn typcn-th-small-outline menu-icon"></i>
              <span class="menu-title">Commission</span>
              <i class="menu-arrow"></i>
            </button>
          </li>
        </ul>
      </nav>
=======
    <!-- Commission -->
    <li class="nav-item">
      <button
        class="nav-link btn btn-link w-100 text-left"
        type="button"
        onclick="location.href='/admin/commission'"
      >
        <i class="typcn typcn-calculator menu-icon"></i>
        <span class="menu-title">Commission</span>
        <i class="typcn typcn-chevron-right menu-arrow"></i>
      </button>
    </li>
    <!-- Voucher -->
    <li class="nav-item">
      <button
        class="nav-link btn btn-link w-100 text-left"
        type="button"
        onclick="location.href='/admin/voucher'"
      >
        <i class="typcn typcn-ticket menu-icon"></i>
        <span class="menu-title">Voucher</span>
        <i class="typcn typcn-chevron-right menu-arrow"></i>
      </button>
    </li>
    <!-- Vendor Approval -->
    <li class="nav-item">
      <button
        class="nav-link btn btn-link w-100 text-left"
        type="button"
        onclick="location.href='/admin/vendor-approval'"
      >
        <i class="typcn typcn-tick menu-icon"></i>
        <span class="menu-title">Vendor Approval</span>
        <i class="typcn typcn-chevron-right menu-arrow"></i>
      </button>
    </li>
  </ul>
</nav>
>>>>>>> anhvuDev
