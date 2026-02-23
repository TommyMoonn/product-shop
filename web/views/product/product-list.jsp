<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Products</title>
        <!--CSS-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        <!--JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>

    <body class="darkmode">

        <c:set var="activePage" value="products" />
        <%@include file="../navbar.jspf"%>
        <div class="container mt-4">

            <h1 class="text-center"> 
                Product Dashboard
                <img src="${pageContext.request.contextPath}/images/icons/box-icon.png" alt="product"
                     width="40" height="40" class="align-middle"/>
            </h1>
            <c:if test="${not empty error}">
                <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                </div>
            </c:if>
                     
            <div data-bs-theme="dark">
                <form action="${pageContext.request.contextPath}/auth" method="get"
                      class="d-flex align-items-center gap-2 mb-3">
                    <input type="hidden" name="type" value="product">
                    <input type="hidden" name="action" value="list">
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
            <table class="table table-dark table-striped table-bordered table-hover mt-3">
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
                                   href="${pageContext.request.contextPath}/auth?type=product&action=detail&productId=${p.productId}">
                                    ${p.productName}
                                </a>
                            </td>
                            <td class="text-center">
                                <img src="${pageContext.request.contextPath}${p.productImage}"
                                     width="95" height="95"
                                     class="border border-3 border-secondary">
                            </td>
                            <td>${p.type.categoryName}</td>
                            <td>${p.price}</td>
                            <td>${p.discount}%</td>
                            <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem != 3}">
                                <td class="align-middle text-center">
                                    <div class="d-flex flex-column gap-2 justify-content-center">

                                        <!--Update button-->
                                        <a class="btn btn-primary"
                                           href="${pageContext.request.contextPath}/auth?type=product&action=update&productId=${p.productId}">
                                            <img src="${pageContext.request.contextPath}/images/icons/edit-icon.png" alt="update"
                                                 width="20" height="20"/>
                                            Update
                                        </a>

                                        <!--Delete button-->
                                        <form action="${pageContext.request.contextPath}/auth?type=product&action=delete&productId=${p.productId}" method="post">
                                            <button class="btn btn-danger w-100" type="submit"
                                                    onclick="return confirm('Delete this product?')">
                                                <img src="${pageContext.request.contextPath}/images/icons/delete-icon.png" alt="delete"
                                                     style="width: 20px; height: auto"/>
                                                Delete
                                            </button>
                                        </form>

                                    </div>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
