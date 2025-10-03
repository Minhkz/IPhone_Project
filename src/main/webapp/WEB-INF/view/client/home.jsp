<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<fmt:setLocale value="en_US" scope="session"/>
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

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">

    <title>My Iphone</title>
</head>
<body>
<!--header-->
<jsp:include page="/WEB-INF/view/client/layout/header.jsp"></jsp:include>

<main>
    <!-- Banner -->
    <div class="d-none d-lg-block banner1 border-top border-bottom">
        <div class="banner1__list">
            <div class="banner1__list--item">
                <a href="#">
                    <img src="${env}/client/images/home/banner/banner10.png" alt="logo">
                </a>
            </div>
            <div class="banner1__list--item">
                <a href="#">
                    <img src="${env}/client/images/home/banner/banner9.png" alt="logo">
                </a>
            </div>
            <div class="banner1__list--item">
                <a href="#">
                    <img src="${env}/client/images/home/banner/banner8.png" alt="logo">
                </a>
            </div>
            <div class="banner1__list--item">
                <a href="#">
                    <img src="${env}/client/images/home/banner/banner7.png" alt="logo">
                </a>
            </div>
            <div class="banner1__list--item">
                <a href="#">
                    <img src="${env}/client/images/home/banner/banner6.png" alt="logo">
                </a>
            </div>
        </div>
    </div>
    <!-- Main -->
    <div class="container">
        <div class="category">
            <div class="category__top d-flex bd-highlight ">
                <div class="p-2 flex-grow-1 bd-highlight category__top--title">Danh mục sản phẩm</div>
                <div class="p-2 bd-highlight">
                    <a href="#">
                        <img src="${env}/client/images/home/Icon/ArrowL.png" alt="logo">
                    </a>
                </div>
                <div class="p-2 bd-highlight">
                    <a href="#">
                        <img src="${env}/client/images/home/Icon/ArrowR.png" alt="logo">
                    </a>
                </div>
            </div>

            <div class="categories container py-4">
                <div class="row row-cols-2 row-cols-sm-3 row-cols-md-4 row-cols-lg-6 g-3">
                    <!-- start -->
                    <div class="col">
                        <div class="category__card d-flex flex-column justify-content-center align-items-center">
                            <div class="category__card--icon">
                                <a href="/client/products">
                                    <img src="${env}/client/images/home/Icon/Phones.png" alt="logo">
                                </a>
                            </div>
                            <div class="category__card--title">Phones</div>
                        </div>
                    </div>
                    <!-- end -->

                    <div class="col">
                        <div class="category__card d-flex flex-column justify-content-center align-items-center">
                            <div class="category__card--icon">
                                <a href="#">
                                    <img src="${env}/client/images/home/Icon/Smart Watches.png" alt="logo">
                                </a>
                            </div>
                            <div class="category__card--title">Smart Watches</div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="category__card d-flex flex-column justify-content-center align-items-center">
                            <div class="category__card--icon">
                                <a href="#">
                                    <img src="${env}/client/images/home/Icon/Cameras.png" alt="logo">
                                </a>
                            </div>
                            <div class="category__card--title">Cameras</div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="category__card d-flex flex-column justify-content-center align-items-center">
                            <div class="category__card--icon">
                                <a href="#">
                                    <img src="${env}/client/images/home/Icon/Headphones.png" alt="logo">
                                </a>
                            </div>
                            <div class="category__card--title">Headphones</div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="category__card d-flex flex-column justify-content-center align-items-center">
                            <div class="category__card--icon">
                                <a href="#">
                                    <img src="${env}/client/images/home/Icon/Computers.png" alt="logo">
                                </a>
                            </div>
                            <div class="category__card--title">Computers</div>
                        </div>
                    </div>

                    <div class="col">
                        <div class="category__card d-flex flex-column justify-content-center align-items-center">
                            <div class="category__card--icon">
                                <a href="#">
                                    <img src="${env}/client/images/home/Icon/Gaming.png" alt="logo">
                                </a>
                            </div>
                            <div class="category__card--title">Gaming</div>
                        </div>
                    </div>
                </div>
            </div>
            </div>
            <!-- Tag -->
            <div class="tag ">
                <ul class="d-flex">
                    <li>
                        <a href="#">Sản phẩm mới</a>
                    </li>
                    <li>
                        <a href="#"> Bán chạy</a>
                    </li>
                    <li class="active">
                        <a href="#">Sản phẩm nổi bật</a>
                    </li>
                </ul>
            </div>
            <!-- Products -->
            <div class="products ">
                <div class="row g-4">
                    <div class="col-lg-12">
                        <div class="row g-4">
                            <c:forEach var="product" items="${products}">
                                <!-- start -->
                                <div class="col-md-6 col-lg-4 col-xl-3 product__item m-2">
                                    <div class="product__item--box">
                                        <div class="box__header d-flex justify-content-end">
                                            <button type="button"
                                                    class="border-0 bg-transparent heart__item"
                                                    data-id="${product.id}">
                                                <c:choose>
                                                    <c:when test="${fn:contains(wishlistId, product.id)}">
                                                        <img src="${env}/client/images/home/Icon/heart-solid-full.png" alt="logo">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${env}/client/images/home/Icon/heart.png" alt="logo">
                                                    </c:otherwise>
                                                </c:choose>

                                            </button>
                                        </div>
                                        <div class="box__img">
                                            <a href="/client/productdetails/${product.id}">
                                                <img src="${env}/admin/images/product/${product.avatar}" alt="logo">
                                            </a>
                                        </div>
                                        <div class="box__details d-flex flex-column justify-content-between align-items-center">
                                            <div class="box__details--name text-center">${product.name}</div>
                                            <div class="box__details--price mt-3 mb-4">
                                                $<fmt:formatNumber value="${product.price}" type="number" pattern="#,###"/>
                                            </div>
                                            <form action="/client/productdetails/${product.id}" method="GET">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <button type="submit" class="btn btn-dark box__details--btn">Mua ngay</button>
                                            </form>

                                        </div>
                                    </div>
                                </div>
                                <!-- end -->
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
    <!-- Big banner -->
    <div class="d-none d-lg-flex bigBanner justify-content-between mt-5">
        <!-- start -->
        <div class="bigBanner__item">
            <div class="bigBanner__item--img">
                <a href="#">
                    <img src="${env}/client/images/home/products/Popular.png" alt="logo">
                </a>
            </div>
            <div class="bigBanner__item--details ">
                <div class="bigBanner__item--name">Phổ biến nhất</div>
                <div class="bigBanner__item--describe mt-3 mb-3">iPad sở hữu màn hình Retina 10.2 inch tuyệt đẹp, hiệu năng ấn tượng, hỗ trợ đa nhiệm và cực kỳ dễ sử dụng.</div>
                <button type="button" class="btn btn-outline-secondary bigBanner__item--btn">Mua ngay</button>
            </div>
        </div>
        <!-- end -->
        <!-- start -->
        <div class="bigBanner__item" id="banner2">
            <div class="bigBanner__item--img">
                <a href="#">
                    <img src="${env}/client/images/home/products/IPadPro.png" alt="logo">
                </a>
            </div>
            <div class="bigBanner__item--details ">
                <div class="bigBanner__item--name">Ipad Pro</div>
                <div class="bigBanner__item--describe mt-3 mb-3">iPad sở hữu màn hình Retina 10.2 inch tuyệt đẹp, hiệu năng ấn tượng, hỗ trợ đa nhiệm và cực kỳ dễ sử dụng.</div>
                <button type="button" class="btn btn-outline-secondary bigBanner__item--btn">Mua ngay</button>
            </div>
        </div>
        <!-- end -->
        <!-- start -->
        <div class="bigBanner__item" id="banner3">
            <div class="bigBanner__item--img">
                <a href="#">
                    <img src="${env}/client/images/home/products/SSGalaxy.png" alt="logo">
                </a>
            </div>
            <div class="bigBanner__item--details ">
                <div class="bigBanner__item--name">Samsung Galaxy </div>
                <div class="bigBanner__item--describe mt-3 mb-3">iPad sở hữu màn hình Retina 10.2 inch tuyệt đẹp, hiệu năng ấn tượng, hỗ trợ đa nhiệm và cực kỳ dễ sử dụng.</div>
                <button type="button" class="btn btn-outline-secondary bigBanner__item--btn">Mua ngay</button>
            </div>
        </div>
        <!-- end -->
        <!-- start -->
        <div class="bigBanner__item" id="banner4">
            <div class="bigBanner__item--img">
                <a href="#">
                    <img src="${env}/client/images/home/products/Macbook .png" alt="logo">
                </a>
            </div>
            <div class="bigBanner__item--details ">
                <div class="bigBanner__item--name">Macbook Pro</div>
                <div class="bigBanner__item--describe mt-3 mb-3">iPad sở hữu màn hình Retina 10.2 inch tuyệt đẹp, hiệu năng ấn tượng, hỗ trợ đa nhiệm và cực kỳ dễ sử dụng.</div>
                <button type="button" class="btn btn-outline-secondary bigBanner__item--btn">Mua ngay</button>
            </div>
        </div>
        <!-- end -->

    </div>

    <div class="container">
        <div class="discounts">
            <div class="discounts__title">Ưu đãi lên đến 50%</div>
            <div class="discounts__products ">
                <div class="row g-4">
                    <div class="col-lg-12">
                        <div class="row g-4">
                            <c:forEach var="productDis" items="${productDiss}">
                                <!-- start -->
                                <div class="col-md-6 col-lg-4 col-xl-3 product__item m-2">
                                    <div class="product__item--box">
                                        <div class="box__header d-flex justify-content-end">
                                            <button type="button"
                                                    class="border-0 bg-transparent heart__item"
                                                    data-id="${productDis.id}">
                                                <c:choose>
                                                    <c:when test="${fn:contains(wishlistId, productDis.id)}">
                                                        <img src="${env}/client/images/home/Icon/heart-solid-full.png" alt="logo">
                                                    </c:when>
                                                    <c:otherwise>
                                                        <img src="${env}/client/images/home/Icon/heart.png" alt="logo">
                                                    </c:otherwise>
                                                </c:choose>

                                            </button>
                                        </div>
                                        <div class="box__img">
                                            <a href="/client/productdetails/${productDis.id}">
                                                <img src="${env}/admin/images/product/${productDis.avatar}" alt="logo">
                                            </a>
                                        </div>
                                        <div class="box__details d-flex flex-column justify-content-between align-items-center">
                                            <div class="box__details--name text-center">${productDis.name}</div>
                                            <div class="box__details--price mt-3 mb-4">
                                                $<fmt:formatNumber type="number" value="${productDis.price}" />
                                            </div>
                                            <form action="/client/productdetails/${productDis.id}" method="GET">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                                <button type="submit" class="btn btn-dark box__details--btn">Mua ngay</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                                <!-- end -->
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="bigBanner2">
        <div class="bigBanner2__item">
            <a href="#">
                <img src="${env}/client/images/home/banner/Big_Banner.png" alt="logo">
            </a>
        </div>
    </div>
