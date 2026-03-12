<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Category List</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
        <%@ include file="../../head.jspf" %>
    </head>

    <body class="darkmode">
        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="categories" />
        <div class="container-fluid">
            <div class="row">
                <%@include file="../sidebar.jspf"%>
                <div class="admin-content col">
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                            ${error}
                            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                        </div>
                    </c:if>
                    <div class="admin-card">
                        <!-- HEADER -->
                        <div class="admin-header">
                            <h2>Category Management</h2>
                            <p class="text-white">Manage product categories</p>
                        </div>
                        <hr>
                        <!-- ADD BUTTON -->
                        <div class="d-flex justify-content-end mb-3">
                            <a class="btn btn-success"
                               href="${pageContext.request.contextPath}/admin/category?action=add">
                                + Add New Category
                            </a>
                        </div>
                        <!-- TABLE -->
                        <div class="table-responsive">
                            <table class="table table-dark table-striped table-bordered table-hover align-middle">
                                <thead>
                                    <tr>
                                        <th>Type ID</th>
                                        <th>Category Name</th>
                                        <th>Memo</th>
                                        <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem != 3}">
                                            <th class="text-center">Actions</th>
                                            </c:if>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="c" items="${requestScope.list}">
                                        <tr>
                                            <td>${c.typeId}</td>
                                            <td>${c.categoryName}</td>
                                            <td>${c.memo}</td>
                                            <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem != 3}">
                                                <td class="text-center">
                                                    <div class="d-flex gap-2 justify-content-center">
                                                        <!-- UPDATE -->
                                                        <a class="btn btn-primary"
                                                           href="${pageContext.request.contextPath}/admin/category?action=update&typeId=${c.typeId}">
                                                            <img src="${pageContext.request.contextPath}/images/icons/edit-icon.png"
                                                                 width="20" height="20"/>
                                                            Edit
                                                        </a>
                                                        <!-- DELETE (ADMIN ONLY) -->
                                                        <c:if test="${sessionScope.user.roleInSystem == 1}">
                                                            <form action="${pageContext.request.contextPath}/admin/category?action=delete&typeId=${c.typeId}"
                                                                  method="post">
                                                                <button class="btn btn-danger"
                                                                        type="submit"
                                                                        onclick="return confirm('Delete this category?')">
                                                                    <img src="${pageContext.request.contextPath}/images/icons/delete-icon.png"
                                                                         width="20"/>
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
        </div>
    </body>
</html>