<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product History</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/shop.css"/>
        <%@include file="../head.jspf"%>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="history"/>
        <%@include file="../navbar.jspf"%>

        <div class="container-fluid py-3 px-4">

            <!--Page title and Clear History button-->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="d-flex align-items-center gap-2">
                    <!-- Store Icon -->
                    <img src="${pageContext.request.contextPath}/images/icons/history-icon.png"
                         width="60" height="60">

                    <!-- Title -->
                    <div>
                        <h2 class="mb-0">Viewing History</h2>
                        <small class="text-light">
                            Browse products you have looked at
                        </small>
                    </div>
                </div>
                <c:if test="${not empty viewedProducts}">
                    <form method="post" action="${pageContext.request.contextPath}/user/history?action=clear">
                        <button type="submit" class="btn btn-danger"
                                onclick="return confirm('Are you sure you want to clear your history?');">
                            Clear History
                        </button>
                    </form>
                </c:if>
            </div>
            <!-- Filters -->
            <c:if test="${not empty viewedProducts}">
                <div data-bs-theme="dark" class="mb-2">
                    <form method="get" action="${pageContext.request.contextPath}/user/history">
                        <div class="filter-card mb-3">
                            <div class="row align-items-end">

                                <!-- Filter by category -->
                                <div class="col-md-2">
                                    <label class="form-label">Category</label>
                                    <select name="typeId" class="form-select">
                                        <option value="">All Categories</option>
                                        <c:forEach var="c" items="${categories}">
                                            <option value="${c.typeId}"
                                                    ${param.typeId == c.typeId ? "selected" : ""}>
                                                ${c.categoryName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Price range -->
                                <div class="col-md-2">
                                    <label class="form-label">Price Range</label>
                                    <div class="d-flex gap-2">
                                        <input type="number"
                                               name="minPrice"
                                               value="${param.minPrice}"
                                               placeholder="Min"
                                               class="form-control">
                                        <input type="number"
                                               name="maxPrice"
                                               value="${param.maxPrice}"
                                               placeholder="Max"
                                               class="form-control">
                                    </div>
                                </div>

                                <!-- Sort -->
                                <div class="col-md-2">
                                    <label class="form-label">Sort</label>
                                    <select name="sort"
                                            class="form-select">
                                        <option value="newest"
                                                ${param.sort == 'newest' ? 'selected' : ''}>
                                            Newest Viewed
                                        </option>
                                        <option value="oldest"
                                                ${param.sort == 'oldest' ? 'selected' : ''}>
                                            Oldest Viewed
                                        </option>
                                        <option value="priceAsc"
                                                ${param.sort == 'priceAsc' ? 'selected' : ''}>
                                            Price: Low → High
                                        </option>
                                        <option value="priceDesc"
                                                ${param.sort == 'priceDesc' ? 'selected' : ''}>
                                            Price: High → Low
                                        </option>

                                    </select>
                                </div>

                                <!-- Discount -->
                                <div class="col-md-2">
                                    <label class="form-label">Discounted</label>
                                    <div class="form-check mt-2">
                                        <input class="form-check-input"
                                               type="checkbox"
                                               name="discounted"
                                               value="true"
                                               id="discounted"
                                               <c:if test="${param.discounted == 'true'}">checked</c:if>>

                                               <label class="form-check-label" for="discounted">
                                                   Yes
                                               </label>
                                        </div>
                                    </div>

                                    <!-- Buttons -->
                                    <div class="col-md-4 d-flex justify-content-end gap-2 mt-3">

                                        <!-- Filter -->
                                        <button class="btn btn-primary">
                                            Apply Filters
                                        </button>

                                        <!-- Reset -->
                                        <a href="${pageContext.request.contextPath}/user/history"
                                       class="btn btn-outline-light">
                                        Reset
                                    </a>
                                </div>
                            </div> 
                    </form>
                </div>
            </div>
        </c:if>
        <!--Empty history-->
        <c:if test="${empty viewedProducts}">
            <div class="text-center py-5">
                <h4 class="text-white">No products viewed yet</h4>
                <p class="text-white">
                    Browse our products and they will appear here.
                </p>

                <a class="btn btn-primary"
                   href="${pageContext.request.contextPath}/product">
                    Browse Products
                </a>
            </div>
        </c:if>

        <!-- Viewed Product Grid -->
        <div class="row g-4">
            <c:forEach var="pv" items="${viewedProducts}">
                <div class="col-md-2">
                    <div class="card product-card h-100 bg-dark text-white border-secondary position-relative">
                        <form method="post"
                              action="${pageContext.request.contextPath}/user/history?action=remove"
                              class="position-absolute top-0 start-0 m-2"
                              onclick="event.stopPropagation();">

                            <input type="hidden" name="viewId" value="${pv.viewId}">

                            <button class="btn btn-sm btn-danger rounded remove-btn"
                                    onclick="return confirm('Remove this item from your history?');">
                                &times;
                            </button>
                        </form>
                        <a href="${pageContext.request.contextPath}/product?action=detail&productId=${pv.product.productId}"
                           class="text-decoration-none text-white">

                            <c:if test="${pv.product.discount > 0}">
                                <span class="badge bg-danger discount-badge">
                                    -${pv.product.discount}%
                                </span>
                            </c:if>

                            <img src="${pageContext.request.contextPath}${pv.product.productImage}"
                                 class="card-img-top product-image">

                            <div class="card-body d-flex flex-column">
                                <h6 class="card-title mb-1">
                                    <a class="text-white text-decoration-none"
                                       href="${pageContext.request.contextPath}/product?action=detail&productId=${pv.product.productId}">
                                        ${pv.product.productName}
                                    </a>
                                </h6>

                                <p class="text-secondary small mb-2">
                                    ${pv.product.type.categoryName}
                                </p>

                                <c:choose>
                                    <c:when test="${pv.product.discount > 0}">
                                        <p class="product-price mb-3">
                                            <span class="text-secondary text-decoration-line-through me-2">
                                                <fmt:formatNumber value="${pv.product.price}" type="number"/> VND
                                            </span>
                                            <span class="fw-bold text-success">
                                                <br><fmt:formatNumber value="${pv.product.price * (100 - pv.product.discount) / 100}" type="number"/> VND
                                            </span>
                                        </p>
                                    </c:when>

                                    <c:otherwise>
                                        <p class="fw-bold product-price mb-3">
                                            <fmt:formatNumber value="${pv.product.price}" type="number"/> VND
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                                <!-- Viewed Date -->
                                <p class="small text-center viewed-date mt-auto mb-0">
                                    Viewed
                                    <fmt:formatDate value="${pv.viewDate}" pattern="dd MMM yyyy - HH:mm"/>
                                </p>
                            </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>