<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!--css-->
    <jsp:include page="/WEB-INF/view/client/layout/css.jsp"></jsp:include>
    <!--CSRF-->
    <meta name="_csrf" content="${_csrf.token}" />
    <meta name="_csrf_header" content="${_csrf.headerName}" />
    <title>Lịch sử đơn hàng</title>
    <style>
        body { background-color: #f8f9fa; }
        .order-container {
            max-width: 1000px;
            margin: 40px auto;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,.05);
        }
        .order-header { margin-bottom: 25px; }
        .status-badge { font-weight: 600; }
        .product-img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 8px;
        }
    </style>
</head>
<body>
<!--header-->
<jsp:include page="/WEB-INF/view/client/layout/header.jsp"></jsp:include>

<div class="container order-container">
    <div class="order-header">
        <h3>Chi tiết đơn hàng #${order.id}</h3>
        <p>
            <strong>Trạng thái:</strong>
            <c:choose>
                <c:when test="${order.status == 'PENDING'}">
                    <span class="badge bg-warning text-dark status-badge">Chờ xử lý</span>
                </c:when>
                <c:when test="${order.status == 'CONFIRMED'}">
                    <span class="badge bg-info text-dark status-badge">Đã xác nhận</span>
                </c:when>
                <c:when test="${order.status == 'SHIPPING'}">
                    <span class="badge bg-primary status-badge">Đang giao</span>
                </c:when>
                <c:when test="${order.status == 'COMPLETED'}">
                    <span class="badge bg-success status-badge">Hoàn tất</span>
                </c:when>
                <c:when test="${order.status == 'CANCELLED'}">
                    <span class="badge bg-danger status-badge">Đã hủy</span>
                </c:when>
                <c:otherwise>
                    <span class="badge bg-secondary">${order.status}</span>
                </c:otherwise>
            </c:choose>
        </p>
        <p><strong>Tổng tiền:</strong>
            <fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,##0"/> VNĐ
        </p>
    </div>

    <h5>Danh sách sản phẩm</h5>
    <div class="table-responsive">
        <table class="table table-striped align-middle">
            <thead class="table-light">
            <tr>
                <th>Sản phẩm</th>
                <th>Tên</th>
                <th>Số lượng</th>
                <th>Giá</th>
                <th>Thành tiền</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${orderProducts}">
                <tr>
                    <td>
                        <img class="product-img"
                             src="${env}/admin/images/product/${item.product.avatar}"
                             alt="logo">
                    </td>
                    <td>${item.product.name}</td>
                    <td>${item.quantity}</td>
                    <td>
                        <fmt:formatNumber value="${item.price}" type="number" pattern="#,##0"/> VNĐ
                    </td>
                    <td>
                        <fmt:formatNumber value="${item.price * item.quantity}" type="number" pattern="#,##0"/> VNĐ
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>

    <div class="text-end mt-3">
        <a href="/client/homes/order-history"
           class="btn btn-secondary">← Quay lại lịch sử</a>
    </div>
</div>

<!-- Nút Scroll to Top -->
<button id="scrollTopBtn" title="Go to top">↑</button>

<!--Footer-->
<jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>

<!--js-->
<jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>
<script src="${env}/client/js/common.js"></script>
</body>
</html>
