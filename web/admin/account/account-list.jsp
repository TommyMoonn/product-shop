<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Account List</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
        <%@ include file="../../head.jspf" %>
    </head>

    <body class="darkmode">
        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="accounts"/>
        <div class="container-fluid">
            <%@include file="../sidebar.jspf"%>
            <div class="admin-content">
                <c:if test="${not empty error}">
                    <div class="alert alert-danger alert-dismissible fade show mt-3" role="alert">
                        ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                </c:if>
                <div class="admin-card">
                    <!-- PAGE HEADER -->
                    <div class="admin-header">
                        <h2>Account Management</h2>
                        <p class="text-white">Manage staff and customer accounts</p>
                    </div>
                    <hr>
                    <div data-bs-theme="dark">
                        <!-- FILTER BAR -->
                        <form action="${pageContext.request.contextPath}/admin/account?action=list"
                              method="get"
                              class="d-flex justify-content-between align-items-end flex-wrap gap-3 mb-3">
                            <div class="d-flex align-items-end gap-3">
                                <div>
                                    <label class="form-label">Account Type</label>
                                    <select id="type" name="type" class="form-select">
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
                                    <button type="submit" class="btn btn-primary">
                                        Filter
                                    </button>
                                </div>
                                <a class="btn btn-success"
                                   href="${pageContext.request.contextPath}/admin/account?action=add">
                                + Add New Account
                            </a>
                        </form>
                    </div>
                    <!-- ACCOUNT TABLE -->
                    <div class="table-responsive">
                        <table class="table table-dark table-striped table-bordered table-hover align-middle">
                            <thead>
                                <tr>
                                    <th>Account</th>
                                    <th>Full Name</th>
                                    <th>Birthday</th>
                                    <th>Gender</th>
                                    <th>Phone</th>
                                    <th>Role</th>
                                    <th class="text-center">Status</th>
                                    <th class="text-center">Actions</th>
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
                                                <c:when test="${a.roleInSystem == 1}">Admin</c:when>
                                                <c:when test="${a.roleInSystem == 2}">Manager</c:when>
                                                <c:when test="${a.roleInSystem == 3}">Staff</c:when>
                                                <c:otherwise>Customer</c:otherwise>
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
                                                        Inactive
                                                    </a>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td class="text-center">
                                            <div class="d-flex gap-2 justify-content-center">
                                                <a class="btn btn-primary"
                                                   href="${pageContext.request.contextPath}/admin/account?action=update&account=${a.account}">
                                                    <img src="${pageContext.request.contextPath}/images/icons/edit-icon.png"
                                                         width="20" height="20">
                                                    Edit
                                                </a>
                                                <form action="${pageContext.request.contextPath}/admin/account?action=delete&account=${a.account}"
                                                      method="post">
                                                    <button class="btn btn-danger"
                                                            type="submit"
                                                            onclick="return confirm('Delete this account?')">
                                                        <img src="${pageContext.request.contextPath}/images/icons/delete-icon.png"
                                                             width="20">
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