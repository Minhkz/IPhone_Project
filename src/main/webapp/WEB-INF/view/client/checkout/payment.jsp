<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--css-->
    <jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>
    <link rel="stylesheet" href="${env}/client/css/pay.css" />
    <title>My Iphone</title>
</head>
<body>
<!--header-->
<jsp:include page="/WEB-INF/view/client/layout/header.jsp"></jsp:include>

<main>
    <div class="container">
        <nav>
            <ul class="d-flex justify-content-between align-items-center">
                <li class="d-flex align-items-center">
                    <a href="/client/payment/address">
                        <img src="${env}/client/images/checkout/payment/Location.png" alt="logo">
                    </a>
                    <div class="address__title text-muted ms-2">
                        <div class="address__title--step">Bước 1</div>
                        <div class="address__title--name">Address</div>
                    </div>
                </li>
                <li class="d-flex align-items-center">
                    <a href="/client/payment/shipping">
                        <img src="${env}/client/images/checkout/payment/Shipping.png" alt="logo">
                    </a>
                    <div class="address__title text-muted m-2">
                        <div class="address__title--step">Bước 2</div>
                        <div class="address__title--name">Shipping</div>
                    </div>
                </li>
                <li class="d-flex align-items-center">
                    <a href="/client/payment">
                        <img src="${env}/client/images/checkout/payment/Payment.png" alt="logo">
                    </a>
                    <div class="address__title  m-2">
                        <div class="address__title--step">Bước 3</div>
                        <div class="address__title--name">Payment</div>
                    </div>
                </li>
            </ul>
        </nav>
        <div class="address__main">
            <div class="container py-5">
                <div class="row g-4">
                    <!-- Summary -->
                    <div class="col-lg-8">
                        <div class="card-summary shadow-sm">
                            <h5 class="mb-3">Summary</h5>
                            <c:forEach var="cartProduct" items="${products}">
                                <div class="summary-item">
                                    <div class="d-flex align-items-center">
                                        <img src="${env}/admin/images/product/${cartProduct.product.avatar}" alt="iPhone">
                                        <span>${cartProduct.product.name}</span>
                                    </div>
                                    <strong>$<fmt:formatNumber type="number" value="${cartProduct.price * cartProduct.quantity}" /></strong>
                                    <strong>${cartProduct.quantity}</strong>
                                </div>
                            </c:forEach>

                            <p class="mt-3 mb-1"><small>Địa chỉ</small></p>
                            <p>${address.detailDesc}</p>

                            <p class="mt-3 mb-1"><small>Người nhận</small></p>
                            <p>${address.reciverName}, ${address.reciverPhone}</p>


                            <p class="mb-1"><small>Phương thức giao hàng</small></p>
                            <p>
                                <c:choose>
                                    <c:when test="${typeShip == 1}">
                                        Tiết kiệm
                                    </c:when>
                                    <c:when test="${typeShip == 2}">
                                        Giao nhanh
                                    </c:when>
                                    <c:otherwise>
                                        Miễn phí
                                    </c:otherwise>
                                </c:choose>
                            </p>

                            <div class="d-flex justify-content-between"><span>Tạm tính</span><strong>
                                $<fmt:formatNumber type="number" value="${subTotal}" /></strong>
                            </div>
                            <div class="d-flex justify-content-between"><span>Thuế ước tính</span><strong>
                                $<fmt:formatNumber type="number" value="${thue}" />
                            </strong></div>
                            <div class="d-flex justify-content-between"><span>Phí vận chuyển</span>
                                <strong>
                                    $<fmt:formatNumber type="number" value="${typeShip}" />
                                </strong>
                            </div>
                            <hr>
                            <div class="d-flex justify-content-between fs-5"><span>Tổng cộng</span>
                                <strong>
                                    $<fmt:formatNumber type="number" value="${total}" />
                                </strong>
                            </div>
                        </div>
                    </div>

                    <!-- Payment -->
                    <div class="col-lg-4">
                        <h5 class="mb-3">Hình thức thanh toán</h5>
                        <form method="POST" action="/client/payment/checkout">
                            <div class="mb-3">
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="COD" checked="checked" value="COD">
                                    <label class="form-check-label" for="COD">
                                        Thanh toán khi nhận hàng
                                    </label>
                                </div>
                                <div class="form-check">
                                    <input class="form-check-input" type="radio" name="paymentMethod" id="BANKING" value="BANKING">
                                    <label class="form-check-label" for="BANKING">
                                        Thanh toán bằng ví VNpay
                                    </label>
                                </div>
                            </div>

                            <div class="d-flex">
                                <a href="/client/payment/get/shipping"
                                   class="btn btn-outline-dark d-flex justify-content-center align-items-center"
                                   style="width: 208px; height: 64px; margin-right: 24px">
                                    Back
                                </a>
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-dark"
                                        style="width: 208px; height: 64px;">
                                    Thanh toán
                                </button>
                            </div>
                        </form>
                    </div>

                </div>
            </div>

        </div>
    </div>
</main>
<!-- Nút Scroll to Top -->
<button id="scrollTopBtn" title="Go to top">↑</button>
<!--Footer-->
<jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>

<!--js-->
<jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>
<script src="${env}/client/js/common.js"></script>
</body>
</html>