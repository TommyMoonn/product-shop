<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Orders</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css"/>

        <%@include file="../../head.jspf"%>
    </head>

    <body class="darkmode">

    <c:set var="isAdminPage" value="true"/>
    <c:set var="activePage" value="orders"/>

    <div class="container-fluid">

        <%@include file="../sidebar.jspf"%>

        <div class="admin-content">

            <!-- PAGE HEADER -->
            <div class="admin-card mb-4">
                <div class="admin-header">
                    <h2>Order Management</h2>
                    <p class="text-white">Manage and view all customer orders</p>
                </div>
            </div>
            
            <!-- ORDER METRICS (same as dashboard cards) -->
            <div class="row g-4 mb-4">

                <div class="col-md-3">
                    <div class="admin-metric-card">
                        <div class="metric-label">Total Orders</div>
                        <div class="metric-value fw-bold">
                            ${orderCount}
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="admin-metric-card">
                        <div class="metric-label">Completed Orders</div>
                        <div class="metric-value text-success fw-bold">
                            ${completedOrderCount}
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="admin-metric-card">
                        <div class="metric-label">Processing</div>
                        <div class="metric-value text-info fw-bold">
                            ${processingOrderCount}
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="admin-metric-card">
                        <div class="metric-label">Pending</div>
                        <div class="metric-value text-warning fw-bold">
                            ${pendingOrderCount}
                        </div>
                    </div>
                </div>

            </div>

            <!-- ORDERS TABLE -->
            <div class="admin-card mb-4">

                <div class="admin-header">
                    <h5>All Orders</h5>
                </div>

                <div class="table-responsive orders-table">
                    <div class="d-flex gap-2 mb-3">
                        <a class="btn btn-sm ${param.status == null ? 'btn-primary' : 'btn-outline-light'}"
                           href="${pageContext.request.contextPath}/admin/order?action=list">
                            All
                        </a>

                        <a class="btn btn-sm ${param.status == '0' ? 'btn-warning text-dark' : 'btn-outline-light'}"
                           href="${pageContext.request.contextPath}/admin/order?action=list&status=0">
                            Pending
                        </a>

                        <a class="btn btn-sm ${param.status == '1' ? 'btn-info' : 'btn-outline-light'}"
                           href="${pageContext.request.contextPath}/admin/order?action=list&status=1">
                            Processing
                        </a>

                        <a class="btn btn-sm ${param.status == '2' ? 'btn-success' : 'btn-outline-light'}"
                           href="${pageContext.request.contextPath}/admin/order?action=list&status=2">
                            Completed
                        </a>
                    </div>
                    <table class="table table-dark table-borderless align-middle mb-0">

                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th width="260">Date</th>
                                <th width="200">Status</th>
                                <th width="220">Total</th>
                                <th width="200">Action</th>
                            </tr>
                        </thead>

                        <tbody>

                        <c:if test="${empty orders}">
                            <tr>
                                <td colspan="5" class="text-center text-secondary py-4">
                                    No orders found
                                </td>
                            </tr>
                        </c:if>

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
                                   href="${pageContext.request.contextPath}/admin/order?action=detail&orderId=${order.orderId}">
                                    View Details
                                </a>
                            </td>

                            </tr>

                        </c:forEach>

                        </tbody>

                    </table>

                </div>

            </div>

        </div>

    </div>

</body>
</html>