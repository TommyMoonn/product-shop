<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>${product.productName}</title>
        <%@include file="../../head.jspf"%>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="store" />
        <%@include file="../../navbar.jspf"%>
        <div class="container-fluid row">
            <div class="col py-5">
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

                                <!--Back to home --->
                                <div class="d-flex gap-2 mt-3">
                                    <a href="${pageContext.request.contextPath}/product?action=list"
                                       class="btn btn-outline-light">
                                        ← Back to Store
                                    </a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
