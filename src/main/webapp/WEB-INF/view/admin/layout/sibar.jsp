<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <!--Sibar-->
        <div class="sb-sidenav-menu">
            <div class="nav">
                <div class="sb-sidenav-menu-heading">FEATURES</div>
                <a class="nav-link" href="/admin">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Dashboard
                </a>
                <a class="nav-link" href="/admin/users">
                    <div class="sb-nav-link-icon"><i class="fa-solid fa-user"></i></div>
                    User
                </a>
                <a class="nav-link" href="/admin/products">
                    <div class="sb-nav-link-icon"><i class="fa-solid fa-mobile-screen-button"></i></div>
                    Products
                </a>
                <a class="nav-link" href="/admin/orders">
                    <div class="sb-nav-link-icon"><i class="fa-solid fa-cart-shopping"></i></div>
                    Orders
                </a>
                <a class="nav-link" href="/admin/reviews">
                    <div class="sb-nav-link-icon"><i class="fa-regular fa-pen-to-square"></i></div>
                    Review
                </a>
            </div>
        </div>
        <div class="sb-sidenav-footer d-flex gap-1 align-items-center">
            <img class="rounded-circle mr-3" src="${env}/admin/images/user/${sessionScope.avatar}" alt="avatar" width="40" height="40">
            <div class="media-body">
                <h5 class="mb-1">${sessionScope.fullName}</h5>
                <div>
                    <i class="fas fa-circle text-success"></i> Online
                </div>
            </div>
        </div>
    </nav>
</div>