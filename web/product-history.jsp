<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Product History</title>
        <%@include file="../head.jspf"%>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="history"/>
        <%@include file="../navbar.jspf"%>

        <div class="container-fluid py-3 px-5">

            <!--Page title and Clear History button-->
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h3 class="mb-0 d-flex align-items-center justify-content-center gap-2">
                    <img src="${pageContext.request.contextPath}/images/icons/history-icon.png" width="45" height="45">
                    Your Viewing History
                </h3>

                <c:if test="${not empty viewedProducts}">
                    <form method="post" action="${pageContext.request.contextPath}/user/history?action=clear">
                        <button type="submit" class="btn btn-danger"
                                href="">
                            Clear History
                        </button>
                    </form>
                </c:if>
            </div>
            <!-- Filters -->
            <c:if test="${not empty viewedProducts}">
                <div data-bs-theme="dark" class="mb-2">
                    <form method="get" action="${pageContext.request.contextPath}/user/history">
                        <div class="row mb-4 align-items-end">

                            <!-- Filter by category -->
                            <div class="col-md-2 mt-4">
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
                <c:forEach var="pv" items="${requestScope.viewedProducts}">
                    <div class="col-md-3">
                        <div class="card h-100 bg-dark text-white border-secondary position-relative">

                            <!--Remove view button-->
                            <form method="post" action="${pageContext.request.contextPath}/user/history?action=remove"
                                  class="position-absolute top-0 end-0 m-2">
                                <input type="hidden" name="viewId" value="${pv.viewId}">

                                <button class="btn btn-sm btn-danger rounded"
                                        style="width:30px;height:25px;padding:0;">
                                    X
                                </button>
                            </form>

                            <!-- Image -->
                            <img src="${pageContext.request.contextPath}${pv.product.productImage}"
                                 class="card-img-top"
                                 style="height:500px; object-fit:cover;">

                            <!--Card Body-->
                            <div class="card-body d-flex flex-column">
                                <!-- Name -->
                                <h5 class="card-title">
                                    <a class="text-white text-decoration-none"
                                       href="${pageContext.request.contextPath}/product?action=detail&productId=${p.productId}">
                                        ${pv.product.productName}
                                    </a>
                                </h5>

                                <!-- Category -->
                                <p class="text-secondary mb-1">
                                    ${pv.product.type.categoryName}
                                </p>

                                <!-- Price -->
                                <p class="fw-bold mb-1">
                                    ${pv.product.price} VND
                                </p>

                                <!-- Discount -->
                                <c:if test="${pv.product.discount > 0}">
                                    <span class="badge bg-danger mb-2 mt-2">
                                        -${pv.product.discount}%
                                    </span>
                                </c:if>

                                <!-- Button -->
                                <div class="mt-auto d-flex align-items-center gap-2">
                                    <a class="btn btn-outline-light w-50"
                                       href="${pageContext.request.contextPath}/product?action=detail&productId=${pv.product.productId}">
                                        View Details
                                    </a>
                                    <form method="post" action="${pageContext.request.contextPath}/user/cart?action=add"
                                          class="w-50">
                                        <a class="btn btn-success w-100">
                                            Add to Cart
                                        </a>
                                    </form>
                                </div>

                                <!--Viewed date-->
                                <h5 class="text-white text-center small mt-4">
                                    Viewed <fmt:formatDate value="${pv.viewDate}" pattern="dd MMM yyyy HH:mm"/>
                                </h5>

                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </body>
</html>