</main>
<!-- Nút chat -->
<button class="chat-toggle" onclick="toggleChat()">
    <i class="fa-regular fa-comment-dots fa-bounce" style="color: #fff;"></i>
</button>

<input type="hidden" id="username" value="${empty sessionScope.username ? '' : sessionScope.username}" />

<!-- Khung chat (giữ như bạn có) -->
<div id="chat-box" style="display:none; flex-direction:column;">
    <div id="chat-header">
        Hỗ trợ trực tuyến
        <button onclick="toggleChat()">✖</button>
    </div>
    <div id="chat-messages" style="flex:1; overflow-y:auto; padding:10px;"></div>
    <form id="messageForm" name="messageForm" onsubmit="sendMsg(event)">
        <div id="chat-input" style="display:flex;">
            <input type="text" id="msg" placeholder="Nhập tin nhắn..." style="flex:1;"/>
            <button type="submit">Gửi</button>
        </div>
    </form>
</div>

<!-- Nút Scroll to Top -->
<button id="scrollTopBtn" title="Go to top">↑</button>
<!--Footer-->
<jsp:include page="/WEB-INF/view/client/layout/footer.jsp"></jsp:include>

<!--js-->
<jsp:include page="/WEB-INF/view/client/layout/js.jsp"></jsp:include>
<script src="${env}/client/js/common.js"></script>
<script src="${env}/client/js/home.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>
<script>
    // GLOBAL
    var stompClient = null;
    var username = '';

    // Lấy giá trị lúc load (an toàn)
    window.onload = function () {
        // 1) đọc từ hidden input (render từ server nếu có)
        var el = document.getElementById('username');
        if (el && el.value && el.value.trim() !== '') {
            username = el.value.trim();
        }

        // 2) nếu không có, thử lấy từ userPrincipal (Spring Security) - server-side evaluated
        if (!username) {
            var principalFromServer = "${pageContext.request.userPrincipal != null ? pageContext.request.userPrincipal.name : ''}";
            if (principalFromServer && principalFromServer !== '') {
                username = principalFromServer;
            }
        }

        // 3) fallback để test (Guest)
        if (!username) {
            username = 'Guest' + Math.floor(Math.random() * 10000);
            console.warn('No username from server. Using fallback:', username);
        }

        console.log('Final username ->', username);

        // Bắt đầu connect
        connect();
    };

    function toggleChat() {
        let chatBox = document.getElementById("chat-box");
        chatBox.style.display = (chatBox.style.display === "none" || chatBox.style.display === "") ? "flex" : "none";
    }

    function connect() {
        if (!username) {
            console.error('Không có username, không connect WebSocket');
            return;
        }

        // Dùng contextPath để chắc chắn đường dẫn đúng khi deploy có context
        var sockJsUrl = '${pageContext.request.contextPath}/chat';
        console.log('Connecting SockJS to', sockJsUrl);

        var socket = new SockJS(sockJsUrl);
        stompClient = Stomp.over(socket);

        stompClient.connect({}, function(frame) {
            console.log('✅ STOMP connected: ', frame);
            onConnected();
        }, function(error) {
            console.error('❌ STOMP connect error:', error);
        });
    }

    function onConnected() {
        stompClient.subscribe('/topic/public', onMessageReceived);

        // thông báo JOIN
        stompClient.send("/app/chat.addUser", {}, JSON.stringify({
            sender: username,
            type: 'JOIN'
        }));
    }

    function onMessageReceived(payload) {
        try {
            var message = JSON.parse(payload.body);
            var messageArea = document.getElementById("chat-messages");
            var div = document.createElement("div");

            if (message.type === 'JOIN') {
                div.textContent = message.sender + " đã tham gia phòng chat.";
                div.style.color = "green";
            } else if (message.type === 'LEAVE') {
                div.textContent = message.sender + " đã rời phòng.";
                div.style.color = "red";
            } else {
                div.textContent = message.sender + ": " + message.content;
            }

            messageArea.appendChild(div);
            messageArea.scrollTop = messageArea.scrollHeight;
        } catch (e) {
            console.error('Không parse được payload:', payload, e);
        }
    }

    function sendMsg(event) {
        event.preventDefault();
        var messageInput = document.getElementById("msg");
        var messageContent = messageInput.value.trim();

        if (messageContent && stompClient && stompClient.connected) {
            var chatMessage = {
                sender: username,
                content: messageContent,
                type: 'CHAT'
            };
            stompClient.send("/app/chat.sendMessage", {}, JSON.stringify(chatMessage));
            messageInput.value = '';
        } else {
            console.warn("WebSocket chưa kết nối hoặc message rỗng. connected=", stompClient ? stompClient.connected : stompClient);
        }
    }
</script>
</body>
</html>