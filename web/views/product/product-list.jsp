<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Products</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="products" />
        <%@include file="../navbar.jspf"%>
        <div class="container mt-4">
            <h1 class="text-center">List of Products</h1>
            <div data-bs-theme="dark">
                <form action="${pageContext.request.contextPath}/product" method="get"
                      class="d-flex align-items-center gap-2 mb-3">
                    <input type="hidden" name="action" value="list" />
                    <select 
                        id="typeId"
                        name="typeId"
                        class="form-select form-select-md w-auto">
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

                    <button type="submit" class="btn btn-primary btn-md">
                        Filter
                    </button>
                </form>
            </div>
            <table class="table table-dark table-striped table-bordered mt-3">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Image</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Discount</th>
                            <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem != 3}">
                            <th>Actions</th>
                            </c:if>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="p" items="${requestScope.list}">
                        <tr>
                            <td>
                                <a class='text-white product-link'
                                   href="${pageContext.request.contextPath}/product/detail?productId=${p.productId}">
                                    ${p.productName}
                                </a>
                            </td>
                            <td>
                                <img src="${pageContext.request.contextPath}${p.productImage}" width="80">
                            </td>
                            <td>${p.type.categoryName}</td>
                            <td>${p.price}</td>
                            <td>${p.discount}%</td>
                            <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem != 3}">
                                <td class="align-middle text-center">
                                    <a class="btn btn-success"
                                       href="${pageContext.request.contextPath}/product?action=update&productId=${p.productId}">
                                        Update
                                    </a>
                                    <a class="btn btn-danger"
                                       href="${pageContext.request.contextPath}/product?action=delete&productId=${p.productId}"
                                       onclick="return confirm('Delete this product?')">
                                        Delete
                                    </a>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
