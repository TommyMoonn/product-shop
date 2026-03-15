<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

    <head>
        <meta charset="UTF-8">
        <title>${product.productName}</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/detail.css"/>
        <%@include file="../../head.jspf"%>
    </head>

    <body class="darkmode">

        <%@include file="../../navbar.jspf"%>

        <div class="container py-5 product-page">

            <!-- MAIN PRODUCT CARD -->
            <div class="card bg-dark text-light shadow-lg p-4 mb-4 product-card">

                <div class="row g-4 align-items-center">

                    <!-- IMAGE -->
                    <div class="col-md-4 text-center">
                        <img src="${pageContext.request.contextPath}${product.productImage}"
                             class="img-fluid rounded product-detail-img"
                             alt="${product.productName}">
                    </div>

                    <!-- PRODUCT INFO -->
                    <div class="col-md-8">

                        <h2 class="mb-3">${product.productName}</h2>

                        <p class="text-light">
                            ${product.brief}
                        </p>

                        <!-- PRICE -->
                        <c:choose>

                            <c:when test="${product.discount > 0}">
                                <div class="mb-3">

                                    <span class="price-old">
                                        <fmt:formatNumber value="${product.price}" type="number"/> VND
                                    </span>

                                    <span class="price-new">
                                        <fmt:formatNumber
                                            value="${product.price * (100 - product.discount) / 100}"
                                            type="number"/> VND
                                    </span>

                                    <span class="badge bg-danger discount-badge ms-2">
                                        -${product.discount}%
                                    </span>

                                </div>
                            </c:when>

                            <c:otherwise>
                                <div class="mb-3 price-normal">
                                    <fmt:formatNumber value="${product.price}" type="number"/> VND
                                </div>
                            </c:otherwise>

                        </c:choose>

                        <hr class="border-secondary">
                        <c:if test="${sessionScope.user == null || sessionScope.user.roleInSystem == 0}">
                            <!-- ACTION BUTTONS -->
                            <form method="post">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <input type="hidden" name="redirect" value="detail">    
                                <input type="hidden" name="buyNow" value="true">    
                                <div data-bs-theme="dark">
                                    <div class="quantity-box mb-4">
                                        <label class="form-label text-secondary small">Quantity</label>

                                        <input type="number"
                                               name="quantity"
                                               min="1"
                                               value="1"
                                               class="form-control quantity-input">
                                    </div>
                                </div>

                                <div class="product-actions">

                                    <button formaction="${pageContext.request.contextPath}/user/cart"
                                            formmethod="post"
                                            name="action"
                                            value="add"
                                            class="btn btn-success">
                                        Add to Cart
                                    </button>

                                    <button formaction="${pageContext.request.contextPath}/user/order"
                                            formmethod="get"
                                            name="action"
                                            value="checkout"
                                            class="btn btn-warning">
                                        Buy Now
                                    </button>

                                </div>

                            </form>
                        </c:if>
                        <!-- BACK BUTTON -->
                        <div class="mt-4">
                            <a onclick="history.back()" class="btn btn-outline-light">
                                ← Back
                            </a>
                        </div>

                    </div>

                </div>

            </div>


            <!-- PRODUCT DETAILS -->
            <div class="card bg-dark text-light shadow-lg p-4 mb-5">

                <h4 class="mb-3">Product Information</h4>

                <ul class="list-group list-group-flush">

                    <li class="list-group-item bg-dark text-light border-secondary">
                        <strong>ID:</strong> ${product.productId}
                    </li>

                    <li class="list-group-item bg-dark text-light border-secondary">
                        <strong>Name:</strong> ${product.productName}
                    </li>

                    <li class="list-group-item bg-dark text-light border-secondary">
                        <strong>Category:</strong> ${product.type.categoryName}
                    </li>

                    <li class="list-group-item bg-dark text-light border-secondary">
                        <strong>Unit:</strong> ${product.unit}
                    </li>

                    <li class="list-group-item bg-dark text-light border-secondary">
                        <strong>Posted:</strong>
                        <fmt:formatDate value="${product.postedDate}" pattern="dd MMM yyyy"/>
                    </li>

                </ul>

            </div>


            <!-- SIMILAR PRODUCTS -->
            <div class="card bg-dark text-light shadow-lg p-4">

                <h4 class="mb-4">Checkout Similar Products</h4>

                <div class="featured-scroll">

                    <c:forEach items="${featuredProducts}" var="p">

                        <div class="featured-item">

                            <a class="featured-product-link"
                               href="${pageContext.request.contextPath}/product?action=detail&productId=${p.productId}">

                                <div class="featured-product-card">

                                    <div class="featured-product-image-box">
                                        <img src="${pageContext.request.contextPath}${p.productImage}"
                                             class="featured-product-img"
                                             alt="${p.productName}">
                                    </div>

                                    <div class="mt-2 text-center">
                                        <div class="featured-product-name">
                                            ${p.productName}
                                        </div>
                                    </div>

                                </div>

                            </a>

                        </div>

                    </c:forEach>

                </div>

            </div>

        </div>

    </body>
</html>
