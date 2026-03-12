<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Shopping Cart</title>
        <%@include file="../head.jspf"%>
    </head>

    <body class="darkmode">

        <c:set var="activePage" value="cart"/>
        <%@include file="../navbar.jspf"%>
        <div class="container-fluid py-4">
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
                    <h4 class="text-white">Your cart is currently empty</h4>
                    <p class="text-white">
                        Browse our products and add them to your shopping cart.
                    </p>
                    <a class="btn btn-primary"
                       href="${pageContext.request.contextPath}/product">
                        Continue Shopping
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

                                                <img src="${pageContext.request.contextPath}${item.product.productImage}"
                                                     width="70" height="70"
                                                     style="object-fit:cover">

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
                                        <td>
                                            <fmt:formatNumber value="${price}" type="number"/> VND
                                        </td>

                                        <!-- Discount -->
                                        <td>
                                            <c:if test="${discount > 0}">
                                                <span class="badge bg-danger">
                                                    -${discount}%
                                                </span>
                                            </c:if>

                                            <c:if test="${discount == 0}">
                                                <span class="badge bg-danger">
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
                                                       class="form-control form-control-sm me-2">

                                                <button class="btn btn-outline-light btn-sm">
                                                    Update
                                                </button>
                                            </form>
                                        </td>

                                        <!-- Subtotal -->
                                        <td>
                                            <fmt:formatNumber value="${subtotal}" type="number"/> VND
                                        </td>

                                        <!-- Remove -->
                                        <td>
                                            <form method="post" class="d-flex justify-content-center"
                                                  action="${pageContext.request.contextPath}/user/cart?action=remove">
                                                <input type="hidden" name="productId"
                                                       value="${item.product.productId}">

                                                <button class="btn btn-danger btn-sm">
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

                        <div class="col-md-6 text-end">
                            <h4>
                                Total:
                                <span class="text-success">
                                    <fmt:formatNumber value="${total}" type="number"/> VND
                                </span>
                            </h4>
                            <!-- Clear Cart -->
                            <div class="d-flex justify-content-end gap-2 mt-2">
                                <form method="post"
                                      action="${pageContext.request.contextPath}/user/cart?action=clear">

                                    <button class="btn btn-outline-danger mt-2"
                                            onclick="return confirm('Are you sure you want to clear the cart?');">
                                        Clear Cart
                                    </button>
                                </form>

                                <form method="get"
                                      action="${pageContext.request.contextPath}/user/order">
                                    <input type="hidden" name="action" value="checkout">
                                    <button class="btn btn-success mt-2">
                                        Proceed to Checkout
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </body>
</html>