<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Products</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css"/>

        <%@include file="../../head.jspf"%>
    </head>

    <body class="darkmode">

        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="products"/>

        <div class="container-fluid">

            <%@include file="../sidebar.jspf"%>

            <div class="admin-content">

                <!-- ERROR MESSAGE -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show mb-3">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- PAGE HEADER -->
                <div class="admin-card mb-4">

                    <div class="admin-header d-flex justify-content-between align-items-center flex-wrap">

                        <div>
                            <h2>Product Management</h2>
                            <p class="text-white">Manage all store products</p>
                        </div>

                        <a class="btn btn-success"
                           href="${pageContext.request.contextPath}/admin/product?action=add">
                            + Add Product
                        </a>

                    </div>

                </div>

                <!-- FILTER BAR -->
                <div data-bs-theme="dark">

                    <div class="admin-card mb-4">

                        <form action="${pageContext.request.contextPath}/admin/product"
                              method="get"
                              class="d-flex flex-wrap gap-3 align-items-end">

                            <input type="hidden" name="action" value="list"/>

                            <!-- CATEGORY -->
                            <div>
                                <label class="form-label">Category</label>
                                <select name="typeId" class="form-select">

                                    <option value="">All categories</option>

                                    <c:forEach var="c" items="${categories}">
                                        <option value="${c.typeId}"
                                                <c:if test="${param.typeId == c.typeId}">selected</c:if>>
                                            ${c.categoryName}
                                        </option>
                                    </c:forEach>

                                </select>
                            </div>

                            <!-- SORT -->
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

                                <!-- DISCOUNT -->
                                <div>
                                    <label class="form-label mb-2">Discount</label>

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

                                <!-- BUTTONS -->
                                <div class="d-flex gap-2">

                                    <button type="submit" class="btn btn-primary">
                                        Apply
                                    </button>

                                    <a class="btn btn-outline-light"
                                       href="${pageContext.request.contextPath}/admin/product?action=list">
                                    Reset
                                </a>

                            </div>

                        </form>

                    </div>
                </div>
                <!-- PRODUCT TABLE -->
                <div class="admin-card">

                    <div class="admin-header">
                        <h5>Products</h5>
                    </div>

                    <div class="table-responsive orders-table">

                        <table class="table table-dark table-borderless align-middle mb-0">

                            <thead>
                                <tr>
                                    <th width="400">Product</th>
                                    <th width="180">Category</th>
                                    <th width="160">Price</th>
                                    <th width="120">Discount</th>

                                    <c:if test="${sessionScope.user != null}">
                                        <th width="220" class="text-center">Actions</th>
                                        </c:if>
                                </tr>
                            </thead>

                            <tbody>

                                <c:forEach var="p" items="${list}">

                                    <tr>

                                        <!-- PRODUCT -->
                                        <td>

                                            <div class="d-flex align-items-center gap-3">

                                                <img src="${pageContext.request.contextPath}${p.productImage}"
                                                     width="70"
                                                     height="70"
                                                     class="rounded border border-secondary">

                                                <div>

                                                    <a class="text-white product-link"
                                                       href="${pageContext.request.contextPath}/admin/product?action=detail&productId=${p.productId}">

                                                        <div class="fw-bold">
                                                            ${p.productName}
                                                        </div>

                                                    </a>

                                                    <small class="text-secondary">
                                                        ID #${p.productId}
                                                    </small>

                                                </div>

                                            </div>

                                        </td>

                                        <!-- CATEGORY -->
                                        <td>
                                            ${p.type.categoryName}
                                        </td>

                                        <!-- PRICE -->
                                        <td>
                                            ${p.price}
                                        </td>

                                        <!-- DISCOUNT -->
                                        <td>
                                            ${p.discount}%
                                        </td>

                                        <!-- ACTIONS -->
                                        <c:if test="${sessionScope.user != null}">
                                            <td class="text-center">

                                                <div class="d-flex justify-content-center gap-2">

                                                    <a class="btn btn-outline-light btn-sm"
                                                       href="${pageContext.request.contextPath}/admin/product?action=update&productId=${p.productId}">
                                                        Update
                                                    </a>

                                                    <c:if test="${sessionScope.user.roleInSystem != 3}">

                                                        <form action="${pageContext.request.contextPath}/admin/product"
                                                              method="post">

                                                            <input type="hidden" name="action" value="delete"/>
                                                            <input type="hidden" name="productId" value="${p.productId}"/>

                                                            <button class="btn btn-danger btn-sm"
                                                                    type="submit"
                                                                    onclick="return confirm('Delete this product?')">
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