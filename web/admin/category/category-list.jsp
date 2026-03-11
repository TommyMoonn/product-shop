<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Category List</title>
        <%@ include file="../../head.jspf" %>
    </head>

    <body class="darkmode">
        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="categories" />
        <div class="container-fluid row">
            <%@include file="../sidebar.jspf"%>
            <div style="margin-left:180px;" class="col py-1 mt-4">
                <div data-bs-theme="dark" class="">
                    <div class="d-flex align-items-center gap-2 mb-3">
                        <a class="btn btn-success ms-auto"
                           href="${pageContext.request.contextPath}/admin/category?action=add">
                            + Add New Category
                        </a>
                    </div>
                </div>
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <table class="table table-dark table-striped table-bordered table-hover mt-3">
                    <thead>
                        <tr>
                            <th>Type ID</th>
                            <th>Category Name</th>
                            <th>Memo</th>
                                <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem != 3}">
                                <th>Actions</th>
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
                                    <td class="align-middle text-center">
                                        <div class="d-flex flex-column gap-2 justify-content-center">
                                            <!--Update button-->
                                            <a class="btn btn-primary" 
                                               href="${pageContext.request.contextPath}/admin/category?action=update&typeId=${c.typeId}">
                                                <img src="${pageContext.request.contextPath}/images/icons/edit-icon.png" alt="update"
                                                     width="20" height="20"/>
                                                Edit
                                            </a>

                                            <!--Delete button-->
                                            <c:if test="${sessionScope.user != null && sessionScope.user.roleInSystem == 1}">
                                                <form action="${pageContext.request.contextPath}/admin/category?action=delete&typeId=${c.typeId}" method="post">
                                                    <button class="btn btn-danger w-100" type="submit"
                                                            onclick="return confirm('Delete this category?')">
                                                        <img src="${pageContext.request.contextPath}/images/icons/delete-icon.png" alt="delete"
                                                             style="width: 20px; height: auto"/>
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
    </body>
</html>
