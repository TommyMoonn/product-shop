<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Category List</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="categories" />
        <%@include file="../navbar.jspf"%>

        <div class="container mt-4">
            <h1>List of Categories</h1>

            <table class="table table-dark table-striped table-bordered mt-3">
                <thead>
                    <tr>
                        <th>Type ID</th>
                        <th>Category Name</th>
                        <th>Memo</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="c" items="${requestScope.list}">
                        <tr>
                            <td>${c.typeId}</td>
                            <td>${c.categoryName}</td>
                            <td>${c.memo}</td>
                            <td>       
                                <a class="btn btn-success " href="category?action=update&typeId=${c.typeId}">
                                    Edit
                                </a>
                                <a class="btn btn-danger" href="category?action=delete&typeId=${c.typeId}" onclick="return confirm('Delete this item?')">
                                    Delete
                                </a>
                            </td> 
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
