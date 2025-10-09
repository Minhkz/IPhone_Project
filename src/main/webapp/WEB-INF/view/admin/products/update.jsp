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
    <title>Update a Product</title>
    <!--css-->
    <jsp:include page="/WEB-INF/view/admin/layout/css.jsp"></jsp:include>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script>
        $(document).ready(() => {
            const avatarFile = $("#avatarFile");
            avatarFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#avatarPreview").attr("src", imgURL);
                $("#avatarPreview").css({ "display": "block" });
            });


            // Image preview
            const imageFile = $("#imageFile");
            imageFile.change(function (e) {
                const imgURL = URL.createObjectURL(e.target.files[0]);
                $("#imagePreview").attr("src", imgURL);
                $("#imagePreview").css({ "display": "block" });
            });
        });
    </script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
<!--header-->
<jsp:include page="/WEB-INF/view/admin/layout/header.jsp"></jsp:include>
<div id="layoutSidenav">
    <!--sibar-->
    <jsp:include page="/WEB-INF/view/admin/layout/sibar.jsp"></jsp:include>
    <div id="layoutSidenav_content">
        <main>
            <div class="container-fluid px-4">
                <h1 class="mt-4">Products</h1>
                <ol class="breadcrumb mb-4">
                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                    <li class="breadcrumb-item active">Product</li>
                </ol>
                <div class="mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Create a product</h3>
                            <hr />
                            <form:form method="post" action="/admin/products/update" class="row"
                                       enctype="multipart/form-data" modelAttribute="updateProduct">
                                <div class="mb-3 col-12 col-md-6 d-none">
                                    <label class="form-label">Id:</label>
                                    <form:input type="text" class="form-control" path="id" />
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Name:</label>
                                    <form:input type="text" class="form-control" path="name" />
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Price:</label>
                                    <form:input type="number" class="form-control" path="price" />
                                </div>
                                <div class="mb-3 col-12">
                                    <label class="form-label">Detail description:</label>
                                    <form:textarea type="text" class="form-control" path="detailDesc" />
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Short description:</label>
                                    <form:input type="text" class="form-control" path="shortDesc" />
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Quantity:</label>
                                    <form:input type="number" class="form-control" path="quantity" />
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Sản phẩm nổi bật:</label>
                                    <form:select class="form-select" path="featured">
                                        <form:option value="1">Có</form:option>
                                        <form:option value="0">Không</form:option>
                                    </form:select>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label class="form-label">Sản phẩm giảm giá:</label>
                                    <form:select class="form-select" path="discount">
                                        <form:option value="1">Có</form:option>
                                        <form:option value="0">Không</form:option>
                                    </form:select>
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label for="">Old avatar:</label><br>
                                    <img src="<c:url value='/resources/admin/images/product/${updateProduct.avatar}'/>" alt="" width="100" height="100" />
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label for="avatarFile" class="form-label">New avatar:</label>
                                    <input class="form-control" type="file" id="avatarFile"
                                           accept=".png, .jpg, .jpeg" name="nhatminhFile" />
                                </div>

                                <div class="col-12 mb-3">
                                    <img style="max-height: 250px; display: none;" alt="avatar preview"
                                         id="avatarPreview" />
                                </div>

                                <div class="mb-3 col-12 col-md-6">
                                    <label for="">Old Image:</label><br>
                                    <img src="<c:url value='/resources/admin/images/product_details/${updateProduct.img}'/>" alt="" width="100" height="100" />
                                </div>
                                <div class="mb-3 col-12 col-md-6">
                                    <label for="imageFile" class="form-label">Image:</label>
                                    <input class="form-control" type="file" id="imageFile"
                                           accept=".png, .jpg, .jpeg" name="nhatminhImgFile" />
                                </div>
                                <div class="col-12 mb-3">
                                    <img style="max-height: 250px; display: none;" alt="avatar preview"
                                         id="imagePreview" />
                                </div>

                                <div class="col-12 mb-5">
                                    <button type="submit" class="btn btn-warning">Update</button>
                                </div>
                            </form:form>

                        </div>

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
