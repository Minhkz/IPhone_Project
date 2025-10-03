<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết đơn hàng</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body { background: #f8f9fa; }
        .order-card { margin-top: 30px; }
        .table th { background-color: #0d6efd; color: #fff; }
    </style>
</head>
<body>

<div class="container order-card">
    <div class="card shadow">
        <div class="card-header bg-primary text-white">
            <h4>Chi tiết đơn hàng #${order.id}</h4>
        </div>
        <div class="card-body">

            <!-- Thông tin khách hàng -->
            <h5>Thông tin khách hàng</h5>
            <ul class="list-unstyled">
                <li><strong>Tên:</strong> ${address.reciverName}</li>
                <li><strong>Số điện thoại:</strong> ${address.reciverPhone}</li>
                <li><strong>Địa chỉ:</strong> ${address.detailDesc}</li>
            </ul>
            <hr>

            <!-- Danh sách sản phẩm -->
            <h5>Sản phẩm trong đơn hàng</h5>
            <div class="table-responsive">
                <table class="table table-bordered text-center align-middle">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Ảnh sản phẩm</th>
                        <th>Tên sản phẩm</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="orderProduct" items="${orderProducts}" varStatus="loop">
                        <tr>
                            <td>${loop.index + 1}</td>
                            <td>${orderProduct.product.avatar}</td>
                            <td>${orderProduct.product.name}</td>
                            <td>${orderProduct.quantity}</td>
                            <td>$<fmt:formatNumber type="number" value="${orderProduct.price * orderProduct.quantity}" /></td>
                        </tr>
                    </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Tổng tiền -->
            <div class="text-end mt-3">
                <h5>
                    Tổng tiền:
                    <span class="fw-bold text-danger">
                        $<fmt:formatNumber type="number" value="${order.totalPrice}" />
                    </span>
                </h5>
            </div>

            <hr>

            <!-- Trạng thái đơn hàng -->
            <h5>Trạng thái đơn hàng</h5>
            <span class="badge bg-warning text-dark">${order.status}</span>

            <div class="mt-3">
                <a href="/admin/orders" class="btn btn-secondary">⬅ Quay lại danh sách</a>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
