<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${product.productName}</title>
        <%@include file="../../head.jspf"%>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin-detail.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
    </head>

    <body class="darkmode">

        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="products"/>

        <div class="container-fluid">

            <%@include file="../sidebar.jspf"%>

            <div class="admin-content">

                <div class="product-detail-wrapper">

                    <div class="product-detail-card">
                        <!-- LEFT IMAGE -->
                        <div class="product-image-section">
                            <img src="${pageContext.request.contextPath}${product.productImage}"
                                 alt="${product.productName}">
                        </div>

                        <!-- RIGHT CONTENT -->
                        <div class="product-info-section">

                            <h3 class="product-name">
                                ${product.productName}
                                <span class="product-id">#${product.productId}</span>
                            </h3>

                            <p class="product-description">
                                ${product.brief}
                            </p>

                            <div class="product-meta">

                                <div class="meta-row">
                                    <span>Posted</span>
                                    <span>${product.postedDate}</span>
                                </div>

                                <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem == 1}">
                                    <div class="meta-row">
                                        <span>Posted by</span>
                                        <span>
                                            ${product.account.account}
                                            -
                                            ${product.account.lastName}
                                            ${product.account.firstName}
                                        </span>
                                    </div>
                                </c:if>

                                <div class="meta-row">
                                    <span>Category</span>
                                    <span>${product.type.categoryName}</span>
                                </div>

                                <div class="meta-row">
                                    <span>Unit</span>
                                    <span>${product.unit}</span>
                                </div>

                                <div class="meta-row price">
                                    <span>Price</span>
                                    <span>$${product.price}</span>
                                </div>

                                <div class="meta-row">
                                    <span>Discount</span>
                                    <span class="discount">${product.discount}%</span>
                                </div>

                            </div>

                            <!-- ACTIONS -->
                            <div class="product-actions">

                                <a href="${pageContext.request.contextPath}/admin/product?action=list"
                                   class="btn btn-outline-light">
                                    ← Back
                                </a>

                                <a href="${pageContext.request.contextPath}/admin/product?action=update&productId=${product.productId}"
                                   class="btn btn-primary">
                                    Update
                                </a>

                                <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem == 1}">
                                    <form action="${pageContext.request.contextPath}/admin/product?action=delete&productId=${product.productId}"
                                          method="post">

                                        <button class="btn btn-danger"
                                                onclick="return confirm('Delete this product?')">
                                            Delete
                                        </button>

                                    </form>
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