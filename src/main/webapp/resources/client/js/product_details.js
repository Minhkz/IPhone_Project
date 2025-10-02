function showToast(type, message) {
    const toastEl = document.getElementById("dynamicToast");
    const toastBody = document.getElementById("toastBody");

    // Reset class
    toastEl.className = "toast text-white border-0";

    // Gán màu theo type
    if (type === "success") {
        toastEl.classList.add("bg-success");
    } else if (type === "error") {
        toastEl.classList.add("bg-danger");
    } else if (type === "info") {
        toastEl.classList.add("bg-primary");
    }

    // Gán nội dung
    toastBody.innerText = message;

    // Hiện toast
    const toast = new bootstrap.Toast(toastEl, {
        autohide: true,
        delay: 2000
    });
    toast.show();
}

$(document).ready(function () {
    //wishlist
    const btn = document.getElementById("showToastWish");
    btn.addEventListener("click", function (e) {
        e.preventDefault();

        let btn = $(this);
        let productId = btn.data("id");

        $.ajax({
            url: "/client/productdetails/add-to-wishlist/" + productId,
            type: "POST",
            success: function (response) {
                if (response.status === "success") {
                    showToast("success", "Thêm vào wishlist thành công!");
                } else {
                    showToast("error", "Sản phẩm đã có trong wishlist!");
                }
            },
            error: function () {
                showToast("error", "Có lỗi xảy ra khi thêm vào wishlist!");
            }
        });
    });
    //cart
    const btnCart = document.getElementById("showToastCart");
    btnCart.addEventListener("click", function (e) {
        e.preventDefault();

        let btn = $(this);
        let productId = btn.data("id");
        let quantity = $(".number").val();

        $.ajax({
            url: "/client/productdetails/add-to-cart/" + productId +"?quantity=" + quantity,
            type: "POST",
            success: function (response) {
                if (response.status === "success") {
                    $("#count-item").text(response.count);
                    showToast("success", "Thêm vào cart thành công!");
                } else {
                    showToast("error", "Không thể thêm vào cart!");
                }
            },
            error: function () {
                showToast("error", "Có lỗi xảy ra khi thêm vào cart!");
            }
        });
    });
    //plus và minus
    let inputQuantity = $(".number");

    // đảm bảo giá trị mặc định = 1
    inputQuantity.val(1);

    // nút plus
    $(".plus").on("click", function () {
        let currentVal = parseInt(inputQuantity.val()) || 1;
        inputQuantity.val(currentVal + 1);
    });

    // nút minus
    $(".minus").on("click", function () {
        let currentVal = parseInt(inputQuantity.val()) || 1;
        if (currentVal > 1) {
            inputQuantity.val(currentVal - 1);
        }
    });

    $(".heart__item").click(function (e) {
        e.preventDefault();

        let btn = $(this);
        let img = btn.find("img");
        let productId = btn.data("id");

        $.ajax({
            url: "/client/homes/add-to-wishlist/" + productId,
            type: "POST",
            success: function (response) {
                // Toggle icon
                if (response.status === "added") {
                    img.attr("src", "/client/images/home/Icon/heart-solid-full.png");
                } else if (response.status === "removed") {
                    img.attr("src", "/client/images/home/Icon/heart.png");
                }
            },
            error: function () {
                alert("Có lỗi xảy ra khi thêm vào wishlist!");
            }
        });
    });

    document.getElementById("checkoutForm").addEventListener("submit", function(e) {
        const productInput = document.querySelector(".number");
        const productId = productInput.dataset.id;
        const qty = productInput.value;
        const pairs = [];
        pairs.push(productId + ":" + qty);
        document.getElementById("selectedIds").value = pairs.join(",");
    });

    let offset = 5; // đã render 5 review ở JSP ban đầu
    const limit = 5;
    const productId = $('#loadMore').data("id");



    $("#loadMore").click(function () {
        $.ajax({
            url: "/client/productdetails/load-more-reviews",
            type: "GET",
            data: {
                productId: productId,
                offset: offset,
                limit: limit
            },
            success: function (data) {
                if (data.length > 0) {
                    data.forEach(review => {

                        let avatarPath = "";
                        if (review.role === "ADMIN" || review.role === "STAFF") {
                            avatarPath = `/admin/images/user/${review.avatar}`;
                        } else {
                            avatarPath = `/client/images/avatar/${review.avatar}`;
                        }

                        $("#reviewList").append(`
                        <div class="review-card">
                            <div class="d-flex align-items-center mb-2">
                                <img style="width: 40px; height: 40px; border-radius: 50%; overflow: hidden;"
                                     src="${avatarPath}" width="40" height="40"/>
                                <div style="padding-left: 2px">
                                    <div class="review-user">${review.fullName}</div>
                                    <div class="review-time">${review.createdAt}</div>
                                </div>
                            </div>
                            <div class="review-body" style="padding-left: 42px">
                                ${review.body}
                            </div>
                        </div>
                    `);
                    });

                    offset += data.length;
                } else {
                    $("#loadMore").hide();
                }
            },
            error: function () {
                alert("Không thể tải thêm đánh giá!");
            }
        });
    });

});