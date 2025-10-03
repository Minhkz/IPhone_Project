<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--css-->
    <jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>
    <link rel="stylesheet" href="${env}/client/css/products-page.css" />
    <link rel="stylesheet" href="${env}/client/css/Product_Details_Page.css">
    <link rel="stylesheet" href="${env}/client/css/Shopping_Cart.css">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css" integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <title>Shopping Cart</title>
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
                    <li class="breadcrumb-item" aria-current="page">Wishlists</li>
                </ol>
            </nav>
        </div>
        <div class="main">
            <div class="left__content fs-4 fw-bold ">
                Sản phẩm yêu thích
            </div>

                <div class="d-flex flex-wrap justify-content-between">
                    <c:forEach var="product" items="${products}">
                        <!-- start -->
                        <div class="left__product--item d-flex gap-3 border-bottom" style="width: calc(100% /2.2)" id="item-${product.id}" >
                            <div class="item__img">
                                <a href="/client/productdetails/${product.id}">
                                    <img src="${env}/admin/images/product/${product.avatar}" alt="logo">
                                </a>
                            </div>
                            <div class="left__product--content d-flex align-items-center">
                                <div class="content__info">
                                    <p class="name">${product.name}</p>
                                    <p class="ma">#${product.id}</p>
                                </div>
                                <div class="rightSide d-flex gap-4">
                                    <div class="price ">
                                        $<fmt:formatNumber type="number" value="${product.price}" />
                                    </div>
                                    <div class="cancel">
                                            <button type="button" class="btn btn-danger" data-id="${product.id}">
                                                <i class="fa-solid fa-xmark"></i>
                                            </button>
                                    </div>
                                </div>

                            </div>
                        </div>
                        <!-- end -->
                    </c:forEach>
                </div>


        </div>
    </div>
</main>

<!--footer-->
<jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>
<!--js-->
<jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>
<script>
    $(document).ready(function () {
        $(".cancel button").click(function (e) {
            e.preventDefault();

            let btn = $(this);
            let productId = btn.data("id");

            $.ajax({
                url: "/client/wishlist/cancel/" + productId,
                type: "POST",
                headers: {
                    "X-CSRF-TOKEN": "${_csrf.token}"
                },
                success: function (response) {
                    if(response.status === "success") {
                        // Xoá phần tử sản phẩm khỏi giao diện
                        $("#item-" + productId).remove();
                    }
                },
                error: function () {
                    alert("Có lỗi xảy ra khi xóa sản phẩm!");
                }
            });
        });
    });

</script>
</body>
</html>