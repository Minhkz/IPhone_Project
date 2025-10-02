<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <!--css-->
    <jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>
    <link rel="stylesheet" href="${env}/client/css/products-page.css" />
    <link rel="stylesheet" href="${env}/client/css/Product_Details_Page.css">

    <!--CSRF-->
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />

    <title>Product Details</title>
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
                    <li class="breadcrumb-item">
                        <a href="/client/products">Phones</a>
                    </li>
                    <li class="breadcrumb-item" aria-current="page">${productd.name}</li>
                </ol>
            </nav>
        </div>
        <!-- Main -->

    </div>
    <div class="container">
        <!-- Main -->
        <div class="row">
            <div class="col-md-12 col-lg-6 g-2 main__left">
                <img src="${env}/admin/images/product_details/${productd.img}" alt="logo" width="414px">
            </div>
            <div class="col-md-12 col-lg-6 g-2 main__right">
                <div class="name m-2">
                    <h1>${productd.name}</h1>
                </div>
                <div class="price m-2">
                    <h2>
                        <fmt:formatNumber type="number" value="${productd.price}" />đ
                    </h2>
                </div>
                <div class="shortDesc m-2">
                    ${productd.shortDesc}
                </div>
                <%--                --%>
                <div class="counter d-flex align-items-center gap-2">
                    <button type="button" class="btn minus d-flex justify-content-center align-items-center">-</button>
                    <input type="text" value="" name="quanity" class="number" data-id="${productd.id}" data-price="${productd.price}" style="text-align:center">
                    <button type="button" class="btn plus d-flex justify-content-center align-items-center">+</button>
                </div>
                <%--                --%>
                <div class="infos__btn d-flex justify-content-between m-2">
                    <button type="button" class="btn btn-outline-dark nut" id="showToastWish" data-id="${productd.id}">Thêm vào yêu thích</button>
                    <button type="button" class="btn btn-outline-dark nut" id="showToastCart" data-id="${productd.id}">Thêm vào giỏ hàng</button>
                    <form id="checkoutForm" action="/client/payment/address?returnUrl=/client/productdetails/${productd.id}" method="post">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                        <input type="hidden" id="selectedIds" name="selectedIds" value=""/>
                        <button type="submit" class="btn btn-outline-dark nut">Mua ngay</button>
                    </form>
                </div>
                <div class="infos__icons m-2">
                    <img src="${env}/client/images/productsDetailsPage/Icons.png" alt="logo">
                </div>
            </div>
        </div>
    </div>

    <div class="details">
        <div class="container">
            <div class="details__desc">
                <h1>Thông tin chi tiết</h1>
                <p>${productd.detailDesc}</p>
            </div>
            <div class="details__info">
                <h1>Thông số</h1>
                <div class="d-flex justify-content-between align-items-center m-2 border-bottom details__info--color">
                    <p class="m-0">Color</p>
                    <p class="m-0">${productd.specification.color}</p>
                </div>
                <div class="d-flex justify-content-between align-items-center m-2 border-bottom details__info--pin">
                    <p class="m-0">Pin</p>
                    <p class="m-0">${productd.specification.pin} mAh</p>
                </div>
                <div class="d-flex justify-content-between align-items-center m-2 border-bottom details__info--screens">
                    <p class="m-0">Screen size</p>
                    <p class="m-0">${productd.specification.screenSize} inchs</p>
                </div>
                <div class="d-flex justify-content-between align-items-center m-2 border-bottom details__info--screent">
                    <p class="m-0">Screen type</p>
                    <p class="m-0">${productd.specification.screenType}</p>
                </div>
                <div class="d-flex justify-content-between align-items-center m-2 border-bottom details__info--protection">
                    <p class="m-0">Protection</p>
                    <p class="m-0">${productd.specification.protection}</p>
                </div>
                <div class="d-flex justify-content-between align-items-center m-2 border-bottom details__info--rom">
                    <p class="m-0">Rom</p>
                    <p class="m-0">${productd.specification.ram} GB</p>
                </div>
            </div>
        </div>
    </div>
    <div class="container py-5">
        <h1>Đánh giá sản phẩm</h1>
        <br>
        <!-- Form nhập bình luận -->
        <div class="mb-4">
            <form action="/client/productdetails/review/${productd.id}" method="post">
                <textarea class="form-control" placeholder="Viết bình luận..." rows="3" name="comment" required
                          oninvalid="this.setCustomValidity('Vui lòng nhập bình luận!')"
                          oninput="this.setCustomValidity('')"></textarea>
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                <button type="submit" class="btn btn-primary mt-2">Gửi đánh giá</button>
            </form>

        </div>

        <!-- Danh sách đánh giá -->
        <div id="reviewList">
            <c:forEach var="review" items="${reviews}">
                <div class="review-card">
                    <div class="d-flex align-items-center mb-2">
                        <c:choose>
                            <c:when test="${review.role eq 'ADMIN' or review.role eq 'STAFF'}">
                                <img style="width: 40px; height: 40px; border-radius: 50%;"
                                     src="${env}/admin/images/user/${review.avatar}" width="40" height="40"/>
                            </c:when>
                            <c:otherwise>
                                <img style="width: 40px; height: 40px; border-radius: 50%;"
                                     src="${env}/client/images/avatar/${review.avatar}" width="40" height="40"/>
                            </c:otherwise>
                        </c:choose>
                        <div style="padding-left: 2px">
                            <div class="review-user">${review.fullName}</div>
                            <div class="review-time">${review.createdAt}</div>
                        </div>
                    </div>
                    <div class="review-body" style="padding-left: 42px">${review.body}</div>
                </div>
            </c:forEach>
        </div>



        <!-- Nút xem thêm -->
        <div class="text-center mt-3">
            <button type="button" id="loadMore" class="btn btn-outline-secondary" data-id="${productd.id}">Xem thêm</button>
        </div>


    </div>
    <div class="container">
        <div class="discounts">
            <div class="discounts__title">Sản phẩm liên quan</div>
            <div class="discounts__products">
                <div class="row g-4">
                    <div class="col-lg-12">
                        <div class="row g-4">
                            <c:forEach var="product" items="${products}">
                                <!-- start -->
                                <div class="col-md-6 col-lg-4 col-xl-3 product__item m-2">
                                    <div class="product__item--box">
                                        <div class="box__header d-flex justify-content-end">
                                            <button type="button"
                                                    class="border-0 bg-transparent heart__item"
                                                    data-id="${product.id}">
                                                <c:choose>
                                                    <c:when test="${fn:contains(wishlistId, product.id)}">
                                                        <img src="${env}/client/images/home/Icon/heart-solid-full.png" alt="logo">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${env}/client/images/home/Icon/heart.png" alt="logo">
                                                    </c:otherwise>
                                                </c:choose>
                                            </button>
                                        </div>
                                        <div class="box__img">
                                            <a href="/client/productdetails/${product.id}">
                                                <img src="${env}/admin/images/product/${product.avatar}" alt="logo">
                                            </a>
                                        </div>
                                        <div class="box__details d-flex flex-column justify-content-between align-items-center">
                                            <div class="box__details--name text-center">${product.name}</div>
                                            <div class="box__details--price mt-3 mb-4">
                                                <fmt:formatNumber type="number" value="${product.price}" />đ
                                            </div>
                                            <form action="/client/productdetails/${product.id}" method="GET">
                                                <button type="submit" class="btn btn-dark box__details--btn">Mua ngay</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!-- end -->
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<!-- Container toast -->
<div class="toast-container position-fixed end-0 p-3"
     style="z-index: 1100; top: 70px; pointer-events: none;">
    <div id="dynamicToast" class="toast text-white border-0"
         role="alert" aria-live="assertive" aria-atomic="true"
         style="pointer-events: auto;">
        <div class="d-flex">
            <div id="toastBody" class="toast-body"></div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast" aria-label="Close"></button>
        </div>
    </div>
</div>
<!-- Nút Scroll to Top -->
<button id="scrollTopBtn" title="Go to top">↑</button>
<!--footer-->
<jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>

<!--js-->
<jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>
<script src="${env}/client/js/common.js"></script>
<script src="${env}/client/js/product_details.js"></script>
</body>
</html>