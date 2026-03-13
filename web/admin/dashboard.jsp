<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Admin Dashboard</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css"/>

        <%@include file="../../head.jspf"%>
    </head>

    <body class="darkmode">
        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="dashboard"/>
        <div class="container-fluid">
            <%@include file="sidebar.jspf"%>
            <div class="admin-content">
                <div class="admin-card mb-4">
                    <div class="admin-header">
                        <h2>Dashboard</h2>
                        <p class="text-white">Store analytics overview</p>
                    </div>
                </div>

                <div class="row g-4 mb-4">
                    <div class="col-md-3">
                        <div class="admin-metric-card">
                            <div class="metric-label">Total Orders</div>
                            <div class="metric-value fw-bold">${totalOrders}</div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="admin-metric-card">
                            <div class="metric-label">Total Revenue</div>
                            <div class="metric-value text-success fw-bold">
                                <fmt:formatNumber value="${totalRevenue}" type="number"/> VND
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="admin-metric-card">
                            <div class="metric-label">Orders Today</div>
                            <div class="metric-value fw-bold">${ordersToday}</div>
                        </div>
                    </div>

                    <div class="col-md-3">
                        <div class="admin-metric-card">
                            <div class="metric-label">Online Staff</div>
                            <div class="metric-value fw-bold">${onlineStaffCount}</div>
                        </div>
                    </div>
                </div>

                <div class="admin-card mb-4">
                    <div class="admin-header">
                        <h5>Recent Orders</h5>
                    </div>
                    <div class="table-responsive orders-table">
                        <table class="table table-dark table-borderless align-middle mb-0">
                            <thead>
                                <tr>
                                    <th>Order ID</th>
                                    <th width="260">Customer</th>
                                    <th width="260">Date</th>
                                    <th width="200">Status</th>
                                    <th width="220">Total</th>
                                    <th width="200">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="order" items="${recentOrders}">
                                    <tr>
                                        <td class="order-id">
                                            #${order.orderId}
                                        </td>
                                        <td>
                                            ${order.customerName}
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
                <div class="row g-4">
                    <div class="col-lg-6">
                        <div class="admin-card">
                            <div class="admin-header">
                                <h5>Top Viewed Products</h5>
                            </div>
                            <c:choose>
                                <c:when test="${not empty topViewedProducts}">
                                    <c:forEach var="item" items="${topViewedProducts}" varStatus="loop">
                                        <c:set var="p" value="${item[0]}"/>
                                        <c:set var="views" value="${item[1]}"/>
                                        <div class="product-analytics large">
                                            <div class="rank">
                                                #${loop.index + 1}
                                            </div>
                                            <img class="product-thumb-large"
                                                 src="${pageContext.request.contextPath}${p.productImage}">
                                            <div class="product-info">
                                                <div class="product-name">
                                                    ${p.productName}
                                                </div>
                                                <div class="product-metric fw-bold text-success">
                                                    ${views} views
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center text-secondary">
                                        No data available
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>

                    <div class="col-lg-6">
                        <div class="admin-card">
                            <div class="admin-header">
                                <h5>Top Selling Products</h5>
                            </div>
                            <c:choose>
                                <c:when test="${not empty topSellingProducts}">
                                    <c:forEach var="item" items="${topSellingProducts}" varStatus="loop">
                                        <c:set var="p" value="${item[0]}"/>
                                        <c:set var="revenue" value="${item[1]}"/>
                                        <div class="product-analytics large">
                                            <div class="rank">
                                                #${loop.index + 1}
                                            </div>
                                            <img class="product-thumb-large"
                                                 src="${pageContext.request.contextPath}${p.productImage}">
                                            <div class="product-info">
                                                <div class="product-name">
                                                    ${p.productName}
                                                </div>
                                                <div class="product-metric fw-bold">
                                                    Total Revenue: <span class="text-danger">
                                                        <fmt:formatNumber value="${revenue}" type="number"/> VND 
                                                    </span>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <div class="text-center text-secondary">
                                        No data available
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>