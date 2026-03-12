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
        <div class="container-fluid row">
            <div class="col py-5 px-5">
                <div class="card bg-dark text-light shadow-lg">
                    <div class="row g-4 p-4">

                        <!-- Product Image -->
                        <div class="col-md-2 text-center">

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

                            <p class="text-white">
                                ${product.brief}
                            </p>

                            <!-- Category -->
                            <p class="mb-2">
                                <strong>Category:</strong> ${product.type.categoryName}
                            </p>

                            <!-- Unit -->
                            <p class="mb-3">
                                <strong>Unit:</strong> ${product.unit}
                            </p>

                            <!-- Price -->
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

                            <!-- Posted date -->
                            <p class="text-secondary small">
                                Posted
                            <fmt:formatDate value="${product.postedDate}" pattern="dd MMM yyyy"/>
                            </p>
                            <hr class="border-secondary">
                            <!-- Buttons -->
                            <div class="d-flex gap-3 mt-3">
                                <a onclick="history.back()"
                                   class="btn btn-outline-light">
                                    ← Back
                                </a>

                                <form method="post"
                                      action="${pageContext.request.contextPath}/user/cart?action=add">

                                    <input type="hidden" name="productId" value="${product.productId}">
                                    <input type="hidden" name="redirect" value="detail">

                                    <button class="btn btn-success">
                                        Add to Cart
                                    </button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
