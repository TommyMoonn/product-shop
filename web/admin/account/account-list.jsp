<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Account List</title>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css"/>

        <%@ include file="../../head.jspf" %>
    </head>

    <body class="darkmode">

        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="accounts"/>

        <div class="container-fluid">

            <%@include file="../sidebar.jspf"%>

            <div class="admin-content">

                <!-- ERROR -->
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show mb-3">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>

                <!-- HEADER -->
                <div class="admin-card mb-4">
                    <div class="admin-header d-flex justify-content-between align-items-center flex-wrap">

                        <div>
                            <h2>Account Management</h2>
                            <p class="text-white">Manage staff and customer accounts</p>
                        </div>

                        <a class="btn btn-success"
                           href="${pageContext.request.contextPath}/admin/account?action=add">
                            + Add Account
                        </a>

                    </div>
                </div>

                <!-- FILTER -->
                <div data-bs-theme="dark">
                    <div class="admin-card mb-4">

                        <form action="${pageContext.request.contextPath}/admin/account"
                              method="get"
                              class="d-flex gap-3 align-items-end flex-wrap">

                            <input type="hidden" name="action" value="list"/>

                            <div>
                                <label class="form-label">Account Type</label>
                                <select name="type" class="form-select">

                                    <option value="">All accounts</option>

                                    <option value="customer"
                                            <c:if test="${param.type == 'customer'}">selected</c:if>>
                                                Customer
                                            </option>

                                            <option value="staff"
                                            <c:if test="${param.type == 'staff'}">selected</c:if>>
                                                Staff
                                            </option>

                                    </select>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-primary">
                                        Apply
                                    </button>

                                    <a class="btn btn-outline-light"
                                       href="${pageContext.request.contextPath}/admin/account?action=list">
                                    Reset
                                </a>
                            </div>

                        </form>

                    </div>
                </div>
                <!-- TABLE -->
                <div class="admin-card">

                    <div class="admin-header">
                        <h5>Accounts</h5>
                    </div>

                    <div class="table-responsive orders-table">

                        <table class="table table-dark table-borderless align-middle mb-0">

                            <thead>
                                <tr>
                                    <th>Account</th>
                                    <th>Full Name</th>
                                    <th>Birthday</th>
                                    <th>Gender</th>
                                    <th>Phone</th>
                                    <th>Role</th>
                                    <th>Status</th>
                                    <th class="text-center">Actions</th>
                                </tr>
                            </thead>

                            <tbody>

                                <c:forEach var="a" items="${list}">

                                    <tr>

                                        <td>${a.account}</td>

                                        <td>${a.lastName} ${a.firstName}</td>

                                        <td>${a.birthday}</td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${a.gender}">Male</c:when>
                                                <c:otherwise>Female</c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>${a.phone}</td>

                                        <td>
                                            <c:choose>
                                                <c:when test="${a.roleInSystem == 1}">Admin</c:when>
                                                <c:when test="${a.roleInSystem == 2}">Manager</c:when>
                                                <c:when test="${a.roleInSystem == 3}">Staff</c:when>
                                                <c:otherwise>Customer</c:otherwise>
                                            </c:choose>
                                        </td>

                                        <td>

                                            <c:choose>

                                                <c:when test="${a.active}">
                                                    <a href="${pageContext.request.contextPath}/admin/account?action=deactivate&account=${a.account}">
                                                        <span class="badge bg-success">Active</span>
                                                    </a>
                                                </c:when>

                                                <c:otherwise>
                                                    <a href="${pageContext.request.contextPath}/admin/account?action=activate&account=${a.account}">
                                                        <span class="badge bg-secondary">Inactive</span>
                                                    </a>
                                                </c:otherwise>

                                            </c:choose>

                                        </td>

                                        <td class="text-center">

                                            <div class="d-flex justify-content-center gap-2">

                                                <a class="btn btn-outline-light btn-sm"
                                                   href="${pageContext.request.contextPath}/admin/account?action=update&account=${a.account}">
                                                    Edit
                                                </a>

                                                <form action="${pageContext.request.contextPath}/admin/account?action=delete&account=${a.account}"
                                                      method="post">

                                                    <button class="btn btn-danger btn-sm"
                                                            onclick="return confirm('Delete this account?')">
                                                        Delete
                                                    </button>

                                                </form>

                                            </div>

                                        </td>

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