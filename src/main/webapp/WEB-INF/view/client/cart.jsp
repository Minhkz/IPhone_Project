<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<fmt:setLocale value="en_US" scope="session"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Shopping Cart</title>

    <!--css-->
    <jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>
    <link rel="stylesheet" href="${env}/client/css/products-page.css" />
    <link rel="stylesheet" href="${env}/client/css/Product_Details_Page.css">
    <link rel="stylesheet" href="${env}/client/css/Shopping_Cart.css">

    <!--CSRF-->
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
          crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
<!--header-->
<jsp:include page="/WEB-INF/view/client/layout/header.jsp"></jsp:include>

<main>
    <div class="container">

        <!-- Breadcrumbs -->
        <div class="breadcrumb">
            <nav style="--bs-breadcrumb-divider: '>'" aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">
                        <a href="/client/homes">Trang chủ</a>
                    </li>
                    <li class="breadcrumb-item" aria-current="page">Cart</li>
                </ol>
            </nav>
        </div>

        <!-- Giỏ hàng -->
        <div class="main d-flex justify-content-between ${totalItem > 0 ? '' : 'd-none'}">
            <div class="left">
                <div class="left__content fs-4 fw-bold d-flex justify-content-between">
                    <h2>Giỏ hàng</h2>
                    <div class="check-all">
                        <input type="checkbox" id="cart-check-all" style="width: 20px; height: 20px;">
                    </div>
                </div>

                <div class="left__product">
                    <c:forEach items="${cartProducts}" var="cartProduct">
                        <!-- start item -->
                        <div id="item-${cartProduct.product.id}"
                             class="left__product--item d-flex gap-3 border-bottom">
                            <div class="item__img">
                                <a href="/client/productdetails/${cartProduct.product.id}">
                                    <img src="${env}/admin/images/product/${cartProduct.product.avatar}" alt="logo">
                                </a>
                            </div>
                            <div class="left__product--content">
                                <div class="content__info">
                                    <p class="name">${cartProduct.product.name}</p>
                                    <p class="ma">#${cartProduct.product.id}</p>
                                </div>
                                <div class="rightSide d-flex gap-4 align-items-center">
                                    <div class="counter d-flex align-items-center gap-2">
                                        <button type="button" class="btn minus d-flex justify-content-center align-items-center">-</button>
                                        <input type="text"
                                               value="${cartProduct.quantity}"
                                               data-id="${cartProduct.product.id}"
                                               data-price="${cartProduct.product.price}"
                                               name="quantity"
                                               class="number"
                                               style="text-align: center;">
                                        <button type="button" class="btn plus d-flex justify-content-center align-items-center">+</button>
                                    </div>
                                    <div class="price">
                                        <fmt:formatNumber value="${cartProduct.product.price * cartProduct.quantity}" type="number" pattern="#,##0"/> VNĐ

                                    </div>
                                    <div class="cancel">
                                        <button type="button" class="btn btn-danger btn-remove"
                                                data-id="${cartProduct.product.id}">
                                            <i class="fa-solid fa-xmark"></i>
                                        </button>
                                    </div>
                                    <div class="check-item">
                                        <input type="checkbox" class="cart-check-item" style="width: 20px; height: 20px;">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- end item -->
                    </c:forEach>
                </div>
            </div>

            <!-- Thanh toán -->
            <div class="right border">
                <div class="subcontainer">
                    <div class="right__Summary">Chi tiết đơn hàng</div>
                    <div class="right__content">
                        <div class="price">
                            <div class="Subtotal d-flex justify-content-between" >
                                <p class="left__text">Tạm tính</p>
                                <p class="right__text">
                                    <fmt:formatNumber value="${subtotal}" type="number" pattern="#,##0"/> VNĐ
                                </p>
                            </div>
                            <div class="Taxes mt-3 mb-3">
                                <div class="Taxes1 d-flex justify-content-between" data-fee="${serviceFee}">
                                    <p class="Taxes__text">Ước tính thuế</p>
                                    <p class="right__text">
                                        <fmt:formatNumber value="${serviceFee}" type="number" pattern="#,##0"/> VNĐ
                                    </p>
                                </div>
                                <div class="Taxes2 d-flex justify-content-between" data-fee="${shippingFee}">
                                    <p class="Taxes__text">Phí vận chuyển và xử lý</p>
                                    <p class="right__text">
                                        <fmt:formatNumber value="${shippingFee}" type="number" pattern="#,##0"/> VNĐ
                                    </p>
                                </div>
                            </div>
                            <div class="Total d-flex justify-content-between">
                                <p class="left__text">Tổng tiền</p>
                                <p class="right__text">
                                    <fmt:formatNumber value="${total}" type="number" pattern="#,##0"/> VNĐ
                                </p>
                            </div>
                        </div>
                        <form id="checkoutForm" method="post" action="/client/payment/address?returnUrl=/client/carts">
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                            <input type="hidden" id="selectedIds" name="selectedIds" value=""/>
                            <button type="submit" class="btn btn-outline-dark but1">Thanh toán</button>
                        </form>

                    </div>
                </div>
            </div>
        </div>

        <!-- Giỏ hàng trống -->
        <div class="empty-cart text-center ${totalItem == 0 ? '' : 'd-none'}" style="margin: 35px;">
            Không có sản phẩm nào
        </div>
    </div>
</main>
<!-- Nút Scroll to Top -->
<button id="scrollTopBtn" title="Go to top">↑</button>
<!--footer-->
<jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>

<!--js-->
<jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>
<script src="${env}/client/js/common.js"></script>
<script src="${env}/client/js/cart.js"></script>
</body>
</html>
