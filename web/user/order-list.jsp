<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>My Orders</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/order.css"/>
        <%@include file="../head.jspf"%>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="order"/>
        <%@include file="../navbar.jspf"%>
        <div class="container-fluid py-3 px-4">
            <div class="page-header d-flex align-items-center gap-3 mb-3">

                <img src="${pageContext.request.contextPath}/images/icons/order-icon.png"
                     width="55" height="55">

                <div>
                    <h2 class="mb-0">My Orders</h2>
                    <small class="text-secondary">
                        ${orders.size()} orders found
                    </small>
                </div>

            </div>
            <!-- No Orders -->
            <c:if test="${empty orders}">
                <div class="text-center empty-state">

                    <img src="${pageContext.request.contextPath}/images/icons/empty-cart-icon.png"
                         width="70" height="70" class="mb-3">

                    <h4 class="text-light">You have no orders yet</h4>

                    <p class="text-secondary">
                        Looks like you haven't placed any orders.
                    </p>

                    <a class="btn btn-primary mt-2"
                       href="${pageContext.request.contextPath}/product?action=list">
                        Start Shopping
                    </a>

                </div>
            </c:if>

            <!-- Orders Table -->
            <c:if test="${not empty orders}">
                <div class="page-card">

                    <div class="table-responsive orders-table">
                        <table class="table table-dark table-borderless align-middle mb-0">

                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th width="300">Date</th>
                                    <th width="250">Status</th>
                                    <th width="280">Total</th>
                                    <th width="250">Action</th>
                                </tr>
                            </thead>

                            <tbody>
                                <c:forEach var="order" items="${orders}">
                                    <tr>
                                        <td class="order-id">
                                            #${order.orderId}
                                        </td>
                                        <td>
                                            <fmt:formatDate value="${order.orderDate}"
                                                            pattern="dd MMM yyyy, HH:mm"/>
                                        </td>
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
                                        <td class="order-total">
                                            <fmt:formatNumber value="${order.totalValue}" type="number"/> VND
                                        </td>
                                        <td>
                                            <a class="btn btn-outline-light btn-sm view-btn"
                                               href="${pageContext.request.contextPath}/user/order?action=detail&orderId=${order.orderId}">
                                                View Details
                                            </a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </c:if>
        </div>
    </body>
</html>