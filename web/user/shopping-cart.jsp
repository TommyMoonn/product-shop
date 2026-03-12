<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Shopping Cart</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/cart.css"/>
        <%@include file="../head.jspf"%>
    </head>

    <body class="darkmode">

        <c:set var="activePage" value="cart"/>
        <%@include file="../navbar.jspf"%>
        <div class="container-fluid py-3 px-4">
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    ${sessionScope.success}
                    <button type="button"
                            class="btn-close"
                            data-bs-dismiss="alert"
                            aria-label="Close"></button>
                </div>
                <c:remove var="success" scope="session"/>
            </c:if>
            <!-- Header -->
            <div class="d-flex align-items-center gap-2 mb-4">
                <img src="${pageContext.request.contextPath}/images/icons/cart-icon.png"
                     width="60" height="60">
                <div>
                    <h2 class="mb-0">Shopping Cart</h2>
                    <small class="text-light">
                        ${requestScope.cartItems.size()} items in your cart
                    </small>
                </div>
            </div>

            <!-- Empty Cart -->
            <c:if test="${empty requestScope.cartItems}">
                <div class="text-center py-5">
                    <img src="${pageContext.request.contextPath}/images/icons/empty-cart-icon.png"
                         width="90"
                         class="mb-3">
                    <h4>Your cart is empty</h4>
                    <p class="text-secondary">
                        Looks like you haven't added anything yet.
                    </p>
                    <a class="btn btn-primary mt-2"
                       href="${pageContext.request.contextPath}/product">
                        Start Shopping
                    </a>
                </div>
            </c:if>

            <div data-bs-theme="dark">
                <!-- Cart Table -->
                <c:if test="${not empty requestScope.cartItems}">
                    <div class="table-responsive">
                        <table class="table table-dark table-bordered align-middle">
                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th width="170">Price</th>
                                    <th width="120">Discount</th>
                                    <th width="140">Quantity</th>
                                    <th width="150">Subtotal</th>
                                    <th width="120">Action</th>
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

                                        <!-- Product Info -->
                                        <td>
                                            <div class="d-flex align-items-center gap-3">
                                                <a href="${pageContext.request.contextPath}/product?action=detail&productId=${item.product.productId}">
                                                    <img src="${pageContext.request.contextPath}${item.product.productImage}"
                                                         class="cart-product-img">
                                                </a>
                                                <div>
                                                    <div class="fw-bold">
                                                        <a class="product-link text-white"
                                                           href="${pageContext.request.contextPath}/product?action=detail&productId=${item.product.productId}">
                                                            ${item.product.productName}
                                                        </a>
                                                    </div>
                                                    <small class="text-secondary">
                                                        ${item.product.type.categoryName}
                                                    </small>
                                                </div>
                                            </div>
                                        </td>

                                        <!-- Price -->
                                        <td class="fw-bold">
                                            <fmt:formatNumber value="${price}" type="number"/> VND
                                        </td>

                                        <!-- Discount -->
                                        <td class="text-center">
                                            <c:if test="${discount > 0}">
                                                <span class="badge bg-danger">
                                                    -${discount}%
                                                </span>
                                            </c:if>
                                            <c:if test="${discount == 0}">
                                                <span class="badge bg-secondary">
                                                    -0%
                                                </span>
                                            </c:if>
                                        </td>

                                        <!-- Quantity -->
                                        <td>
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/user/cart?action=update"
                                                  class="d-flex">
                                                <input type="hidden" name="productId" value="${item.product.productId}">
                                                <input type="number"
                                                       name="quantity"
                                                       value="${item.quantity}"
                                                       min="1"
                                                       class="form-control form-control-sm cart-qty me-2">

                                                <button class="btn btn-outline-light btn-sm btn-update">
                                                    Update
                                                </button>
                                            </form>
                                        </td>

                                        <!-- Subtotal -->
                                        <td class="cart-subtotal">
                                            <fmt:formatNumber value="${subtotal}" type="number"/> VND
                                        </td>

                                        <!-- Remove -->
                                        <td>
                                            <form method="post" class="d-flex justify-content-center"
                                                  action="${pageContext.request.contextPath}/user/cart?action=remove">
                                                <input type="hidden" name="productId"
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

                    <!-- Cart Summary -->
                    <div class="row mt-4">
                        <div class="col-md-6">
                            <a href="${pageContext.request.contextPath}/product?action=list"
                               class="btn btn-outline-light">
                                Continue Shopping
                            </a>
                        </div>
                        <div class="col-md-6 d-flex justify-content-end">
                            <div class="cart-total-box text-end">
                                <h4 class="mb-3">
                                    Total:
                                    <span class="text-success">
                                        <fmt:formatNumber value="${total}" type="number"/> VND
                                    </span>
                                </h4>
                                <div class="d-flex gap-2 justify-content-end">
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/user/cart?action=clear">

                                        <button class="btn btn-outline-danger"
                                                onclick="return confirm('Are you sure you want to clear the cart?');">
                                            Clear Cart
                                        </button>
                                    </form>
                                    <form method="get"
                                          action="${pageContext.request.contextPath}/user/order">
                                        <input type="hidden" name="action" value="checkout">

                                        <button class="btn btn-success btn-checkout">
                                            Checkout
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </body>
</html>