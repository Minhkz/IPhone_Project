$(document).ready(function () {
    // Helper
    // Định dạng tiền kiểu 18,000,000 VNĐ
    const formatVND = (n) =>
        new Intl.NumberFormat('en-US', {
            minimumFractionDigits: 0,
            maximumFractionDigits: 0
        }).format(n) + " VNĐ";

    const parseNumberFromText = (txt) => parseFloat(String(txt).replace(/[^\d.-]/g, "")) || 0;


    const $checkAll = $("#cart-check-all");
    const $itemsContainer = $(".left__product");

    // Ban đầu: check tất cả
    if ($(".cart-check-item").length > 0) {
        $(".cart-check-item").prop("checked", true);
        $checkAll.prop("checked", true);
    } else {
        $checkAll.prop("checked", false);
    }

    // Cập nhật trạng thái của nút check-all theo các item
    function refreshCheckAllState() {
        const total = $(".cart-check-item").length;
        const checked = $(".cart-check-item:checked").length;
        $checkAll.prop("checked", total > 0 && total === checked);
    }

    // Tính lại summary dựa trên những item đang checked
    function updateSummary() {
        let subtotal = 0;


        $(".cart-check-item:checked").each(function () {
            const $inputQuantity = $(this).closest(".rightSide").find(".number");
            const unitPrice = parseFloat($inputQuantity.data("price")) || 0;
            const qty = parseInt($inputQuantity.val()) || 1;
            subtotal += unitPrice * qty;
        });

        const baseServiceFee = parseFloat($(".Taxes1").data("fee")) || 0;
        const baseShippingFee = parseFloat($(".Taxes2").data("fee")) || 0;


        const serviceFee = subtotal > 0 ? baseServiceFee : 0;
        const shippingFee = subtotal > 0 ? baseShippingFee : 0;
        const total = subtotal + serviceFee + shippingFee;

        // Cập nhật giao diện
        $(".Subtotal .right__text").text(formatVND(subtotal));
        $(".Taxes1 .right__text").text(formatVND(serviceFee));
        $(".Taxes2 .right__text").text(formatVND(shippingFee));
        $(".Total .right__text").text(formatVND(total));
    }


    // Events: check all / check item

    $checkAll.on("change", function () {
        const checked = $(this).is(":checked");
        $(".cart-check-item").prop("checked", checked);
        updateSummary();
    });

    // delegation cho từng item (dùng class)
    $(document).on("change", ".cart-check-item", function () {
        refreshCheckAllState();
        updateSummary();
    });


    // Xoá sản phẩm

    $(document).on("click", ".btn-remove", function (e) {
        e.preventDefault();
        const productId = $(this).data("id");

        $.ajax({
            url: "/client/carts/cancel/" + productId,
            type: "POST",
            success: function (response) {
                if (response.status === "success") {
                    // Xóa trên UI
                    $("#item-" + productId).remove();
                    $("#count-item").text(response.sum);

                    // Cập nhật summary và trạng thái check-all
                    refreshCheckAllState();
                    updateSummary();

                    if (response.sum === 0) {
                        $(".main").addClass("d-none");
                        $(".empty-cart").removeClass("d-none");
                    }
                } else {
                    alert("Xoá thất bại!");
                }
            },
            error: function () {
                alert("Có lỗi xảy ra khi xóa sản phẩm!");
            }
        });
    });


    // Tăng số lượng

    $(document).on("click", ".plus", function () {
        const $inputQuantity = $(this).siblings(".number");
        const productId = $inputQuantity.data("id");

        $.ajax({
            url: "/client/carts/plus/" + productId,
            type: "POST",
            success: function (response) {
                if (response.status === "success") {
                    // cập nhật input và giá item
                    $inputQuantity.val(response.quantity);
                    const $priceElement = $inputQuantity.closest(".rightSide").find(".price");
                    $priceElement.text(formatVND(response.totalPrice));

                    // recompute toàn bộ summary
                    updateSummary();
                } else {
                    alert("Cập nhật số lượng thất bại!");
                }
            },
            error: function () {
                alert("Có lỗi xảy ra khi tăng số lượng!");
            }
        });
    });


    // Giảm số lượng

    $(document).on("click", ".minus", function () {
        const $inputQuantity = $(this).siblings(".number");
        const currentVal = parseInt($inputQuantity.val()) || 1;
        const productId = $inputQuantity.data("id");

        if (currentVal > 1) {
            $.ajax({
                url: "/client/carts/minus/" + productId,
                type: "POST",
                success: function (response) {
                    if (response.status === "success") {
                        $inputQuantity.val(response.quantity);
                        const $priceElement = $inputQuantity.closest(".rightSide").find(".price");
                        $priceElement.text(formatVND(response.totalPrice));

                        updateSummary();
                    } else {
                        alert("Cập nhật số lượng thất bại!");
                    }
                },
                error: function () {
                    alert("Có lỗi xảy ra khi giảm số lượng!");
                }
            });
        }
    });

    refreshCheckAllState();
    updateSummary();

    document.getElementById("checkoutForm").addEventListener("submit", function(e) {
        const checkedItems = document.querySelectorAll(".cart-check-item:checked");
        const pairs = [];

        checkedItems.forEach(item => {
            const parent = item.closest(".left__product--item");
            if (parent) {
                const productId = parent.id.replace("item-", "");
                const qty = parent.querySelector(".number").value; // lấy quantity
                pairs.push(productId + ":" + qty);
            }
        });


        document.getElementById("selectedIds").value = pairs.join(",");
    });

});
