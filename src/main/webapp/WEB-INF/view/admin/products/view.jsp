<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Product</title>
    <!--css-->
    <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>

</head>
<body class="sb-nav-fixed">
<!--header-->
<jsp:include page="/WEB-INF/view/admin/layout/header.jsp"></jsp:include>
<div id="layoutSidenav">
    <!--sibar-->
    <jsp:include page="/WEB-INF/view/admin/layout/sibar.jsp"></jsp:include>
    <div id="layoutSidenav_content">
        <main>

            <div class="container mt-5">
                <h1 class="mt-4">Manage Products</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Products</li>
                    <li class="breadcrumb-item active">View</li>
                </ol>
                <table  style="border-collapse: collapse">
                    <tr>
                        <td rowspan="5"><img src="/admin/images/product/${product.avatar}" /></td>
                        <td>
                            <strong>Name</strong>: ${product.name}
                        </td>
                    </tr>
                    <tr>
                        <td><strong>Price</strong>: $<fmt:formatNumber type="number" value="${product.price}" /></td>
                    </tr>
                    <tr>
                        <td><strong>Description</strong>: ${product.shortDesc}</td>
                    </tr>
                    <tr>
                        <td><strong>Quantity</strong>: ${product.quantity}</td>
                    </tr>
                    <tr>
                        <td><strong>Sold</strong>: ${product.sold}</td>
                    </tr>
                </table>

            </div>
        </main>
        <!--footer-->
        <jsp:include page="/WEB-INF/view/admin/layout/footer.jsp"></jsp:include>
    </div>
</div>
<!--js-->
<jsp:include page="/WEB-INF/view/admin/layout/js.jsp"></jsp:include>
</body>
</html>
