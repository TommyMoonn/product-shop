<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Shopping Cart</title>

        <!-- SAME CSS AS ORDERS -->
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css"/>

        <%@include file="../head.jspf"%>
    </head>

    <body class="darkmode">

        <c:set var="activePage" value="cart"/>
        <%@include file="../navbar.jspf"%>

        <div class="container-fluid py-3 px-4">
            <!-- HEADER -->
            <div class="page-header d-flex align-items-center gap-3 mb-3">
                <img src="${pageContext.request.contextPath}/images/icons/cart-icon.png"
                     width="55" height="55">
                <div>
                    <h2 class="mb-0">Shopping Cart</h2>

                    <small class="text-secondary">
                        ${requestScope.cartItems.size()} items in your cart
                    </small>
                </div>

            </div>
            <!-- EMPTY CART -->
            <c:if test="${empty requestScope.cartItems}">
                <div class="text-center empty-state">
                    <img src="${pageContext.request.contextPath}/images/icons/empty-cart.png"
                         width="110" class="mb-3">
                    <h4 class="text-light">Your cart is empty</h4>
                    <p class="text-secondary">
                        Looks like you haven't added any products yet.
                    </p>
                    <a class="btn btn-primary mt-2"
                       href="${pageContext.request.contextPath}/product?action=list">
                        Start Shopping
                    </a>
                </div>
            </c:if>
            <!-- CART TABLE -->
            <c:if test="${not empty requestScope.cartItems}">
                <div class="page-card">
                    <div class="table-responsive orders-table">
                        <table class="table table-dark table-borderless align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th width="180">Price</th>
                                    <th width="140">Discount</th>
                                    <th width="170">Quantity</th>
                                    <th width="200">Subtotal</th>
                                    <th width="150">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:set var="total" value="0"/>
                                <c:forEach var="item" items="${requestScope.cartItems}">
                                    <c:set var="price" value="${item.product.price}" />
                                    <c:set var="discount" value="${item.product.discount}" />
                                    <c:set var="finalPrice" value="${price - (price * discount / 100)}" />
                                    <c:set var="subtotal" value="${finalPrice * item.quantity}" />
                                    <c:set var="total" value="${total + subtotal}" />
                                    <tr>
                                        <td>
                                            <div class="d-flex align-items-center gap-3">
                                                <img src="${pageContext.request.contextPath}${item.product.productImage}"
                                                     width="65" height="65"
                                                     style="object-fit:cover;border-radius:8px;">
                                                <div>
                                                    <div class="fw-bold">
                                                        ${item.product.productName}
                                                    </div>
                                                    <small class="text-secondary">
                                                        ${item.product.type.categoryName}
                                                    </small>
                                                </div>
                                            </div>
                                        </td>
                                        <td>
                                            <fmt:formatNumber value="${price}" type="number"/> VND
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${discount > 0}">
                                                    <span class="badge bg-danger">
                                                        -${discount}%
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-secondary">
                                                        -0%
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/user/cart?action=update"
                                                  class="d-flex gap-2">
                                                <input type="hidden"
                                                       name="productId"
                                                       value="${item.product.productId}">
                                                <div data-bs-theme="dark">
                                                    <input type="number"
                                                           name="quantity"
                                                           value="${item.quantity}"
                                                           min="1"
                                                           class="form-control"
                                                           style="width:70px;">
                                                </div>
                                                <button class="btn btn-outline-light btn-sm">
                                                    Update
                                                </button>
                                            </form>
                                        </td>
                                        <td class="order-total">
                                            <fmt:formatNumber value="${subtotal}" type="number"/> VND
                                        </td>
                                        <td>
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/user/cart?action=remove">
                                                <input type="hidden"
                                                       name="productId"
                                                       value="${item.product.productId}">
                                                <button class="btn btn-danger btn-sm"
                                                        onclick="return confirm('Remove this item?');">
                                                    Remove
                                                </button>
                                            </form>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <!-- SUMMARY -->
                    <div class="d-flex justify-content-between align-items-center mt-4">
                        <a href="${pageContext.request.contextPath}/product?action=list"
                           class="btn btn-outline-light">
                            Continue Shopping
                        </a>
                        <div class="d-flex align-items-center gap-3">
                            <h5 class="order-total mt-2">
                                Total:
                                <fmt:formatNumber value="${total}" type="number"/> VND
                            </h5>
                            <form method="post"
                                  action="${pageContext.request.contextPath}/user/cart?action=clear">
                                <button class="btn btn-outline-danger"
                                        onclick="return confirm('Clear your cart?');">
                                    Clear Cart
                                </button>
                            </form>
                            <form method="get"
                                  action="${pageContext.request.contextPath}/user/order">
                                <input type="hidden" name="action" value="checkout">
                                <button class="btn btn-success">
                                    Checkout
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </c:if>
        </div>
    </body>
</html>