<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Account</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admin.css"/>
        <%@ include file="../../head.jspf" %>
    </head>

    <body class="darkmode">
        <c:set var="isAdminPage" value="true"/>
        <c:set var="activePage" value="accounts"/>
        <div class="container-fluid row">
            <div data-bs-theme="dark">
                <%@include file="../sidebar.jspf"%>
                <div class="col admin-content">
                    <div class="row justify-content-center">
                        <div class="col-xl-8 col-lg-9">
                            <div class="admin-card">
                                <!-- Page Header -->
                                <div class="admin-header">
                                    <h2>Create New Account</h2>
                                    <p class="text-white">Add a new staff or administrator account</p>
                                </div>
                                <hr>
                                <form action="${pageContext.request.contextPath}/admin/account?action=add"
                                      method="post">
                                    <!-- ACCOUNT INFO -->
                                    <div class="form-section">
                                        <h5 class="section-title">Account Information</h5>
                                        <div class="mb-3">
                                            <label class="form-label">Account name</label>
                                            <input type="text"
                                                   name="account"
                                                   required
                                                   minlength="4"
                                                   maxlength="20"
                                                   pattern="[a-zA-Z0-9_]+"
                                                   title="4–20 characters, letters, numbers, underscore only"
                                                   class="form-control"
                                                   placeholder="Username"/>
                                        </div>
                                        <div class="mb-3">
                                            <label class="form-label">Password</label>
                                            <input type="password"
                                                   name="pass"
                                                   required
                                                   maxlength="20"
                                                   class="form-control"
                                                   placeholder="Enter password"/>
                                        </div>
                                    </div>
                                    <!-- PERSONAL INFO -->
                                    <div class="form-section">
                                        <h5 class="section-title">Personal Information</h5>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">First name</label>
                                                <input type="text"
                                                       name="firstName"
                                                       required
                                                       pattern="[\p{L} ]+"
                                                       maxlength="30"
                                                       class="form-control"
                                                       placeholder="First name"/>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Last name</label>
                                                <input type="text"
                                                       name="lastName"
                                                       required
                                                       pattern="[\p{L} ]+"
                                                       maxlength="50"
                                                       class="form-control"
                                                       placeholder="Last name"/>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Birthday</label>
                                                <input type="date"
                                                       name="birthday"
                                                       required
                                                       max="${requestScope.today}"
                                                       class="form-control"/>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label class="form-label">Gender</label>
                                                <select name="gender" required class="form-select">
                                                    <option value="" disabled selected>Select gender</option>
                                                    <option value="true">Male</option>
                                                    <option value="false">Female</option>
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
                                                   required
                                                   pattern="0[0-9]{9}"
                                                   title="Phone must start with 0 and contain 10 digits"
                                                   class="form-control"
                                                   placeholder="0123456789"/>
                                        </div>
                                    </div>
                                    <!-- ROLE -->
                                    <div class="form-section">
                                        <h5 class="section-title">Role</h5>
                                        <div class="mb-3">
                                            <select name="role"
                                                    required
                                                    class="form-select">
                                                <option value="" disabled selected>Select role</option>
                                                <option value="1">Admin</option>
                                                <option value="2">Manager</option>
                                                <option value="3">Staff</option>

                                            </select>
                                        </div>
                                    </div>
                                    <!-- ACTION BUTTONS -->
                                    <div class="form-actions">
                                        <a class="btn btn-outline-light"
                                           onclick="history.back()">
                                            Back
                                        </a>
                                        <button class="btn btn-primary px-4">
                                            Create Account
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
        </div>
    </body>
</html>