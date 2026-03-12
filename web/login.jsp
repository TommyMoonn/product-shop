<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Login - Product Shop</title>
        <%@include file="head.jspf"%>
        <link href="${pageContext.request.contextPath}/css/login.css" rel="stylesheet">
    </head>

    <body class="darkmode">

        <%@include file="navbar.jspf"%>

        <section>
            <div class="container py-5 h-100">
                <div class="row justify-content-center align-items-center h-100">

                    <div class="col-12 col-md-8 col-lg-5">

                        <div class="card bg-dark text-white login-card">
                            <div class="card-body p-5">

                                <!-- Logo -->
                                <div class="text-center mb-4 logo-title">
                                    <h3 class="fw-bold d-flex justify-content-center align-items-center gap-2">
                                        <img src="${pageContext.request.contextPath}/images/icons/store-icon.png"
                                             width="32" height="32">
                                        Product Shop
                                    </h3>

                                    <p class="text-white-50 mb-0">
                                        Sign in to your account
                                    </p>
                                </div>

                                <!-- Avatar -->
                                <div class="text-center mb-4">
                                    <img src="${pageContext.request.contextPath}/images/img_avatar2.png"
                                         class="rounded-circle avatar">
                                </div>

                                <!-- Login Form -->
                                <form action="${pageContext.request.contextPath}/login" method="POST">

                                    <!-- Username -->
                                    <div class="mb-3">
                                        <label class="form-label">Username</label>
                                        <div class="input-group">
                                            <span class="input-group-text bg-success">
                                                <img src="${pageContext.request.contextPath}/images/icons/profile-icon.png"
                                                     width="18">
                                            </span>

                                            <input type="text"
                                                   name="account"
                                                   class="form-control"
                                                   placeholder="Enter username"
                                                   required>
                                        </div>
                                    </div>

                                    <!-- Password -->
                                    <div class="mb-4">
                                        <label class="form-label">Password</label>
                                        <div class="input-group">

                                            <span class="input-group-text bg-success">
                                                <img src="${pageContext.request.contextPath}/images/icons/lock-icon.png"
                                                     width="18">
                                            </span>

                                            <input type="password"
                                                   name="pass"
                                                   id="password"
                                                   class="form-control"
                                                   placeholder="Enter password"
                                                   required>

                                            <button class="btn btn-outline-secondary"
                                                    type="button"
                                                    onclick="togglePassword()">
                                                👁
                                            </button>

                                        </div>
                                    </div>

                                    <!-- Submit -->
                                    <button class="btn btn-success w-100 p-2 login-btn">
                                        Sign In
                                    </button>

                                </form>

                                <!-- Register -->
                                <p class="text-center mt-4 mb-0">
                                    Don't have an account?
                                    <a href="${pageContext.request.contextPath}/register.jsp"
                                       class="text-success fw-bold card-hover">
                                        Create one
                                    </a>
                                </p>

                                <!-- Error Message -->
                                <c:if test="${not empty error}">
                                    <div class="alert alert-danger mt-4 mb-0 text-center">
                                        ${error}
                                    </div>
                                </c:if>

                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </section>

        <script>
            function togglePassword() {
                const input = document.getElementById("password");
                input.type = input.type === "password" ? "text" : "password";
            }
        </script>

    </body>
</html>