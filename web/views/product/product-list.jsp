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
            <h1>List of Products</h1>

            <table class="table table-dark table-striped table-bordered mt-3">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Image</th>
                        <th>Category</th>
                        <th>Price</th>
                        <th>Discount</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="p" items="${requestScope.list}">
                        <tr>
                            <td>${p.productName}</td>
                            <td>
                                <img src="${pageContext.request.contextPath}${p.productImage}" width="80">
                            </td>
                            <td>${p.type.categoryName}</td>
                            <td>${p.price}</td>
                            <td>${p.discount}%</td>
                            <td class="align-middle text-center">
                                <a class="btn btn-primary"
                                   href="${pageContext.request.contextPath}/product/detail?id=${p.productId}">
                                    Details
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
