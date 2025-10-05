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
        .history-container {
            max-width: 900px;
            margin: 40px auto;
            background: #fff;
            padding: 25px;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,.05);
        }
        .status-badge { font-weight: 600; }
    </style>
</head>
<body>
<!--header-->
<jsp:include page="/WEB-INF/view/client/layout/header.jsp"></jsp:include>

<div class="container history-container">
    <h3 class="mb-4 text-center">Lịch sử đặt hàng</h3>
    <c:if test="${empty orders}">
        <div class="alert alert-info text-center">Bạn chưa có đơn hàng nào.</div>
    </c:if>
    <c:if test="${not empty orders}">
        <div class="table-responsive">
            <table class="table table-hover align-middle">
                <thead class="table-light">
                <tr>
                    <th>Mã đơn</th>
                    <th>Tổng sản phẩm</th>
                    <th>Tổng tiền</th>
                    <th>Trạng thái</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="order" items="${orders}">
                    <tr>
                        <td>#${order.id}</td>
                        <td>${order.quantity}</td>
                        <td>
                            <fmt:formatNumber value="${order.totalPrice}" type="number" pattern="#,##0"/> VNĐ
                        </td>
                        <td>
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
                        </td>
                        <td>
                            <a class="btn btn-sm btn-outline-primary"
                               href="/client/homes/order-history/${order.id}">
                                Xem chi tiết
                            </a>
                            <c:if test="${order.status eq 'PENDING'}">
                                <a class="btn btn-sm btn-outline-danger"
                                   href="/client/homes/order-history/cancel/${order.id}">
                                    Hủy đơn
                                </a>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </c:if>
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
