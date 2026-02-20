<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Account List</title>
        <!--CSS-->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet">
        <!--JS-->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </head>

    <body class="darkmode">
        <c:set var="activePage" value="accounts" />
        <%@include file="../navbar.jspf"%>

        <div class="container mt-4">
            <h1 class="text-center">
                Account Dashboard
                <img src="${pageContext.request.contextPath}/images/icons/avatar-icon-2.png" alt="account"
                     width="50" height="50" class="align-middle"/>
            </h1>

            <table class="table table-dark table-striped table-bordered table-hover mt-3">
                <thead>     
                    <tr>
                        <th>Account</th>
                        <th>Full Name</th>  
                        <th>Birthday</th>
                        <th>Gender</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Status</th>
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
                            <td>
                                <c:choose>
                                    <c:when test="${a.roleInSystem == 1}">
                                        Admin
                                    </c:when>
                                    <c:when test="${a.roleInSystem == 2}">
                                        Manager
                                    </c:when>
                                    <c:otherwise>
                                        Staff
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="text-center">
                                <c:choose>
                                    <c:when test="${a.active}">
                                        <a class="btn btn-success" 
                                           href="${pageContext.request.contextPath}/account/deactivate?account=${a.account}"
                                           onclick="return confirm('Deactivate this account?')">
                                            Active
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a class="btn btn-secondary" 
                                           href="${pageContext.request.contextPath}/account/activate?account=${a.account}"
                                           onclick="return confirm('Activate this account?')">
                                            Unactive
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td class="d-flex gap-2 align-middle text-center">
                                
                                <!--Update button-->
                                <a class="btn btn-primary w-50" 
                                   href="${pageContext.request.contextPath}/account/update?account=${a.account}">
                                    <img src="${pageContext.request.contextPath}/images/icons/edit-icon.png" alt="edit"
                                         width="20" height="20"/>
                                    Edit
                                </a>
                                         
                                <!--Delete button-->
                                <form class="w-50"
                                      action="${pageContext.request.contextPath}/auth" method="post">
                                    <input hidden name="account" value="${a.account}">
                                    <input hidden name="type" value="account">
                                    <input hidden name="action" value="delete">
                                    <button class="btn btn-danger w-100" type="submit"
                                            onclick="return confirm('Delete this account?')">
                                        <img src="${pageContext.request.contextPath}/images/icons/delete-icon.png" alt="delete"
                                             style="width: 20px; height: auto"/>
                                        Delete
                                    </button>
                                </form>
                                             
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </body>
</html>
