<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${product.productName}</title>
        <!--CSS-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        <!--JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="products" />
        <%@include file="../navbar.jspf"%>
        <div class="container mt-5">
            <div class="card bg-dark text-light shadow-lg">
                <div class="row g-0 mb-3">

                    <div class="col-md-4 text-center p-4">
                        <img src="${pageContext.request.contextPath}${product.productImage}"
                             class="img-fluid rounded"
                             alt="${product.productName}">
                    </div>

                    <div class="col-md-8">
                        <div class="card-body">

                            <!--Product details-->
                            <h2 class="card-title">
                                ${product.productName}
                                <small class="fs-6 ms-2">
                                    #${product.productId}
                                </small>
                            </h2>
                            <p class="card-text">
                                ${product.brief}
                            </p>

                            <ul class="list-group list-group-flush mb-3">
                                <li class="list-group-item bg-dark text-light">
                                    <strong>Posted:</strong> ${product.postedDate}
                                </li>
                                <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem != 3}">
                                    <li class="list-group-item bg-dark text-light">
                                        <strong>Posted by:</strong> ${product.account.account} - ${product.account.lastName} ${product.account.firstName}
                                    </li>
                                </c:if>
                                <li class="list-group-item bg-dark text-light">
                                    <strong>Category:</strong> ${product.type.categoryName}
                                </li>
                                <li class="list-group-item bg-dark text-light">
                                    <strong>Unit:</strong> ${product.unit}
                                </li>
                                <li class="list-group-item bg-dark text-light">
                                    <strong>Price:</strong> $${product.price}
                                </li>
                                <li class="list-group-item bg-dark text-light">
                                    <strong>Discount:</strong> ${product.discount}%
                                </li>
                            </ul>

                            <!--Action buttons-->
                            <div class="d-flex gap-2 mt-3">
                                <a href="${pageContext.request.contextPath}/product?action=list"
                                   class="btn btn-outline-light">
                                    ← Back to Products
                                </a>
                                <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem != 3}">
                                    <a class="btn btn-primary"
                                       href="${pageContext.request.contextPath}/main?type=product&action=update&productId=${product.productId}">
                                        <img src="${pageContext.request.contextPath}/images/icons/edit-icon.png"
                                             width="20" height="20"/>
                                        Update
                                    </a>

                                    <form action="${pageContext.request.contextPath}/main?type=product&action=delete&productId=${product.productId}"
                                          method="post"
                                          class="d-inline">
                                        <button class="btn btn-danger"
                                                type="submit"
                                                onclick="return confirm('Delete this product?')">
                                            <img src="${pageContext.request.contextPath}/images/icons/delete-icon.png"
                                                 width="20"/>
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
    </body>
</html>
