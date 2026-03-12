<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Checkout</title>
        <%@ include file="../../head.jspf" %>
    </head>
    <body class="darkmode">
        <%@include file="../navbar.jspf"%>
        <div class="container-fluid row">
            <div data-bs-theme="dark">
                <div class="col py-5">
                    <div class="row d-flex justify-content-center align-items-center h-100">
                        <div class="col-12 col-md-10 col-lg-8 col-xl-7">
                            <div class="card bg-dark text-white" style="border-radius: 1rem;">
                                <div class="card-body p-5 text-start">
                                    <form action="${pageContext.request.contextPath}/user/order?action=checkout" 
                                          method="post" accept-charset="UTF-8">
                                        <h2 class="fw-bold mb-3">Checkout</h2>
                                        <hr>

                                        <!-- Customer Information -->
                                        <h5 class="mb-3">Customer Information</h5>

                                        <!--Full Name-->
                                        <div class="mb-3">
                                            <label class="form-label">Full Name</label>
                                            <input type="text"
                                                   name="customerName"
                                                   required
                                                   maxlength="80"
                                                   class="form-control"
                                                   placeholder="Enter your full name">
                                        </div>

                                        <!--Phone Number-->
                                        <div class="mb-3">
                                            <label class="form-label">Phone Number</label>
                                            <input type="tel"
                                                   name="customerPhone"
                                                   required
                                                   pattern="0[0-9]{9}"
                                                   class="form-control"
                                                   placeholder="Enter phone number">
                                        </div>

                                        <!-- Shipping Address -->
                                        <h5 class="mt-4 mb-3">Shipping Address</h5>

                                        <div class="mb-3">
                                            <label class="form-label">Address</label>
                                            <textarea name="customerAddress"
                                                      required
                                                      rows="3"
                                                      class="form-control"
                                                      placeholder="Enter delivery address"></textarea>
                                        </div>

                                        <!-- Order Summary -->
                                        <h5 class="mt-4 mb-3">Order Summary</h5>

                                        <table class="table table-dark table-striped">
                                            <thead>
                                                <tr>
                                                    <th>Product</th>
                                                    <th width="100">Qty</th>
                                                    <th width="150">Price</th>
                                                </tr>
                                            </thead>
                                            <tbody>

                                                <c:forEach var="item" items="${cart.items}">
                                                    <c:set var="price" value="${item.product.price}" />
                                                    <c:set var="discount" value="${item.product.discount}" />
                                                    <c:set var="finalPrice" value="${price - (price * discount / 100)}" />
                                                    <c:set var="subtotal" value="${finalPrice * item.quantity}" />
                                                    <c:set var="total" value="${total + subtotal}" />
                                                    <tr>
                                                        <td>${item.product.productName}</td>
                                                        <td>${item.quantity}</td>
                                                        <td><fmt:formatNumber value="${subtotal}" type="number"/> VND</td>
                                                    </tr>
                                                </c:forEach>

                                            </tbody>
                                        </table>

                                        <!--Total Price-->
                                        <div class="text-end mb-3">
                                            <h5>Total: <fmt:formatNumber value="${total}" type="number"/> VND</h5>
                                        </div>

                                        <!-- Buttons -->
                                        <div class="d-flex justify-content-between mt-4">
                                            <a href="${pageContext.request.contextPath}/user/cart"
                                               class="btn btn-outline-light">
                                                ← Back to Cart
                                            </a>

                                            <button class="btn btn-success px-4"
                                                    type="submit"
                                                    onclick="return confirm('Confirm checkout?');">
                                                Place Order
                                            </button>
                                        </div>

                                    </form>
                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger mt-3">
                                            <strong>Failed!</strong> ${error}
                                        </div>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
