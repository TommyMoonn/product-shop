<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Staff List</title>
        <%@ include file="../../head.jspf" %>
    </head>

    <body class="darkmode">
        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="accounts" />
        <%@include file="../../navbar.jspf"%>
        <div class="container-fluid row">
            <%@include file="../sidebar.jspf"%>
            <div style="margin-left:180px;" class="col py-1 mt-4">
                <h1 class="text-center">
                    <img src="${pageContext.request.contextPath}/images/icons/account-icon.png" alt="account"
                         width="50" height="50" class="mb-1"/>
                    List of Staff
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
                                        <c:when test="${a.roleInSystem == 3}">
                                            Staff
                                        </c:when>
                                        <c:otherwise>
                                            Customer
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-center">
                                    <c:choose>
                                        <c:when test="${a.active}">
                                            <a class="btn btn-success" 
                                               href="${pageContext.request.contextPath}/admin/account?action=deactivate&account=${a.account}"
                                               onclick="return confirm('Deactivate this account?')">
                                                Active
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a class="btn btn-secondary" 
                                               href="${pageContext.request.contextPath}/admin/account?action=activate&account=${a.account}"
                                               onclick="return confirm('Activate this account?')">
                                                Unactive
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="d-flex gap-2 align-middle text-center">

                                    <!--Update button-->
                                    <a class="btn btn-primary w-50" 
                                       href="${pageContext.request.contextPath}/admin/account?action=update&account=${a.account}">
                                        <img src="${pageContext.request.contextPath}/images/icons/edit-icon.png" alt="edit"
                                             width="20" height="20"/>
                                        Edit
                                    </a>

                                    <!--Delete button-->
                                    <form class="w-50"
                                          action="${pageContext.request.contextPath}/admin/account?action=delete&account=${a.account}" method="post">
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
        </div>
    </body>
</html>
