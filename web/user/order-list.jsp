<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>My Orders</title>
        <%@include file="../head.jspf"%>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="orders"/>
        <%@include file="../navbar.jspf"%>
        <div class="container-fluid py-3 px-4">

            <!-- Header -->
            <div class="d-flex align-items-center gap-3 mb-4">

                <img src="${pageContext.request.contextPath}/images/icons/order-icon.png"
                     width="55" height="55">

                <div>
                    <h2 class="mb-0">My Orders</h2>
                    <small class="text-light">
                        ${orders.size()} orders found
                    </small>
                </div>

            </div>
                    
            <!-- No Orders -->
            <c:if test="${empty orders}">
                <div class="text-center py-5">
                    <h4 class="text-white">You have no orders yet</h4>

                    <p class="text-white">
                        Browse products and place your first order.
                    </p>

                    <a class="btn btn-primary"
                       href="${pageContext.request.contextPath}/product?action=list">
                        Start Shopping
                    </a>
                </div>
            </c:if>

            <!-- Orders Table -->
            <c:if test="${not empty orders}">
                <div class="table-responsive">
                    <table class="table table-dark table-bordered align-middle">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th width="200">Date</th>
                                <th width="150">Status</th>
                                <th width="180">Total</th>
                                <th width="150">Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="order" items="${orders}">
                                <tr>
                                    <!-- Order ID -->
                                    <td class="fw-bold">
                                        ${order.orderId}
                                    </td>

                                    <!-- Date -->
                                    <td>
                                        <fmt:formatDate value="${order.orderDate}" 
                                                        pattern="dd/MM/yyyy HH:mm"/>
                                    </td>

                                    <!-- Status -->
                                    <td>
                                        <c:choose>
                                            <c:when test="${order.orderStatus == 0}">
                                                <span class="badge bg-warning text-dark">
                                                    Pending
                                                </span>
                                            </c:when>

                                            <c:when test="${order.orderStatus == 1}">
                                                <span class="badge bg-info">
                                                    Processing
                                                </span>
                                            </c:when>

                                            <c:when test="${order.orderStatus == 2}">
                                                <span class="badge bg-success">
                                                    Completed
                                                </span>
                                            </c:when>

                                            <c:otherwise>
                                                <span class="badge bg-secondary">
                                                    Unknown
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>

                                    <!-- Total -->
                                    <td class="text-success fw-bold">
                                        <fmt:formatNumber value="${order.totalValue}" type="number"/> VND
                                    </td>

                                    <!-- Action -->
                                    <td>

                                        <a class="btn btn-outline-light btn-sm"
                                           href="${pageContext.request.contextPath}/user/order?action=detail&orderId=${order.orderId}">
                                            View Details
                                        </a>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </body>
</html>