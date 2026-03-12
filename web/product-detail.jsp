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
        <%@include file="../../navbar.jspf"%>
        <div class="container-fluid row">
            <div class="col py-5 px-5">
                <div class="card bg-dark text-light shadow-lg">
                    <div class="row g-0 mb-3 p-4">

                        <div class="col-md-3 text-center">
                            <img src="${pageContext.request.contextPath}${product.productImage}"
                                 class="img-fluid rounded"
                                 alt="${product.productName}">
                        </div>

                        <div class="col-md-9">
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
                                    <a onclick="history.back()"
                                       class="btn btn-outline-light">
                                        ← Back
                                    </a>
                                    <form method="post" action="${pageContext.request.contextPath}/user/cart?action=add"
                                          class="">
                                        <input type="hidden" name="productId" value="${product.productId}">
                                        <input type="hidden" name="redirect" value="detail">
                                        <button type="submit" class="btn btn-success">
                                            Add to Cart
                                        </button>
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
