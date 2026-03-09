<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Products</title>
        <%@include file="../head.jspf"%>
    </head>

    <body class="darkmode">

        <c:set var="activePage" value="store"/>
        <%@include file="../navbar.jspf"%>

        <div class="container-fluid py-3 px-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div class="d-flex align-items-center gap-2">

                    <!-- Store Icon -->
                    <img src="${pageContext.request.contextPath}/images/icons/store-icon.png"
                         width="60" height="60">

                    <!-- Title -->
                    <div>
                        <h2 class="mb-0">Product Store</h2>
                        <small class="text-light">
                            Browse our collection
                        </small>
                    </div>

                </div>

                <!--Product number-->
                <div class="text-white">
                    ${requestScope.list.size()} products
                </div>

            </div>

            <div data-bs-theme="dark" class="mb-2">
                <form action="${pageContext.request.contextPath}/product"
                      method="get"
                      class="py-2">
                    <input type="hidden" name="action" value="list">

                    <!-- Search -->
                    <div class="row justify-content-center mb-4">
                        <div class="col-md-6">
                            <div class="input-group input-group-md">
                                <input type="text"
                                       name="keyword"
                                       value="${param.keyword}"
                                       placeholder="Search products..."
                                       class="form-control">

                                <button class="btn btn-primary">
                                    Search
                                </button>
                            </div>
                        </div>
                    </div>

                    <!-- Filters -->
                    <div class="row align-items-end">
                        <div class="col-md-9 mt-4">
                            <div class="row g-3">

                                <!-- Category -->
                                <div class="col-md-3">
                                    <label class="form-label">Category</label>
                                    <select name="typeId" class="form-select">
                                        <option value="">All</option>
                                        <c:forEach var="c" items="${requestScope.categories}">
                                            <option value="${c.typeId}"
                                                    <c:if test="${param.typeId == c.typeId}">selected</c:if>>
                                                ${c.categoryName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>

                                <!-- Price Range -->
                                <div class="col-md-4">
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

                                <!--Sort by Price and Discount-->
                                <div class="col-md-3">

                                    <!--Sort by Price-->
                                    <label class="form-label">Sort</label>
                                    <select name="sortPrice" class="form-select">
                                        <option value="">Default</option>
                                        <option value="asc"
                                                <c:if test="${param.sortPrice == 'asc'}">selected</c:if>>
                                                    Price ↑
                                                </option>
                                                <option value="desc"
                                                <c:if test="${param.sortPrice == 'desc'}">selected</c:if>>
                                                    Price ↓
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
                                </div>
                            </div>

                            <!-- Buttons -->
                            <div class="col-md-3 d-flex justify-content-end gap-2 mt-3">

                                <!--Filter-->
                                <button class="btn btn-primary">
                                    Apply Filters
                                </button>

                                <!--Reset Filter-->
                                <a href="${pageContext.request.contextPath}/product?action=list"
                               class="btn btn-outline-light">
                                Reset
                            </a>
                        </div>
                    </div>
                </form>
            </div>

            <!-- Product Grid -->
            <div class="row g-4">
                <c:forEach var="p" items="${requestScope.list}">
                    <div class="col-md-3">
                        <div class="card h-100 bg-dark text-white border-secondary">

                            <!-- Image -->
                            <img src="${pageContext.request.contextPath}${p.productImage}"
                                 class="card-img-top"
                                 style="height:500px; object-fit:cover;">
                            <div class="card-body d-flex flex-column">

                                <!-- Name -->
                                <h5 class="card-title">
                                    <a class="text-white text-decoration-none"
                                       href="${pageContext.request.contextPath}/product?action=detail&productId=${p.productId}">
                                        ${p.productName}
                                    </a>
                                </h5>

                                <!-- Category -->
                                <p class="text-secondary mb-1">
                                    ${p.type.categoryName}
                                </p>

                                <!-- Price -->
                                <p class="fw-bold mb-1">
                                    <fmt:formatNumber value="${p.price}" type="number"/> VND
                                </p>

                                <!-- Discount -->
                                <c:if test="${p.discount > 0}">
                                    <span class="badge bg-danger mb-2 mt-2">
                                        -${p.discount}%
                                    </span>
                                </c:if>

                                <!-- Button -->
                                <div class="mt-auto d-flex align-items-center gap-2">

                                    <!-- Details -->
                                    <a class="btn btn-outline-light w-50"
                                       href="${pageContext.request.contextPath}/product?action=detail&productId=${p.productId}">
                                        View Details
                                    </a>

                                    <!-- Cart -->
                                    <a class="btn btn-success w-50"
                                       href="#">
                                        Add to Cart
                                    </a>
                                </div>

                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </body>
</html>