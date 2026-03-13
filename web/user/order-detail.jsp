<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Detail</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css"/>
        <%@include file="../head.jspf"%>
    </head>

    <body class="darkmode">

        <c:set var="activePage" value="orders"/>
        <%@include file="../navbar.jspf"%>

        <div class="container-fluid py-4 px-4">

            <!-- PAGE HEADER -->
            <div class="page-header d-flex align-items-center gap-3 mb-3">

                <img src="${pageContext.request.contextPath}/images/icons/order-icon.png"
                     width="55" height="55">

                <div>
                    <h2 class="mb-0">
                        Order #${order.orderId}
                    </h2>

                    <small class="text-secondary">
                        <fmt:formatDate value="${order.orderDate}" pattern="dd MMM yyyy, HH:mm"/>
                    </small>
                </div>

            </div>


            <!-- CUSTOMER INFO -->
            <div class="page-card mb-4">

                <h5 class="mb-3">Customer Information</h5>

                <p><strong>Name:</strong> ${order.customerName}</p>
                <p><strong>Phone:</strong> ${order.customerPhone}</p>
                <p><strong>Address:</strong> ${order.customerAddress}</p>

                <p>
                    <strong>Status:</strong>

                    <c:choose>
                        <c:when test="${order.orderStatus == 0}">
                            <span class="badge bg-warning text-dark">Pending</span>
                        </c:when>

                        <c:when test="${order.orderStatus == 1}">
                            <span class="badge bg-info">Confirmed</span>
                        </c:when>

                        <c:when test="${order.orderStatus == 2}">
                            <span class="badge bg-primary">Shipping</span>
                        </c:when>

                        <c:when test="${order.orderStatus == 3}">
                            <span class="badge bg-success">Completed</span>
                        </c:when>

                        <c:otherwise>
                            <span class="badge bg-danger">Cancelled</span>
                        </c:otherwise>
                    </c:choose>

                </p>

            </div>


            <!-- ORDER ITEMS -->
            <div class="page-card">

                <div class="table-responsive orders-table">

                    <table class="table table-dark table-borderless align-middle mb-0">

                        <thead>
                            <tr>
                                <th>Product</th>
                                <th width="150">Price</th>
                                <th width="120">Discount</th>
                                <th width="120">Quantity</th>
                                <th width="160">Subtotal</th>
                            </tr>
                        </thead>

                        <tbody>

                            <c:set var="total" value="0"/>

                            <c:forEach var="d" items="${details}">

                                <c:set var="price" value="${d.price}" />
                                <c:set var="discount" value="${d.discount}" />
                                <c:set var="finalPrice" value="${price - (price * discount / 100)}" />
                                <c:set var="subtotal" value="${finalPrice * d.quantity}" />
                                <c:set var="total" value="${total + subtotal}" />

                                <tr>

                                    <td>
                                        <div class="d-flex align-items-center gap-3">

                                            <img src="${pageContext.request.contextPath}${d.product.productImage}"
                                                 width="70" height="70"
                                                 style="object-fit:cover">

                                            <div>
                                                <div class="fw-bold">
                                                    ${d.product.productName}
                                                </div>

                                                <small class="text-secondary">
                                                    ${d.product.type.categoryName}
                                                </small>
                                            </div>

                                        </div>
                                    </td>

                                    <td>
                                        <fmt:formatNumber value="${price}" type="number"/> VND
                                    </td>

                                    <td>
                                        <span class="badge bg-danger">
                                            -${discount}%
                                        </span>
                                    </td>

                                    <td>
                                        ${d.quantity}
                                    </td>

                                    <td>
                                        <fmt:formatNumber value="${subtotal}" type="number"/> VND
                                    </td>

                                </tr>

                            </c:forEach>

                        </tbody>

                    </table>

                </div>

            </div>


            <!-- ORDER TOTAL -->
            <div class="text-end mt-4">

                <h4>
                    Total:
                    <span class="text-success">
                        <fmt:formatNumber value="${total}" type="number"/> VND
                    </span>
                </h4>

                <a href="${pageContext.request.contextPath}/user/order?action=list"
                   class="btn btn-outline-light mt-2">
                    ← Back to Orders
                </a>

            </div>

        </div>
    </body>
</html>