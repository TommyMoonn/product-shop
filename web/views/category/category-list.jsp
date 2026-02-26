<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Category List</title>
        <!--CSS-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        <!--JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="categories" />
        <%@include file="../navbar.jspf"%>

        <div class="container mt-4">
            <h1 class="text-center">
                Category Dashboard
                <img src="${pageContext.request.contextPath}/images/icons/category-icon.png" alt=""
                     width="50" height="50" class="align-middle"/>
            </h1>
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
                                <td class="d-flex gap-2 align-middle text-center">

                                    <!--Update button-->
                                    <a class="btn btn-primary w-50" 
                                       href="${pageContext.request.contextPath}/main?type=category&action=update&typeId=${c.typeId}">
                                        <img src="${pageContext.request.contextPath}/images/icons/edit-icon.png" alt="update"
                                             width="20" height="20"/>
                                        Edit
                                    </a>

                                    <!--Delete button-->
                                    <form class="w-50"
                                          action="${pageContext.request.contextPath}/main?type=category&action=delete&typeId=${c.typeId}" method="post">
                                        <button class="btn btn-danger w-100" type="submit"
                                                onclick="return confirm('Delete this category?')">
                                            <img src="${pageContext.request.contextPath}/images/icons/delete-icon.png" alt="delete"
                                                 style="width: 20px; height: auto"/>
                                            Delete
                                        </button>
                                    </form>

                                </td> 
                            </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
