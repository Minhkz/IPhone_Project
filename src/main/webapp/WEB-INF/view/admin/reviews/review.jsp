<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Order</title>
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
                <h1 class="mt-4">Manage Reviews</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Reviews</li>
                </ol>
                <div class="row">
                    <div class="col-12 mx-auto">
                        <div class="d-flex align-items-center">
                            <h3>Table reviews</h3>
                        </div>

                        <hr />
                        <table class=" table table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>ID</th>
                                <th>Người dùng</th>
                                <th>Sản phẩm</th>
                                <th>Nội dung</th>
                                <th>Action</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="review" items="${reviews}">
                                <tr>
                                    <td>${review.id}</td>
                                    <td>${review.user.fullName}</td>
                                    <td>${review.product.name}</td>
                                    <td>${review.body}</td>
                                    <td>
                                        <a href="/admin/reviews/success/${review.id}" class="btn btn-success">Duyệt</a>
                                        <a href="/admin/reviews/deletes/${review.id}"
                                           class="btn btn-danger" onclick="return confirm('Xác nhận không duyệt comment này?');">Không duyệt</a>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>

                        </table>
<%--                        <c:if test="${totalPages > 0}">--%>
<%--                            <div class="paging d-flex justify-content-center align-items-center ">--%>
<%--                                <nav aria-label="Page navigation example">--%>
<%--                                    <ul class="pagination ">--%>
<%--                                        <li class="page-item">--%>
<%--                                            <a class="${1 eq currentPage ? 'd-none' : 'page-link'}" href="/admin/orders?page=${currentPage -1}" aria-label="Previous">--%>
<%--                                                <span aria-hidden="true">&laquo;</span>--%>
<%--                                            </a>--%>
<%--                                        </li>--%>
<%--                                        <c:forEach begin="0" end="${totalPages -1}" varStatus="loop">--%>
<%--                                            <li class="page-item">--%>
<%--                                                <a class="${(loop.index + 1) eq currentPage ? 'active page-link' : 'page-link'}"--%>
<%--                                                   href="/admin/orders?page=${loop.index + 1}">--%>
<%--                                                        ${loop.index + 1}--%>
<%--                                                </a>--%>
<%--                                            </li>--%>
<%--                                        </c:forEach>--%>
<%--                                        <li class="page-item">--%>
<%--                                            <a class="${currentPage eq totalPages? 'd-none' : 'page-link'}" href="/admin/orders?page=${currentPage +1}" aria-label="Next">--%>
<%--                                                <span aria-hidden="true">&raquo;</span>--%>
<%--                                            </a>--%>
<%--                                        </li>--%>
<%--                                    </ul>--%>
<%--                                </nav>--%>
<%--                            </div>--%>
<%--                        </c:if>--%>
                    </div>
                </div>

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
