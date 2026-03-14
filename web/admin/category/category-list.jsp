<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

    <head>

        <meta charset="UTF-8">
        <title>Category List</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css"/>

        <%@ include file="../../head.jspf" %>

    </head>

    <body class="darkmode">

        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="categories"/>

        <div class="container-fluid">

            <%@include file="../sidebar.jspf"%>

            <div class="admin-content">

                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show mb-3">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- HEADER -->
                <div class="admin-card mb-4">

                    <div class="admin-header d-flex justify-content-between align-items-center">

                        <div>
                            <h2>Category Management</h2>
                            <p class="text-white">Manage product categories</p>
                        </div>

                        <a class="btn btn-success"
                           href="${pageContext.request.contextPath}/admin/category?action=add">
                            + Add Category
                        </a>

                    </div>

                </div>

                <!-- TABLE -->
                <div class="admin-card">

                    <div class="admin-header">
                        <h5>Categories</h5>
                    </div>

                    <div class="table-responsive orders-table">

                        <table class="table table-dark table-borderless align-middle mb-0">

                            <thead>
                                <tr>
                                    <th width="120">ID</th>
                                    <th>Category Name</th>
                                    <th>Memo</th>

                                    <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem != 3}">
                                        <th width="200" class="text-center">Actions</th>
                                        </c:if>

                                </tr>
                            </thead>

                            <tbody>

                                <c:forEach var="c" items="${list}">

                                    <tr>

                                        <td>#${c.typeId}</td>

                                        <td class="fw-bold">
                                            ${c.categoryName}
                                        </td>

                                        <td class="text-secondary">
                                            ${c.memo}
                                        </td>

                                        <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem != 3}">

                                            <td class="text-center">

                                                <div class="d-flex justify-content-center gap-2">

                                                    <a class="btn btn-outline-light btn-sm"
                                                       href="${pageContext.request.contextPath}/admin/category?action=update&typeId=${c.typeId}">
                                                        Edit
                                                    </a>

                                                    <c:if test="${sessionScope.user.roleInSystem == 1}">

                                                        <form action="${pageContext.request.contextPath}/admin/category?action=delete&typeId=${c.typeId}"
                                                              method="post">

                                                            <button class="btn btn-danger btn-sm"
                                                                    onclick="return confirm('Delete this category?')">
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