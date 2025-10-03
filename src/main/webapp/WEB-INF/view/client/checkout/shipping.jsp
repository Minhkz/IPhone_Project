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
                        <img src="${env}/client/images/checkout/shipping/Location.png" alt="logo">
                    </a>
                    <div class="address__title text-muted ms-2">
                        <div class="address__title--step">Bước 1</div>
                        <div class="address__title--name">Address</div>
                    </div>
                </li>
                <li class="d-flex align-items-center">
                    <a href="/client/payment/shipping">
                        <img src="${env}/client/images/checkout/shipping/Shipping.png" alt="logo">
                    </a>
                    <div class="address__title  m-2">
                        <div class="address__title--step">Bước 2</div>
                        <div class="address__title--name">Shipping</div>
                    </div>
                </li>
                <li class="d-flex align-items-center">
                    <a href="/client/payment">
                        <img src="${env}/client/images/checkout/shipping/Payment.png" alt="logo">
                    </a>
                    <div class="address__title text-muted m-2">
                        <div class="address__title--step">Bước 3</div>
                        <div class="address__title--name">Payment</div>
                    </div>
                </li>
            </ul>
        </nav>
        <div class="address__main">
            <div class="address__main--title" style="margin-bottom: 32px">
                Phương thức vận chuyển
            </div>
            <div class="address__main--content d-flex justify-content-between align-items-center"
                 style="height: 72px; border: 1px solid black; border-radius: 5px; margin-bottom: 24px">
                <div class="main__content--left d-flex p-4">
                    <input type="radio" name="shipping" value="0" style="width: 24px; height: 24px;" disabled="disabled"/>
                    <div class="ms-4">Miễn phí ship</div>
                </div>
                <div class="address__main--right me-4">
                    $<fmt:formatNumber type="number" value="0" />
                </div>
            </div>

            <div class="address__main--content d-flex justify-content-between align-items-center"
                 style="height: 72px; border: 1px solid black; border-radius: 5px; margin-bottom: 24px">
                <div class="main__content--left d-flex p-4">
                    <input type="radio" name="shipping" value="1" checked="checked" style="width: 24px; height: 24px;"/>
                    <div class="ms-4">Tiết kiệm</div>
                </div>
                <div class="address__main--right me-4">
                    $<fmt:formatNumber type="number" value="1" />
                </div>
            </div>

            <div class="address__main--content d-flex justify-content-between align-items-center"
                 style="height: 72px; border: 1px solid black; border-radius: 5px; margin-bottom: 24px">
                <div class="main__content--left d-flex p-4">
                    <input type="radio" name="shipping" value="2" style="width: 24px; height: 24px;"/>
                    <div class="ms-4">Giao nhanh</div>
                </div>
                <div class="address__main--right me-4">
                    $<fmt:formatNumber type="number" value="2" />
                </div>
            </div>


            <div class="d-flex justify-content-end align-items-center mb-5">
                <form action="/client/payment/address" method="get">
                    <button type="submit" class="btn btn-outline-dark" style="width: 208px; height: 64px; margin-right: 24px">Back</button>
                </form>
                <form id="shippingForm" action="/client/payment" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="hidden" id="shippingHidden" name="shipping" value=""/>
                    <button type="submit" class="btn btn-dark" style="width: 208px; height: 64px;">Next</button>
                </form>

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
<script>
    document.getElementById("shippingForm").addEventListener("submit", function () {
        const selected = document.querySelector("input[name='shipping']:checked");
        document.getElementById("shippingHidden").value = selected ? selected.value : "";
    });
</script>
</body>
</html>