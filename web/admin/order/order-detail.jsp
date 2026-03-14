<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Details</title>

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

                <!-- PAGE TITLE -->
                <div class="admin-card mb-4">
                    <div class="admin-header">
                        <h2>Order #${order.orderId}</h2>
                        <p class="text-white">Order details and purchased products</p>
                    </div>
                </div>


                <!-- ORDER INFORMATION -->
                <div class="admin-card mb-4">

                    <div class="admin-header">
                        <h5>Order Information</h5>
                    </div>

                    <div class="row g-4">

                        <div class="col-md-4">
                            <div class="metric-label">Customer</div>
                            <h5 class="fw-bold">
                                ${order.customerName}
                            </h5>
                        </div>

                        <div class="col-md-4">
                            <div class="metric-label">Order Date</div>
                            <h5 class="fw-bold">
                                <fmt:formatDate value="${order.orderDate}"
                                                pattern="dd MMM yyyy, HH:mm"/>
                            </h5>
                        </div>

                        <div class="col-md-4">
                            <div class="metric-label">Total Amount</div>
                            <h5 class="order-total">
                                <fmt:formatNumber value="${order.totalValue}" type="number"/> VND
                            </h5>
                        </div>

                        <div class="col-md-6">

                            <div class="metric-label mb-2">Order Progress</div>

                            <form class="order-status-steps"
                                  method="post"
                                  action="${pageContext.request.contextPath}/admin/order">

                                <input type="hidden" name="action" value="updateStatus">
                                <input type="hidden" name="orderId" value="${order.orderId}">

                                <button type="submit"
                                        name="status"
                                        value="0"
                                        class="status-step ${order.orderStatus == 0 ? 'active' : ''}">
                                    Pending
                                </button>

                                <span class="status-arrow">→</span>

                                <button type="submit"
                                        name="status"
                                        value="1"
                                        class="status-step ${order.orderStatus == 1 ? 'active' : ''}">
                                    Processing
                                </button>

                                <span class="status-arrow">→</span>

                                <button type="submit"
                                        name="status"
                                        value="2"
                                        class="status-step ${order.orderStatus == 2 ? 'active' : ''}">
                                    Completed
                                </button>

                            </form>

                        </div>    

                    </div>

                </div>


                <!-- ORDER ITEMS -->
                <div class="admin-card mb-4">

                    <div class="admin-header">
                        <h5>Products in this Order</h5>
                    </div>

                    <div class="table-responsive orders-table">

                        <table class="table table-dark table-borderless align-middle mb-0">

                            <thead>
                                <tr>
                                    <th>Product</th>
                                    <th width="180">Price</th>
                                    <th width="150">Quantity</th>
                                    <th width="200">Subtotal</th>
                                </tr>
                            </thead>

                            <tbody>

                                <c:forEach var="item" items="${orderDetails}">

                                    <tr>

                                        <td>
                                            <div class="d-flex align-items-center gap-3">

                                                <img src="${pageContext.request.contextPath}${item.product.productImage}"
                                                     class="product-thumb">

                                                <div>
                                                    <div class="product-name">
                                                        ${item.product.productName}
                                                    </div>
                                                </div>

                                            </div>
                                        </td>

                                        <td>
                                            <fmt:formatNumber value="${item.price}" type="number"/> VND
                                        </td>

                                        <td>
                                            ${item.quantity}
                                        </td>

                                        <td class="order-total">
                                            <fmt:formatNumber value="${item.price * item.quantity}" type="number"/> VND
                                        </td>

                                    </tr>

                                </c:forEach>

                            </tbody>

                        </table>

                    </div>

                </div>


                <!-- BACK BUTTON -->
                <div>
                    <a class="btn btn-outline-light"
                       href="${pageContext.request.contextPath}/admin/order">
                        ← Back
                    </a>
                </div>

            </div>

        </div>

    </body>
</html>