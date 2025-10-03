<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <!--css-->
    <jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>
    <!--CSRF-->
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />

    <link rel="stylesheet" href="${env}/client/css/products-page.css" />

    <title>Trang sản phẩm</title>
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
                    <li class="breadcrumb-item" aria-current="page">Phones</li>
                </ol>
            </nav>
        </div>
        <!-- main  -->
        <div class="main d-flex">
            <div class="d-none d-lg-block lefmenu">
                <div class="accordion" id="accordionPanelsStayOpenExample">
                    <!-- start Trade mark-->
                    <div class="accordion-item left__item tradeMarkFilter">
                        <h2 class="accordion-header" id="panelsStayOpen-headingBrand">
                            <button
                                    class="accordion-button collapsed"
                                    type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#panelsStayOpen-collapseBrand"
                                    aria-expanded="false"
                                    aria-controls="panelsStayOpen-collapseBrand"
                                    style="font-family: Inter"
                            >
                                Thương hiệu
                            </button>
                        </h2>
                        <div
                                id="panelsStayOpen-collapseBrand"
                                class="accordion-collapse collapse"
                                aria-labelledby="panelsStayOpen-headingBrand"
                        >
                            <div class="accordion-body">
                                <!-- body -->

                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="apple"
                                            id="apple"
                                            name="trade_mark"
                                    />
                                    <label class="form-check-label items__name" for="apple">
                                        Apple
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="samsung"
                                            id="samsung"
                                            name="trade_mark"
                                    />
                                    <label class="form-check-label items__name" for="samsung">
                                        Samsung
                                    </label>
                                </div>
                                <!-- end -->
                            </div>
                        </div>
                    </div>
                    <!-- end -->
                    <!-- start Color-->
                    <div class="accordion-item left__item colorFilter">
                        <h2
                                class="accordion-header"
                                id="panelsStayOpen-headingColor"
                        >
                            <button
                                    class="accordion-button collapsed"
                                    type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#panelsStayOpen-collapseColor"
                                    aria-expanded="false"
                                    aria-controls="panelsStayOpen-collapseColor"
                                    style="font-family: Inter"
                            >
                                Màu sắc
                            </button>
                        </h2>
                        <div
                                id="panelsStayOpen-collapseColor"
                                class="accordion-collapse collapse"
                                aria-labelledby="panelsStayOpen-headingColor"
                        >
                            <div class="accordion-body">
                                <!-- body -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="Deep Purple"
                                            id="DeepPurple"
                                            name="color"
                                    />
                                    <label class="form-check-label items__name" for="DeepPurple">
                                        Deep Purple
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="Blackmagic"
                                            id="Blackmagic"
                                            name="color"
                                    />
                                    <label class="form-check-label items__name" for="Blackmagic">
                                        Blackmagic
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="Silver"
                                            id="Silver"
                                            name="color"
                                    />
                                    <label class="form-check-label items__name" for="Silver">
                                        Silver
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="Black"
                                            id="Black"
                                            name="color"
                                    />
                                    <label class="form-check-label items__name" for="Black">
                                        Black
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="Phantom Black"
                                            id="Phantom Black"
                                            name="color"
                                    />
                                    <label class="form-check-label items__name" for="Phantom Black">
                                        Phantom Black
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="Gold"
                                            id="Gold"
                                            name="color"
                                    />
                                    <label class="form-check-label items__name" for="Gold">
                                        Gold
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="White"
                                            id="White"
                                            name="color"
                                    />
                                    <label class="form-check-label items__name" for="White">
                                        White
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="Pink"
                                            id="Pink"
                                            name="color"
                                    />
                                    <label class="form-check-label items__name" for="Pink">
                                        Pink
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="Space Black"
                                            id="Space Black"
                                            name="color"
                                    />
                                    <label class="form-check-label items__name" for="Space Black">
                                        Space Black
                                    </label>
                                </div>
                                <!-- end -->
                            </div>
                        </div>
                    </div>
                    <!-- end -->
                    <!-- start Rom-->
                    <div class="accordion-item left__item romFilter">
                        <h2 class="accordion-header" id="panelsStayOpen-headingMemory">
                            <button
                                    class="accordion-button collapsed"
                                    type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#panelsStayOpen-collapseMemory"
                                    aria-expanded="false"
                                    aria-controls="panelsStayOpen-collapseMemory"
                                    style="font-family: Inter"
                            >
                                Bộ nhớ
                            </button>
                        </h2>
                        <div
                                id="panelsStayOpen-collapseMemory"
                                class="accordion-collapse collapse"
                                aria-labelledby="panelsStayOpen-headingMemory"
                        >
                            <div class="accordion-body">
                                <!-- body -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="64"
                                            id="64"
                                            name="rom"

                                    />
                                    <label
                                            class="form-check-label items__name"
                                            for="64"
                                    >
                                        64GB
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="128"
                                            id="128"
                                            name="rom"
                                    />
                                    <label class="form-check-label items__name" for="128">
                                        128GB
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="256"
                                            id="256"
                                            name="rom"
                                    />
                                    <label class="form-check-label items__name" for="256">
                                        256GB
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="512"
                                            id="512"
                                            name="rom"
                                    />
                                    <label class="form-check-label items__name" for="512">
                                        512GB
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="checkbox"
                                            value="1000"
                                            id="1"
                                            name="rom"
                                    />
                                    <label class="form-check-label items__name" for="1">
                                        1TB
                                    </label>
                                </div>
                                <!-- end -->
                            </div>
                        </div>
                    </div>
                    <!-- end -->
                    <!-- start Price-->
                    <div class="accordion-item left__item priceFilter">
                        <h2 class="accordion-header" id="panelsStayOpen-headingPrice">
                            <button
                                    class="accordion-button collapsed"
                                    type="button"
                                    data-bs-toggle="collapse"
                                    data-bs-target="#panelsStayOpen-collapsePrice"
                                    aria-expanded="false"
                                    aria-controls="panelsStayOpen-collapsePrice"
                                    style="font-family: Inter"
                            >
                                Giá tiền
                            </button>
                        </h2>
                        <div
                                id="panelsStayOpen-collapsePrice"
                                class="accordion-collapse collapse"
                                aria-labelledby="panelsStayOpen-headingPrice"
                        >
                            <div class="accordion-body">
                                <!-- body -->

                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="radio"
                                            value="100-500"
                                            id="500"
                                            name="price"
                                    />
                                    <label
                                            class="form-check-label items__name"
                                            for="500"
                                    >
                                        Từ $100 -> $500
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="radio"
                                            value="500-1000"
                                            id="501"
                                            name="price"
                                    />
                                    <label class="form-check-label items__name" for="501">
                                        Từ $500 -> $1000
                                    </label>
                                </div>
                                <!-- end -->
                                <!-- start -->
                                <div class="form-check">
                                    <input
                                            class="form-check-input"
                                            type="radio"
                                            value="1001"
                                            id="1001"
                                            name="price"
                                    />
                                    <label class="form-check-label items__name" for="1001">
                                        Hơn $1000
                                    </label>
                                </div>
                                <!-- end -->

                            </div>
                        </div>
                    </div>
                    <!-- end -->
                </div>
            </div>
            <div class="main__product">
                <div
                        class="main__product--list"
                >
                    <div class="row g-4">
                        <div class="col-lg-12">
                            <div class="row g-2">
                                <c:if test="${totalPages==0}">
                                    <div class="text-center">
                                        Không tìm thấy sản phẩm nào
                                    </div>
                                </c:if>
                                <c:forEach var="product" items="${products}">
                                    <!-- start -->
                                    <div class="col-lg-4 main__product--item m-1">
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
                                                    <img src="${env}/admin/images/product/${product.avatar}" alt="logo"/>
                                                </a>
                                            </div>
                                            <div class="box__details d-flex flex-column justify-content-between align-items-center">
                                                <div class="box__details--name text-center">
                                                        ${product.name}
                                                </div>
                                                <div class="box__details--price mt-3 mb-4">
                                                    $<fmt:formatNumber type="number" value="${product.price}" />
                                                </div>
                                                <form action="/client/productdetails/${product.id}" method="GET">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
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
                <c:if test="${totalPages > 0}">
                    <div class="paging d-flex justify-content-center align-items-center ">
                        <nav aria-label="Page navigation example">
                            <ul class="pagination ">
                                <li class="page-item">
                                    <a class="${1 eq currentPage ? 'd-none' : 'page-link'}" href="/client/products?page=${currentPage -1}" aria-label="Previous">
                                        <span aria-hidden="true">&laquo;</span>
                                    </a>
                                </li>
                                <c:forEach begin="0" end="${totalPages -1}" varStatus="pageNum">
                                    <li class="page-item">
                                        <a class="${(pageNum.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"
                                           href="/client/products?page=${pageNum.index + 1}">${pageNum.index + 1}</a>
                                    </li>
                                </c:forEach>

                                <li class="page-item">
                                    <a class="${currentPage eq totalPages? 'd-none' : 'page-link'}" href="/client/products?page=${currentPage +1}" aria-label="Next">
                                        <span aria-hidden="true">&raquo;</span>
                                    </a>
                                </li>
                            </ul>
                        </nav>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</main>
<!-- Nút Scroll to Top -->
<button id="scrollTopBtn" title="Go to top">↑</button>
<!--footer-->
<jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>

<!--js-->
<jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>
<script src="${env}/client/js/main.js"></script>
<script src="${env}/client/js/common.js"></script>
<script src="${env}/client/js/product.js"></script>
</body>
</html>
