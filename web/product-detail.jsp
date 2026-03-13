<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>

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
        <div class="container py-5">
            <!-- PRODUCT DETAIL -->
            <div class="card bg-dark text-light shadow-lg p-4">
                <div class="row g-4 align-items-center">
                    <!-- Product Image -->
                    <div class="col-md-4 text-center">
                        <img src="${pageContext.request.contextPath}${product.productImage}"
                             class="img-fluid rounded product-detail-img"
                             alt="${product.productName}">
                    </div>
                    <!-- Product Info -->
                    <div class="col-md-8">
                        <h2 class="mb-2">
                            ${product.productName}
                            <small class="fs-6 text-secondary ms-2">
                                #${product.productId}
                            </small>
                        </h2>
                        <p class="text-light">
                            ${product.brief}
                        </p>
                        <p class="mb-2">
                            <strong>Category:</strong> ${product.type.categoryName}
                        </p>
                        <p class="mb-3">
                            <strong>Unit:</strong> ${product.unit}
                        </p>
                        <!-- PRICE -->
                        <c:choose>
                            <c:when test="${product.discount > 0}">
                                <div class="mb-3">
                                    <span class="price-old">
                                        <fmt:formatNumber value="${product.price}" type="number"/> VND
                                    </span>
                                    <span class="price-new">
                                        <fmt:formatNumber value="${product.price * (100 - product.discount) / 100}" type="number"/> VND
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
                        <!-- Posted -->
                        <p class="text-secondary small">
                            Posted
                            <fmt:formatDate value="${product.postedDate}" pattern="dd MMM yyyy"/>
                        </p>
                        <hr class="border-secondary">
                        <!-- BUTTONS -->
                        <div class="d-flex flex-wrap gap-3 mt-3">
                            <a onclick="history.back()"
                               class="btn btn-outline-light">
                                ← Back
                            </a>
                            <!-- ADD TO CART -->
                            <form method="post"
                                  action="${pageContext.request.contextPath}/user/cart?action=add">
                                <input type="hidden" name="productId" value="${product.productId}">
                                <input type="hidden" name="redirect" value="detail">
                                <button class="btn btn-success">
                                    Add to Cart
                                </button>
                            </form>
                            <!-- BUY NOW -->
                            <form method="get"
                                  action="${pageContext.request.contextPath}/user/order">

                                <input type="hidden" name="action" value="checkout">
                                <input type="hidden" name="buyNow" value="true">
                                <input type="hidden" name="productId" value="${product.productId}">

                                <button class="btn btn-warning">
                                    Buy Now
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <!-- FEATURED PRODUCTS -->
            <div class="card bg-dark text-light shadow-lg mt-5 p-4">
                <h4 class="mb-4">
                    Checkout Similar Products
                </h4>
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