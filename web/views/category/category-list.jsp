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
            <h1 class="text-center">List of Categories</h1>

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
                                <td>
                                    <a class="btn btn-success " href="category?action=update&typeId=${c.typeId}">
                                        Edit
                                    </a>
                                    <a class="btn btn-danger" href="category?action=delete&typeId=${c.typeId}"
                                       onclick="return confirm('Delete this category?')">
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
