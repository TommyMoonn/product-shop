<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

        <div class="container-fluid py-5">

            <h1 class="text-center mb-4">
                Product Store
                <img src="${pageContext.request.contextPath}/images/icons/product-icon.png"
                     width="40" height="40" class="mb-1"/>
            </h1>

            <!-- Category Filter -->
            <div data-bs-theme="dark">
                <form action="${pageContext.request.contextPath}/product" method="get"
                      class="d-flex align-items-center gap-2 mb-4">

                    <input type="hidden" name="action" value="list">

                    <select name="typeId" class="form-select w-auto">
                        <option value="">All categories</option>

                        <c:forEach var="c" items="${requestScope.categories}">
                            <option value="${c.typeId}"
                                    <c:if test="${param.typeId == c.typeId}">
                                        selected
                                    </c:if>>
                                ${c.categoryName}
                            </option>
                        </c:forEach>
                    </select>

                    <button class="btn btn-primary">
                        Filter
                    </button>

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
                                 style="height:220px; object-fit:cover;">
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
                                    $${p.price}
                                </p>
                                <!-- Discount -->
                                <c:if test="${p.discount > 0}">
                                    <span class="badge bg-danger mb-2 mt-2">
                                        -${p.discount}%
                                    </span>
                                </c:if>
                                <!-- Button -->
                                <div class="mt-auto d-flex align-items-center gap-2">
                                    <a class="btn btn-outline-light w-50"
                                       href="${pageContext.request.contextPath}/product?action=detail&productId=${p.productId}">
                                        View Details
                                    </a>
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