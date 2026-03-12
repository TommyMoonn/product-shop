<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Update Account</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
        <%@ include file="../../head.jspf" %>
    </head>

    <body class="darkmode">
        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="accounts"/>
        <div class="container-fluid">
            <div data-bs-theme="dark">
                <%@include file="../sidebar.jspf"%>
                <div class="admin-content">
                    <div class="admin-container">
                        <div class="admin-card">
                            <form action="${pageContext.request.contextPath}/admin/account?action=update" method="post">
                                <input type="hidden" name="account" value="${account.account}">
                                <!-- Page Header -->
                                <div class="admin-header">
                                    <h2>Update Account</h2>
                                    <p class="text-white">Modify existing account information</p>
                                </div>
                                <hr>
                                <h5 class="mb-3">
                                    Username: <strong>${account.account}</strong>
                                </h5>
                                <!-- ACCOUNT -->
                                <div class="form-section">
                                    <h5 class="section-title">Account Information</h5>
                                    <div class="mb-3">
                                        <label class="form-label">Password</label>
                                        <input type="password"
                                               name="pass"
                                               value="${account.pass}"
                                               required
                                               maxlength="20"
                                               class="form-control"
                                               placeholder="Enter password"/>
                                    </div>
                                </div>
                                <!-- PERSONAL -->
                                <div class="form-section">
                                    <h5 class="section-title">Personal Information</h5>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">First name</label>
                                            <input type="text"
                                                   name="firstName"
                                                   value="${account.firstName}"
                                                   required
                                                   pattern="[\p{L} ]+"
                                                   maxlength="30"
                                                   class="form-control"/>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Last name</label>
                                            <input type="text"
                                                   name="lastName"
                                                   value="${account.lastName}"
                                                   required
                                                   pattern="[\p{L} ]+"
                                                   maxlength="50"
                                                   class="form-control"/>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Birthday</label>
                                            <fmt:formatDate value="${account.birthday}" pattern="yyyy-MM-dd" var="birthdayFormatted"/>
                                            <input type="date"
                                                   name="birthday"
                                                   value="${birthdayFormatted}"
                                                   required
                                                   max="${requestScope.today}"
                                                   class="form-control"/>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Gender</label>
                                            <select name="gender" required class="form-select">
                                                <option value="true" ${account.gender ? "selected" : ""}>Male</option>
                                                <option value="false" ${!account.gender ? "selected" : ""}>Female</option>
                                            </select>
                                        </div>
                                    </div>
                                </div>
                                <!-- CONTACT -->
                                <div class="form-section">
                                    <h5 class="section-title">Contact</h5>
                                    <div class="mb-3">
                                        <label class="form-label">Phone number</label>
                                        <input type="tel"
                                               name="phone"
                                               value="${account.phone}"
                                               required
                                               pattern="0[0-9]{9}"
                                               class="form-control"/>
                                    </div>
                                </div>
                                <!-- ROLE -->
                                <div class="form-section">
                                    <h5 class="section-title">Role</h5>
                                    <div class="mb-3">
                                        <select name="role" required class="form-select">

                                            <option value="0" ${account.roleInSystem == 0 ? "selected" : ""}>Customer</option>
                                            <option value="1" ${account.roleInSystem == 1 ? "selected" : ""}>Admin</option>
                                            <option value="2" ${account.roleInSystem == 2 ? "selected" : ""}>Manager</option>
                                            <option value="3" ${account.roleInSystem == 3 ? "selected" : ""}>Staff</option>

                                        </select>
                                    </div>
                                </div>
                                <!-- ACTIONS -->
                                <div class="form-actions">
                                    <a class="btn btn-outline-light"
                                       onclick="history.back()">
                                        Back
                                    </a>
                                    <button class="btn btn-primary px-4"
                                            onclick="return confirm('Save new changes?')">
                                        Update Account
                                    </button>
                                </div>
                            </form>
                            <c:if test="${not empty error}">
                                <div class="alert alert-danger mt-3">
                                    ${error}
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>