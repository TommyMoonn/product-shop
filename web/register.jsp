<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Create Account</title>
        <%@ include file="../../head.jspf" %>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/register.css"/>
    </head>

    <body class="darkmode">

        <c:set var="activePage" value="accounts" />
        <%@include file="../../navbar.jspf"%>

        <div data-bs-theme="dark">
            <div class="container py-5">
                <div class="row justify-content-center">
                    <div class="col-12 col-md-9 col-lg-7 col-xl-6">
                        <div class="card bg-dark text-white register-card">
                            <div class="card-body p-5">
                                <form action="${pageContext.request.contextPath}/register" method="post">

                                    <!-- Header -->
                                    <div class="text-center mb-4">

                                        <img src="${pageContext.request.contextPath}/images/icons/account-icon.png"
                                             width="50" height="50">

                                        <h3 class="mt-2 fw-bold">Create Account</h3>

                                        <p class="text-secondary mb-0">
                                            Join Product Shop and start shopping today
                                        </p>

                                    </div>

                                    <c:if test="${not empty error}">
                                        <div class="alert alert-danger">
                                            ${error}
                                        </div>
                                    </c:if>

                                    <!-- ACCOUNT -->
                                    <div class="section-title text-secondary mt-3">
                                        Account Information
                                    </div>
                                    <hr>
                                    <div class="mb-3">
                                        <label class="form-label">Username</label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <img src="${pageContext.request.contextPath}/images/icons/profile-icon.png"
                                                     width="18">
                                            </span>
                                            <input type="text"
                                                   name="account"
                                                   required
                                                   minlength="4"
                                                   maxlength="20"
                                                   pattern="[a-zA-Z0-9_]+"
                                                   title="4–20 characters, letters, numbers, underscore only"
                                                   class="form-control"
                                                   placeholder="Enter username">

                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Password</label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <img src="${pageContext.request.contextPath}/images/icons/lock-icon.png"
                                                     width="18">
                                            </span>
                                            <input type="password"
                                                   id="pass"
                                                   name="pass"
                                                   required
                                                   maxlength="20"
                                                   class="form-control"
                                                   placeholder="Enter password">

                                            <button class="btn btn-outline-secondary"
                                                    type="button"
                                                    onclick="togglePassword()">
                                                👁
                                            </button>
                                        </div>
                                    </div>

                                    <div class="mb-3">
                                        <label class="form-label">Confirm Password</label>
                                        <div class="input-group">
                                            <span class="input-group-text">
                                                <img src="${pageContext.request.contextPath}/images/icons/lock-icon.png"
                                                     width="18">
                                            </span>

                                            <input type="password"
                                                   id="confirmPass"
                                                   required
                                                   class="form-control"
                                                   placeholder="Confirm password">
                                        </div>
                                    </div>

                                    <!-- PERSONAL -->
                                    <div class="section-title text-secondary mt-4">
                                        Personal Information
                                    </div>
                                    <hr>

                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">First Name</label>
                                            <input type="text"
                                                   name="firstName"
                                                   required
                                                   pattern="[\p{L} ]+"
                                                   maxlength="30"
                                                   class="form-control"
                                                   placeholder="Enter first name">

                                        </div>

                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Last Name</label>
                                            <input type="text"
                                                   name="lastName"
                                                   required
                                                   pattern="[\p{L} ]+"
                                                   maxlength="50"
                                                   class="form-control"
                                                   placeholder="Enter last name">

                                        </div>
                                    </div>
                                    
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Birthday</label>
                                            <input type="date"
                                                   name="birthday"
                                                   required
                                                   max="${requestScope.today}"
                                                   class="form-control">

                                        </div>
                                                   
                                        <div class="col-md-6 mb-3">
                                            <label class="form-label">Gender</label>
                                            <select name="gender"
                                                    required
                                                    class="form-select">
                                                <option value="" disabled selected>
                                                    Select gender
                                                </option>
                                                <option value="true">Male</option>
                                                <option value="false">Female</option>
                                            </select>
                                        </div>
                                    </div>

                                    <!-- CONTACT -->
                                    <div class="section-title text-secondary mt-4">
                                        Contact Information
                                    </div>
                                    <hr>
                                    <div class="mb-3">
                                        <label class="form-label">Phone Number</label>
                                        <div class="input-group">

                                            <span class="input-group-text">
                                                <img src="${pageContext.request.contextPath}/images/icons/phone-icon.png"
                                                     width="18">
                                            </span>

                                            <input type="tel"
                                                   name="phone"
                                                   required
                                                   pattern="(03|05|07|08|09)[0-9]{8}"
                                                   title="Enter a valid Vietnamese phone number"
                                                   class="form-control"
                                                   placeholder="Enter phone number">

                                        </div>
                                    </div>

                                    <!-- Buttons -->
                                    <div class="d-flex justify-content-between mt-4">

                                        <a href="${pageContext.request.contextPath}/home.jsp"
                                           class="btn btn-outline-light">
                                            ← Back
                                        </a>

                                    </div>

                                    <button class="btn btn-success w-100 mt-3 register-btn"
                                            type="submit">
                                        Create Account
                                    </button>

                                    <div class="text-center mt-3">
                                        Already have an account?
                                        <a href="${pageContext.request.contextPath}/login">
                                            Sign in
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function togglePassword() {
            const pass = document.getElementById("pass");
            pass.type = pass.type === "password" ? "text" : "password";
        }
    </script>
</body>
</html>