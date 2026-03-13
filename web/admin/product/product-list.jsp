<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Products</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
        <%@include file="../../head.jspf"%>
    </head>

    <body class="darkmode">

        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="products"/>

        <div class="container-fluid">
            <%@include file="../sidebar.jspf"%>
            <div class="admin-content">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <div class="admin-card">
                    <!-- PAGE HEADER -->
                    <div class="admin-header">
                        <h2>Product Management</h2>
                        <p class="text-white">Manage all store products</p>
                    </div>
                    <hr>
                    <div data-bs-theme="dark">
                        <!-- FILTER BAR -->
                        <form action="${pageContext.request.contextPath}/admin/product?action=list"
                              method="get"
                              class="d-flex justify-content-between align-items-end flex-wrap gap-3 mb-3">
                            <div class="d-flex align-items-end gap-3 flex-wrap">
                                <!-- Category -->
                                <div>
                                    <label class="form-label">Category</label>
                                    <select id="typeId" name="typeId" class="form-select">
                                        <option value="">All categories</option>
                                        <c:forEach var="c" items="${requestScope.categories}">
                                            <option value="${c.typeId}"
                                                    <c:if test="${param.typeId == c.typeId}">selected</c:if>>
                                                ${c.categoryName}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                                <!-- Sort -->
                                <div>
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
                                    <div>
                                        <label class="form-label">Discounted</label>
                                        <div class="form-check mt-1">
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
                                <!-- RIGHT BUTTONS -->
                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        Filter
                                    </button>
                                    <a class="btn btn-success"
                                       href="${pageContext.request.contextPath}/admin/product?action=add">
                                    + Add Product
                                </a>
                            </div>
                        </form>
                    </div>
                    <!-- PRODUCT TABLE -->
                    <div class="table-responsive">
                        <table class="table table-dark table-striped table-bordered table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Name</th>
                                    <th class="text-center">Image</th>
                                    <th>Category</th>
                                    <th>Price</th>
                                    <th>Discount</th>

                                    <c:if test="${sessionScope.user != null}">
                                        <th class="text-center">Actions</th>
                                        </c:if>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="p" items="${requestScope.list}">
                                    <tr>
                                        <td>
                                            <a class="text-white product-link"
                                               href="${pageContext.request.contextPath}/admin/product?action=detail&productId=${p.productId}">
                                                ${p.productName}
                                            </a>
                                        </td>
                                        <td class="text-center">
                                            <img src="${pageContext.request.contextPath}${p.productImage}"
                                                 width="95"
                                                 height="95"
                                                 class="border border-2 border-secondary rounded">
                                        </td>
                                        <td>${p.type.categoryName}</td>
                                        <td>${p.price}</td>
                                        <td>${p.discount}%</td>
                                        <c:if test="${sessionScope.user != null}">
                                            <td class="text-center">
                                                <div class="d-flex flex-column gap-2">
                                                    <a class="btn btn-primary"
                                                       href="${pageContext.request.contextPath}/admin/product?action=update&productId=${p.productId}">
                                                        <img src="${pageContext.request.contextPath}/images/icons/edit-icon.png"
                                                             width="20" height="20">
                                                        Update
                                                    </a>
                                                    <c:if test="${sessionScope.user.roleInSystem != 3}">
                                                        <form action="${pageContext.request.contextPath}/admin/product?action=delete&productId=${p.productId}"
                                                              method="post">
                                                            <button class="btn btn-danger w-100"
                                                                    type="submit"
                                                                    onclick="return confirm('Delete this product?')">
                                                                <img src="${pageContext.request.contextPath}/images/icons/delete-icon.png"
                                                                     width="20">
                                                                Delete
                                                            </button>
                                                        </form>
                                                    </c:if>
                                                </div>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>