<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Account List</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="accounts" />
        <%@include file="../navbar.jspf"%>

        <div class="container mt-4">
            <h1 class="text-center">List of Accounts</h1>

            <table class="table table-dark table-striped table-bordered mt-3">
                <thead>     
                    <tr>
                        <th>Account</th>
                        <th>Full Name</th>  
                        <th>Birthday</th>
                        <th>Gender</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>

                <tbody>
                    <c:forEach var="a" items="${requestScope.list}">
                        <tr>
                            <td>${a.account}</td>
                            <td>${a.lastName} ${a.firstName}</td>
                            <td>${a.birthday}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${a.gender}">
                                        Male
                                    </c:when>
                                    <c:otherwise>
                                        Female
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${a.phone}</td>
                            <td>${a.roleInSystem}</td>
                            <td class="align-middle text-center">
                                <a class="btn btn-success" 
                                   href="${pageContext.request.contextPath}/account?action=update&account=${a.account}">
                                    Edit
                                </a>
                                <c:choose>
                                    <c:when test="${a.active}">
                                        <a class="btn btn-primary" 
                                           href="${pageContext.request.contextPath}/account?action=deactivate&account=${a.account}"
                                           onclick="return confirm('Deactivate this account?')">
                                            Active
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="btn btn-secondary" 
                                           href="${pageContext.request.contextPath}/account?action=activate&account=${a.account}"
                                           onclick="return confirm('Activate this account?')">
                                            Unactive
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                                <a class="btn btn-danger" 
                                   href="${pageContext.request.contextPath}/account?action=delete&account=${a.account}"
                                   onclick="return confirm('Delete this account?')">
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
